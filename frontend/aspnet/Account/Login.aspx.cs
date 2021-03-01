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
    public partial class TLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //            RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
        }
        protected string GetJScriptAlert( string message )
        {
            return "<script type='text/javascript'>alert('" + message + "');</script>";
        }
        protected void LoginUser_LoggingIn(object sender, LoginCancelEventArgs e)
        {
            try
            {

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["xConnectionString"].ConnectionString))
                {
                    con.Open();

                    using (SqlCommand cmd = new SqlCommand("spTestUser", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@userName", LoginUser.UserName.Trim());
                        cmd.Parameters.AddWithValue("@psw", LoginUser.Password.Trim());

                        SqlParameter pvNewId = new SqlParameter();
                        pvNewId.ParameterName = "@userId";
                        pvNewId.DbType = DbType.Guid;
                        pvNewId.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(pvNewId);

                        cmd.ExecuteNonQuery();


                        if (null == pvNewId.Value)
                        {
                            string message = GetJScriptAlert("Failed to get user's Id: " + LoginUser.UserName);
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "Alert", message);
                            Session["trial"] = "1";
                            return;
                        }
                        string userGuid = pvNewId.Value.ToString();   // user' guid

                        if (36 != userGuid.Length)
                        {
                            string message = GetJScriptAlert("User's Id has wrong format: " + LoginUser.UserName);
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "Alert", message);
                            Session["trial"] = "1";
                            return;
                        }
                        // Query the user store to get this user's User Data

                        // Create the cookie that contains the forms authentication ticket
                        HttpCookie authCookie = FormsAuthentication.GetAuthCookie(LoginUser.UserName, LoginUser.RememberMeSet);

                        if (null == authCookie)
                        {
                            Session["trial"] = "1";
                            return;
                        }
                        // Get the FormsAuthenticationTicket out of the encrypted cookie
                        FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);

                        if (null == ticket)
                        {
                            Session["trial"] = "1";
                            return;
                        }
                        // Create a new FormsAuthenticationTicket that includes our custom User Data
                        FormsAuthenticationTicket newTicket = new FormsAuthenticationTicket(ticket.Version, ticket.Name, ticket.IssueDate, ticket.Expiration, ticket.IsPersistent, userGuid);

                        // Update the authCookie's Value to use the encrypted version of newTicket  
                        authCookie.Value = FormsAuthentication.Encrypt(newTicket);

                        // Manually add the authCookie to the Cookies collection
                        Response.Cookies.Add(authCookie);

                        // Determine redirect URL and send user there
                        string redirUrl = FormsAuthentication.GetRedirectUrl(LoginUser.UserName, LoginUser.RememberMeSet);
                        Response.Redirect(redirUrl);
                        Session["trial"] = "0";
                    }
                    con.Close();
                }
            }
            catch(Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Oops!! following error occured : " + ex.Message.ToString() + "');", true);
                Response.Write("Oops!! following error occured: " +ex.Message.ToString());           
            }
 
            // If we reach here, the user's credentials were invalid
//            InvalidCredentialsMessage.Visible = true;
        }

    }
}


