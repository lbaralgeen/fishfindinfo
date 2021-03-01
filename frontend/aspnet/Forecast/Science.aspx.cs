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

namespace FishTracker.Forecast
{
    public partial class Science : FishTracker.DbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String userGuid = ""; String idFish = "";
            String country = "" ;
            hdPath.Value = "";

            hlForecast.Enabled = m_IsAdmin;

            if (null != Session && Session["user"] != null)
            {
                try { userGuid = Session["user"].ToString(); } catch (Exception) { }
            }
            if (null != Session && Session["path"] != null)
            {
                try { hdPath.Value = Session["path"].ToString(); } catch (Exception) { hdPath.Value = "~/Forecast "; }
            }           
            if (HttpContext.Current.Session["fish"] != null)
            {
                idFish = Session["fish"].ToString();
            }
            if (HttpContext.Current.Session["country"] != null)
            {
                country = Session["country"].ToString();
            }
            else
            {
                country = "CA";
            }

            if (String.IsNullOrEmpty(userGuid))
            {
                if (!System.Diagnostics.Debugger.IsAttached)
                {
                    return;
                }
            }
            String id = Request.QueryString["id"];
            int sid = 266824;

            if( !String.IsNullOrEmpty(id) && !Int32.TryParse(id, out sid) || sid <= 0)
            {
                if (!System.Diagnostics.Debugger.IsAttached)
                {
                    return;
                }
            }
            if(m_IsAdmin)
                hlForecast.NavigateUrl = hdPath.Value + "Plot.aspx?id=" + id + "&fish=" + idFish;
            try
            {
                {
                    string arr = m_dbObject.GetSingleString( "SELECT mli+'|'+country FROM WaterStation WHERE sid=@param0", SqlDbType.Int, sid, "Page_Load");
                    string[] vals = arr.Split('|');

                    string mli = vals[0];
                    country    = vals[1];

                    if ( !String.IsNullOrEmpty(mli))
                    {
                        string sqlcmd2 = String.Format("SELECT CAST(fish_id AS varchar(36)), fish_name, fish_latin FROM dbo.fn_getfirstmlifish('{0}')", mli);
                        var fish = m_dbObject.GetSingleSSS(m_dbObject.m_connection, sqlcmd2, null, null, "Page_Load");

                        if (fish != null)
                        {
                            idFish = fish.Item1;
                            LabelGuid.Text = fish.Item1;
                            LabelFishName.Text = fish.Item2;
                            LabelFishLatin.Text = fish.Item3;
                        }
                    }
                    LabelSID.Text = sid.ToString();
                    hlMLI.Text = mli;

                    if ("CA" == country)
                    {
                        hlMLI.NavigateUrl = "https://wateroffice.ec.gc.ca/report/real_time_e.html?stn=" + mli;
                    }
                    else
                    {
                        hlMLI.NavigateUrl = "http://waterdata.usgs.gov/nwis/uv/?site_no=" + mli;
                    }
                    string sqlcmd = "select TOP 1 * from dbo.vScienceView WHERE @sid = sid order by dt desc, tm desc";
                    using (SqlCommand cmd = new SqlCommand(sqlcmd, m_dbObject.m_connection))
                    {
                        cmd.Parameters.Add("@sid", SqlDbType.Int).Value = sid;
//                        cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = Guid.Parse(idFish);
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            lbLocName.Text = dr["locName"].ToString();
                            lbCity.Text = dr["city"].ToString();
                            lbState.Text = dr["state"].ToString();
                            lbDate.Text = dr["dt"].ToString();
                            lbTime.Text = dr["tm"].ToString();

                            lbLat.Text = dr["Lat"].ToString();
                            lbLon.Text = dr["Lon"].ToString();
                            Session["lat"] = dr["Lat"].ToString();
                            Session["lon"] = dr["Lon"].ToString();

                            lbTemperature.Text = dr["Temperature"].ToString();
                            lbTempUnit.Text = dr["temperature_unit"].ToString();
                            lbDischarge.Text = dr["Discharge"].ToString();
                            lbDischUnit.Text = dr["Discharge_unit"].ToString();

                            lbElevation.Text = dr["Elevation"].ToString();
                            lbElevUnit.Text = dr["Elevation_unit"].ToString();
                            lbVelocity.Text = dr["Velocity"].ToString();
                            lbVelUnit.Text = dr["Velocity_unit"].ToString();

                            lbOxygen.Text = dr["Oxygen"].ToString();
                            lbPH.Text = dr["PH"].ToString() ;
                            lbTurbidity.Text = dr["Turbidity"].ToString();
                         //   lbConductance.Text = dr["Conductance"].ToString();
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