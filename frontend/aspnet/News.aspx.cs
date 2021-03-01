using System;
using System.Data;
using System.Web;
using System.Text;
using System.Data.SqlClient;
using System.Web.UI;
using System.Linq;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;

// https://validator.w3.org/

namespace FishTracker
{
    public partial class TNews : DbLayer     //System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (null == sender)
            {
                return;
            }
            Guid idNews = Guid.Empty;
            int offset = 0;
            try
            {
                if (Int32.TryParse(Request.QueryString["Offset"], out int ioff))
                {
                    offset = (offset >= 0 && offset < 1000) ? ioff : 0;
                }
            } catch (Exception) { }
            try
            {
                if (Int32.TryParse(Request.QueryString["Clean"], out int clean))
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

                        Response.Redirect("/Default.aspx");
                    }
                }
                Guid.TryParse(Request.QueryString["LeadID"], out idNews);

                if (idNews == Guid.Empty)
                {
                    idNews = m_dbObject.GetSingleGuid("SELECT TOP 1 news_id FROM vNewsList ORDER BY stamp DESC", null, "News.Page_Load");
                }
                if (!IsPostBack)
                {
                    // Enable the GridView paging option and  
                    // specify the page size. 
                    // gvNews.AllowPaging = true;
                    // gvNews.PageSize = 15;

                    // Enable the GridView sorting option. 
                    // gvNews.AllowSorting = true;

                    // Initialize the sorting expression. 
                    // ViewState["SortExpression"] = "PersonID ASC";
                    // Populate the GridView. 
                    BindGridView(offset, idNews);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }

            if(idNews != Guid.Empty )
            {
                hdNewsId.Value = idNews.ToString();

                string title = string.Empty;
                string fish1 = string.Empty;
                string fish2 = string.Empty;
                string fish3 = string.Empty;
                string auth_name = string.Empty;
                string country = string.Empty;

                if (LoadNews(idNews, out title, out fish1, out fish2, out fish3, out auth_name, out country))
                {
                    var news = new Dictionary<string, string>();

                    news["id"] = idNews.ToString();
                    news["headline"] = title;
                    news["fish1"] = hlfish1Lake.Text;
                    news["fish2"] = hlfish2Lake.Text;
                    news["fish3"] = hlfish3Lake.Text;
                    news["author"] = auth_name;
                    news["country"] = country;
                    news["datePublished"] = hdNewsDate.Value;

                    if (!String.IsNullOrEmpty(hdNews0.Value) && hdNews0.Value.Length >= 100)
                    {
                        news["description"] = hdNews0.Value.Substring(0, 100);
                    }
                    SetMetaTags(news); //  auth_name, country, "");
                }
            }
        }
        private void BindGridView( int currPage, Guid idNews)
        {
            string traits = String.Format("LeadID={0}", idNews);

            var controls = new System.Collections.Generic.HashSet<HyperLink>()
                { hlFirstPage, hlLeft, hlLeft1, hlLeft2, hlLeft3, hlLeftDots, hlCurrentPage
                , hlRight1, hlRight2, hlRight3, hlRightDots, hlRight, hlLastPage, hlNPages  };

            InitizlizeNavigator( "News.aspx", currPage, traits, controls);
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["xConnectionString"].ToString()))
                {
                    // Create a DataSet object. 
                    DataSet dsNews = new DataSet();

                    string rcs = "select id, news_id, title, source, stamp, flag, cnt from dbo.vNewsList ";

                    string strSelectCmd = String.Format("{0} ORDER BY id ASC OFFSET {1} ROWS FETCH NEXT {2} ROWS ONLY"
                            , rcs, currPage * nPage, nPage);

                    SqlDataAdapter da = new SqlDataAdapter(strSelectCmd, conn);

                    conn.Open();
                    da.Fill(dsNews, "News");
                    DataView dvNews = dsNews.Tables["News"].DefaultView;
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    
                    foreach (DataRow dr in dt.Rows)
                    {
                        hdTotal.Value = dr["cnt"].ToString();
                        break;
                    }
                    // Set the sort column and sort order. 
                    // dvPerson.Sort = ViewState["SortExpression"].ToString();
                    // Bind the GridView control. 
                    gvNews.DataSource = dvNews;
                    gvNews.DataBind();
                }
                if ( Int32.TryParse(hdTotal.Value, out int count) )
                {
                    UpdateNavigator("News.aspx", currPage, count, traits, controls );
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "BindGridView");
            }
        }
        protected bool SetMetaTags(Dictionary<string, string> news )
        {
                if (news == null || !news.ContainsKey("id") || !news.ContainsKey("headline"))
                {
                    return false;
                }
                // add meta tags
                Page.Title = news["headline"];

            if(!String.IsNullOrEmpty(news["fish1"]) || !String.IsNullOrEmpty(news["fish2"]) || !String.IsNullOrEmpty(news["fish2"]))
            {
                // keywords
                string keywords = String.Format("\"{0}\"", news["fish1"]);

                if (!String.IsNullOrEmpty(news["fish2"]))
                {
                    keywords += (String.IsNullOrEmpty(keywords) ? "" : ",") + String.Format("\"{0}\"", news["fish2"]);
                }
                if (!String.IsNullOrEmpty(news["fish3"]))
                {
                    keywords += (String.IsNullOrEmpty(keywords) ? "" : ",") + String.Format("\"{0}\"", news["fish3"]);
                }

                HtmlMeta tag_keywords = new HtmlMeta();
                tag_keywords.Name = "keywords";
                tag_keywords.Content = keywords;
                Header.Controls.Add(tag_keywords);
            }
            if (news.ContainsKey("author") && !String.IsNullOrEmpty(news["author"]))
            {
                HtmlMeta tag_auth = new HtmlMeta();
                tag_auth.Name = "author";
                tag_auth.Content = news["author"];
                Header.Controls.Add(tag_auth);
            }
            if (!String.IsNullOrEmpty(news["country"]))
            {
                if (news.ContainsKey("region") && !String.IsNullOrEmpty(news["region"]))
                {
                    news["country"] = news["region"] + " " + news["country"];
                }
                HtmlMeta tag = new HtmlMeta();
                tag.Name = "geo.region";
                tag.Content = news["country"];
                Header.Controls.Add(tag);
            }

            string json = NewsAsJSONLD( news );

            Page.Header.Controls.Add(new LiteralControl(json));

            return true;
        }
        /// <summary>
        /// Create JOSON structure for google markup
        /// https://technicalseo.com/tools/schema-markup-generator/
        /// </summary>
        /// <param name="s"></param>
        /// <param name="news"></param>
        /// <returns></returns>
        public string NewsAsJSONLD(Dictionary<string, string> news)
        {
            if (news == null || !news.ContainsKey("id") || !news.ContainsKey("headline"))
            {
                return string.Empty;
            }
            StringBuilder sb = new StringBuilder();
            try
            {
                sb.AppendFormat("<script type=\"application/ld+json\">");
                sb.AppendFormat("{{");
                sb.AppendFormat("\"@context\"" + ":" + "\"http://schema.org\",");
                sb.AppendFormat("\"@type\": \"NewsArticle\"");
                sb.AppendFormat(",");
                sb.AppendFormat("\"mainEntityOfPage\": ");
                sb.AppendFormat("{0},", '{');
                sb.AppendFormat("\"@type\": \"WebPage\",");
                sb.AppendFormat("\"@id\": \"news.aspx?LeadID={0}\"", news["id"]);
                sb.AppendFormat("{0},", '}');
                sb.AppendFormat("\"headline\": \"{0}\"", news["headline"]);
                sb.AppendFormat(",");
                sb.AppendFormat("\"description\": \"{0}\"", news["description"]);
                sb.AppendFormat(",");

                if (news.ContainsKey("url"))
                {
                    sb.AppendFormat("\"image\": { \"@type\": \"ImageObject\",");
                    sb.AppendFormat("\"url\": \"{0}\"", news["id"]);
                    sb.AppendFormat("\"width\": , \"height\": ");
                    sb.AppendFormat(",");
                }
                if (news.ContainsKey("author"))
                {
                    sb.Append("\"author\": {");
                    sb.AppendFormat(" \"@type\": \"Person\" \"name\": \"{0}\"", news["author"]);
                    sb.AppendFormat("{0},", '}');
                }
                if (news.ContainsKey("publisher"))
                {
                    sb.Append("\"publisher\": { ");
                    sb.AppendFormat(" \"@type\": \"Organization\" \"name\": \"{0}\"", news["publisher"]);
                    sb.AppendFormat("{0},", '}');
                }
                sb.AppendFormat("{0}", '}');

                if (news.ContainsKey("datePublished"))
                {
                    string datePublished = news["datePublished"];
                    string datefmt = DateTime.Parse(datePublished).ToString("yyyy-MM-dd");
                    sb.AppendFormat("\"datePublished\": \"{0}\"", datefmt);
                    sb.AppendFormat("{0}", '}');
                }
                sb.AppendFormat("</script>");
            }
            catch (Exception ex)
            {
                DbEventLogger(ex);
            }
            return sb.ToString();  // // Page.Header.Controls.Add(new LiteralControl(sb.ToString()));
        }

        // GridView.PageIndexChanging Event 
        protected bool LoadNews(Guid idNews, out string  title, out string fish1, out string fish2, out string fish3, out string auth_name, out string country)
        {
            title = string.Empty;
            fish1 = string.Empty;
            fish2 = string.Empty;
            fish3 = string.Empty;
            auth_name = string.Empty;
            country = string.Empty;

            string sqlCmd = "select * FROM dbo.fn_GetTopNews( @newsId )";
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@newsId", SqlDbType.UniqueIdentifier).Value = idNews;

                    using (SqlDataReader datareader = cmd.ExecuteReader())
                    {
                        hlfish1Lake.Text = ""; hlfish2Lake.Text = ""; hlfish3Lake.Text = ""; hlLinkLake.Text = "";
                        string link_auth = string.Empty;
                        string source_name = string.Empty;
                        string credit = string.Empty;

                        if ( LoadTopNews( datareader, hdNewsDate, hdNewsTitle, out link_auth, out auth_name, hlNewsSourceLink, out source_name, out credit
                                   , hdNews0, hdNews1, ImageNews0, hdNewsFlag, hlLinkLake, new HyperLink[] { hlfish1Lake, hlfish2Lake, hlfish3Lake } ) )
                        {
                            Setlink(ref hdNewsAuthor, "By", link_auth, auth_name);
                            Setlink(ref hdNewsSource, " Source:", null, source_name);
                            Setlink(ref hdNewsCredit0, "Credit:", null, credit);

                            string altimg = String.IsNullOrEmpty(auth_name) ? hdNewsTitle.Value : auth_name;

                            ImageNews0.AlternateText = altimg;

                            title = hdNewsTitle.Value;
                            fish1 = hlfish1Lake.Text;
                            fish2 = hlfish2Lake.Text;
                            fish3 = hlfish3Lake.Text;

                            if (!String.IsNullOrEmpty(hdNewsFlag.Value) && hdNewsFlag.Value.Length >= 2)
                            {
                                country = hdNewsFlag.Value.Substring(0, 2);
                                hd_NewsAltFlag1.Value = country;
                            }

                        }
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex);
            }
            return false;
        }
    }
}
