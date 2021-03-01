using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using TDbInterface;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace FishTracker.Editor
{
    public partial class EditFishZoo : DbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            ButtonSubmit.Enabled = m_IsAdmin;

            LinkButtonFood.Enabled = m_IsAdmin;
            LinkButtonSpawn.Enabled = m_IsAdmin;
            LinkButtonGeneral.Enabled = m_IsAdmin;

            try { hiddenFishGuid.Value = Request.QueryString["fishId"]; } catch (Exception) { }

            if (String.IsNullOrEmpty(hiddenFishGuid.Value))
            {
                if (System.Diagnostics.Debugger.IsAttached)
                {
                    hiddenFishGuid.Value = "c7d5f9c6-4967-4ffa-8131-d687f489781b";
                }
                else
                {
                    return;
                }
            }
            try
            {
                LoadUnEditedFish();
                LoadFishName(hiddenFishGuid.Value, TextBoxName, TextBoxLatin );
                TextBoxGuid.Text = hiddenFishGuid.Value;

                Guid fish_id = Guid.Empty;

                if (Guid.TryParse(hiddenFishGuid.Value, out fish_id) )
                {
                    int? imageId = m_dbObject.GetSingleInt( "SELECT fish_image_id FROM fish_image WHERE @param0=fish_id"
                                               , SqlDbType.UniqueIdentifier, fish_id, WhatsMyName());
                    LoadFishImage( fish_id, imageId
                            , TextBoxLat, TextBoxLon, TextBoxTag, TextBoxDate, CheckBoxGender
                            , TextBoxImageSource, TextBoxImageAuthor, TextBoxImageLink, TextBoxLabel, TextBoxLocation );
                }
            }
            catch (Exception ex)
            {
                InsertDbMessage(ex.Message, WhatsMyName());
            }
        }
        protected void LoadUnEditedFish()
        {
            string sqlCmd = "SELECT TOP 1 * from dbo.vw_read_fish_zoo WHERE fish_id = @fish_id ORDER BY fish_name ASC";

            using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
            {
                Guid fishid = Guid.Parse(hiddenFishGuid.Value);
                cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = fishid;
                try
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            TextBoxName.Text = dr["fish_name"].ToString();
                            TextBoxLatin.Text = dr["fish_latin"].ToString();
                            TextBoxGuid.Text = dr["fish_id"].ToString();

                            SetList(dr, "natural_color", cblNaturalColor);

                            //LabelEditedBy.Text = dr["editor"].ToString();
                            //cbxLock.Checked = ReadBit(dr, "locked");

                            ReadSingle(dr, "fish_max_length", TextBoxLength);
                            ReadSingle(dr, "fish_max_weight", TextBoxWeight);
                            ReadSingle(dr, "fish_avg_length", TextBoxAvgLength);
                            ReadSingle(dr, "fish_avg_weight", TextBoxAvgWeight);

                            TextBoxLongevity.Text = ReadInt(dr, "Longevity").ToString();

                            TextBoxFin.Text = dr["fin"].ToString();
                            TextBoxBody.Text = dr["body"].ToString();
                            TextBoxCounts.Text = dr["Counts"].ToString();
                            TextBoxShape.Text = dr["shape"].ToString();
                            TextBoxEM.Text = dr["external_morphology"].ToString();
                            TextBoxIM.Text = dr["internal_morphology"].ToString();
                            //ReadDate(dr, "stamp", LabelStamp);

                            int? imageId = ReadInt(dr, "fish_image_id");

                            ImageZoo.ImageUrl = String.Format("~/Editor/HandlerImage.ashx?id={0}&sid={1}&page=2", fishid, imageId);
                        }
                    }
                }
                catch (Exception ex)
                {
                    DbEventLogger(ex, WhatsMyName());
                }
            }
        }
        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(hiddenFishGuid.Value))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), WhatsMyName(), "alert('Fish guid is empty');", true);
                return;
            }
            try
            {
                using (SqlCommand cmd = new SqlCommand("dbo.sp_update_fish_zoo", m_dbObject.m_connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    Guid fishid = Guid.Parse(hiddenFishGuid.Value);

                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = fishid;

                    AddFloatParameter(cmd, "@max_length", TextBoxLength);
                    AddFloatParameter(cmd, "@max_weight", TextBoxWeight);
                    AddFloatParameter(cmd, "@avg_length", TextBoxAvgLength);
                    AddFloatParameter(cmd, "@avg_weight", TextBoxAvgWeight);
                    AddIntParameter(cmd, "@longevity", TextBoxLongevity);

                    cmd.Parameters.Add("@fin", SqlDbType.NVarChar).Value = TextBoxFin.Text;
                    cmd.Parameters.Add("@body", SqlDbType.NVarChar).Value = TextBoxBody.Text;
                    cmd.Parameters.Add("@counts", SqlDbType.NVarChar).Value = TextBoxCounts.Text;
                    cmd.Parameters.Add("@shape", SqlDbType.NVarChar).Value = TextBoxShape.Text;
                    cmd.Parameters.Add("@em", SqlDbType.NVarChar).Value = TextBoxEM.Text;
                    cmd.Parameters.Add("@im", SqlDbType.NVarChar).Value = TextBoxIM.Text;

                    AddListParameter(cmd, "@natural_color", cblNaturalColor);

                    cmd.Parameters.Add("@locked", SqlDbType.Bit).Value = 0; //  (cbxLock.Checked ? 1 : 0);

                    if ( m_userGuid == Guid.Empty)
                    {
                        cmd.Parameters.Add("@editor", SqlDbType.UniqueIdentifier).Value = DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@editor", SqlDbType.UniqueIdentifier).Value = m_userGuid;
                    }
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected void LinkButtonEditor_Click(object sender, EventArgs e)
        {
            Response.Redirect("FishEditor.aspx?fishId=" + hiddenFishGuid.Value);
        }
        protected void LinkButtonFood_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditFood.aspx?fishId=" + hiddenFishGuid.Value);
        }
        protected void LinkButtonSpawn_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditFishSpawn.aspx?fishId=" + hiddenFishGuid.Value);
        }
        protected void LinkButtonGeneral_Click(object sender, EventArgs e)
        {
            Response.Redirect("FishGeneral.aspx?fishId=" + hiddenFishGuid.Value);
        }
        bool? GetPicture(System.Web.UI.WebControls.TextBox bx, System.Web.UI.WebControls.Image img )
        {
            bx.BackColor = System.Drawing.Color.White;

            if (String.IsNullOrEmpty(bx.Text))
            {
                return null;
            }
            string urlPic = bx.Text;
            string fn_name = WhatsMyName();
            string[] extlist = { "jpg", "png", "gif", "wep", "jpeg", "bmp" };
            try
            {
                int http = urlPic.IndexOf("http");
                if (http > 0)
                {
                    urlPic = urlPic.Substring(http);
                }
                int picIndex = -1; int idx = 0;

                foreach (var ext in extlist)
                {
                    picIndex = urlPic.LastIndexOf(ext);

                    if (picIndex > 0)
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

                if (!String.IsNullOrEmpty(urlPic))
                {
                    WebClient cln = new WebClient();
                    byte[] data = cln.DownloadData(urlPic);

                    if (data != null)
                    {
                        Guid fishid = Guid.Parse(hiddenFishGuid.Value);

                        Int32.TryParse(TextBoxLat.Text, out int lat);
                        Int32.TryParse(TextBoxLon.Text, out int lon);
                        if( !DateTime.TryParse(TextBoxDate.Text, out DateTime dt) )
                        {
                            dt = DateTime.Now;
                        }
                        string source = TextBoxImageSource.Text;
                        string author = TextBoxImageAuthor.Text;
                        string link = TextBoxImageLink.Text;
                        string label = TextBoxLabel.Text;
                        string location = TextBoxLocation.Text;
                        string tag = TextBoxTag.Text;
                        bool gender = CheckBoxGender.Checked;
                        byte[] hash = new byte[]   { 0x00 };
                        string flds = "fish_id,fish_image_pic,fish_image_source,fish_image_author,fish_image_link,fish_image_label,fish_image_location,fish_image_lat,fish_image_lon,fish_image_tag,fish_image_stamp,fish_image_gender,fish_image_hash";
                        dynamic[] vals = new dynamic[] { fishid, data, source, author, link, label, location, lat, lon, tag, dt, gender, hash };

                        int fish_image_id = m_dbObject.Insert("fish_image", flds, vals, fn_name);

                        if (fish_image_id > 0)
                        {
                            bx.Text = "";
                            string base64String = Convert.ToBase64String(data, 0, data.Length);
                            img.ImageUrl = "data:image/png;base64," + base64String;

                            string sqlcmd = "UPDATE f SET img = fish_image_pic FROM fish f JOIN fish_image i ON f.fish_id = i.fish_id WHERE fish_id = @param0";
                            int? res = m_dbObject.ExecCmd(m_dbObject.m_connection, sqlcmd, SqlDbType.UniqueIdentifier, fishid, "GetPicture");
                            return null == res;
                        }
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            bx.BackColor = System.Drawing.Color.IndianRed;
            return false;
        }

        protected void UploadFile_Click(object sender, EventArgs e)
        {
            try
            {
                System.Web.UI.WebControls.Button btn = (System.Web.UI.WebControls.Button)sender;

                if(btn == null)
                {
                    return;
                }
                if (!String.IsNullOrEmpty(txtImgUrl.Text) && null == GetPicture(txtImgUrl, ImageZoo ))
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
                if (FileUpload.HasFile)
                {
                    string strname = FileUpload.FileName.ToString();

                    FileUpload.SaveAs(folderPath + strname);       //Save the File to the Directory (Folder).

                    ImageZoo.ImageUrl = "~/Files/" + Path.GetFileName(FileUpload.FileName);  // //Display the Picture in Image control.

                    int length = FileUpload.PostedFile.ContentLength;

                    if (0 < length)
                    {
                        byte[] imgbyte = new byte[length];
                        HttpPostedFile img = FileUpload.PostedFile;
                        img.InputStream.Read(imgbyte, 0, length);

                        float lat = float.TryParse(TextBoxLat.Text, out lat) ? lat : 0;
                        float lon = float.TryParse(TextBoxLat.Text, out lon) ? lon : 0;
                        DateTime dt = DateTime.TryParse(TextBoxDate.Text, out dt) ? dt: DateTime.Now;

                        AddFishImage(Guid.Parse(hiddenFishGuid.Value), imgbyte, "fish_zoo", "fish_zoo_image"
                                    , CheckBoxGender.Checked, TextBoxImageSource.Text, TextBoxImageAuthor.Text
                                    , TextBoxImageLink.Text, TextBoxLabel.Text, TextBoxLocation.Text
                                    , lat, lon, TextBoxTag.Text, dt);
                    }
                }

            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected void AddFishImage(Guid fishId, byte[] fishImage, string tableName, string colName
            , bool gender, string source, string author, string link, string label
            , string location, float lat, float lon, string tag, DateTime stamp )
        {
            try
            {
                var paramList = new List<Tuple<string, SqlDbType, dynamic>>();
                paramList.Add(TValue.Create("@fish_id", SqlDbType.UniqueIdentifier, fishId));
                paramList.Add(TValue.Create("@image", SqlDbType.VarBinary, fishImage));
                paramList.Add(TValue.Create("@tablename", SqlDbType.NVarChar, tableName));
                paramList.Add(TValue.Create("@colname", SqlDbType.NVarChar, colName));
                paramList.Add(TValue.Create("@gender", SqlDbType.Bit, gender));
                paramList.Add(TValue.Create("@source", SqlDbType.NVarChar, source));
                paramList.Add(TValue.Create("@author", SqlDbType.NVarChar, author));
                paramList.Add(TValue.Create("@link", SqlDbType.NVarChar, link));
                paramList.Add(TValue.Create("@label", SqlDbType.NVarChar, label));
                paramList.Add(TValue.Create("@location", SqlDbType.NVarChar, location));
                paramList.Add(TValue.Create("@lat", SqlDbType.Float, lat));
                paramList.Add(TValue.Create("@lon", SqlDbType.Float, lon));
                paramList.Add(TValue.Create("@tag", SqlDbType.NVarChar, tag));
                paramList.Add(TValue.Create("@stamp", SqlDbType.DateTime2, stamp));

                int? rows = m_dbObject.ExecSP( "dbo.sp_add_fish_image", paramList, WhatsMyName());

                int? imageId = m_dbObject.GetSingleInt( "SELECT fish_image_id FROM fish_image WHERE @param0=fish_id"
                                                      , SqlDbType.UniqueIdentifier, fishId, WhatsMyName());
                if (imageId != null)
                {
                    ImageZoo.ImageUrl = String.Format("~/Editor/HandlerImage.ashx?id={0}&sid={1}&page=2", fishId, imageId);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
    }
}