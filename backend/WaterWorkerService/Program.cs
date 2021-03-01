using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Configuration;
using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WaterWorkerService
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }
        public static Dictionary<string, string> LoadWaterList(string countryFile)
        {
            Dictionary<string, string> result = new Dictionary<string, string>();

            if (String.IsNullOrEmpty(countryFile))
                return result;
            try
            {
                string path = Path.Combine(Directory.GetCurrentDirectory(), countryFile);
                List<string> allLinesText = File.ReadAllLines(path).ToList();

                foreach (var val in allLinesText)
                {
                    string[] row = val.Split(',');

                    if (row.Count() == 2)
                    {
                        string stationid = row[0].Trim();
                        result[stationid] = row[1];   // example: 02DD006	ON
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return result;
        }
        public static string GetDbConnection()
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())  //location of the exe file
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);

            IConfigurationRoot configuration = builder.Build();

            var connectionstring = configuration.GetConnectionString("DefaultConnection");

            return connectionstring;
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureServices((hostContext, services) =>
                {
                    services.AddHostedService<Worker>();
                });
    }
}
