using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Threading.Tasks;

using TDbInterface;

namespace FishTracker.Editor
{
    public partial class AddNews : DbLayer
    {
        private Guid GetNewsGuid()
        {
            return Guid.Parse(HiddenFieldNews.Value);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            String fn_name = WhatsMyName();
            try
            {
                if (!m_IsAdmin)
                {
                    Response.Redirect("/Default.aspx");
                }
                HiddenFieldNews.Value = Guid.NewGuid().ToString();

                m_dbObject.ExecCmd( "DELETE FROM news WHERE news_publish <> 1", WhatsMyName()); // delete old not used publications

                var types = new SqlDbType[] { SqlDbType.NVarChar , SqlDbType.NVarChar , SqlDbType.UniqueIdentifier, SqlDbType.Bit, SqlDbType.DateTime2 };
                var values = new dynamic[] { "title", "Lepsik", GetNewsGuid(), 0, DateTime.Now };

                int? rs = m_dbObject.Insert( "news", "news_title,news_author,news_id,news_publish,news_stamp", types, values, fn_name);

                if(rs != null)
                {
                    HiddenFieldNews.Value = m_dbObject.GetSingleString( "SELECT TOP 1 CAST(news_id AS varchar(36)) AS id FROM news WHERE news_publish = 0", "Page_Load" );
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Failed", "alert('[Page_Load]: Cannot add news!');", true);
                }
                // add countries
                List<String> lstcountry = m_dbObject.GetListString(m_dbObject.m_connection, "SELECT Country_id FROM Country WHERE Country_id NOT IN('CA', 'US', 'UK')", "Page_Load");
                //
                foreach( string countr in lstcountry)
                {
                    ddlNewsCountry.Items.Add(countr);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "AddNews>Page_Load");
            }
        }
        bool? GetPicture(System.Web.UI.WebControls.TextBox bx, int index, System.Web.UI.WebControls.Image img)
        {
            bx.BackColor = System.Drawing.Color.White;

            if ( String.IsNullOrEmpty(bx.Text))
            {
                return null;
            }
            string urlPic = bx.Text;
            string fn_name = WhatsMyName();
            string[] extlist = {"jpg", "png", "gif", "wep", "jpeg", "bmp" };
            try
            {
                int http = urlPic.IndexOf("http");
                if (http > 0)
                {
                    urlPic = urlPic.Substring(http);
                }
                int picIndex = -1; int idx = 0;

                foreach(var ext in extlist)
                {
                    picIndex = urlPic.LastIndexOf(ext);

                    if(picIndex > 0)
                    {
                        break;
                    }
                    idx++;
                }
                if (picIndex > 0)
                {
                    string ext = extlist[idx];
                    urlPic = urlPic.Substring(0, picIndex + ext.Length);
                }
                urlPic = System.Web.HttpUtility.UrlDecode(urlPic);
                string field = "news_photo" + index;

                if (!String.IsNullOrEmpty(urlPic))
                {
                    WebClient cln = new WebClient();
                    byte[] data = cln.DownloadData(urlPic);

                    if (data != null)
                    {
                        var values = new List<Tuple<string, SqlDbType, dynamic>>();
                        values.Add(Tuple.Create<string, SqlDbType, dynamic>(field, SqlDbType.VarBinary, data));

                        Guid newid = Guid.Parse(HiddenFieldNews.Value);

                        var where = new List<Tuple<string, SqlDbType, dynamic>>();
                        where.Add(Tuple.Create<string, SqlDbType, dynamic>("news_id", SqlDbType.UniqueIdentifier, newid));

                        int rs = m_dbObject.Update(m_dbObject.m_connection, "news", values, where, fn_name);

                        if( rs == 1 )
                        {
                            bx.Text = "";
                            string base64String = Convert.ToBase64String(data, 0, data.Length);
                            img.ImageUrl = "data:image/png;base64," + base64String;
                        }
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "AddNews>GetPicture");
            }
            bx.BackColor = System.Drawing.Color.IndianRed;
            return false;
        }
        protected void ButtonSubmitAddNews_Click(object sender, EventArgs e)
        {
            string fn_name = WhatsMyName();
            try
            {
                string news_title = TextBoxTitle.Text.Trim();
                string news_author = TextBoxAuthor.Text.Trim();
                string news_source = TextBoxSource.Text;
                string news_source_link = TextBoxSourceLink.Text.Trim();
                string news_author_link = TextBoxAuthorLink.Text.Trim();
                string country = ddlNewsCountry.Text;
                DateTime stamp = DateTime.Now;
                DateTime.TryParse(txDate.Text, out stamp);

                if(stamp > DateTime.Now || stamp < DateTime.Now.AddYears(-1))
                {
                    stamp = DateTime.Now;
                }
                if ( String.IsNullOrEmpty(news_title) || !(!String.IsNullOrEmpty(news_author) || !String.IsNullOrEmpty(news_source)) )
                {
                    return;
                }
                var values = new List<Tuple<string, SqlDbType, dynamic>>();
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_title", SqlDbType.NVarChar, news_title));
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_author", SqlDbType.NVarChar, news_author));
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_source", SqlDbType.NVarChar, news_source));
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_source_link", SqlDbType.NVarChar, news_source_link));
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_author_link", SqlDbType.NVarChar, news_author_link));
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_stamp", SqlDbType.DateTime2, stamp));
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_publish", SqlDbType.Bit, 1));
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_video_link", SqlDbType.NVarChar, txtYoutube.Text));

                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_paragraph0", SqlDbType.NVarChar, TextBoxParagraph0.Text));
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_paragraph1", SqlDbType.NVarChar, TextBoxParagraph1.Text));
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("news_paragraph2", SqlDbType.NVarChar, TextBoxParagraph2.Text));
                values.Add(Tuple.Create<string, SqlDbType, dynamic>("country", SqlDbType.NVarChar, country));

                Guid newid = Guid.Parse(HiddenFieldNews.Value);

                if( Guid.TryParse(txtNewsLakeId.Text.Trim(), out Guid lakeGuid))
                {
                    values.Add(Tuple.Create<string, SqlDbType, dynamic>("lake_id", SqlDbType.UniqueIdentifier, lakeGuid));
                }
                if (Guid.TryParse(txtFishId1.Text.Trim(), out Guid fish1Guid))
                {
                    values.Add(Tuple.Create<string, SqlDbType, dynamic>("fish1_id", SqlDbType.UniqueIdentifier, fish1Guid));
                }
                if (Guid.TryParse(txtFishId2.Text.Trim(), out Guid fish2Guid))
                {
                    values.Add(Tuple.Create<string, SqlDbType, dynamic>("fish2_id", SqlDbType.UniqueIdentifier, fish2Guid));
                }
                if (Guid.TryParse(txtFishId3.Text.Trim(), out Guid fish3Guid))
                {
                    values.Add(Tuple.Create<string, SqlDbType, dynamic>("fish3_id", SqlDbType.UniqueIdentifier, fish3Guid));
                }
                var where = new List<Tuple<string, SqlDbType, dynamic>>();
                where.Add(Tuple.Create<string, SqlDbType, dynamic>("news_id", SqlDbType.UniqueIdentifier, newid));

                int rs = m_dbObject.Update(m_dbObject.m_connection, "news", values, where, fn_name);

                if( rs == 1 )
                {
                    Response.Redirect( "~/Editor/AddNews.aspx" );
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "AddNews>ButtonSubmitAddNews_Click");
            }
        }
        void ClearForm()
        {
            TextBoxTitle.Text = "";
            TextBoxSource.Text = "";
            TextBoxAuthor.Text = "";
            TextBoxSourceLink.Text = "";
            TextBoxAuthorLink.Text = "";
            TextBoxParagraphAuthor0.Text = ""; TextBoxParagraphAuthor1.Text = ""; TextBoxParagraphAuthor2.Text = "";
            TextBoxPictureAlt0.Text = ""; TextBoxPictureAlt1.Text = ""; TextBoxPictureAlt2.Text = "";
            TextBoxParagraph0.Text = ""; TextBoxParagraph1.Text = ""; TextBoxParagraph2.Text = ""; 
            txtLink0.Text = ""; txtLink1.Text = ""; txtLink2.Text = ""; 

            ImageParagraph0.ImageUrl = ""; ImageParagraph1.ImageUrl = ""; ImageParagraph2.ImageUrl = ""; 
        }
        protected void btnBriefUpload_Click(object sender, EventArgs e)
        {
            try
            {
                System.Web.UI.WebControls.Button btn = (System.Web.UI.WebControls.Button)sender;

                if (btn == null)
                {
                    return;
                }
                int numControl = Int32.Parse(btn.ID.Substring(btn.ID.Length-1));

                Guid newGuid = Guid.Parse(HiddenFieldNews.Value);

                var uploadList = new System.Web.UI.WebControls.FileUpload[] { FileUploadParagraph0, FileUploadParagraph1, FileUploadParagraph2 };
                var authList = new System.Web.UI.WebControls.TextBox[] { TextBoxParagraphAuthor0, TextBoxParagraphAuthor1, TextBoxParagraphAuthor2 };
                var picAltList = new System.Web.UI.WebControls.TextBox[] { TextBoxPictureAlt0, TextBoxPictureAlt1, TextBoxPictureAlt2 };
                var textList = new System.Web.UI.WebControls.TextBox[] { TextBoxParagraph0, TextBoxParagraph1, TextBoxParagraph2 };
                var urlList = new System.Web.UI.WebControls.TextBox[] { txtLink0, txtLink1, txtLink2 };
                var picList = new System.Web.UI.WebControls.Image[] { ImageParagraph0, ImageParagraph1, ImageParagraph2 };

                if ( !String.IsNullOrEmpty(urlList[numControl].Text) &&  null == GetPicture(urlList[numControl], numControl, picList[numControl]) )
                {
                    return;
                }
                string folderPath = Server.MapPath("~/Files/");

                //Check whether Directory (Folder) exists.
                if (!Directory.Exists(folderPath))
                {
                    //If Directory (Folder) does not exists Create it.
                    Directory.CreateDirectory(folderPath);
                }
                System.Web.UI.WebControls.FileUpload itemFileUpload = uploadList[numControl];
                System.Web.UI.WebControls.TextBox itemTextBox = authList[numControl];
                System.Web.UI.WebControls.TextBox picAltTextBox = picAltList[numControl];
                System.Web.UI.WebControls.TextBox paragTextBox = textList[numControl];

                if (itemFileUpload.HasFile)
                {
                    string strname = itemFileUpload.FileName.ToString();

                    itemFileUpload.SaveAs(folderPath + strname);       //Save the File to the Directory (Folder).

                    ImageParagraph0.ImageUrl = "~/Files/" + Path.GetFileName(itemFileUpload.FileName);  // //Display the Picture in Image control.

                    int length = itemFileUpload.PostedFile.ContentLength;

                    if (0 < length)
                    {
                        byte[] imgbyte = new byte[length];
                        HttpPostedFile img = itemFileUpload.PostedFile;
                        img.InputStream.Read(imgbyte, 0, length);

                        using (SqlConnection connection = new SqlConnection(m_connStr))
                        {
                            connection.Open();
                            {
                                var prms = new List<Tuple<string, SqlDbType, dynamic>>();

                                prms.Add(TValue.Create("news_paragraph" + numControl, SqlDbType.NVarChar, paragTextBox));
                                prms.Add(TValue.Create("news_photo_author" + numControl, SqlDbType.NVarChar, itemTextBox));
                                prms.Add(TValue.Create("news_photo_alt" + numControl, SqlDbType.NVarChar, picAltTextBox));
                                prms.Add(TValue.Create("news_photo" + numControl, SqlDbType.VarBinary, imgbyte));

                                var where = new List<Tuple<string, SqlDbType, dynamic>>();
                                where.Add(TValue.Create("news_id", SqlDbType.UniqueIdentifier, newGuid));

                                int rs = m_dbObject.Update(connection, "news", prms, where, WhatsMyName());

                                if( rs == 1 )
                                {
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "AddNews>btnBriefUpload_Click");
            }
        }
    }
}