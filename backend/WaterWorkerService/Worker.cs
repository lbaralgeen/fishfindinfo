using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using System.Net;
using System.Data;
using System.Data.SqlClient;

namespace WaterWorkerService
{
    public partial class Worker : BackgroundService
    {
        private readonly ILogger<Worker> _logger;
        static string connStr = null;
        static public HashSet<String> CaStates = new HashSet<String>() { "ON", "QC", "NS", "NB", "MB", "BC", "PE", "SK", "AB", "NL", "NT", "YT", "NU" };
        static public HashSet<String> USStates = new HashSet<String>() { "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL"
        , "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM"
        , "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "DC"};

        static public String[] g_sShortCountry = new String[] { "CA", "US", "RU", "UK", "MX", "NO" };


        public Worker(ILogger<Worker> logger)
        {
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            
            Dictionary<string, string> naList = Program.LoadWaterList("na.csv");
            connStr = Program.GetDbConnection();

            for (var round = DateTime.Now.AddDays(-1).Date;  !stoppingToken.IsCancellationRequested; )
            {
                if( round == DateTime.Today.Date)
                {
                    await Task.Delay(1000 * 60 * 60, stoppingToken); // wait for an hour
                    continue;
                }
                if (null != naList)
                {
                    using (SqlConnection cnn = new SqlConnection(connStr))
                    {
                        cnn.Open();
                        foreach (var station in naList)
                        {
                            _logger.LogInformation("{time}\tProcess station {1} running for: [{2}]"
                                                  , DateTimeOffset.Now, station.Key, station.Value);

                            string json = ProcessStation(station.Key, station.Value);

                            PassJsonToStorage(station.Key, station.Value, json, cnn);

                            await Task.Delay(1000, stoppingToken);

                            if (stoppingToken.IsCancellationRequested)
                                break;
                        }
                        cnn.Close();
                    }
                }
                _logger.LogInformation("Exit round.");
                await Task.Delay(1000, stoppingToken);
            }
        }
    }
}
