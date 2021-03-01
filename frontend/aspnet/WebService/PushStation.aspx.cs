using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Threading;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;

namespace FishTracker.WebService
{

    public partial class PushStation : DbLayer
    {
        string m_state, m_mli;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                m_mli = Request.QueryString["mli"];   // "05RC001"; 
                m_state = Request.QueryString["state"];   // "ON"; 

                if (System.Diagnostics.Debugger.IsAttached)
                {
                    m_mli = "01AD008";
                    m_state = "NB";
                }
                LabelMLI.Text = m_mli;
                LabelState.Text = m_state;
            }
            catch (Exception )
            {
                Label1.Text = "Bad input parameters";
                return;
            }
            if( string.IsNullOrEmpty(m_mli) || string.IsNullOrEmpty(m_state) )
            {
                Label1.Text = "Bad input parameters 2";
                return;
            }
            string fn_name = "WebService->Page_Load";
            String msg = "";
            try
            {
                // download data  WebClient  DownloadData
                List<string[]> datacsv = GetDataFromCAWaterServer(m_state, m_mli, ref msg);

                if( !String.IsNullOrEmpty(msg))
                {
                    String part = "INSERT INTO LogException (msg, page_name, ip, email) VALUES";
                    String sqlcmd = String.Format("{0} (@param0, '{1}', '{2}', '{3}')", part, fn_name, m_state, m_mli);
                    m_dbObject.ExecCmd(m_dbObject.m_connection, sqlcmd, SqlDbType.NVarChar, msg, fn_name);
                    return;
                }

                var wtData = TConverter.ONWaterData(datacsv);

                if(wtData == null || wtData.Count == 0 )
                {
                    String part = "INSERT INTO LogException (msg, page_name, ip, email) VALUES";
                    String sqlcmd = String.Format("{0} (@param0, '{1}', '{2}', '{3}')", part, fn_name, m_state, m_mli);
                    m_dbObject.ExecCmd(m_dbObject.m_connection, sqlcmd, SqlDbType.NVarChar, "Failed parser - no data", fn_name);
                    Label1.Text = "Empty Data";
                    return;
                }
                {
                    string crsql = String.Format("CREATE TABLE #{0} (k smalldatetime, t int NOT NULL PRIMARY KEY, w float, d float)", m_mli);
                    int? rs1 = m_dbObject.ExecCmd(m_dbObject.m_connection, crsql, fn_name);
                    Label1.Text = rs1.ToString();

                    var types = new SqlDbType[] { SqlDbType.Int, SqlDbType.Float, SqlDbType .Float};
                    int? rs2 = 0;

                    foreach (var entry in wtData)
                    {
                        var values = new dynamic[] { entry.Key, entry.Value.Item1, entry.Value.Item2 };

                        rs2 += m_dbObject.Insert(m_dbObject.m_connection, "#" + m_mli, "t,w,d", types, values, fn_name);
                    }
                    int? tz = m_dbObject.ReadSingleInt(m_dbObject.m_connection, "SELECT TOP 1 tz FROM WaterStation WHERE mli=@param0", SqlDbType.VarChar, m_mli, fn_name);

                    if(tz == null)
                    {
                        tz = 0;
                    }
                    string updsql = string.Format("UPDATE #{0} SET k= DATEADD(n, t-100*(t/100), DATEADD(hh, {1}+(t/100), CAST(CAST(getdate() AS DATE) AS smalldatetime)))", m_mli, tz);
                    int ? rs3 = m_dbObject.ExecCmd(m_dbObject.m_connection, updsql, fn_name);
                    Label3.Text = rs3.ToString();
                    int? rs4 = m_dbObject.ExecCmd(m_dbObject.m_connection, "DELETE FROM WaterData WHERE mli = @param0 AND stamp < DATEADD(d, -15, GETDATE())", SqlDbType.VarChar, m_mli, fn_name);
                    Label4.Text = rs4.ToString();
                    long cnt = m_dbObject.GetTableCount("#" + m_mli, fn_name);
                    //                    string sqlcmd = String.Format("INSERT INTO WaterData (mli,stamp,elevation,discharge) SELECT @param0, k, w, d FROM #{0} t WHERE NOT EXISTS(SELECT * FROM WaterData w WHERE w.mli = @param0 AND w.stamp = t.k ); ", m_mli);
                    string sqlcmd = String.Format("Merge Into dbo.WaterData As trg Using #{0} As src On '{0}'=trg.mli AND trg.stamp= src.k When Not Matched Then Insert (mli, stamp, elevation,discharge) Values ('{0}', src.k, src.w, src.d);", m_mli);
                    int? rs5 = m_dbObject.ExecCmd(m_dbObject.m_connection, sqlcmd, SqlDbType.VarChar, m_mli, fn_name);
                    Label5.Text = rs5.ToString();
                    Label6.Text = cnt.ToString();
                }
            }
            catch (Exception ex)
            {
                Label6.Text = ex.Message;
            }
        }
        protected List<string[]> GetDataFromCAWaterServer(String state, String mli, ref String msg)
        {
            try
            {
                // download data  WebClient  DownloadData
                string url = String.Format(@"http://dd.weather.gc.ca/hydrometric/csv/{0}/hourly/{0}_{1}_hourly_hydrometric.csv", state, mli);  // ON_02AB006_hourly_hydrometric.csv
                string file = System.IO.Path.GetFileName(url);

                ServicePointManager.Expect100Continue = true;
                ServicePointManager.DefaultConnectionLimit = 9999;
                ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072 | SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls;

                WebClient cln = new WebClient();
                cln.Headers.Add("User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:48.0) Gecko/20100101 Firefox/48.0");

                byte[] data = cln.DownloadData(url);

                // cln.DownloadFile(url, file);
                if (data == null)
                {
                    Label1.Text = "No Data";
                    return null;
                }
                // convert data
                string str = System.Text.Encoding.Default.GetString(data);
                var dataList = str.Split('\n');
                return CSV.Import(dataList, ',', true, true);
            }
            catch (Exception ex)
            {
                msg = String.Format("GetDataFromCAWaterServer: [{0}] - {1} = {2} ", state, mli, ex.Message);
                Label1.Text = ex.Message;
            }
            Label3.Text = "No Data 2";
            return null;
        }

        /// <summary>
        /// return time as HHmm
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        static public int ConvertTime(DateTime data)
        {
            TimeSpan value = data.TimeOfDay;
            return value.Hours * 100 + value.Minutes;
        }
    }
}