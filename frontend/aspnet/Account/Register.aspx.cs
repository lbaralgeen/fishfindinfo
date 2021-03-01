using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using GooglereCAPTCHa.Models;
using System.Data.SqlClient;

// https://developers.google.com/recaptcha/docs/start

namespace FishTracker
{
    public partial class RegisterAccount : System.Web.UI.Page
    {
        String m_conn_str;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            m_conn_str = ConfigurationManager.ConnectionStrings["xConnectionString"].ConnectionString;
        }
        public bool ValidateCaptcha(ref string Message)
        {
            var response = Request["g-recaptcha-response"];
            //secret that was generated in key value pair
            const string secret = "6LfkBjgUAAAAAI4gkGBdMKHnb-idhWwv1wmxlnAl";  // site key frm here: https://www.google.com/recaptcha/admin#site/339216100?setup
            Message = "Unknown Error";

            var client = new System.Net.WebClient();
            string ftm = string.Format("https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}", secret, response);
            var reply = client.DownloadString(ftm);

            var captchaResponse = JsonConvert.DeserializeObject<CaptchaResponse>(reply);

            //when response is false check for the error message
            if (!captchaResponse.Success)
            {
                if (captchaResponse.ErrorCodes.Count <= 0) return false;

                var error = captchaResponse.ErrorCodes[0].ToLower();
                switch (error)
                {
                    case ("missing-input-secret"):
                        Message = "The secret parameter is missing.";
                        break;
                    case ("invalid-input-secret"):
                        Message = "The secret parameter is invalid or malformed.";
                        break;

                    case ("missing-input-response"):
                        Message = "The response parameter is missing.";
                        break;
                    case ("invalid-input-response"):
                        Message = "The response parameter is invalid or malformed.";
                        break;

                    default:
                        Message = "Error occured. Please try again";
                        break;
                }
            }
            else
            {
                Message = "Valid";
                return true;
            }
            return false;
        }
        protected void btAddUser_Click(object sender, EventArgs e)
        {
            LabelMessage.Text = "";
            LabelMessage.Visible = false;
            try
            {
                // pass capture
                var capture = Session["Captcha"];
                string Message = "";

                if (null == capture)
                {
                    if (!ValidateCaptcha(ref Message))
                    {
                        btAddUser.ForeColor = System.Drawing.Color.Red;
                        return;
                    }
                }
                Session["Captcha"] = "1";

                // test input data
                string email = txtEmail.Text;
                string email2 = txtEmailConf.Text;
                string name = txtFIO.Text;
                String country = rbCanada.Checked ? "CA" : "US";
                String postal = TextBoxPostal.Text;
                String fname = TextBoxFName.Text;
                String lname = TextBoxLName.Text;
                String psw = txtPassword.Text;
                String psw2 = txtPasswordConf.Text;

                if (String.IsNullOrEmpty(email)    || String.IsNullOrEmpty(email2) || String.IsNullOrEmpty(name)
                    || String.IsNullOrEmpty(fname) || String.IsNullOrEmpty(lname)  || String.IsNullOrEmpty(psw) || String.IsNullOrEmpty(psw2))
                {
                    LabelMessage.Visible = true;
                    LabelMessage.Text = "All field must be filled";
                    return;
                }
                if (email != email2)
                {
                    LabelMessage.Visible = true;
                    LabelMessage.Text = "emails must be then same!";
                    return;
                }
                if (psw != psw2)
                {
                    LabelMessage.Visible = true;
                    LabelMessage.Text = "password must be then same!";
                    return;
                }
                if (SaveUser(name, email, country, postal, fname, lname, psw))
                {
                    Response.Redirect("Login.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        protected bool SaveUser(String name, String email, String country, String postal, String fname, String lname, String psw)
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            string userAgent = context.Request.UserAgent;
            string hostAddress = context.Request.UserHostAddress;
            string hostName = context.Request.UserHostName;

            if (null == ipAddress || 0 == ipAddress.Length)
            {
                ipAddress = context.Request.ServerVariables["REMOTE_ADDR"];
            }
            try
            {
                using (SqlConnection con = new SqlConnection(m_conn_str))
                {
                    using (SqlCommand cmd = new SqlCommand("spSaveUser", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@ipaddr", SqlDbType.VarChar).Value = ipAddress;
                        cmd.Parameters.Add("@agent", SqlDbType.VarChar).Value = userAgent;
                        cmd.Parameters.Add("@addr", SqlDbType.VarChar).Value = hostAddress;
                        cmd.Parameters.Add("@host", SqlDbType.VarChar).Value = hostName;
                        cmd.Parameters.Add("@user", SqlDbType.VarChar).Value = name;
                        cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
                        cmd.Parameters.Add("@country", SqlDbType.Char).Value = country;
                        cmd.Parameters.Add("@postal", SqlDbType.VarChar).Value = postal;
                        cmd.Parameters.Add("@fname", SqlDbType.NVarChar).Value = fname;
                        cmd.Parameters.Add("@lname", SqlDbType.NVarChar).Value = lname;
                        cmd.Parameters.Add("@psw", SqlDbType.VarChar).Value = psw.Trim();

                        con.Open();

                        cmd.ExecuteNonQuery();

                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("[RegisterSession]: following error occured: " + ex.Message.ToString() + "-" + name + "=" + email);

                LabelMessage.Visible = true;

                if (ex.Message.Contains("UK_Users_Email"))
                {
                    LabelMessage.Text = "This email alreay in use. Please try another one.";
                }
                else
                if (ex.Message.Contains("CH_users_userName"))
                {
                    LabelMessage.Text = "User name must be at least 3 symbols. Please try another one.";
                }
                else
                if (ex.Message.Contains("CH_users_email"))
                {
                    LabelMessage.Text = "Email is incorrect - must be at least 6 symbols. Please try correct one.";
                }
                else
                    if (ex.Message.Contains("CH_users_psw"))
                {
                    LabelMessage.Text = "The Password is too short. It must be at least 6 symbols, letters in uppercase and lowercase, and numerals";
                }
                else
                {
                    try
                    {
                        using (SqlConnection con = new SqlConnection(m_conn_str))
                        {
                            using (SqlCommand cmd = new SqlCommand("spSaveException", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;

                                cmd.Parameters.Add("@ip", SqlDbType.VarChar).Value = ipAddress;
                                cmd.Parameters.Add("@msg", SqlDbType.NVarChar).Value = ex.Message.ToString();
                                cmd.Parameters.Add("@email", SqlDbType.NVarChar).Value = email;
                                cmd.Parameters.Add("@page_name", SqlDbType.NVarChar).Value = "Register.aspx";

                                con.Open();
                                cmd.ExecuteNonQuery();

                                return true;
                            }
                        }
                    }
                    catch (Exception ex2)
                    {
                        LabelMessage.Text = ex.Message.ToString() + ex2.Message.ToString();
                    }
                }
            }
            return false;
        }
    }
}
