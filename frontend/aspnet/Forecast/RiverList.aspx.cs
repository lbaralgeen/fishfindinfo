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

namespace FishTracker.Forecast
{
    public partial class RiverList : System.Web.UI.Page
    {
        string m_country = "CA";
        string m_sql = "SELECT * FROM dbo.fn_river_list( 'ON', 'CA', 1, 'A' ) ORDER BY lake_name ASC";
        protected void Page_Load(object sender, EventArgs e)
        {
            try 
            { 
                m_country =  Request.QueryString["Country"];

                if (String.IsNullOrEmpty(m_country))
                {
                    m_country = "CA";
                }
                if (IsPostBack)
                {
                    return;
                }
                m_sql = "SELECT * FROM dbo.fn_river_list( 'ON', '" + m_country + "', 1, 'A' ) ORDER BY lake_name ASC";

                CTRL.SelectCommand = m_sql;
            }
            catch (Exception ex)
            {
                Response.Write("[Page_Load]: Following error occured: " + ex.Message.ToString() + " - " + m_sql);
            }
        }
    }
}