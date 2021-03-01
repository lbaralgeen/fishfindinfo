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

//localhost:32543/WebService/wf.aspx?fList=4CC99297-5119-4516-8973-86582F653A9A

namespace FishTracker.WebService
{
    public partial class json : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userCode = Request.QueryString["user"];
            
            if( string.IsNullOrEmpty(userCode))
            {
                userCode = "00000000-0000-0000-0000-000000000000";
            }
            String connStr = ConfigurationManager.ConnectionStrings["fishConnectionString"].ConnectionString;

            bool isFList = true;

            if (String.IsNullOrEmpty(userCode) || !userCode.Equals("BB30165A-FD1A-4B54-B921-9334242C9BF6", StringComparison.OrdinalIgnoreCase))
            {
                isFList = false;
            }
            Guid userGuid = new Guid();
                
            if( !Guid.TryParse(userCode, out userGuid) )
            {
                return;
            }
            List<String> outfile = new List<String>();

            if (!isFList)
            {
                return;
            }
            //http://localhost:32543/Fish?user=BB30165A-FD1A-4B54-B921-9334242C9BF6
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string sqlCmd = "SELECT fish_name FROM dbo.fn_get_fish_byuser('" + userGuid.ToString() + "')";

                using (SqlCommand cmd = new SqlCommand(sqlCmd, con))
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                 
                    while (dr.Read())
                    {
                        outfile.Add(dr.GetString(0));
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
    }
}