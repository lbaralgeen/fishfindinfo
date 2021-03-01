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
//  http://localhost:32543/WebService/Plot/?id=12&fish='goldyey'

namespace FishTracker.WebService
{
    public partial class TForecastService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ws = "12";//  Request.QueryString["id"];
          //  string fish = Request.QueryString["fish"];

            if (string.IsNullOrEmpty(ws)  )
            {
                return;
            }
            String connStr = ConfigurationManager.ConnectionStrings["xConnectionString"].ConnectionString;
 
            int wsid = -1;

            if (!Int32.TryParse(ws, out wsid))
            {
                return;
            }
            try
            {
                List<String> outfile = new List<String>();

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("dbo.spForecast", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@sid", SqlDbType.Int).Value = wsid;
//                        cmd.Parameters.Add("@fish", SqlDbType.VarChar, 32).Value = fish;

                        SqlDataReader dr = cmd.ExecuteReader();

                        while(dr.Read())
                        {
                            outfile.Add(dr.GetString(0) + "\n");
                        }
                    }
                }
                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                // Buffer response so that page is sent
                // after processing is complete.
                Response.BufferOutput = true;

                foreach (String line in outfile)
                {
                    HttpContext.Current.Response.Write(line.ToString());
                }
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