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
using System.Diagnostics;
using GeoSpace;

namespace FishTracker.Forecast
{
    public partial class MapFrame : DbLayer
    {
        protected Dictionary<Guid, string> Fishes = new Dictionary<Guid, string>();

        protected DateTime selectedDate = DateTime.Today;
        protected bool IsRegisterPlace = false;
        protected string m_range = "", m_logger = "";

        public String GetSelectedFishResult = "";
        public String TitleUserList = "Historical Data (Aggregated)";
         
        /// <summary>
        /// list of fishing around passed lat long
        /// </summary>
        /// <param name="lat"></param>
        /// <param name="lon"></param>
        /// <param name="firstFish"></param>
        /// <returns></returns>
        protected bool LoadInitialFishes(float lat, float lon, ref string firstFish)
        {
            string sqlCmd = "SELECT fish_id, fish_name FROM dbo.fn_map_fish_list_bylatlon( @lat, @lon, 3 ) ORDER BY 2";

            if (m_IsTrial)
            {
                   sqlCmd = "SELECT fish_id, fish_name FROM dbo.fn_map_fish_list_bylatlon_trial( @lat, @lon ) ORDER BY 2";                
            }
            HiddenRegisterWarning1.Value = m_IsTrial ? "Please register to see more" : "";
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lat", SqlDbType.Float).Value = lat;
                    cmd.Parameters.Add("@lon", SqlDbType.Float).Value = lon;

                    SqlDataReader dr = cmd.ExecuteReader();
                    cblFish.Items.Clear();
                    cblFish.Items.Add("Select desire fish...");

                    while (dr.Read())
                    {
                        Guid fishId = Guid.Parse(dr["fish_Id"].ToString());
                        string fishName = dr["fish_Name"].ToString();

                        Fishes[fishId] = fishName;
                        cblFish.Items.Add(fishName);
                    }
                    dr.Close();
                    if (0 < cblFish.Items.Count)
                        firstFish = cblFish.Items[0].Value;

                    return 0 < firstFish.Length;
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
         
        protected String FormatSingle( double value, int n)
        {
            double grade = 1;
            for (int i = 0; i < n; i++ )
            {
                grade *= 10;
            }
            return ((double)((int)(grade * value)) / grade).ToString();
        }

        protected bool LoadMapLocation( string firstFish )
        {
            if (null == firstFish || 0 == firstFish.Length)
            {
                return false;
            }
            PlaceListMapRegion.Items.Clear();
            PlaceListMapRegion.Items.Add("");

            string firstPlace = "";
            int maxLen = 0;

            String srcName = "SELECT lat, lon, today, location, sid, country, state, county FROM dbo.fn_map_location( @fishName, @lat, @lon, 0 )";

            if (m_IsTrial)
            {
                   srcName = "SELECT lat, lon, today, location, sid, country, state, county FROM dbo.fn_map_location_trial( @fishName, @lat, @lon )";
            }
            using (SqlCommand command = new SqlCommand(srcName, m_dbObject.m_connection))
            {
                command.Parameters.Add("@fishName", SqlDbType.VarChar).Value = firstFish;
                command.Parameters.Add("@lat", SqlDbType.Float).Value = m_userLat;
                command.Parameters.Add("@lon", SqlDbType.Float).Value = m_userLon;

                if (!m_IsTrial)
                {
                    command.Parameters.Add("@dist", SqlDbType.Float);
                    command.Parameters["@dist"].Value = 3;
                }
                SqlDataReader dr = command.ExecuteReader();

                double lonMin = 180.0f; double lonMax = -180.0f;
                double latMin = 180.0f; double latMax = -180.0f;
                List<String> oGeocodeList = new List<String>();
                List<String> oCountyList = new List<String>();
                HashSet<String> hashConty = new HashSet<String>();
                var  places = new Dictionary<String, List<TLatLonPoint>>();

                string savedPlace = "";
                try
                {
                    while (dr.Read())
                    {
                        string county = dr["county"].ToString().Trim();
                        string place = "";

                        if (!String.IsNullOrEmpty(county) && ("na" != county) && ("naa" != county))
                        {
                            place = county + " [" + dr["state"].ToString().Trim() + "]";
                            place.Replace('\'', '"');
                        }
                        double lat   = dr.GetDouble(0);
                        double lon = dr.GetDouble(1);
                        int today   = dr.GetInt32(2);
                        string name = dr["location"].ToString().Trim();
                        int sid        = dr.GetInt32(4);
                        string country = dr["country"].ToString().Trim();
                        string state = dr["state"].ToString().Trim();
                        int code = (0 == country.CompareTo("CA") ? 0 : 1);
                        {
                            string idx = country + state;

                            List<TLatLonPoint> lstPoint = null;
                            if (!places.ContainsKey(idx))
                            {
                                lstPoint = new List<TLatLonPoint>();
                            }
                            else
                            {
                                lstPoint = places[idx];
                            }
                            lstPoint.Add(new TLatLonPoint(lat, lon));
                        }
                        if (lonMin > lon) { lonMin = lon; }
                        if (lonMax < lon) { lonMax = lon; }
                        if (latMin > lat) { latMin = lat; }
                        if (latMax < lat) { latMax = lat; }

                        string ln = String.Format(" '{0},{1},{2},{3}' "
                                  , lat, lon, ((today / 10) - 1), sid); ;
                        oGeocodeList.Add(ln);

                        string placeName = " '" + sid + " |'"; // " + name.Trim() + "' ";

                        if (maxLen < placeName.Length)
                        {
                            maxLen = placeName.Length;
                        }
                        if (savedPlace != place && !String.IsNullOrEmpty(place))   // do not add duplicates into string list control - only unique counties
                        {
                            if (!hashConty.Contains(place)) // filter out duplicates
                            {
                                if (PlaceListMapRegion.Items.Count < 15)
                                {
                                    PlaceListMapRegion.Items.Add(place);
                                    string line = " '" + place + "| " + FormatSingle(lat, 3) + "| " + FormatSingle(lon, 3) + "|" + code + "'";
                                    oCountyList.Add(line);
                                    savedPlace = place;
                                    hashConty.Add(place);
                                }
                            } 
                        }
                        if (0 == firstPlace.Length)
                        {
                            firstPlace = name;
                        }
                    }
                }
                catch (Exception ex)
                {
                    DbEventLogger(ex, WhatsMyName());
                }      
                oCountyList.Add(" 'Ontario|51.2538|-85.3232|0'");
                try
                {
                    if (dr.HasRows)
                    {
                        String geocodevalues = string.Join(",", oGeocodeList.ToArray());
                        String counties = string.Join(",", oCountyList.ToArray());
                        ClientScript.RegisterArrayDeclaration("g_locationList", geocodevalues);
                        ClientScript.RegisterArrayDeclaration("g_countyList", counties);

                        // calc center of map
                        if (Math.Abs(lonMin - lonMax) < 0.00001)
                        {
                            mapLon.Value = lonMax.ToString();
                        }
                        else
                        {
                            mapLon.Value = (lonMin + Math.Abs(lonMin - lonMax) / 2).ToString();
                        }
                        if (Math.Abs(latMin - latMax) < 0.00001)
                        {
                            mapLat.Value = latMax.ToString();
                        }
                        else
                        {
                            mapLat.Value = (latMin + Math.Abs(latMin - latMax) / 2).ToString();
                        }
                    }
                    else
                    {
                        mapLon.Value = paramLon.Value;
                        mapLat.Value = paramLat.Value;
                        // LabelInfo.Text = "No locations are found for: " + firstFish + ". Please select different spiece.";
                    }
                    dr.Close();   //  mapLat.Value

                    return true;
                }
                catch (Exception ex)
                {
                    DbEventLogger(ex, WhatsMyName());
                }
                return false; ;
            }
        }

        public bool GetUserData( ref float lat, ref float lon )
        {
            try
            {
                var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                var ipv = Session["ip"];
                var trl = Session["trial"];

                string ipAddress = "127.0.0.0";

                if ((null != ipv) && ipv.ToString() != "::1")
                {
                    ipAddress = ipv.ToString();
                }
                zone51.Value = "Plot.aspx";
                int trial = -1;

                if (null != trl)
                {
                    trial = int.Parse(trl.ToString());

                    if( 0 < trial )
                    {
 //                       zone51.Value = "Weather\\plot.htm";
                    }
                }

                if (null == cookie)
                {
                    if (1 == trial)
                    {
                        return true;
                    }
                    using (SqlCommand cmd = new SqlCommand("SELECT TOP 1 lat, lon FROM dbo.fn_map_latlon_byip( @ip )", m_dbObject.m_connection))
                    {
                        cmd.Parameters.Add("@ip", SqlDbType.Char);
                        cmd.Parameters["@ip"].Value = ipAddress;

                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            string x = dr["lat"].ToString();
                            string y = dr["lon"].ToString();

                            Session["lat"] = x;
                            Session["lon"] = y;
                            Session["trial"] = '1';

                            lat = float.Parse(x);
                            lon = float.Parse(y);

                            dr.Close();
                            return true;
                        }
                        dr.Close();
                    }
                    return false;
                }
                var ticketInfo = FormsAuthentication.Decrypt(cookie.Value);

                if (null == ticketInfo || null == ticketInfo.UserData || 36 != ticketInfo.UserData.Length)
                {
                    return false;
                }
                using (SqlCommand cmd = new SqlCommand("SELECT TOP 1 lat, lon, postal FROM dbo.fn_map_user_location( @userId )", m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.UniqueIdentifier);
                    cmd.Parameters["@userId"].Value = Guid.Parse(ticketInfo.UserData);

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        string x = dr["lat"].ToString();
                        string y = dr["lon"].ToString();
                        string postal = dr["postal"].ToString();

                        Session["lat"] = x;
                        Session["lon"] = y;
                        Session["trial"] = '0';
                        Session["postal"] = postal;

                        lat = float.Parse(x);
                        lon = float.Parse(y);

                        dr.Close();
                        return true;
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }

        public bool GetLatLon(ref float lat, ref float lon, string postal, SqlConnection con)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("SELECT TOP 1 lat, lon FROM dbo.fn_map_LatLon_ByPostal( @postal )", m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@postal", SqlDbType.VarChar);
                    cmd.Parameters["@postal"].Value = postal;

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        string x = dr["lat"].ToString();
                        string y = dr["lon"].ToString();

                        Session["lat"] = x;
                        Session["lon"] = y;

                        lat = float.Parse(x);
                        lon = float.Parse(y);

                        dr.Close();
                        return true;
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        private bool LoadMapData()
        {
            bool result = false;
            try
            {
                if (null != m_postal && 5 < m_postal.Length)
                {
                    result = GetLatLon(ref m_userLat, ref m_userLon, m_postal, m_dbObject.m_connection);

                    if (!result)
                    {
                        return false;
                    }
                }
                if (!result && !GetUserData(ref m_userLat, ref m_userLon))
                {
                    return false;
                }
                paramLat.Value = m_userLat.ToString();
                paramLon.Value = m_userLon.ToString();

                mapLat.Value = paramLat.Value;
                mapLon.Value = paramLon.Value;

                int nrange = 3;

                if (!int.TryParse(m_range, out nrange))
                {
                    nrange = 3;
                }
                LoadMap(m_userLat, m_userLon, nrange);

                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
         
        protected void LoadMap(float userLat, float userLon, int nrange)
        {
            IsRegisterPlace = true;

            if (IsPostBack)
            {
                return;
            }
            var geocodevalues = " '" + userLat.ToString() + ", " + userLon.ToString() + "' ";

            String message = " '0 | You are here' ";

            if (!IsRegisterPlace)
            {
                ClientScript.RegisterArrayDeclaration("g_locationList", geocodevalues);

                ClientScript.RegisterArrayDeclaration("g_placeList", message);
            }
        }
         
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                m_postal = Request.QueryString["Postal"];
                String userGuid = "";

                var tr = Session["trial"];
                if (Session["user"] != null)
                {
                    try { userGuid = Session["user"].ToString(); }
                    catch (Exception ex) { m_logger += ex.Message; }
                }

                if (String.IsNullOrEmpty(m_postal) && Session["Postal"] != null )
                {
                    try { m_postal = Session["Postal"].ToString(); }
                    catch (Exception ex) { m_logger += ex.Message; m_postal = "N2M5L4"; }
                }
                else
                {
                    Session["Postal"] = m_postal;
                }
                string trial = "";

                if (null != tr)
                {
                    trial = tr.ToString();
                }
                m_IsTrial = (trial == "1" || String.IsNullOrEmpty(trial));

                if (String.IsNullOrEmpty(m_postal) && !String.IsNullOrEmpty(userGuid))
                {
                    try
                    {
                        // load station data
                        using (SqlCommand cmd = new SqlCommand("SELECT postal FROM dbo.users WHERE id=@id", m_dbObject.m_connection))
                        {
                            cmd.Parameters.Add("@id", SqlDbType.UniqueIdentifier).Value = Guid.Parse(userGuid);
                            SqlDataReader dr = cmd.ExecuteReader();
                            if (dr.Read())
                            {
                                m_postal = dr["postal"].ToString();
                                Session["Postal"] = m_postal;
                            }
                            dr.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        DbEventLogger(ex, WhatsMyName());
                    }
                }
                 LoadMapData();
                PlaceListMapRegion.Attributes.Add("onClick", "filterFishingRegionOnMap();");
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
 
        protected void cblFish_Load(object sender, EventArgs e)
        {
            string firstFish = "";
            string connStr = ConfigurationManager.ConnectionStrings["xConnectionString"].ConnectionString;

            if (0 < cblFish.Items.Count)
            {
                return;
            }
            if (!LoadInitialFishes(m_userLat, m_userLon, ref firstFish))
            {
                Response.Write("Could not identify User!");
            }

        }
        protected void cblFish_SelectedIndexChanged(object sender, EventArgs e)
        {
            PlaceListMapRegion.Items.Clear();

            string selectedFish = cblFish.SelectedItem.Value;

            if (String.IsNullOrEmpty(selectedFish))
            {
                return;
            }
            string connStr = ConfigurationManager.ConnectionStrings["xConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                Guid fishId = m_dbObject.GetSingleGuid("SELECT TOP 1 fish_id FROM fish WHERE fish_name like @param0", SqlDbType.NVarChar, selectedFish, WhatsMyName());

                if (fishId != Guid.Empty && null != con)
                {
                    fishGuid.Value = fishId.ToString();
                    Session["fish"] = fishId.ToString();

                    if (!LoadMapLocation(selectedFish))
                    {
                        // LabelInfo.Text = "Failed to get location for: " + selectedFish;
                    }
                }
                con.Close();
            }
        }

    }
}


//  document.getElementById('<%=Label1.ClientID%>').innerHTML = fllpath;

//   <!--    <tr><td></td><td class="auto-style26"><asp:Label ID="Label1" runat="server" Text="Label" Font-Size="Smaller"></asp:Label></td></tr> -->
     
