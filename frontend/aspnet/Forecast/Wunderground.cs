using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Xml;
using System.IO;

//http://forecast.weather.gov/MapClick.php?lat=40.78158&lon=-73.96648&FcstType=dwml
// http://www.wunderground.com/cgi-bin/findweather/hdfForecast?query=41.4,-80
// http://api.wunderground.com/api/5bd976229d3b1932/forecast10day/q/ON/Kitchener.xml
// http://api.wunderground.com/api/5bd976229d3b1932/conditions/q/ON/Kitchener.xml
// http://api.wunderground.com/api/5bd976229d3b1932/conditions/q/pws:IABCALGA19.json
// http://climate.weather.gc.ca/FAQ_e.html
// http://www.rap.ucar.edu/weather/surface/stations.txt
// METAR https://aviationweather.gov/adds/dataserver
// http://api.wunderground.com/api/5bd976229d3b1932/forecast10day/q/41.8497,-87.04444.xml 
// http://api.wunderground.com/api/5bd976229d3b1932/forecast10day/q/43.4842114,-80.5467194.xml  - waterloo  
// http://openweathermap.org/forecast

namespace Wunderground
{
    public class TWeatherState
    {
        public DateTime m_date = new DateTime();
        public float m_tmHigh = 0, m_tmLow = 0, m_wind_max_speed = 0;
        public float m_gpfDay = 0, m_gpfNight = 0, m_wind_degree = 0, precipitation = 0;   // gpf mm/day
        public int m_humidity = 0, m_pop = 0;
        public string m_Icon = "";
        public string m_ShortText = "";         // 1-12f  short text about a weather
        public string m_wind_direction = "";
        public string m_Text = "";              // detailed text about a weather
        public float  m_pressure;               // PA 
    };
    class TForecast
    {
        public TWeatherState[] m_fcst = new TWeatherState[10];
        public TForecast(float lattitude, float longitude)
        {
            for ( int index = 0; index < 10; index++)
            {
                m_fcst[index] = new TWeatherState();
            }
//            string wunderground_key = "5bd976229d3b1932"; // You'll need to goto http://www.wunderground.com/weather/api/, and get a key to use the API.
/*
            parse("http://api.wunderground.com/api/" + wunderground_key + "/forecast10day/q/"
                    + lattitude.ToString() + "," + longitude.ToString() + ".xml");
*/
        }
    }
}
