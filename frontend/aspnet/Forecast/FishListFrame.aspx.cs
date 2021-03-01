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

namespace FishTracker.Forecast
{
    public partial class FishListFrame : System.Web.UI.Page
    {
        public string m_connStr = "";
        protected Dictionary<Guid, string> Fishes = new Dictionary<Guid, string>();
        public float userLat = 0;
        public float userLon = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            m_connStr = ConfigurationManager.ConnectionStrings["fishConnectionString"].ConnectionString;
            if (String.IsNullOrEmpty(m_connStr))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot get connection string", "alert('[Page_Load]: Fish');", true);
                return;
            }
        }
        protected bool LoadInitialFishes( String postal, String trial, SqlConnection con )
        {
            string sqlCmd = "SELECT id, name FROM dbo.GetFishByPostal( @postal ) ORDER BY name ASC";

            if ("1" == trial)
            {
                sqlCmd = "SELECT id, name FROM dbo.GetTrialFishByPostal(  @postal ) ORDER BY name ASC";
            }
            using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
            {
                cmd.Parameters.Add("@postal", SqlDbType.VarChar).Value = postal;

                SqlDataReader dr = cmd.ExecuteReader();
                cblFish.Items.Clear();

                while (dr.Read())
                {
                    Guid fishId     = dr.GetGuid(0);
                    string fishName = dr.GetString(1);

                    Fishes[fishId] = fishName;
                    cblFish.Items.Add(fishName);
                }
                dr.Close();

                return true;
            }
        }

        protected void cblFish_Load(object sender, EventArgs e)
        {
            var postal = Request.QueryString["Postal"];   // location sid
            var trial  = Request.QueryString["Trial"];   // location sid

            using (SqlConnection con = new SqlConnection(m_connStr))
            {
                con.Open();
                if (LoadInitialFishes(postal, trial, con))
                {
                }
                else
                {
                    Response.Write("Could not identify index!");
                }
                con.Close();
            }

        }
    }
}