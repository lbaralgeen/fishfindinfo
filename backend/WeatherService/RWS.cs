using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.IO;
using System.Xml;
using System.Threading.Tasks;
using System.Timers;
using System.Data.SqlClient;
using System.Net.Mail;
using Microsoft.Win32;
using System.Net;
using System.Runtime.InteropServices;
// powershell
using System.Management;
using System.Collections.ObjectModel;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

// https://wiki.gdn.rintra.net/display/SLNX3/Password+Change+Notification

namespace OWMService
{
    public partial class RWS : ServiceBase
    {
        private Timer m_timer = new Timer();
        private double m_servicePollInterval;
        private string m_serverName = Environment.MachineName;  // MSSQL service name
        private string m_dbName = "fishfind";  // database name
        private string m_userName = "superadmin";  // user name for database
        private string m_userPassword = "superpassword";  // password for MSSQL service 
        private string m_wunderground = "weather APi Key"; // https://www.wunderground.com/member/api-keys   

        private bool m_bFlagProcessing = true;
        private const string null_guid = "00000000-0000-0000-0000-000000000000";

        public RWS()
        {
            InitializeComponent();
            m_servicePollInterval = 60 * 2;  // every 2 hours
#if DEBUG
            if (System.Diagnostics.Debugger.IsAttached)
            {
                if (!ReadSettings())
                {
                    return;
                }
                Process();
            }
#endif
        }
        /// <summary>
        /// Read initial data from registry
        /// File: OWMService.reg is used to initialize original data
        /// </summary>
        /// <returns></returns>
        private bool ReadSettings()
        {
            string path = @"HKEY_LOCAL_MACHINE\SOFTWARE\FishFind\OWMService\";
            try
            {
                m_serverName   = (string)Registry.GetValue(path, "Server", null);

                if (String.IsNullOrEmpty(m_serverName))
                {
                    eventLogRN.WriteEntry("Cannot read MSSQL Server Name");
                    m_servicePollInterval = 100; // read every 100 min;
                    return false;
                }
                m_dbName = (string)Registry.GetValue(path, "dbName", null);

                if (String.IsNullOrEmpty(m_dbName))
                {
                    eventLogRN.WriteEntry("Cannot read MSSQL Server Db Name");
                    return false;
                }
                m_userName = (string)Registry.GetValue(path, "userName", null);
                if (String.IsNullOrEmpty(m_userName))
                {
                    eventLogRN.WriteEntry("Cannot read MSSQL Server user name");
                    return false;
                }
                m_userPassword = (string)Registry.GetValue(path, "userPassword", null);
                if (String.IsNullOrEmpty(m_userPassword))
                {
                    eventLogRN.WriteEntry("Cannot read MSSQL Server user password");
                    return false;
                }
                m_wunderground = (string)Registry.GetValue(path, "wunderground", null);
                if (String.IsNullOrEmpty(m_wunderground))
                {
                    eventLogRN.WriteEntry("Cannot read wunderground API key");
                    return false;
                }
                Int32 interval = (Int32)Registry.GetValue(path, "Interval", null); // value read in minutes
                m_servicePollInterval = interval;

                eventLogRN.WriteEntry("Connect to: " + m_serverName + " every " + interval + " minutes");
                m_bFlagProcessing = false;
                return true;
            }
            catch (Exception ex)
            {
                eventLogRN.WriteEntry("ReadSettings: " + ex.Message, EventLogEntryType.Error);
            }
            return false;
        }
        protected void ReReadConfig()
        {
            eventLogRN.WriteEntry("OWMService is started.");
        }
        protected override void OnStart(string[] args)
        {
            eventLogRN.WriteEntry("OWMService is started.");

            if (!ReadSettings())
            {
                return;
            }
            m_timer.Elapsed += new ElapsedEventHandler(timer_Elapsed);
            //providing the time in miliseconds 
            m_timer.Interval = 1024 * 60 * 3; // check in 3 mins
            m_timer.AutoReset = true;
            m_timer.Enabled = true;
            m_timer.Start();
        }
        protected string GetConnectionString()
        {
            string con_str = String.Format(@"Data Source={0};Initial Catalog={1};Integrated Security=False;User ID={2};Password={3}"
                                          , m_serverName, m_dbName, m_userName, m_userPassword);
            return con_str;

        }

        // Run list of actions to sync users between DC and CORE       
        private bool Process()
        {
            string con_str = GetConnectionString();

            if( String.IsNullOrEmpty(con_str) )
            {
                return false;
            }
            try
            {
                using (SqlConnection cnn = new SqlConnection(con_str))
                {
                    cnn.Open();

                    List<Tuple<string, float, float, string>> stations = GetListOwsMeteo(cnn );

                    ProcessEnvData(stations, cnn);  // get data from wheather underground: https://www.wunderground.com/member/devices
                    ProcessFishState( cnn );

                    m_timer.Interval = 1024 * 60 * 2; // check in 5 min
                    return true;
                }
            }
            catch (Exception ex)
            {
                eventLogRN.WriteEntry("OWMService Failed to connect." + ex.Message + " at: " + con_str);
                return false;
            }
        }
        void ProcessEnvData(List<Tuple<string, float, float, string>> stations, SqlConnection cnn)
        {
            try
            {
                int i = 0;

                foreach (var item in stations)
                {
                    try
                    {
                        ProcessOWSPoint(item.Item1, item.Item2, item.Item3, cnn);
                        i++;
                    }
                    catch (Exception ex)
                    {
                        string msg = ex.Message + " MLI:  " + item.Item1 + " at: " + i.ToString();
                        eventLogRN.WriteEntry("135: OWMService Failed to connect." + ex.Message + " MLI:  " + item.Item1);
                    }
                }
                    // ProcessWaterData(item.Item1, item.Item2, item.Item3, item.Item4, cnn);
            }  catch (Exception ex)
            {
                eventLogRN.WriteEntry("141: OWMService Failed to connect." + ex.Message  );
            }
        }
        List<Tuple<string, float, float, string>> GetListOwsMeteo(SqlConnection cnn)
        {
            var result = new List<Tuple<string, float, float, string>>();

            using (SqlCommand cmd = new SqlCommand("select mli, lat, lon, state from WaterStation w where exists (select * from lake_fish f where f.lake_Id = w.lakeId)", cnn))
            {
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string mli = dr.GetString(0);
                        float lat = (float)dr.GetDouble(1);
                        float lon = (float)dr.GetDouble(2);
                        string state = dr.GetString(3);

                        result.Add(Tuple.Create<string, float, float, string>(mli, lat, lon, state));
                    }
                }
            }
            return result;
        }
        protected override void OnStop()
        {
            m_bFlagProcessing = true;
            eventLogRN.WriteEntry("OWMService is stopped.");
        }
        protected override void OnContinue()
        {
            m_bFlagProcessing = false;
            eventLogRN.WriteEntry("OWMService On Continue.");
        }
        protected override void OnShutdown()
        {
            m_bFlagProcessing = true;
            eventLogRN.WriteEntry("OWMService OnShutdown.");
            base.OnShutdown();
            m_timer.Stop();
        }

        private void timer_Elapsed(object sender, EventArgs e)
        {
            if( m_bFlagProcessing )
            {
                return;
            }
            m_bFlagProcessing = true;
            eventLogRN.WriteEntry("timer_Elapsed: Update Accounts");

            Process();
            m_bFlagProcessing = false;
        }

    }
}
