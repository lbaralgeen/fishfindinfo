/*
 *    ForecastFrame.aspx.cs
 */


using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using Wunderground;

// http://www.programmableweb.com/api/weather-channel
// http://api.openweathermap.org/data/2.5/station/find?lat=43.4723155&lon=-80.5399388&cnt=5&APPID=31bcac72e13696625c9c01d0030d92c9

namespace FishTracker.Forecast
{    
    public partial class ForecastFrame : System.Web.UI.Page
    {
        public string  m_connStr = "";
        private string m_userGuid = "";
        private float m_lattitude = 43.4842114f, m_longitude = -80.5467194f;
        private int m_IsLoadWheather = 0; 
        private string m_mli = "";
        private string m_county = "", m_city = "", m_state = "", m_locName = "", m_country = "";
        private TWeatherState[] m_fcst = new TWeatherState[10];
        private string m_oxygen = "", m_temperature = "", m_turbidity = "", m_gpd = "", m_discharge = "", m_waterLevel = "";
        private int m_probability = 0;
        DateTime m_StationDate = DateTime.Now;
        private bool m_bIsMetric = true;       

        protected bool SetPlaceFish(string idPlace, string idFish, SqlConnection con)
        {
            using (SqlCommand cmd = new SqlCommand("SELECT name, place FROM  dbo.GetFisNamePlaceDescr( @fishId, @placeId )", con))
            {
                cmd.Parameters.Add("@fishId", SqlDbType.UniqueIdentifier).Value = Guid.Parse(idFish);
                cmd.Parameters.Add("@placeId", SqlDbType.BigInt).Value = Convert.ToInt64(idPlace);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    hiddenFishName.Value = dr["name"].ToString();
                    hiddenPlaceName.Value = dr["place"].ToString();

                    dr.Close();
                    return true;
                }
                dr.Close();
            }
            return false;
        }
        protected void SetPlotParams(string idPlace, string idFish)
        {
            List<String> dateList = new List<String>();
            int days = 0;
            int prevMonth = -1;

            for (DateTime item = DateTime.Now; days < 10; days++, item = item.AddDays(1))
            {
                if ((prevMonth < item.Month) && (item == DateTime.Now) )
                {
                    prevMonth = item.Month;
                    dateList.Add(" '" + item.ToString("MMM") + " " + item.DayOfWeek.ToString().Substring(0, 3) + " " + item.Day.ToString() + "' ");
                }
                else
                {
                    dateList.Add(" '" + item.DayOfWeek.ToString().Substring(0, 3) + " " + item.Day.ToString() + "' ");
                }
            }
            String dates = string.Join(",", dateList.ToArray());

            ClientScript.RegisterArrayDeclaration("g_datesList",       dates);

            try
            {
                var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];

                if (null == cookie)
                {
                    return;
                }
                var ticketInfo = FormsAuthentication.Decrypt(cookie.Value);

                if (null == ticketInfo || null == ticketInfo.UserData || 36 != ticketInfo.UserData.Length)
                {
                    return;
                }
                m_userGuid = ticketInfo.UserData;

                using (SqlConnection con = new SqlConnection(m_connStr))
                {
                    if (null == con)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot set connection", "alert('[Page_Load]: UserList');", true);
                        return;
                    }

                    con.Open();

                    SetPlaceFish(idPlace, idFish, con);

                    con.Close();
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Oops!! following error occured : " + ex.Message.ToString() + "');", true);
                Response.Write("Oops!! following error occured: " + ex.Message.ToString());
            }

        }
        private bool SaveWeatherState(string idPlace, TForecast forecast, SqlConnection con)
        {
            if (String.IsNullOrEmpty(idPlace) || null == con || null == forecast )
            {
                return false;
            }
            try
            {
                int placeId = Convert.ToInt32(idPlace);

                if (0 > placeId)
                {
                    return false;
                }
                Guid meteoId = new Guid();
                // update data in station data
                using (SqlCommand cmd = new SqlCommand("spSaveWeatherState", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@condition", SqlDbType.VarChar).Value = forecast.m_fcst[0].m_Text;
                    cmd.Parameters.Add("@placeId", SqlDbType.Int).Value = idPlace;

                    SqlParameter pvNewId = new SqlParameter();
                    pvNewId.ParameterName = "@Id";
                    pvNewId.DbType = DbType.Guid;
                    pvNewId.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(pvNewId);

                    cmd.ExecuteNonQuery();

                    meteoId = Guid.Parse(pvNewId.Value.ToString());   // user' guid
                }
                //  delete forecast
                using (SqlCommand cmd = new SqlCommand("DELETE FROM weather_Forecast WHERE link = @link AND dt >= CONVERT(VARCHAR(10), GETDATE(),101)", con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@link", SqlDbType.UniqueIdentifier).Value = meteoId;
                    cmd.ExecuteNonQuery();
                }
                string sqlCmd = "INSERT INTO weather_Forecast (link, dt, tmHigh, tmLow, gpfDay, gpfNight"
                              + " , humidity, maxWin, degree, direction, shortText, longText, icon, pop)"
                              + " VALUES (@link, @dt, @tmHigh, @tmLow, @gpfDay, @gpfNight, @humidity, @maxWin"
                              + " , @degree, @direction, @shortText, @longText, @icon, @pop)";
                //  insert forecast
                for (int i = 0; i < 10; i++)
                {
                    using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
                    {
                        cmd.CommandType = CommandType.Text;

                        cmd.Parameters.Add("@link",     SqlDbType.UniqueIdentifier).Value = meteoId;
                        cmd.Parameters.Add("@dt",       SqlDbType.Date).Value = forecast.m_fcst[i].m_date;
                        cmd.Parameters.Add("@tmHigh",   SqlDbType.Real).Value = forecast.m_fcst[i].m_tmHigh;
                        cmd.Parameters.Add("@tmLow",    SqlDbType.Real).Value = forecast.m_fcst[i].m_tmLow;
                        cmd.Parameters.Add("@gpfDay",   SqlDbType.Real).Value = forecast.m_fcst[i].m_gpfDay;
                        cmd.Parameters.Add("@gpfNight", SqlDbType.Real).Value = forecast.m_fcst[i].m_gpfNight;
                        cmd.Parameters.Add("@humidity", SqlDbType.Int).Value = forecast.m_fcst[i].m_humidity;
                        cmd.Parameters.Add("@maxWin",   SqlDbType.Real).Value = forecast.m_fcst[i].m_maxWind;
                        cmd.Parameters.Add("@degree",   SqlDbType.Real).Value = forecast.m_fcst[i].m_degree;
                        cmd.Parameters.Add("@direction", SqlDbType.VarChar).Value = forecast.m_fcst[i].m_dir;
                        cmd.Parameters.Add("@shortText", SqlDbType.VarChar).Value = forecast.m_fcst[i].m_ShortText;
                        cmd.Parameters.Add("@longText", SqlDbType.VarChar).Value = forecast.m_fcst[i].m_Text;
                        cmd.Parameters.Add("@icon",     SqlDbType.VarChar).Value = forecast.m_fcst[i].m_Icon;
                        cmd.Parameters.Add("@pop",      SqlDbType.Int).Value = forecast.m_fcst[i].m_pop;

                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('[SaveWeatherState] following error occured : " + ex.Message.ToString() + "');", true);
                Response.Write("[SaveWeatherState] following error occured: " + ex.Message.ToString());
                return false;
            }
            return true;
        }
        protected bool LoadPlaceLatLon(string idPlace, string idFish, SqlConnection con)
        {
            if (String.IsNullOrEmpty(idPlace) || null == con || null == m_fcst )
            {
                return false;
            }
            for (int index = 0; index < 10; index++)
            {
                m_fcst[index] = new TWeatherState();
            }
            string lastCheck = "";
            Guid meteoId = new Guid();

            // load station data
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.GetStationInfo( @fishId, @placeId)", con))
            {
                cmd.Parameters.Add("@placeId", SqlDbType.BigInt).Value = Convert.ToInt32(idPlace);
                cmd.Parameters.Add("@fishId", SqlDbType.UniqueIdentifier).Value = Guid.Parse(idFish);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lastCheck       = dr["wheatherStamp"].ToString();
                    m_lattitude     = Convert.ToSingle(dr["lat"].ToString());
                    m_longitude     = Convert.ToSingle( dr["lon"].ToString());
                    m_IsLoadWheather = Int32.Parse( dr["loadWeather"].ToString() );  // 1 - load wheather, 0 - weather is chached for today
                    m_county        = dr["county"].ToString();
                    m_city          = dr["city"].ToString();
                    m_state         = dr["state"].ToString();
                    m_country       = dr["country"].ToString();
                    m_locName       = dr["locName"].ToString();
                    meteoId         = Guid.Parse(dr["id"].ToString());   // user' guid
                    m_oxygen        = dr["oxygen"].ToString();
                    m_temperature   = dr["temperature"].ToString();      // water temperature
                    m_turbidity     = dr["turbidity"].ToString();
                    m_discharge     = dr["discharge"].ToString();
                    m_waterLevel    = dr["elevation"].ToString();
                    string probability = dr["today"].ToString();
                    DateTime.TryParse(dr["stamp"].ToString(), out m_StationDate);          // time of update
                    m_mli           = dr["mli"].ToString(); 

                    if (String.IsNullOrEmpty(probability))
                        m_probability = 100;
                    else
                        m_probability = Convert.ToInt32(probability);
                    m_bIsMetric = (m_state == "ON" && m_country == "CA");
                }
                dr.Close();
            }

            if (String.IsNullOrEmpty(lastCheck) )
            {
                return true;   // no saved forecast
            }
            // load forecast data
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.fnWeatherForecast(@link)", con))
            {
                cmd.Parameters.Add("@link", SqlDbType.UniqueIdentifier).Value = meteoId;

                SqlDataReader dr = cmd.ExecuteReader();

                for (int index = 0; dr.Read() && index < 10; index++)
                {
                    m_fcst[index].m_date = Convert.ToDateTime( dr["dt"].ToString());
                    m_fcst[index].m_degree = Convert.ToSingle(dr["degree"].ToString());
                    m_fcst[index].m_gpfDay = Convert.ToSingle(dr["gpfDay"].ToString());
                    m_fcst[index].m_gpfNight = Convert.ToSingle(dr["gpfNight"].ToString());
                    m_fcst[index].m_humidity = Convert.ToInt32(dr["humidity"].ToString());
                    m_fcst[index].m_dir = dr["direction"].ToString();
                    m_fcst[index].m_tmLow = Convert.ToSingle(dr["tmLow"].ToString());
                    m_fcst[index].m_tmHigh = Convert.ToSingle(dr["tmHigh"].ToString());
                    m_fcst[index].m_maxWind = Convert.ToSingle(dr["maxWin"].ToString());
                    m_fcst[index].m_ShortText = dr["shortText"].ToString();
                    m_fcst[index].m_Text = dr["longText"].ToString();
                    m_fcst[index].m_Icon = dr["icon"].ToString();
                }

                dr.Close();
            }
            return true;
        }
        protected bool LoadWeather(string idPlace, string idFish)
        {
            if (String.IsNullOrEmpty(idPlace) )
            {
                return false;
            }
            List<String> temperatureList = new List<String>();
            List<String> probabilityList = new List<String>();
            List<String> precipitationList = new List<String>();
            List<String> turbidityList = new List<String>();
            List<String> dischargeList = new List<String>();
            List<String> waterLevelList = new List<String>();
            String condition = "Unknown condition";
 
            using (SqlConnection con = new SqlConnection(m_connStr))
            {
                con.Open();

                if (LoadPlaceLatLon(idPlace, idFish, con))
                {
                    // check if was hashed
                    if (10 != m_IsLoadWheather )
                    {
                        TForecast forecast = new TForecast(m_lattitude, m_longitude);
                        condition = forecast.m_fcst[0].m_Text; ;

                        if (!String.IsNullOrEmpty( condition))
                        {
                            if( SaveWeatherState(idPlace, forecast, con) )
                            {
                                m_fcst = forecast.m_fcst;
                            }
                        }
                    }
                    for (int j = 0; j < m_fcst.Length; j++)  // final preprocessing
                    {
                        if(  String.IsNullOrEmpty(m_fcst[j].m_dir) )
                        {
                            m_fcst[j].m_dir = "dot";   // if no wind then display empty image
                        }
                    }
                    m_gpd = ((int)(m_fcst[0].m_gpfDay + m_fcst[0].m_gpfNight)).ToString();
                    string turbidity = "0";
                    float fWaterLevel = 0.0f;

                    if (!String.IsNullOrEmpty(m_waterLevel) && float.TryParse(m_waterLevel, out fWaterLevel))
                    {
                        fWaterLevel = float.Parse(m_waterLevel);

                        if (fWaterLevel > 10)
                        {
                            fWaterLevel = 10 + fWaterLevel - (int)fWaterLevel;
                        }
                    }
                    
                    if (!String.IsNullOrEmpty(m_turbidity))
                    {
                        turbidity =  m_turbidity;
                    }
                    int probability = 100, today = 100;
                    float fDischarge = 0.0f;

                    float.TryParse(m_discharge, out fDischarge);

                    for (int index = 0; index < m_fcst.Length; index++)
                    {
                        probability = m_probability;
                        temperatureList.Add(   " " + m_fcst[index].m_tmHigh.ToString() + " ");
                        float totalPrecipitation = m_fcst[index].m_gpfDay + m_fcst[index].m_gpfNight;
                        precipitationList.Add( " " + totalPrecipitation.ToString() + " ");

                        probability -= (int)(m_fcst[index].m_gpfDay / 10);

                        if (0 > probability)
                            probability = 0;
                        if (0 == index)
                            today = probability;
                        probabilityList.Add(" " + probability.ToString() + " ");
                        turbidityList.Add(" " + turbidity + " ");

                        dischargeList.Add(" " + String.Format("{0,3:G}", fDischarge) + " ");
                        waterLevelList.Add(" " + ( totalPrecipitation / 100 + fWaterLevel ).ToString() + " "); // assume precipitation add some value to waterlevel 
                    }
                    if (String.IsNullOrEmpty(m_waterLevel))
                    {
                        waterLevelList.Clear();
                        waterLevelList.Add(" 0,0,0,0,0,0,0,0,0,0 ");
                    }
                    if (String.IsNullOrEmpty(m_discharge))
                    {
                        dischargeList.Clear();
                        dischargeList.Add(" 0,0,0,0,0,0,0,0,0,0 ");
                    }
                    String sTemperature   = string.Join(",", temperatureList.ToArray());
                    String sPrecipitation = string.Join(",", precipitationList.ToArray());
                
                    String sTurbidity     = string.Join(",", turbidityList.ToArray());
                    String sDischarge     = string.Join(",", dischargeList.ToArray());
                    String sProbability   = string.Join(",", probabilityList.ToArray());
                    String sWaterLevel    = string.Join(",", waterLevelList.ToArray());

                    ClientScript.RegisterArrayDeclaration("g_TemperatureList", sTemperature);
                    ClientScript.RegisterArrayDeclaration("g_WaterLevelList",  sWaterLevel);
                    ClientScript.RegisterArrayDeclaration("g_DischargeList",   sDischarge);
                    ClientScript.RegisterArrayDeclaration("g_ProbabilityList", sProbability);
                    ClientScript.RegisterArrayDeclaration("g_Precipitation",   sPrecipitation);
                    ClientScript.RegisterArrayDeclaration("g_Turbidity",       sTurbidity);

                    sTextGrid.Value = PrintAdminDescription(fWaterLevel, today);  // print water analisys
                    sMoonLine.Value = PrintMoonLine();
                    sWindLine.Value = PrintWindDescription();
                    sWeatherLine.Value = PrintWeatherState();

                    return true;
                }
                con.Close();
            }
            return false;
        }

        protected String PrintMoonLine()
        {
            String result = "";
            DateTime valiter = DateTime.Now;

            for (int day = 1; day <= 10; day++)
            {
                int age = TMoonData.MoonAge(valiter.Day, valiter.Month, valiter.Year);
                int phase = TMoonData.phase[age];

                String alt  = TMoonData.alt[phase];
                String icon = TMoonData.icons[phase];

                result += "<td class=\"auto-style3\"><img src=\"/Images/air/" + icon + ".png\" alt=\"" + alt + "\" title=\"" + alt + "\" height=\"24\" width=\"24\"></td>";
                result += "<td><table><tr><td class=\"auto-style5\"></td></tr><tr><td class=\"auto-style5\"></td></tr></table></td>";
                result += "<td class=\"auto-style4\"></td>\n";
                valiter = valiter.AddDays(1);
            }
            return result + "<td class=\"auto-style5\"></td>";
        }
        protected String PrintWeatherState()
        {
            String result = "";

            foreach (TWeatherState iter in m_fcst)
            {
                result += "<td class=\"auto-style3\"><img src=\"/Images/air/" + iter.m_Icon + ".png\" title=\"" + iter.m_ShortText + "\" height=\"24\" width=\"24\"></td>";
                result += "  <td><table><tr><td class=\"auto-style5\">" + iter.m_tmHigh.ToString()
                       + "</td></tr><tr><td class=\"auto-style5\">" + iter.m_tmLow.ToString() + "</td></tr></table></td>\n";
                result += "<td class=\"auto-style4\"></td>";
            }
                         
            return result + "<td class=\"auto-style5\">[C]</td>";
        }
        protected String PrintWindDescription()
        {
            String result = "";

            foreach (TWeatherState iter in m_fcst)
            {
                result += "<td class=\"auto-style3\"><img src=\"/Images/air/" + iter.m_dir + ".png\" height=\"24\" width=\"24\"></td>";
                result += "  <td><table><tr><td class=\"auto-style5\">" + iter.m_maxWind.ToString() + "</td></tr><tr><td class=\"auto-style5\"></td></tr></table></td>\n";
                result += "<td class=\"auto-style4\"></td>";
            }

            return result + "<td class=\"auto-style5\">[m/s]</td>";
        }
        // print water analisys
        protected String PrintAdminDescription(float fWaterLevel, float today)
        {
            String result = "";
            result += "<tr><td class=\"auto-style10\">" + m_locName + "</td><td class=\"auto-style9\">"
                            + m_city + "</td><td></td>";
            result += "<td class=\"auto-style10\">" + m_county + "</td><td class=\"auto-style9\">"
                            + m_state + "</td></tr>\n";

            if (!String.IsNullOrEmpty(m_oxygen) || !String.IsNullOrEmpty(m_temperature))
            {
                result += "<tr><td class=\"auto-style10\">Water oxygen: </td><td class=\"auto-style9\">";

                if (!String.IsNullOrEmpty(m_oxygen))
                {
                    result += Convert.ToSingle(m_oxygen).ToString("0.0") + " [mg/l]</td>";
                }
                else
                    result += "N/A</td>";

                result += "<td class=\"auto-style4\"></td>";
                result += "<td class=\"auto-style10\">Water temperature: </td><td class=\"auto-style9\">";

                if (!String.IsNullOrEmpty(m_temperature))
                {
                    result += Convert.ToSingle(m_temperature).ToString("0.0") + " [C]";
                }
                else
                    result += "N/A";

                result += "</td></tr>\n";
            }
            if (!String.IsNullOrEmpty(m_turbidity) || !String.IsNullOrEmpty(m_discharge))
            {
                result += "<tr><td class=\"auto-style10\">Water turbidity: </td><td class=\"auto-style9\">";

                if (!String.IsNullOrEmpty(m_turbidity))
                {
                    Single value = Convert.ToSingle(m_turbidity);
                    result += String.Format("{0,3:G}", value) + " [NTU]</td>";
                }
                else
                    result += "N/A</td>";
                result += "<td class=\"auto-style4\"></td>";
                result += "<td class=\"auto-style10\">Water discharge: </td><td class=\"auto-style9\">";

                if (!String.IsNullOrEmpty(m_discharge))
                {
                    Single value = Convert.ToSingle(m_discharge);
                    if (!m_bIsMetric)
                        value *= 0.028316847F;

                    result += String.Format("{0,3:G}", value) + " [m^3/s]";
                }
                else
                    result += "N/A";

                result += "</td></tr>\n";
            }
            if (!String.IsNullOrEmpty(m_waterLevel))
            {
                result += "<tr><td class=\"auto-style10\">Water level: </td><td class=\"auto-style9\">";

                if (!String.IsNullOrEmpty(m_waterLevel))
                {
                    if (!m_bIsMetric)
                        fWaterLevel *= 0.3048F;
                    result += String.Format("{0,3:G}", fWaterLevel) + " [m]</td>";
                }
                else
                    result += "N/A</td>";

                result += "<td class=\"auto-style4\"></td>";
                result += "<td class=\"auto-style10\"></td><td class=\"auto-style9\"></td></tr>\n";
            }
            if (!String.IsNullOrEmpty(m_gpd))
            {
                result += "<tr><td class=\"auto-style10\">Precipitation total: </td><td class=\"auto-style9\">";

                if (!String.IsNullOrEmpty(m_gpd))
                {
                    Single value = Convert.ToSingle(m_gpd);
                    result += String.Format("{0,3:G}", value) + " [mm]</td>";
                }
                else
                    result += "N/A</td>";

                result += "<td class=\"auto-style4\"></td>";
                result += "<td class=\"auto-style10\"></td><td class=\"auto-style9\"></td></tr>\n";
            }
            {
                result += "<tr><td class=\"auto-style10\">Station: </td>";
                result += "<td class=\"auto-style9\">";

                if (m_bIsMetric)
                    result += "<a href=\"http://wateroffice.ec.gc.ca/report/report_e.html?type=realTime&stn=" + m_mli + "\" target=\"_blank\">";
                else
                    result += "<a href=\"http://waterdata.usgs.gov/nwis/uv/?site_no=" + m_mli + "\" target=\"_blank\">";

                result += m_mli + "</a></td>";
                result += "<td class=\"auto-style4\"></td>";
                result += "<td class=\"auto-style10\">Last reading: </td>";
                result += "<td class=\"auto-style9\">" + m_StationDate.ToString() + " </td></tr>\n";
            }
            {
                result += "<tr><td class=\"auto-style10\"> </td>";
                result += "<td class=\"auto-style9\"></td>";
                result += "<td class=\"auto-style4\"></td>";
                result += "<td class=\"auto-style10\">Fishing probability: </td>";
                result += "<td class=\"auto-style9\">" + today.ToString() + " [%]</td></tr>\n";
            }
            return result;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            var idPlace = Request.QueryString["id"];   // location sid
            var idFish = Request.QueryString["fish"];   // location sid

            if (String.IsNullOrEmpty(idPlace) || String.IsNullOrEmpty(idFish))
            {
                return;
            }
            m_connStr = ConfigurationManager.ConnectionStrings["fishConnectionString"].ConnectionString;
            if (String.IsNullOrEmpty(m_connStr))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot get connection string", "alert('[Page_Load]: Graph');", true);
                return;
            }
            LoadWeather(idPlace, idFish);
            SetPlotParams( idPlace, idFish );
        }
    }
}