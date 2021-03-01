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

using ExtensionMethods;

namespace FishTracker
{
    public partial class TUserList : System.Web.UI.Page
    {
        protected bool m_IsTrial = false;
        protected string m_postal    = "N2M5L4";
        protected string m_logger = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Session["path"] = "";
                m_postal    = Request.QueryString["Postal"];
                String userGuid = "";
                var tr           = Session["trial"];
                try { userGuid = Session["sessionId"].ToString(); }
                catch (Exception ex) { m_logger += ex.Message;  }

                if (String.IsNullOrEmpty(userGuid))
                {
                    try { userGuid = Session["user"].ToString();  }
                    catch (Exception ex) { m_logger += ex.Message; }
                }
                if (!String.IsNullOrEmpty(m_postal))
                {
                    Session["Postal"] = m_postal;
                }
                string trial = "";

                if (null != tr)
                {
                    trial = tr.ToString();
                }else
                {
                     hiddenPlot.Value = "Plot.aspx";
                }
                m_IsTrial = (trial == "1" || String.IsNullOrEmpty(trial));
                string connStr = ConfigurationManager.ConnectionStrings["fishConnectionString"].ConnectionString;

                if (String.IsNullOrEmpty(connStr))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot get connection string", "alert('[Page_Load]: UserList');", true);
                    return;
                }
                if (System.Diagnostics.Debugger.IsAttached)
                {
                   // userGuid = "e9388505-7637-461b-a2d2-c42bf9769791"; // 0";
                }
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    if (null == con)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot set connection", "alert('[Page_Load]: UserList');", true);
                        return;
                    }
                    con.Open();

                    if (String.IsNullOrEmpty(m_postal) && !String.IsNullOrEmpty(userGuid))
                    {
                        try
                        {
                            // load station data
                            using (SqlCommand cmd = new SqlCommand("SELECT postal FROM users WHERE id=@id", con))
                            {
                                cmd.Parameters.Add("@id", SqlDbType.UniqueIdentifier).Value = Guid.Parse(userGuid);
                                SqlDataReader dr = cmd.ExecuteReader();
                                if (dr.Read())
                                {
                                    m_postal = dr["postal"].ToString();
                                    Session["Postal"] = m_postal;
                                    Session["sessionId"] = userGuid;
                                }
                                dr.Close();
                                
                            }
                        }
                        catch (Exception ex) { m_logger = ex.Message; }
                    }
                    if (String.IsNullOrEmpty(m_postal))
                    {
                        m_postal = "N2M5L4";
                        Session["Postal"] = m_postal;
                    }

                    hiddenPostal.Value = m_postal;
                    hiddenTrial.Value = m_IsTrial ? "1" : "0";

                    con.Close();
                }
            }catch( Exception ex )
            {
                String txt = ex.Message;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "UserList: [Page_Load]", txt, true);
            }
            
        }

    }
}

namespace ExtensionMethods
{
    public static class MyExtensions
    {
        public static int WordCount(this String str)
        {
            return str.Split(new char[] { ' ', '.', '?' }, StringSplitOptions.RemoveEmptyEntries).Length;
        }
    }
}