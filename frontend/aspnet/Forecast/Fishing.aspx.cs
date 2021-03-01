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
    public partial class Fishing : DbLayer
    {
        protected string m_fishGuid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            String userGuid = ""; String idFish = "";
            String country = "";
            try
            {
                userGuid = Session["user"].ToString();
                hdPath.Value = Session["path"].ToString();
                idFish = Session["fish"].ToString();
                country = Session["country"].ToString();
            }
            catch (Exception )
            {
                country = "US";
            }
            if (String.IsNullOrEmpty(userGuid))
            {
                return;
            }
        }
        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(m_fishGuid))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ButtonSubmit_Click", "alert('Fish guid is empty');", true);
                return;
            }
            try
            {
                using (SqlCommand cmd = new SqlCommand("spUpdateFishFood", m_dbObject.m_connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    Guid fishid = Guid.Parse(m_fishGuid);

                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = fishid;

                    if ( Guid.Empty == m_userGuid )
                    {
                        cmd.Parameters.Add("@editor", SqlDbType.UniqueIdentifier).Value = DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@editor", SqlDbType.UniqueIdentifier).Value = m_userGuid;
                    }
                    //                    cmd.Parameters.Add("@node_food_habitat", SqlDbType.NVarChar).Value = txtFood.Text;
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
    }
}