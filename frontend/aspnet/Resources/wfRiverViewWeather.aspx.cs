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

namespace FishTracker.Resources
{
    public partial class RiverViewWeather : ResDbLayer
    {
        private string m_riverId = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            try { m_postal = Request.QueryString["Postal"]; } catch (Exception) { }

            try { m_postal = Request.QueryString["Postal"]; } catch (Exception) { }
            try { m_riverId = Request.QueryString["LakeId"]; } catch (Exception) { }

            if (System.Diagnostics.Debugger.IsAttached)
            {
                m_riverId = "9B879189-67AE-412C-9D67-6082AB3A0846";
            }
            else
            {
                return;
            }
            var links = new Dictionary<string, HyperLink>
            {
                   {"Edit", HyperLinkEdit }
                ,  {"Fishing", hlinkFishing }
//                ,  {"Regulations", hlinkRegulations }
//                ,  {"Weather", hlinkWeather }
            };

            SetMenu(m_riverId, links);
            LoadRiver(m_riverId);
        }

        private void LoadRiver( string sRiverGuid )
        {
            if (String.IsNullOrEmpty(sRiverGuid)   )
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "No river guid", "alert('[Page_Load]: LoadRiver');", true);
                return;
            }
            if (!String.IsNullOrEmpty(sRiverGuid))
            {
                try
                {
                    // load station data
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.fn_river_view_regulations( @lake_id )", m_dbObject.m_connection))
                    {
                        cmd.Parameters.Add("@lake_id", SqlDbType.UniqueIdentifier).Value = Guid.Parse(sRiverGuid);
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            string desc = dr["description"].ToString();
                            description.Value = desc.Replace("\n", "<br>");

                            stateCountry.Value = dr["stateCountry"].ToString();
                            riverName.Value = dr["lake_name"].ToString();
                            Zone.Value = dr["Zone"].ToString();
                            location.Value = dr["location"].ToString();

                            stateName.Value = dr["stateName"].ToString();
                            stateRules.Value = dr["stateRules"].ToString();
                            stateParkRules.Value = dr["stateParkRules"].ToString();
                            stateResidentFee.Value = dr["stateResidentFee"].ToString();
                            stateNonResidentFee.Value = dr["stateNonResidentFee"].ToString();

                            RegulationsTxt.Value = dr["Regulations"].ToString();
                            int IsException = int.Parse(dr["IsException"].ToString());

                            phException.Visible = (IsException == 1 ? true : false );

                            String lakeguid = dr["lake_id"].ToString();


                            CTRL.SelectCommand = "SELECT part, fish_name, close_time, sport, conservation FROM dbo.fn_lake_regulation('" + lakeguid + "')";
                        }
                        dr.Close();
                    }
                }
                catch (Exception ex)
                {
                    DbEventLogger(ex);
                }
            }

        }
    }
}