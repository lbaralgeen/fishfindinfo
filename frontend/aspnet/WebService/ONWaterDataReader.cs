using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace FishTracker.WebService
{
    public class TConverter
    {
        static public Dictionary<int,Tuple<float, float>> ONWaterData(List<string[]> data)
        {
            // ID,     Date,                     Water Level / Niveau d'eau (m), Grade, Symbol / Symbole,QA/QC,Discharge / Débit (cms),Grade,Symbol / Symbole,QA/QC
            // 02AB006,2018-07-01T00:55:00-05:00,302.273,,,1                                                ,62.2,,,1
            // process to make minimum sql set
            var dataWS = new Dictionary<int, Tuple<float, float>>();
            DateTime? lastPoint = null;

            foreach (var entry in data)
            {
                bool isValue = false;
                try
                {
                    DateTime point = DateTime.Parse(entry[1]);
                    
                    float wl = 0;
                    float ds = 0;

                    if (!String.IsNullOrEmpty(entry[2]))
                    {
                        if (float.TryParse(entry[2], out wl))
                        {
                            isValue = true;
                        }
                    }
                    if( entry.Length >=5 && !String.IsNullOrEmpty(entry[6]) )
                    {
                        if (float.TryParse(entry[6], out ds))
                        {
                            isValue = true;
                        }
                    }
                    if( !isValue )
                    {
                        continue;
                    }
                    if( lastPoint != null )
                    {
                        TimeSpan span = point.Subtract((DateTime)lastPoint);

//                        if(span.Minutes < 15)
                        if (span.Hours < 1)
                        {
                            continue;
                        }
                    }
                    int stamp = FishTracker.WebService.PushStation.ConvertTime(point);
                    dataWS[stamp] = new Tuple<float, float>(wl, ds);

                    lastPoint = point;
                }
                catch (Exception) { }
            }
            return dataWS;
        }
    }
}
