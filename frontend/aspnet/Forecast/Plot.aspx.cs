using System;
using Newtonsoft.Json;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;
using System.Web.Security;
using Wunderground;

// http://www.programmableweb.com/api/weather-channel
// http://api.openweathermap.org/data/2.5/station/find?lat=43.4723155&lon=-80.5399388&cnt=10&APPID=31bcac72e13696625c9c01d0030d92c9

namespace FishTracker.Forecast
{
    public partial class Plot : DbLayer
    {
        private float m_lattitude = 43.4842114f, m_longitude = -80.5467194f;
        private TWeatherState[] m_fcst = new TWeatherState[23];
        DateTime m_StationDate = DateTime.Now;
        private int m_forecast_length = 0;

        protected void SetPlotParams(string idPlace, string idFish)
        {
            try
            {
                 GetJsonPlot( idPlace, idFish );
                var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
#if RELEASE
                if (null == cookie)
                {
                    return;
                }
                var ticketInfo = FormsAuthentication.Decrypt(cookie.Value);

                if (null == ticketInfo || null == ticketInfo.UserData || 36 != ticketInfo.UserData.Length)
                {
                    return;
                }
                m_userGuid = Guid.Parse( ticketInfo.UserData );
#endif
                hlScience.NavigateUrl = hdPath.Value + "Science.aspx?id=" + idPlace;
                hlScience.Enabled = !m_IsTrial;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        public class WheatherPlot
        {
            public string place { get; set; }
            public string fish { get; set; }
            public string country { get; set; }
            public string state { get; set; }
            public string stamp { get; set; }       // last date/time taken from water service
            public string lakeid { get; set; }
            public IList<string> date { get; set; }
            public IList<float?> discharge { get; set; }
            public IList<float?> precipitation { get; set; }
            public IList<float?> temperature { get; set; }
            public IList<float?> turbidity { get; set; }
            public IList<float?> level { get; set; }

            public bool isMetric() { return (country == "CA" ? true : false); }
            public bool isValid(IList<float?> arr)  // check if array fully empty - do not display on plot
            {
                return true;
            }
            public void testData()
            {
                discharge.Clear(); precipitation.Clear(); temperature.Clear(); turbidity.Clear(); level.Clear();

                for (int i = 0; i < 23; i++)
                {
                    float val = (float)i;
                    discharge.Add(val -= val % 2 + val / 3);
                    precipitation.Add(val += val % 3 - val / 5);
                    temperature.Add(val -= val % 5 + val / 7);
                    turbidity.Add(val += val % 7 - val / 5);
                    level.Add(val -= val % 5 + val / 3);
                }
            }
            public String GetList(IList<float?> lst)
            {
                String result = "";
                bool step = false;
                foreach (var val in lst)
                {
                    string vls = (null == val ? "null" : val.ToString());
                    result += (step ? "," : "") + vls;
                    step = true;
                }
                return result;
            }
            public String GetList(IList<String> lst)
            {
                String result = "";
                bool step = false;
                foreach (var val in lst)
                {
                    result += (step ? ",'" : "'") + val + "'";
                    step = true;
                }
                return result;
            }
        }
        protected bool GetJsonPlot( string idPlace, string idFish )
        {
            try
            {
                WheatherPlot account = null;
                String sTurbidity = "null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null";
                String sTemperature = sTurbidity, sPrecipitation = sTurbidity;
                String sLine1 = sTurbidity;
                String sLine2 = sTurbidity;
                String sLine3 = sTurbidity;

                using (SqlCommand cmd = new SqlCommand("SELECT dbo.fn_forecast_plot_json( @placeId, @fishId )", m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@fishId", SqlDbType.VarChar).Value = idFish;
                    cmd.Parameters.Add("@placeId", SqlDbType.BigInt).Value = Convert.ToInt64(idPlace);

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        String jsonstr = dr.GetString(0);

                        account = JsonConvert.DeserializeObject<WheatherPlot>(jsonstr);
                    }
                    dr.Close();
                    /*
#if DEBUG
                    if (System.Diagnostics.Debugger.IsAttached)
                    {
                        account.testData();
                    }
#endif
                    */
                    Session["country"] = account.country;

                    hiddenPlaceName.Value = account.place;
                    hiddenFishName.Value  = account.fish;
                    LabelPlotDate.Text = account.stamp;

                    if (!String.IsNullOrEmpty(account.place))
                    {
                        HyperLinkPlotRiver.Visible = true;
                        HyperLinkPlotRiver.Text = account.place;
                        HyperLinkPlotRiver.NavigateUrl = 
                                "http://fishfind.info/Resources/wfRiverViewer.aspx?LakeId=" + account.lakeid.ToString();
                        LabelCountryVal.Text = account.country;
                        LabelStateVal.Text   = account.state;
                    }
                    if (account.isValid(account.temperature))
                    {
                        sUnitTemperature.Value = account.isMetric() ? "C" : "F";

                        sTemperature = account.GetList(account.temperature);
                    }
                    ClientScript.RegisterArrayDeclaration("g_TemperatureList", sTemperature);

                    if (account.isValid(account.precipitation))
                    {
                        sPrecipitation = account.GetList(account.precipitation);
                    }
                    ClientScript.RegisterArrayDeclaration("g_Precipitation", sPrecipitation);
                    if (account.isValid(account.turbidity))
                    {
                        sLine3 = account.GetList(account.turbidity);
                    }
                    if (account.isValid(account.level))
                    {
                        sLine2 = account.GetList(account.level);
                    }
                    if (account.isValid(account.discharge))
                    {
                        sLine1 = account.GetList(account.discharge);
                    }
                }
                {
                    sNameLine1.Value = "Discharge";
                    sNameLine2.Value = "Water Level";

                    if ("CA" == account.country)
                    {
                        sUnitLine1.Value = "m/s^3";
                        sUnitLine2.Value = "m";
                    }
                    else
                    {
                        sUnitLine1.Value = "ft/s^3";
                        sUnitLine2.Value = "ft";
                    }
                    ClientScript.RegisterArrayDeclaration("g_Line1List", sLine1);
                    ClientScript.RegisterArrayDeclaration("g_Line2List", sLine2);
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        protected bool LoadPlaceLatLon( string idPlace )
        {
            if (String.IsNullOrEmpty(idPlace) || null == m_fcst )
            {
                return false;
            }
            try
            {
                for (int index = 0; index < 23; index++)
                {
                    m_fcst[index] = new TWeatherState();
                }
                int stationSid = Int32.Parse(idPlace);
                string sqls = "SELECT dt, wind_degree, precipitation, wind_direction, temperature_low, temperature_high, wind_max_speed, Icon, shortText FROM dbo.fn_plot_weather(@sid)"; 

                // load forecast data
                using (SqlCommand cmd = new SqlCommand(sqls, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@sid", SqlDbType.Int).Value = stationSid;

                    SqlDataReader dr = cmd.ExecuteReader();

                    for (int index = 0; dr.Read() && index < 23; index++, m_forecast_length++)
                    {
                        m_fcst[index].m_date = dr.GetDateTime(0);

                        if (!String.IsNullOrEmpty(dr["wind_degree"].ToString()) )
                        {
                            m_fcst[index].m_wind_degree = (float)dr.GetDouble(1);
                        }
                        m_fcst[index].precipitation = (float)dr.GetInt32(2);

                        if (!String.IsNullOrEmpty(dr["wind_direction"].ToString()))
                        {
                            m_fcst[index].m_wind_direction = dr.GetString(3);
                        }
                        m_fcst[index].m_tmLow = (float)dr.GetInt32(4);
                        m_fcst[index].m_tmHigh = (float)dr.GetInt32(5);
                        if (!String.IsNullOrEmpty(dr["wind_max_speed"].ToString()))
                        {
                            m_fcst[index].m_wind_max_speed = (float)dr.GetInt32(6);
                        }
                        if (!String.IsNullOrEmpty(dr["Icon"].ToString()))
                        {
                            m_fcst[index].m_Icon = dr.GetString(7);
                        }
                        if (!String.IsNullOrEmpty(dr["shortText"].ToString()))
                        {
                            m_fcst[index].m_ShortText = dr.GetString(8);
                        }
                        //    m_fcst[index].m_Text = dr["longText"].ToString();
                        //   m_fcst[index].m_humidity = Convert.ToInt32(dr["humidity"].ToString());
                        //    m_fcst[index].m_pressure = Convert.ToSingle(dr["pressure"].ToString());
                    }

                    dr.Close();
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "LoadPlaceLatLon");
            }
            return false;
        }
        protected bool LoadWeather(string idPlace )
        {
            if (String.IsNullOrEmpty(idPlace) )
            {
                return false;
            }
            try
            {
                if (LoadPlaceLatLon( idPlace ))
                {

                    for (int j = 0; j < m_forecast_length; j++)  // final preprocessing
                    {
                        if (String.IsNullOrEmpty(m_fcst[j].m_wind_direction))
                        {
                            m_fcst[j].m_wind_direction = "dot";   // if no wind then display empty image
                        }
                    }
                    sMoonLine.Value = PrintMoonLine();
                    sWindLine.Value = PrintWindDescription();
                    sWeatherLine.Value = PrintWeatherState();

                    return true;
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }

        protected String PrintMoonLine()
        {
            String result = "<tr>";
            DateTime day = DateTime.Now.AddDays(-15);

            for (int i = 0; i < 23 ; i++)
            {
                int age = TMoonData.MoonAge(day.Day, day.Month, day.Year);
                int phase = TMoonData.phase[age];

                String alt  = TMoonData.alt[phase];
                String icon = TMoonData.icons[phase];

                string imageLine = String.Format("<img src=\"/Images/air/{0}.png\" alt=\"{1}\" height=\"15\" width=\"15\">"
                      , icon , alt );

                result += "<td>" + imageLine + "</td>";
                day = day.AddDays(1);
            }
            return result + "<td></td></tr>\n";
        }
        protected String PrintWeatherState()
        {
            String high = "<tr>";
            String low  = "<tr>";
            string link = "http://openweathermap.org/img/w/";

            for (int i = 0; i < 23; i++)
            {
                string content = "", tmHigh = "", tmLow = "";

                if (i < m_fcst.Length)
                {
                    TWeatherState iter = m_fcst[i];

                    if (!String.IsNullOrEmpty(iter.m_Icon))
                    {
                        content = string.Format("<img src=\"{0}{1}.png\" title=\"{2}\" height=\"24\" width=\"24\">"
                                 , link, iter.m_Icon, iter.m_ShortText);
                    }
                    if (iter.m_tmHigh != 0.0)
                    {
                        tmHigh = iter.m_tmHigh.ToString();
                    }
                    if (iter.m_tmLow != 0.0)
                    {
                        tmLow = iter.m_tmLow.ToString();
                    }
                }
                high += "<td>" + tmHigh + "</td>";
                low  += "<td>" + tmLow  + "</td>";
            }
            return high + "<td>C&#176;</td></tr>" + low + "<td></td></tr>";
        }
        protected String PrintWindDescription()
        {
            String result = "<tr>";

            for(int i = 0; i < 23; i++)
            {
                string img_dir = "", speed = "";

                if (i < m_fcst.Length )
                {
                    TWeatherState iter = m_fcst[i];

                    if (!String.IsNullOrEmpty(iter.m_Icon) && !String.IsNullOrEmpty(iter.m_wind_direction))
                    {
                        img_dir = "<img src=\"/Images/air/" + iter.m_wind_direction + ".png\" height=\"14\" width=\"14\">";
                    }
                    if (iter.m_wind_max_speed > 0)
                    {
                        speed = iter.m_wind_max_speed.ToString();
                    }
                }
                result += String.Format("<td>{0}</td>", speed );
            }
            return result + "<td>m/s</td></tr>";
        }
        // print water analisys

        protected void Page_Load(object sender, EventArgs e)
        {
            string idPlace = Request.QueryString["id"];     // location sid
            string idFish  = Request.QueryString["fish"];   // fish name

            if (System.Diagnostics.Debugger.IsAttached)
            {
                //   idPlace = "196285";
                if (String.IsNullOrEmpty(idFish))
                    idFish  = "99c7c368-bca1-4608-8caa-c05dee53ac25";

            }
            int idd = 0;
            HyperLinkPlotRiver.Visible = false;
            try
            {
                if (String.IsNullOrEmpty(idPlace) || !Int32.TryParse(idPlace, out idd))
                {
                    ClientScript.RegisterArrayDeclaration("g_datesList", "");
                    ClientScript.RegisterArrayDeclaration("g_TemperatureList", "");
                    ClientScript.RegisterArrayDeclaration("g_Line1List", "");
                    ClientScript.RegisterArrayDeclaration("g_Line2List", "");
                    ClientScript.RegisterArrayDeclaration("g_Precipitation", "");

                    return;
                }
                if (String.IsNullOrEmpty(idFish))
                {
                    if (Session["fish"] == null)
                    {
                        idFish = "00000000-0000-0000-0000-000000000000";
                    }
                    else
                    {
                        try { idFish = Session["fish"].ToString(); }
                        catch (Exception) { idFish = "00000000-0000-0000-0000-000000000000"; }
                    }
                }
                int station_id = 0;

                int.TryParse(idPlace, out station_id);

                Session["fish"] = idFish;
                try
                {
                    if(Session["path"] != null )
                    {
                        hdPath.Value = Session["path"].ToString();
                    }
                    if (Session["lat"] != null && Session["lon"] != null)
                    {
                        string lat = Session["lat"].ToString();
                        string lon = Session["lon"].ToString();
                        float.TryParse(lat, out m_lattitude);
                        float.TryParse(lon, out m_longitude);

                        LabelLat.Text = lat;
                        LabelLon.Text = lon;
                    }
                    
                }
                catch (Exception )
                {
                    //m_logger = ex.Message;
                }
                hlForecast.Visible = (0 < station_id);
                hlScience.Visible = (0 < station_id);

                if (0 < station_id)
                {
                    LoadWeather(idPlace);
                    SetPlotParams(idPlace, idFish);

                    using (SqlCommand cmd = new SqlCommand("SELECT mli, country FROM WaterStation WHERE sid=@sid", m_dbObject.m_connection))
                    {
                        cmd.Parameters.Add("@sid", SqlDbType.Int).Value = station_id;

                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            String mli = dr.GetString(0);
                            String country = dr.GetString(1);
                            hlMLI.Text = mli;

                            if ("CA" == country)
                            {
                                hlMLI.NavigateUrl = "https://wateroffice.ec.gc.ca/report/real_time_e.html?stn=" + mli;
                            }
                            else
                            {
                                hlMLI.NavigateUrl = "http://waterdata.usgs.gov/nwis/uv/?site_no=" + mli;
                            }
                        }
                        dr.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
    }
}