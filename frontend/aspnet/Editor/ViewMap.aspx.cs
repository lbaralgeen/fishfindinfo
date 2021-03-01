using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace FishTracker.Editor
{
    public partial class ViewMap : DbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!m_IsAdmin)
            {
                Response.Redirect("/Default.aspx");
                return;
            }
            String userGuid = "";

            if(Session["user"] != null)
            {
                try { userGuid = Session["user"].ToString(); } catch (Exception) { }
            }
            String country = Request.QueryString["Country"];
            String state = Request.QueryString["State"];

            if (String.IsNullOrEmpty(userGuid))
            {
                return;
            } 
            if (String.IsNullOrEmpty(country))
            {
                country = "US";
            }
            hdPath.Value = "../Forecast/";
            Session["path"] = hdPath.Value;
            var oGeocodeList = new List<String>();
            try
            {
                string sqlcmd = " lat, lon, sid FROM vMapView WHERE country=@country";

                if (!String.IsNullOrEmpty(state))
                {
                    sqlcmd += " AND state='" + state + "' ";
                }
                if (System.Diagnostics.Debugger.IsAttached)
                {
                    //sqlcmd = " TOP 100 " + sqlcmd;
                }
                hdxy.Value = "43.1,-81.1";
                // select lat, lon, sid FROM vMapView WHERE country='CA'
                using (SqlCommand cmd = new SqlCommand("SELECT " + sqlcmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@country", SqlDbType.Char, 2).Value = country;
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        string slat = dr["lat"].ToString();
                        string slon = dr["lon"].ToString();
                        Int32 sid = dr.GetInt32(2);

                        oGeocodeList.Add(" '" + slat + "," + slon + "," + ToBase36((ulong)sid) + ",0' ");
                    }
                    dr.Close();
                }
                if( 0 < oGeocodeList.Count )
                {
                    String geocodevalues = string.Join(",", oGeocodeList.ToArray());
                    ClientScript.RegisterArrayDeclaration("g_locationList", geocodevalues);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        private static string ToBase36(ulong value)
        {
            const string base36 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            var sb = new StringBuilder(13);
            do
            {
                sb.Insert(0, base36[(byte)(value % 36)]);
                value /= 36;
            } while (value != 0);
            return sb.ToString();
        }
    }
}