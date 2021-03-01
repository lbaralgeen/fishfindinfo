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

namespace FishTracker.Editor
{
    public partial class wfRiverViewer : System.Web.UI.Page
    {
        private string m_postal = "N2M5L4";
        private string connStr = "";
        private string m_logger = "";
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            m_postal = Request.QueryString["Postal"];

            var tr = Session["trial"];
            var riverId = Request.QueryString["LakeId"];

            connStr = ConfigurationManager.ConnectionStrings["fishConnectionString"].ConnectionString;

            if (String.IsNullOrEmpty(connStr))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot get connection string", "alert('[Page_Load]: UserList');", true);
                return;
            }
            LoadRiver(riverId, connStr);
        }
        private void LoadRiver( string sRiverGuid, string strConn )
        {
            if (String.IsNullOrEmpty(sRiverGuid) || String.IsNullOrEmpty(strConn))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "No river guid", "alert('[Page_Load]: LoadRiver');", true);
                return;
            }
            using (SqlConnection con = new SqlConnection(connStr))
            {
                if (null == con)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot set connection", "alert('[Page_Load]: UserList');", true);
                    return;
                }
                con.Open();

                if (!String.IsNullOrEmpty(sRiverGuid))
                {
                    try
                    {
                        // load station data
                        using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.fn_river_view( @lake_id )", con))
                        {
                            cmd.Parameters.Add("@lake_id", SqlDbType.UniqueIdentifier).Value = Guid.Parse(sRiverGuid);
                            SqlDataReader dr = cmd.ExecuteReader();

                            if (dr.Read())
                            {
                                mapLatX.Value = dr["sourceLat"].ToString();
                                mapLonX.Value = dr["sourceLon"].ToString();
                                mapLatY.Value = dr["mouthLat"].ToString();
                                mapLonY.Value = dr["mouthLon"].ToString();
                                description.Value = dr["description"].ToString();
                                stateCountry.Value = dr["stateCountry"].ToString();
                                riverName.Value = dr["lake_name"].ToString();
                                cLat.Value = dr["lat"].ToString();
                                cLon.Value = dr["lon"].ToString();
                                CTRL.SelectCommand = "SELECT * FROM dbo.fn_river_viewer_fish('" + sRiverGuid + "')";
                            }
                            dr.Close();
                        }
                    }
                    catch (Exception ex) { m_logger = ex.Message; }
                }
                con.Close();
            }

        }
    }
}