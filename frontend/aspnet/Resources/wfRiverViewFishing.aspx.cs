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
    public partial class RiverViewFishing : ResDbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            m_postal = Request.QueryString["Postal"];
            var riverId = Request.QueryString["LakeId"];

            var links = new Dictionary<string, HyperLink>
            {
                   {"Edit", HyperLinkEdit }
//                ,  {"Fishing", hlinkFishing }
//                ,  {"Regulations", hlinkRegulations }
//                ,  {"Weather", hlinkWeather }
            };

            SetMenu(riverId, links);
            LoadRiver(riverId);
        }

        private void LoadRiver( string sRiverGuid )
        {
            if (String.IsNullOrEmpty(sRiverGuid)  )
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "No river guid", "alert('[Page_Load]: LoadRiver');", true);
                return;
            }
            if (!String.IsNullOrEmpty(sRiverGuid))
            {
                try
                {
                    // load station data
                    using (SqlCommand cmd = new SqlCommand("SELECT TOP 1 * FROM dbo.fn_river_view_fishing( @lake_id )", m_dbObject.m_connection))
                    {
                        cmd.Parameters.Add("@lake_id", SqlDbType.UniqueIdentifier).Value = Guid.Parse(sRiverGuid);
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            string desc = ReadString(dr, "description");
                            if (!String.IsNullOrEmpty(desc))
                            {
                                description.Value = desc.Replace("\n", "<br>");
                            }
                            stateCountry.Value = ReadString(dr, "stateCountry");
                            riverName.Value = ReadString(dr, "lake_name");
                            Zone.Value = ReadString(dr, "Zone");
                            location.Value = ReadString(dr, "location");

                            stateName.Value = ReadString(dr, "stateName");
                            stateRules.Value = ReadString(dr, "stateRules");
                            stateParkRules.Value = ReadString(dr, "stateParkRules");
                            stateResidentFee.Value = ReadString(dr, "stateResidentFee");
                            stateNonResidentFee.Value = ReadString(dr, "stateNonResidentFee");

                            RegulationsTxt.Value = ReadString(dr, "Regulations");

                        }
                        dr.Close();
                    }
                }
                catch (Exception ex)
                {
                    DbEventLogger(ex, "LoadRiver");
                }
            }
        }
    }
}