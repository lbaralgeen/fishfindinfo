using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using FishTracker.Update;

//  http://localhost:32543/WebService/Plot/?id=12&fish='goldyey'
//  http://localhost:32543/WebService/Plot/Default.aspx?cmd=spot&id=142266&guid='4db64c3d-95cc-4e19-85be-c2a46582f813'

namespace FishTracker.WebService
{
    public partial class TPlotService : System.Web.UI.Page
    {
        public enum eCmd { eID = 1, eGUID = 2, eVAL = 4 };

        protected void Page_Load(object sender, EventArgs e)
        {
            HashSet<eCmd> hsCmd = new HashSet<eCmd>();
            string scmd = Request.QueryString["cmd"];
            int id = -1;
            Guid guid = Guid.Empty;
            String val = String.Empty;
            String statement = String.Empty;


#if DEBUG
            if (System.Diagnostics.Debugger.IsAttached)
            {
                scmd = "spot";
                guid = new Guid("4db64c3d-95cc-4e19-85be-c2a46582f813");
                id = 142266;
            }
#endif
            if (string.IsNullOrEmpty(scmd))
            {
                return;
            }
            if (scmd == "spot")
            {
                hsCmd.Add(eCmd.eID);
                hsCmd.Add(eCmd.eGUID);

                statement = "SELECT dbo.fn_forecast_plot_json(@ID, @GUID)";
            }
///#if RELEASE
            if (hsCmd.Contains(eCmd.eID))
            {
                string sid = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(sid))

                {
                    id = (Int32.TryParse(sid, out id) ? id : -1);
                }
                if ( id == -1  )
                {
                    return;
                }
            }

            if (hsCmd.Contains(eCmd.eGUID))
            {
                string sguid = Request.QueryString["guid"];

                if (!string.IsNullOrEmpty(sguid))
                {
                    guid = (Guid.TryParse(sguid, out guid) ? guid : Guid.Empty);
                }
                if (guid == Guid.Empty)
                {
                    return;
                }
            }
//#endif
            // string val   = Request.QueryString["val"];

            String connStr = ConfigurationManager.ConnectionStrings["xConnectionString"].ConnectionString;
 
            try
            {
                String result = "{}";

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(statement, con))
                    {
                        cmd.CommandType = CommandType.Text;

                        if (hsCmd.Contains(eCmd.eID) )
                        {
                            cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
                        }
                        if (hsCmd.Contains(eCmd.eVAL))
                        {
                            cmd.Parameters.Add("@VAL", SqlDbType.VarChar, 32).Value = val;
                        }
                        if (hsCmd.Contains(eCmd.eGUID))
                        {
                            cmd.Parameters.Add("@GUID", SqlDbType.UniqueIdentifier).Value = guid;
                        }
                        SqlDataReader dr = cmd.ExecuteReader();

                        if(dr.Read())
                        {
                            result = dr.GetString(0);
                        }
                    }
                }
                Response.Clear();
                Response.AppendHeader("Access-Control-Allow-Origin", "*");
                Response.AppendHeader("Content-Length", result.Length.ToString());
                Response.ContentType = "application/json";
                Response.Charset = "UTF-8";
                Response.AppendHeader("Vary", "Accept-Encoding");
                Response.ContentEncoding = System.Text.Encoding.UTF8;

                // Buffer response so that page is sent
                // after processing is complete.
                Response.BufferOutput = true;


                HttpContext.Current.Response.Write(result);
 
                Response.Flush();
                Response.Close();
                Response.End();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('SetPlotParamsd : " + ex.Message.ToString() + "');", true);
            }
        }
    }
}