using System;
using System.Data;
using System.Web;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.Security;


namespace FishTracker
{
    public partial class _Default : DbLayer     //System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (null == sender)
            {
                return;
            }
            try
            {
                if(Int32.TryParse(Request.QueryString["Clean"], out int clean) )
                {
                    if (clean == 1)
                    {
                        m_IsTrial = true;
                        m_IsAdmin = false;
                        Session["UserId"] = "00000000-0000-0000-0000-000000000000";
                        Session["sessionId"] = "00000000-0000-0000-0000-000000000000";

                        var currentUserCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

                        currentUserCookie.Expires = DateTime.Now.AddDays(-10);
                        currentUserCookie.Value = null;
                        HttpContext.Current.Response.SetCookie(currentUserCookie);

                        Response.Redirect( "/Default.aspx" );
                    }
                }
            } catch (Exception){}

            Guid topNewsId = Guid.Empty;

            if (LoadNews())
            {
            }
        }
        protected bool LoadNews()
        {
            string sqlCmd = "select * FROM vDefaultNews ORDER BY ORD ASC";
            try
            {
                string link_auth = string.Empty;
                string auth_name = string.Empty;
                string source_name = string.Empty;
                string credit = string.Empty;

                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    using (SqlDataReader datareader = cmd.ExecuteReader())
                    {

                        if( LoadTopNews(datareader, hd_NewsDateA, hd_NewsTitleA, out link_auth, out auth_name, hl_NewsSourceLinkA
                                        , out source_name, out credit, hd_News0A, hd_News1A, Image_News0
                                        , hd_NewsFlag1, hl_LinkLake1
                                        , new HyperLink[] { hl_fish1Lake1, hl_fish2Lake1, hl_fish3Lake1}) )
                        {
                            if( !String.IsNullOrEmpty(hd_NewsFlag1.Value) && hd_NewsFlag1.Value.Length >= 2 )
                            {
                                hd_NewsAltFlag1.Value = hd_NewsFlag1.Value.Substring(0, 2);
                            }
                            if (!String.IsNullOrEmpty(hd_NewsFlag2.Value) && hd_NewsFlag2.Value.Length >= 2)
                            {
                                hd_NewsAltFlag2.Value = hd_NewsFlag2.Value.Substring(0, 2);
                            }

                            Setlink(ref hd_NewsAuthorA, "By", link_auth, auth_name);
                            Setlink(ref hd_NewsSourceA, " Source:", null, source_name);
                            Setlink(ref hd_NewsCredit0A, "Credit:", null, credit);
                        }
                        hd_NewsDateB.Visible = false;
                        hd_NewsTitleB.Visible = false;
                        hd_NewsAuthorB.Visible = false;
                        hl_NewsSourceLinkB.Visible = false;
                        hd_NewsSourceB.Visible = false;
                        hd_NewsCredit0B.Visible = false;
                        hd_News0B.Visible = false;
                        hd_News1B.Visible = false;
                        Image_News1.Visible = false;
                        link_auth = string.Empty;
                        auth_name = string.Empty;

 //                       if (!m_IsTrial)
                        {
                            if( LoadTopNews(datareader, hd_NewsDateB, hd_NewsTitleB, out link_auth, out auth_name, hl_NewsSourceLinkB
                                            , out source_name, out credit, hd_News0B, hd_News1B, Image_News1
                                            , hd_NewsFlag2, hl_LinkLake2
                                            , new HyperLink[] { hl_fish1Lake2, hl_fish2Lake2, hl_fish3Lake2 }) )
                            {
                                Setlink(ref hd_NewsAuthorB, "By", link_auth, auth_name);
                                Setlink(ref hd_NewsSourceB, " Source:", null, source_name);
                                Setlink(ref hd_NewsCredit0B, "Credit:", null, credit);
                            }
                        }
                        LoadSmallNews(datareader, hd_NewsTitleSmall1, hd_NewsDateSmall1, hd_NewsSourceSmall1, hd_NewsSmall1, hl_SmallNewsLink1);
                        LoadSmallNews(datareader, hd_NewsTitleSmall2, hd_NewsDateSmall2, hd_NewsSourceSmall2, hd_NewsSmall2, hl_SmallNewsLink2);

                        hd_NewsTitleSmall3.Visible = false;
                        hd_NewsDateSmall3.Visible = false;
                        hd_NewsSourceSmall3.Visible = false;
                        hd_NewsSmall3.Visible = false;
                        hl_SmallNewsLink3.Visible = false;

 //                       if (!m_IsTrial)
                        {
                            LoadSmallNews(datareader, hd_NewsTitleSmall3, hd_NewsDateSmall3, hd_NewsSourceSmall3, hd_NewsSmall3, hl_SmallNewsLink3);
                        }
                    }
                }
                return LoadLakeChange();
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        protected bool LoadLakeChange()
        {
            string sqlCmd = "select * from dbo.fn_DefaultLastLake( 'CA' )";
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    using (SqlDataReader datareader = cmd.ExecuteReader())
                    {
                        LoadLakeItem( datareader, hd_LastEditedRiverNative, hd_LastEditedRiverDate, hd_LastEditedRiver, hd_LastEditedRiverLink, hd_LastRiverText);
                        LoadLakeItem( datareader, hd_LastEditedLakeNative, hd_LastEditedLakeDate, hd_LastEditedLake, hd_LastEditedLakeLink, hd_LastLakeText);

                        string lasttop8 =  "";
                        while (datareader.Read())
                        {
                            // read river
                            string lakeGuid = datareader["lake_id"].ToString();

                            string s_lat = GetRecordLatLon(datareader, "lat");
                            string s_lon = GetRecordLatLon(datareader, "lon");

                            string name = ReadString(datareader, "lake_name");
                            string link = String.Format("/Resources/wfRiverViewer.aspx?LakeId={0}", lakeGuid);

                            lasttop8 += String.Format("<tr><td><a href=\"{0}\">{1}</a> [{2}, {3}]</td></tr>\n", link, name, s_lat, s_lon);
                        }
                        hd_LastTop10.Value = lasttop8;
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        protected bool LoadSmallNews(SqlDataReader datareader, HtmlInputHidden title, HtmlInputHidden date, HtmlInputHidden source, HtmlInputHidden txt, HyperLink link )
        {
            try
            {
                if (datareader.Read())
                {
                    string newsGuid = datareader["news_id"].ToString();
                    Guid topNewsId = Guid.Parse(newsGuid);
                    date.Value = ((DateTime)datareader["news_stamp"]).ToShortDateString();

                    ReadString(datareader, "news_title", title);
                    ReadString(datareader, "news_source", source);
                    link.NavigateUrl = ReadString(datareader, "news_source_link");

                    if ( String.IsNullOrEmpty(source.Value))
                    {
                        ReadString(datareader, "news_author", source);
                    }
                    string paragraph0 = ReadString(datareader, "news_paragraph0");

                    if( String.IsNullOrEmpty(paragraph0))
                    {
                        paragraph0 = ReadString(datareader, "news_paragraph1");
                    }
                    int ln = paragraph0.IndexOf('\n');

                    if (ln > 1)
                    {
                        txt.Value = paragraph0.Substring(0, ln - 1);
                    }
                    title.Visible = true;
                    date.Visible = true;
                    source.Visible = true;
                    txt.Visible = true;
                    link.Visible = true;

                    return true;
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        protected bool LoadLakeItem( SqlDataReader datareader, HtmlInputHidden natv, HtmlInputHidden date, HtmlInputHidden name, HtmlInputHidden link, HtmlInputHidden txt)
        {
            try
            {
                if (datareader.Read())
                {
                    // read river
                    string lakeGuid = datareader["lake_id"].ToString();
                    string french_name = ReadString(datareader, "french_name");
                    string native = ReadString(datareader, "native");

                    string s_lat = GetRecordLatLon(datareader, "Lat");
                    string s_lon = GetRecordLatLon(datareader, "Lon");

                    if (String.IsNullOrEmpty(native))
                    {
                        native = french_name;
                    }
                    if (!String.IsNullOrEmpty(native))
                    {
                        natv.Value = "{" + native + "}";
                    }
                    date.Value = ((DateTime)datareader["stamp"]).ToShortDateString();
                    ReadString(datareader, "lake_name", name);
                    link.Value = String.Format("/Resources/wfRiverViewer.aspx?LakeId={0}", lakeGuid);

                    txt.Value = "from: " + ReadString(datareader, "source_loc") + " {" + s_lat + ", " + s_lon + "}";
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
    }
}
