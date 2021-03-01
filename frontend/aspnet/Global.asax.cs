using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FishTracker
{
    public class Global : System.Web.HttpApplication
    {

        void Application_Start(object sender, EventArgs e)
        {
            Application["UsersOnline"] = 0;
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown
            Session_End(sender, e);
        }

        void Application_Error(object sender, EventArgs e)
        {
            try
            {
                Application["UsersOnline"] = 0;
#if (!DEBUG)
            Session_End(sender, e);
            Response.Redirect("~/Default.aspx?Clean=1");
#endif

            }
            catch (Exception)
            {
                Response.Redirect("~/Default.aspx?Clean=1");
            }
        }

        protected string RegisterSession()
        {
            string result ="";
            DbLayer.s_connParameter = "xConnectionString";

            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null ? "" : context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            string userAgent = context.Request.UserAgent;
            string hostAddress = context.Request.UserHostAddress;
            string hostName = context.Request.UserHostName;
            string pageUrl = context.Request.Url.AbsolutePath;

            if (null == ipAddress || 0 == ipAddress.Length)
            {
                ipAddress = context.Request.ServerVariables["REMOTE_ADDR"];
            }
            Session["ip"] = ipAddress;
            Session["UserId"] = "00000000-0000-0000-0000-000000000000";
            Session["sessionId"] = "00000000-0000-0000-0000-000000000000";
            try
            {
                string paramname = DbLayer.s_connParameter;
                string connstr = ConfigurationManager.ConnectionStrings[paramname].ConnectionString;

                if( String.IsNullOrEmpty(connstr))
                {
                    return "Fail to connect";
                }
                using (SqlConnection con = new SqlConnection(connstr))
                {
                    con.Open();

                    using (SqlCommand cmd = new SqlCommand("spSaveSession", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@ipaddr", SqlDbType.VarChar).Value = ipAddress;
                        cmd.Parameters.Add("@agent", SqlDbType.VarChar).Value = userAgent;
                        cmd.Parameters.Add("@host", SqlDbType.VarChar).Value = hostName;
                        cmd.Parameters.Add("@page", SqlDbType.VarChar).Value = pageUrl;
                        cmd.Parameters.Add("@cookie", SqlDbType.VarChar).Value = HttpContext.Current.Session.SessionID;

                        SqlParameter pvNewId = new SqlParameter(); 
                        pvNewId.ParameterName = "@sessionId";
                        pvNewId.DbType = DbType.Guid;
                        pvNewId.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(pvNewId);

                        cmd.ExecuteNonQuery();

                        result = pvNewId.Value.ToString(); 
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("[RegisterSession]: following error occured: " + ex.Message.ToString());
            }
            return result;
        }

        protected void CloseSession( string sessionId, string userId, int visited )
        {
            if (null == sessionId || 0 == sessionId.Length )
            {
                return;
            }
            try
            {
                if (Session != null)
                {
                    // clean cockie 
                    try
                    {
                        Session["trial"] = "1";
                        Session["UserId"] = "00000000-0000-0000-0000-000000000000";
                        Session["sessionId"] = "00000000-0000-0000-0000-000000000000";
                    }
                    catch (Exception) { }
                }
                string pageUrl = "";
                System.Web.HttpContext context = System.Web.HttpContext.Current;

                if (null != context)
                {
                    pageUrl = context.Request.Url.AbsolutePath;
                }
                Guid sId = new Guid(sessionId);
                Guid uId = new Guid(userId);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["xConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("spCloseSession", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@sessionId",    SqlDbType.UniqueIdentifier).Value = sId;
                        cmd.Parameters.Add("@page", SqlDbType.VarChar).Value = pageUrl;
                        cmd.Parameters.Add("@userId",       SqlDbType.UniqueIdentifier).Value = uId;
                        cmd.Parameters.Add("@visitedPages", SqlDbType.Int).Value              = visited;

                        Session["SessionId"] = RegisterSession();

                        con.Open();

                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("[CloseSession]: following error occured: " + ex.Message.ToString());
            }
        }
        void Session_Start(object sender, EventArgs e)
        {
            Application.Lock();
            Application["UsersOnline"] = (int)Application["UsersOnline"] + 1;
            Session["UserId"] = "";
            Session["Visited"] = "0";
            Session["trial"] = "1";
            RegisterSession();
            Application.UnLock();
        }

        void Session_End(object sender, EventArgs e)
        {
            Application.Lock();
            try
            {
                Application["UsersOnline"] = (int)Application["UsersOnline"] - 1;
                String UserId = "";
                String sessId = "";
                int visited = 0;

                if (Session != null)
                {
                    if (Session["UserId"] != null)
                    {
                        UserId = Session["UserId"].ToString();
                    }
                    if (Session["SessionId"] != null)
                    {
                        sessId = Session["SessionId"].ToString();
                    }
                    if (Session["Visited"] != null && UserId != null)
                    {
                        String vst = Session["Visited"].ToString();
                        visited = int.Parse(vst);
                    }
                    CloseSession(UserId, sessId, visited);
                }
            }
            catch (Exception ex)
            {   
                if (null != ex)
                {
//                    Response.Write("[Session_End]: following error occured: " + ex.Message.ToString());
                }
            }
            Application.UnLock();
        }


    }
}
