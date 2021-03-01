using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Text.Json;
using System.Linq;
using System.Text;
using System.Net.Http;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Net;

namespace WaterWorkerService
{
    public struct ca_s 
    {
        public ca_s(DateTime d, float w, float s)
        {
            dt = d;
            wl = w;
            ds = s;
        }
        public DateTime dt { get; set; }
        public float wl { get; set; }
        public float ds { get; set; }
    };

    public partial class Worker : BackgroundService
    {
        public List<ca_s> ONWaterData(List<string[]> data)
        {
            // ID,     Date, Water Level / Niveau d'eau (m), Grade, Symbol / Symbole,QA/QC,Discharge / Débit (cms),Grade,Symbol / Symbole,QA/QC
            // 02AB006,2018-07-01T00:55:00-05:00,302.273,,,1  ,62.2,,,1
            // process to make minimum sql set
            DateTime? lastPoint = null;

            var lstPoint = new List<Tuple<DateTime, float, float>>();

            foreach (var entry in data)
            {
                if(entry.Length < 2)
                {
                    continue;
                }
                bool isValue = false;
                try
                {
                    DateTime point = DateTime.Parse(entry[1]);

                    float wl = 0;
                    float ds = 0;

                    if (entry.Length >= 1 && !String.IsNullOrEmpty(entry[2]))
                    {
                        if (float.TryParse(entry[2], out wl))
                        {
                            isValue = true;
                        }
                    }
                    if (wl < 0 || wl == 99999)
                    {
                        continue;
                    }
                    if (entry.Length >= 5 && !String.IsNullOrEmpty(entry[6]))
                    {
                        if (float.TryParse(entry[6], out ds))
                        {
                            isValue = true;
                        }
                    }
                    if (ds < 0 || ds == 99999)
                    {
                        continue;
                    }
                    if (!isValue)
                    {
                        continue;
                    }
                    if (lastPoint != null)
                    {
                        TimeSpan span = point.Subtract((DateTime)lastPoint);

                        if (span.Hours < 1)
                        {
                            continue;
                        }
                    }
                    lstPoint.Add(Tuple.Create<DateTime, float, float>(point, wl, ds));

                    lastPoint = point;
                }
                catch (Exception ex)
                {
                    _logger.LogInformation("{0} => Could not convert station data: {1}", "ONWaterData", ex.Message);
                }
            }
            var valist = lstPoint.GroupBy(x => new { x.Item1.Date, x.Item1.Hour })
                .Select(g => new { dt = g.Key.Date, Hour = g.Key.Hour, wl = g.Average(x => x.Item2), ds = g.Average(x => x.Item3) })
                .ToList();

            var result = new List<ca_s>();

            foreach (var item in valist)
            {
                result.Add(new ca_s(item.dt.AddHours(item.Hour), item.ds, item.wl));
            }
            return result;
        }

        protected string ProcessStation( string mli, string state )
        {
            if (string.IsNullOrEmpty(mli) || string.IsNullOrEmpty(state))
            {
                _logger.LogInformation("{0} => Bad input parameters: {1} - {2}", "ProcessStation", mli, state);
                return null;
            }
            try
            {
                // download data  WebClient  DownloadData
                List<string[]> datacsv = GetDataCAWater( state, mli );

                if(datacsv == null)
                {
                    _logger.LogInformation("{0} => Failed to get station data: {1} - {2}", "ProcessStation", mli, state);
                    return null;
                }
                var wtData = ONWaterData(datacsv);

                if(wtData == null || wtData.Count() == 0 )
                {
                    _logger.LogInformation("{0} => Could not convert station data: {1} - {2}", "ProcessStation", mli, state);
                    return null;
                }
                return JsonSerializer.Serialize<List<ca_s>>(wtData);
            }
            catch (Exception ex)
            {
                _logger.LogInformation("{0} => Could not convert station data: {1} - {2} - {3}", "ProcessStation", mli, state, ex.Message);
            }
            return null;
        }
        protected void PassJsonToStorage( string mli, string state, string json, SqlConnection connection)
        {
            if( String.IsNullOrEmpty(json) || String.IsNullOrEmpty(mli) || String.IsNullOrEmpty(state)
                || null == connection || connection.State == ConnectionState.Closed
                || !CaStates.Contains(state)  )
            {
                _logger.LogInformation("{0} => Bad input parameters: {1} - {2}", "ProcessStation", mli, state);
                return;
            }
            try
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "sp_AddCaWaterData";

                    command.Parameters.AddWithValue("@mli",     mli);
                    command.Parameters.AddWithValue("@state",   state);
                    command.Parameters.AddWithValue("@jsondoc", json);
                    command.Parameters.AddWithValue("@koef",    1.0);

                    command.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                _logger.LogInformation("{0} => Could not convert station data: {1} - {2} - {3}", "PassJsonToStorage", mli, state, ex.Message);
            }
            return;
        }
        protected List<string[]> GetDataCAWater( String state, String mli )
        {
            if (string.IsNullOrEmpty(mli) || string.IsNullOrEmpty(state))
            {
                _logger.LogInformation("{0} => Bad input parameters: {1} - {2}", "GetDataCAWater", mli, state);
                return null;
            }
            byte[] data = null;
            string str = null;
            try
            {
                // download data  WebClient  DownloadData
                string url = String.Format(@"http://dd.weather.gc.ca/hydrometric/csv/{0}/hourly/{0}_{1}_hourly_hydrometric.csv", state, mli);  // ON_02AB006_hourly_hydrometric.csv
                string file = System.IO.Path.GetFileName(url);

                ServicePointManager.Expect100Continue = true;
                ServicePointManager.DefaultConnectionLimit = 9999;
                ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072 | SecurityProtocolType.Tls;

                WebClient cln = new WebClient();
                cln.Headers.Add("User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:48.0) Gecko/20100101 Firefox/48.0");

                data = cln.DownloadData(url);

                if (data == null)
                {
                    _logger.LogInformation("{0} => Failed to get data: {1} - {2}", "ProcessStation", mli, state);
                    return null;
                }
                // convert data
                str = System.Text.Encoding.Default.GetString(data);
                var dataList = str.Split('\n');
                return CSV.Import(dataList, ',', true, true);
            }
            catch (Exception ex)
            {
                if ( ex is WebException )
                {
                    _logger.LogInformation("{0} => WebException: {1} - {2} - {3}", "GetDataCAWater", mli, state, ex.Message);
                } 
                else _logger.LogInformation("{0} => Could not convert station data: {1} - {2} - {3}", "GetDataCAWater", mli, state, ex.Message);
            }
            return null;
        }
    }
}