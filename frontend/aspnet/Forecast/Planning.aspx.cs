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

using ExtensionMethods;

namespace FishTracker
{
    public partial class TUserList : DbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Session["path"] = "";
                m_postal    = Request.QueryString["Postal"];
                String userGuid = "";
                var tr           = Session["trial"];
                try { userGuid = Session["sessionId"].ToString(); }
                catch (Exception ) {  }

                if (String.IsNullOrEmpty(userGuid))
                {
                    try { userGuid = Session["user"].ToString();  }
                    catch (Exception ) {  }
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
                if (System.Diagnostics.Debugger.IsAttached)
                {
                   // userGuid = "e9388505-7637-461b-a2d2-c42bf9769791"; // 0";
                }
                {
                    if (String.IsNullOrEmpty(m_postal) && !String.IsNullOrEmpty(userGuid))
                    {
                        try
                        {
                            // load station data
                            using (SqlCommand cmd = new SqlCommand("SELECT postal FROM users WHERE id=@id", m_dbObject.m_connection))
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
                        catch (Exception ) {  }
                    }
                    if (String.IsNullOrEmpty(m_postal))
                    {
                        m_postal = "N2M5L4";
                        Session["Postal"] = m_postal;
                    }

                    hiddenPostal.Value = m_postal;
                    hiddenTrial.Value = m_IsTrial ? "1" : "0";
                }
            }catch( Exception ex )
            {
                DbEventLogger(ex, WhatsMyName());
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