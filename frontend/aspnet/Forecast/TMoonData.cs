using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FishTracker.Forecast
{
    static public class TMoonData
    {
        public static readonly int[] phase = new int[] { 0, 1, 1, 1, 2, 2, 2, 2
                                                          , 3, 3, 3, 4, 4, 4, 4
                                                          , 5, 5, 5, 6, 6, 6, 6
                                                          , 7, 7, 7, 7, 8, 8, 8, 8, 1, 1, 1 };

        public static readonly String[] alt 
            = new String[] { "", "New",       "Waxing Crescent", "First Quarter", "Waxing Gibbous"
                               , "Full Moon", "Waning Gibbous",  "Third Quarter", "Waning Crescent" };

        public static readonly String[] icons 
            = new String[] { "dot", "new-moon1",  "waxc-moon2", "fq_moon3", "waxg-moon4"
                                  , "full_moon5", "wg_moon6",   "tq_moon7", "wc_moon8"   };

        private static int JulianDate(int d, int m, int y)
        {
            int yy = y - (int)((12 - m) / 10);
            int mm = m + 9;
            if (mm >= 12)
            {
                mm = mm - 12;
            }
            int k1 = (int)(365.25 * (yy + 4712));
            int k2 = (int)(30.6001 * mm + 0.5);
            int k3 = (int)((int)((yy / 100) + 49) * 0.75) - 38;
            // 'j' for dates in Julian calendar:
            int j = k1 + k2 + d + 59;

            if (j > 2299160)
            {
                // For Gregorian calendar:
                j = j - k3;  // 'j' is the Julian date at 12h UT (Universal Time)
            }
            return j;
        }

        public static int MoonAge(int d, int m, int y)
        {
            int j = JulianDate(d, m, y);
            //Calculate the approximate phase of the moon
            double ip = (j + 4.867) / 29.53059, ag = 0;
            ip = ip - Math.Floor(ip);
            //After several trials I've seen to add the following lines, 
            //which gave the result was not bad
            if (ip < 0.5)
                ag = ip * 29.53059 + 29.53059 / 2;
            else
                ag = ip * 29.53059 - 29.53059 / 2;
            // Moon's age in days
            return (int)(Math.Floor(ag) + 1);
        }
       
    };
};
