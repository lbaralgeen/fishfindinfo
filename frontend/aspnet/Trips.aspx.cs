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
using System.Runtime.CompilerServices;

namespace FishTracker
{
    public partial class Trips : System.Web.UI.Page
    {
        public float userLat = 43;
        public float userLon = -80;

        public bool GetUserData(ref float lat, ref float lon, SqlConnection con)
        {
            try
            {
                var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];

                if (null == cookie)
                {
                    return false;
                }
                var ticketInfo = FormsAuthentication.Decrypt(cookie.Value);

                if (null == ticketInfo || null == ticketInfo.UserData || 36 != ticketInfo.UserData.Length)
                {
                    return false;
                }
                using (SqlCommand cmd = new SqlCommand("SELECT TOP 1 lat, lon FROM dbo.GetUserLocation( @userId )", con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.UniqueIdentifier);
                    cmd.Parameters["@userId"].Value = Guid.Parse(ticketInfo.UserData);

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        string x = dr["lat"].ToString();
                        string y = dr["lon"].ToString();

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
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Oops!! following error occured : " + ex.Message.ToString() + "');", true);
                Response.Write("Oops!! following error occured: " + ex.Message.ToString());
            }
            return false;
        }

        public bool GetLatLon(ref float lat, ref float lon, string postal, SqlConnection con)
        {
            LabelPostal.Text = postal;
            try
            {
                using (SqlCommand cmd = new SqlCommand("SELECT TOP 1 lat, lon FROM dbo.GetLatLonByPostal( @postal )", con))
                {
                    cmd.Parameters.Add("@postal", SqlDbType.VarChar);
                    cmd.Parameters["@postal"].Value = postal;

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        LabelLat.Text = dr["lat"].ToString();
                        LabelLon.Text = dr["lon"].ToString();

                        lat = float.Parse(LabelLat.Text);
                        lon = float.Parse(LabelLon.Text);

                        dr.Close();
                        return true;
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Oops!! following error occured : " + ex.Message.ToString() + "');", true);
                Response.Write("Oops!! following error occured: " + ex.Message.ToString());
            }
            return false;
        }
        protected void LoadMap( float lat, float lon)
        {
            List<String> oGeocodeList = new List<String>();

            oGeocodeList.Add(" '" + lat.ToString() + ", " + lon.ToString() + "' ");

            for (int i = 1; i < 5; i++)
            {
                oGeocodeList.Add(" '" + (i / 10.0f + lat).ToString() + ", " + (i / 10.0f + lon).ToString() + "' ");
            }
            var geocodevalues = string.Join(",", oGeocodeList.ToArray());

            List<String> oMessageList = new List<String>
                 {
                 " '<span class=formatText >You are here</span>' ",
                 " '<span class=formatText >Google Map 3 Awesome !!!</span>' ",
                 " '<span class=formatText>Made it very simple</span>' ",
                 " '<span class=formatText>Google Rocks</span>' "
                 };

            String message = string.Join(",", oMessageList.ToArray());

            ClientScript.RegisterArrayDeclaration("g_locationList", geocodevalues);

            ClientScript.RegisterArrayDeclaration("g_placeList", message);

        }
 
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["fishConnectionString"].ConnectionString;
            string postal  = Request.QueryString["Postal"];

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                bool result = true;

                if (null != postal && 5 < postal.Length)
                {
                    result = GetLatLon(ref userLat, ref userLon, postal, con);

                    if (!result)
                    {
                        con.Close();
                        return;
                    }
                }
                if (!result && !GetUserData(ref userLat, ref userLon, con))
                {
                    con.Close();
                    return; 
                }
                paramLat.Value = userLat.ToString();
                paramLon.Value = userLon.ToString();
                mapLat.Value = paramLat.Value;
                mapLon.Value = paramLon.Value;
                con.Close();
            }
            LoadMap(userLat, userLon);
        }
    }
}
