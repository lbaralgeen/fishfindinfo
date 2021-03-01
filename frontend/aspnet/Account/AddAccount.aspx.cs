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

// http://fishportal.biz/Account/AddAccount.aspx?Login=User123&Psw=MyPassword&Title=Mr&FirstName=John&LastName=Doe&Email=tn@mail.ru&Postal=N2M5L4&UserGuid=E9378505-7637-461B-A2D2-C42BF9769790
namespace FishTracker.Account
{
    public partial class AddAccount : System.Web.UI.Page
    {
        String m_error = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = ConfigurationManager.ConnectionStrings["fishConnectionString"].ConnectionString;
            String loginId = Request.QueryString["Login"];
            String passwrd = Request.QueryString["Psw"];
            String title = Request.QueryString["Title"];
            String firstName = Request.QueryString["FirstName"];
            String lastName = Request.QueryString["LastName"];
            String email = Request.QueryString["Email"];
            String postal = Request.QueryString["Postal"];
            String userGuid = Request.QueryString["UserGuid"];

            if (String.IsNullOrEmpty(connStr) || String.IsNullOrEmpty(loginId) || String.IsNullOrEmpty(passwrd)
                 || String.IsNullOrEmpty(title) || String.IsNullOrEmpty(firstName) || String.IsNullOrEmpty(lastName)
                 || String.IsNullOrEmpty(email) || String.IsNullOrEmpty(postal) || String.IsNullOrEmpty(userGuid))
            {
                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                HttpContext.Current.Response.Write("[Error='Bad parameters']");
                Response.End();
                return;
            }

            if (IsPostBack)
            {
                return;
            }

            if (String.IsNullOrEmpty(connStr))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot get connection string", "alert('[Page_Load]: Account');", true);
                return;
            }
            using (SqlConnection con = new SqlConnection(connStr))
            {
                if (null == con)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot set connection", "alert('[Page_Load]: Account');", true);
                    return;
                }
                con.Open();
                try
                {

                    using (SqlCommand cmd = new SqlCommand("spAddExtUser", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        Guid user = Guid.Parse(userGuid);
                        cmd.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = user;
                        cmd.Parameters.Add("@userName", SqlDbType.NVarChar).Value = loginId;
                        cmd.Parameters.Add("@psw", SqlDbType.NVarChar).Value = passwrd;
                        cmd.Parameters.Add("@titul", SqlDbType.NVarChar).Value = title;
                        cmd.Parameters.Add("@firstName", SqlDbType.NVarChar).Value = firstName;
                        cmd.Parameters.Add("@lastName", SqlDbType.NVarChar).Value = lastName;
                        cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
                        cmd.Parameters.Add("@postal", SqlDbType.VarChar).Value = postal;

                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            string userId = dr["userId"].ToString();
                            string userHash = dr["Hash"].ToString();
                            m_error = " ";

                            Response.Clear();
                            Response.ContentType = "application/json; charset=utf-8";
                            HttpContext.Current.Response.Write("[id='" + userId + "', hash='" + userHash + "']");
                            Response.End();
                        }
                    }
                }catch( Exception ex )
                {
                    if (String.IsNullOrEmpty(m_error))
                    {
                        Response.Clear();
                        Response.ContentType = "application/json; charset=utf-8";
                        HttpContext.Current.Response.Write("[error='" + ex.Message + "']");
                        Response.End();
                    }
                }
                con.Close();
            }
        }
    }
}