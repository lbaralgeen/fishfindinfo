using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FishTracker.Resources
{
    public partial class RscMenu : DbLayer
    {
        int m_with = 1200;
        int m_hight = 1024;
        protected void Page_Load(object sender, EventArgs e)
        {
            try { HiddenCountry.Value = Request.QueryString["Country"]; } catch (Exception) { }

            if (String.IsNullOrEmpty(HiddenCountry.Value) || HiddenCountry.Value.Length != 2)
            {
                HiddenCountry.Value = "CA";
            }
            try
            {
                var links  = new HyperLink[] { hl1, hl2, hl4, hl8, hl32, hl64, hl128, hl8192 };
                var labels = new Label[]     { lb1, lb2, lb4, lb8, lb32, lb64, lb128, lb8192 };
                var types  = new int[]       { 1,   2,   4,   8,   32,   64,   128,   8192 };

                if (Session["BrowserWidth"] == null)
                {
                    m_with = 800;
                }
                else
                {
                    try { string with = Session["BrowserWidth"].ToString(); m_with = Int32.Parse(with); } catch (Exception) { }
                }
                if (Session["BrowserWidth"] == null)
                {
                    m_hight = 1024;
                }
                else
                {
                    try { string hight = Session["BrowserHeight"].ToString(); m_hight = Int32.Parse(hight); } catch (Exception) { }
                }
                if( m_IsTrial)
                {
                    hl4.Visible = false; lb4.Visible = false;
                    hl8.Visible = false; lb8.Visible = false;
                    hl32.Visible = false; lb32.Visible = false;
                    hl64.Visible = false; lb64.Visible = false;
                    hl128.Visible = false; lb128.Visible = false;
                    hl8192.Visible = false; lb8192.Visible = false;
                }
                string sqlcmd = String.Format("SELECT locType, cnt FROM dbo.fn_LocType( '{0}', {1} )", HiddenCountry.Value, m_IsTrial ? 0 : 1);
                Dictionary<int, int> locTypeDic = m_dbObject.GetDicII(m_dbObject.m_connection, sqlcmd, "RscMenu::Page_Load");

                for (int index = 0; index < links.Length; index++)
                {
                    int locType = types[index];

                    HyperLink link = links[index];
                    link.NavigateUrl = String.Format("RscRiverList.aspx?Country={0}&River={1}", HiddenCountry.Value, locType);
                    link.CssClass = "LinkStyleHD";

                    if (locTypeDic.ContainsKey(locType))
                    {
                        Label lb = labels[index];
                        lb.Text = locTypeDic[locType].ToString();
                    }
                }
                lbWeight.Text = m_with.ToString();
                lbHeight.Text = m_hight.ToString();
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "RscMenu>Page_Load");
            }
        }
    }
}