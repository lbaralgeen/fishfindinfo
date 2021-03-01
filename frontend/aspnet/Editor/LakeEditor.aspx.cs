using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TDbInterface;
using System.Diagnostics;
using System.Runtime.CompilerServices;

#pragma warning disable IDE0028 
#pragma warning disable IDE1006 

namespace FishTracker.Editor
{
    public partial class LakeEditor : DbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            try
            {
                Guid? lakeid = GetArgGuid("LakeId", "lake_id", "lake", "stamp");

                if (lakeid != null)
                {
                    lakeGuid.Value = lakeid.ToString();
                }
                HyperLinkView.NavigateUrl = "/Resources/wfRiverViewer.aspx?LakeId=" + lakeid;

                ImageRiver.ImageUrl = String.Format("~/Editor/HandlerImage.ashx?lake={0}", lakeid);

                LoadEditedLakeMenu(lakeid);
                LoadEditedLake( lakeid );

                txtboxEditLake_ImageDate.Text = DateTime.Now.ToShortDateString();

                ButtonSubmit.Enabled = m_IsAdmin;
                cbxLock.Enabled = m_IsAdmin;
                cbxLakeReviewed.Enabled = m_IsAdmin;
                btDelRiver.Enabled = m_IsAdmin;
                btExchLatLonRiver.Enabled = m_IsAdmin;
                iuImage.Enabled = m_IsAdmin;
                FileUploadImage.Enabled = m_IsAdmin;

            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Editor.Page_Load");
            }
        }
        protected bool LoadEditedLakeMenu(Guid? lakeid)
        {
            if (lakeid == null || lakeid == Guid.Empty)
            {
                return false;
            }
            try
            {
                hlLakeEdit.NavigateUrl = "LakeEditor.aspx?LakeId=" + lakeid;

                if (lakeid != Guid.Empty)
                {
                    hlDocs.NavigateUrl = String.Format("LakeMap.aspx?LakeId={0}", lakeid);
                    hlSource.NavigateUrl = String.Format("EditLakelink.aspx?LakeId={0}&Type={1}", lakeid, 16);
                    hlMouth.NavigateUrl = String.Format("EditLakelink.aspx?LakeId={0}&Type={1}", lakeid, 32);
                    hlWaterState.NavigateUrl = String.Format("LakeState.aspx?LakeId={0}", lakeid);
                    hlLink.NavigateUrl = String.Format("EditTributary.aspx?LakeId={0}", lakeid);
                    HyperLinkEditLakeFish.NavigateUrl = String.Format("EditLakeFish.aspx?LakeId={0}", lakeid);
                    HyperLinkView.NavigateUrl = "/Resources/wfRiverViewer.aspx?LakeId=" + lakeid;
                    return true;
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Editor.LoadEditedLakeMenu");
            }
            return false;
        }
        protected bool LoadEditedLake( Guid? lakeid )
        {
            if(lakeid == null  )
            {
                return false;
            }
            try
            {
                XmlDocument xmldoc = m_dbObject.GetXmlDoc("SELECT dbo.fn_lake_edit(@param0)", SqlDbType.UniqueIdentifier, lakeid, WhatsMyName());

                if(xmldoc == null)
                {
                    return false;
                }
                XmlNode rootData = xmldoc.DocumentElement;

                string source_state = rootData.GetAttr("source_state");

                if (String.IsNullOrEmpty(source_state))
                {
                    source_state = "ON";
                }
                string source_country = rootData.GetAttr("source_country");

                if (String.IsNullOrEmpty(source_country))
                {
                    source_country = "CA";
                }
                XmlNode lakeNode = rootData.SelectSingleNode("lake");
                string locType = "";

                if (lakeNode != null)
                {
                    txtboxEditLake_GuidLake.Text = lakeNode.GetAttr("lake_id");
                    LabelStamp.Text = lakeNode.GetAttr("stamp").Substring(0, 8);

                    txtboxEditLake_Depth.Text = lakeNode.GetAttr("depth");
                    txtboxEditLake_Width.Text = lakeNode.GetAttr("width");
                    txtboxEditLake_Length.Text = lakeNode.GetAttr("length");
                    txtboxEditLake_Volume.Text = lakeNode.GetAttr("volume");
                    txtboxEditLake_Surface.Text = lakeNode.GetAttr("surface");
                    txtboxEditLake_Shoreline.Text = lakeNode.GetAttr("shoreline");
                    txtboxEditLake_CGNDB.Text = lakeNode.GetAttr("CGNDB");
                    txtboxEditLake_Basin.Text = lakeNode.GetAttr("basin");

                    checkboxEditLake_Isolated.Checked = lakeNode.GetAttr("isolated") == "1" ? true : false;
                    checkboxEditLake_Prohibited.Checked = lakeNode.GetAttr("is_fishing_prohibited") == "1" ? true : false;
                    checkboxEditLake_NoFish.Checked = lakeNode.GetAttr("no_fish") == "1" ? true : false;
                    cbxLakeReviewed.Checked = lakeNode.GetAttr("reviewed") == "1" ? true : false;

                    if (lakeNode.GetAttr("is_fish") == "1")
                    {
                        checkboxEditLake_NoFish.Enabled = false;
                    }
                    locType = lakeNode.GetAttr("locType");

                    if (Int32.TryParse(locType, out int lkttype))
                    {
                        SetValueToCombo(lkttype, ddlEditLake_LakeType);
                    }
                }
                XmlNode lake_name = rootData.SelectSingleNode("//node[@name=\"lake_name\"]");

                if (lake_name != null)
                {
                    txtboxEditLake_LakeName.Text = lake_name.InnerText;
                }
                XmlNode alt_name = rootData.SelectSingleNode("//node[@name=\"alt_name\"]");

                if (alt_name != null)
                {
                    txtboxEditLake_AltName.Text = alt_name.InnerText;
                }
                XmlNode native = rootData.SelectSingleNode("//node[@name=\"native\"]");

                if (native != null)
                {
                    txtboxEditLake_Native.Text = native.InnerText;
                }
                XmlNode french_name = rootData.SelectSingleNode("//node[@name=\"french_name\"]");

                if (french_name != null)
                {
                    txtboxEditLake_French.Text = french_name.InnerText;
                }
                XmlNode Source_name = rootData.SelectSingleNode("//node[@name=\"Source_name\"]");

                if (Source_name != null)
                {
                    txtboxEditLake_Source.Text = Source_name.InnerText;
                }
                XmlNode Mouth_name = rootData.SelectSingleNode("//node[@name=\"Mouth_name\"]");

                if (Mouth_name != null)
                {
                    txtboxEditLake_Mouth.Text = Mouth_name.InnerText;
                }
                XmlNode link = rootData.SelectSingleNode("//node[@name=\"link\"]");

                if (link != null)
                {
                    txtboxEditLake_Link.Text = link.InnerText;
                }
                XmlNode lake_road_access = rootData.SelectSingleNode("//node[@name=\"lake_road_access\"]");

                if (lake_road_access != null)
                {
                    txtboxEditLake_access.Text = lake_road_access.InnerText;
                }
                XmlNode discharge = rootData.SelectSingleNode("//node[@name=\"discharge\"]");

                if (discharge != null)
                {
                    txtboxEditLake_Discharge.Text = discharge.InnerText;
                }
                XmlNode drainage = rootData.SelectSingleNode("//node[@name=\"drainage\"]");

                if (drainage != null)
                {
                    txtboxEditLake_Drainage.Text = drainage.InnerText;
                }
                
                XmlNode watershield = rootData.SelectSingleNode("//node[@name=\"watershield\"]");

                if (watershield != null)
                {
                    txtboxEditLake_Watershield.Text = watershield.InnerText;
                }

                XmlNode descript = rootData.SelectSingleNode("//node[@name=\"descript\"]");

                if (descript != null)
                {
                    txtboxEditLake_Description.Text = descript.InnerText;
                }
                XmlNode mlinode = rootData.SelectSingleNode("//node[@name=\"MLI\"]");

                if (mlinode != null)
                {
                    txtboxEditLake_MLI.Text = mlinode.InnerText;
                }
                string html = String.Format("~/Editor/WindshieldListCA.aspx?Country={0}&State={1}&Type={2}", source_country, source_state, locType);
                ImageButtonLink.PostBackUrl = html;

                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Editor.LoadEditedLake");
            }
            return false;
        }
        private bool SaveLakeGeneral( Guid lake_id  )
        {
            try
            {
                var prms = new List<Tuple<string, SqlDbType, dynamic>>();

                prms.Add(TValue.Create("lake_Name",   SqlDbType.NVarChar,         txtboxEditLake_LakeName));
                prms.Add(TValue.Create("alt_Name",    SqlDbType.NVarChar,         txtboxEditLake_AltName));
                prms.Add(TValue.Create("native",      SqlDbType.NVarChar,         txtboxEditLake_Native));
                prms.Add(TValue.Create("french_name", SqlDbType.NVarChar,         txtboxEditLake_French));
                prms.Add(TValue.Create("source",      SqlDbType.UniqueIdentifier, txtboxEditLake_Source));
                prms.Add(TValue.Create("mouth",       SqlDbType.UniqueIdentifier, txtboxEditLake_Mouth));
                prms.Add(TValue.Create("link",        SqlDbType.NVarChar,         txtboxEditLake_Link));
                prms.Add(TValue.Create("locType",     SqlDbType.Int,              GetComboType(ddlEditLake_LakeType)));
                prms.Add(TValue.Create("stamp",       SqlDbType.DateTime2,        DateTime.Now));

                var where = new List<Tuple<string, SqlDbType, dynamic>>();
                where.Add(TValue.Create("lake_id", SqlDbType.UniqueIdentifier, lake_id));

                int? rs1 = m_dbObject.Update(m_dbObject.m_connection, "Lake", prms, where, "LakeEditor.SaveLakeGeneral");

                if(rs1 != 1)
                {
                    Response.Write("Failed to save Block1 ");

                    return false;
                }
                string[] mlis = txtboxEditLake_MLI.Text.Trim().Split(',');

                foreach (string mli in mlis)
                {
                    if (!String.IsNullOrEmpty(mli))
                    {
                        var prms1a = new List<Tuple<string, SqlDbType, dynamic>>();
                        prms1a.Add(TValue.Create("lakeid", SqlDbType.UniqueIdentifier, lake_id));

                        var where1a = new List<Tuple<string, SqlDbType, dynamic>>();
                        where1a.Add(TValue.Create("mli", SqlDbType.VarChar, mli));

                        int? rs1a = m_dbObject.Update(m_dbObject.m_connection, "WaterStation", prms1a, where1a, "LakeEditor.SaveLakeGeneral-1a");

                        if (rs1a != 1)
                        {
                            Response.Write("Failed to save Block1a ");

                            return false;
                        }
                    }
                }
                prms.Clear();
                prms.Add(TValue.Create("length",                SqlDbType.Int,      txtboxEditLake_Length));    // km
                prms.Add(TValue.Create("depth",                 SqlDbType.Int,      txtboxEditLake_Depth));  // m
                prms.Add(TValue.Create("width",                 SqlDbType.Int,      txtboxEditLake_Width));  // km

                prms.Add(TValue.Create("volume",                SqlDbType.Int,      txtboxEditLake_Volume));    // km^3
                prms.Add(TValue.Create("surface",               SqlDbType.Int,      txtboxEditLake_Surface));  // km^2
                prms.Add(TValue.Create("shoreline",             SqlDbType.Int,      txtboxEditLake_Shoreline));  // km
                prms.Add(TValue.Create("lake_road_access",      SqlDbType.NVarChar, txtboxEditLake_access));
                
                prms.Add(TValue.Create("isolated", SqlDbType.Bit, checkboxEditLake_Isolated));
                prms.Add(TValue.Create("is_fishing_prohibited", SqlDbType.Bit,      checkboxEditLake_Prohibited));
                prms.Add(TValue.Create("NoFish",                SqlDbType.Bit,      checkboxEditLake_NoFish));
                prms.Add(TValue.Create("Reviewed",               SqlDbType.Bit,      cbxLakeReviewed));

                int? rs2 = m_dbObject.Update(m_dbObject.m_connection, "Lake", prms, where, "LakeEditor.SaveLakeGeneral");

                if (rs2 != 1)
                {
                    Response.Write("Failed to save Block2 ");

                    return false;
                }
                prms.Clear();
                prms.Add(TValue.Create("CGNDB", SqlDbType.Char, txtboxEditLake_CGNDB));
                
                prms.Add(TValue.Create("basin", SqlDbType.VarChar, txtboxEditLake_Basin));
                prms.Add(TValue.Create("drainage", SqlDbType.NVarChar, txtboxEditLake_Drainage));
                prms.Add(TValue.Create("discharge", SqlDbType.NVarChar, txtboxEditLake_Discharge));
                prms.Add(TValue.Create("watershield", SqlDbType.NVarChar, txtboxEditLake_Watershield));

                string text = txtboxEditLake_Description.Text;
                text = text.Replace("\r", "<br>"); text = text.Replace("\n", "<br>");
                prms.Add(TValue.Create("descript", SqlDbType.NVarChar, text));
                prms.Add(TValue.Create("stamp", SqlDbType.DateTime2, DateTime.Now));

                where = new List<Tuple<string, SqlDbType, dynamic>>();
                where.Add(TValue.Create("lake_id", SqlDbType.UniqueIdentifier, txtboxEditLake_GuidLake));

                int? rs = m_dbObject.Update(m_dbObject.m_connection, "Lake", prms, where, "LakeEditor.SaveLakeGeneral");

                m_dbObject.ExecSP(m_dbObject.m_connection, "sp_save_lake", "lake_id", SqlDbType.UniqueIdentifier, lake_id, WhatsMyName());
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Editor.SaveLakeGeneral");
            }
            return false;
        }
        /// <summary>
        /// ?LakeId=00000000-0000-0000-0000-000000000000
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(lakeGuid.Value) || String.IsNullOrEmpty(m_connStr))
                {
                    return;
                }
                Guid lakeid = Guid.Parse(lakeGuid.Value);

                if (SaveLakeGeneral( lakeid ))
                {
                    LoadEditedLake( lakeid );     // re-read data
                    SaveDocument( lakeid, txtboxEditLake_Link.Text );  // save document
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Editor.ButtonSubmit_Click");
            }
        }
        protected void SaveDocument(Guid lake_id, string document)
        {
            if(lake_id == Guid.Empty || String.IsNullOrEmpty(document))
            {
                return;
            }
            try
            {
                string folderPath = Server.MapPath("~/Files/");

                //Check whether Directory (Folder) exists.
                if (!Directory.Exists(folderPath))
                {
                    //If Directory (Folder) does not exists Create it.
                    Directory.CreateDirectory(folderPath);
                }
                int type_doc = (document.Contains(".jpg")) ? 1 : 0;
                type_doc = (document.Contains(".png")) ? 1 : type_doc;
                type_doc = (document.Contains(".pdf")) ? 8 : type_doc;
                type_doc = (document.Contains(".doc")) ? 9 : type_doc;
                type_doc = (document.Contains(".xls")) ? 10 : type_doc;
                type_doc = (document.Contains(".rtf")) ? 11 : type_doc;

                {
                    FileUploadImage.SaveAs(folderPath + document);       //Save the File to the Directory (Folder).

                    ImageRiver.ImageUrl = "~/Files/" + Path.GetFileName(FileUploadImage.FileName);  // //Display the Picture in Image control.
                    int length = FileUploadImage.PostedFile.ContentLength;

                    if (0 < length)
                    {
                        DateTime stamp = DateTime.Parse(txtboxEditLake_ImageDate.Text);

                        byte[] imgbyte = new byte[length];
                        HttpPostedFile img = FileUploadImage.PostedFile;
                        img.InputStream.Read(imgbyte, 0, length);

                        string fields = "lake_image_pic,lake_image_source,lake_image_author,lake_image_link,lake_image_hash,lake_image_stamp,lake_image_ownerid";

                        using (System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create())
                        {
                            byte[] hashBytes = md5.ComputeHash(imgbyte);

                            var values = new dynamic[] { imgbyte, txtboxEditLake_SourceImage.Text, txtboxEditLake_Author.Text
                                    , txtboxEditLake_SourceLink.Text, hashBytes, stamp, lake_id };

                            int rs = m_dbObject.Insert("lake_image", fields, values, WhatsMyName());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Editor.SaveDocument");
            }
        }
        protected void btnBriefUpload_Click(object sender, EventArgs e)
        {
            if (FileUploadImage.HasFile)
            {
                string strname = FileUploadImage.FileName.ToString();

                SaveDocument(Guid.Parse(lakeGuid.Value), strname);
            }
        }

        protected void btDelRiver_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(lakeGuid.Value))
            {
                Guid lake_guid = Guid.Parse(lakeGuid.Value);

                if (0 < m_dbObject.ExecSP(m_dbObject.m_connection, "sp_del_river", "@lake_id", SqlDbType.UniqueIdentifier, lake_guid, "btDelRiver_Click"))
                {
                    Response.Write("<script>javascript:window.close();</script>");
                }
            }
        }

        protected void btExchLatLonRiver_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(lakeGuid.Value))
            {
                Guid lake_guid = Guid.Parse(lakeGuid.Value);

                if (0 < m_dbObject.ExecSP(m_dbObject.m_connection, "sp_exchange_latlon", "@lake_id", SqlDbType.UniqueIdentifier, lake_guid, "btDelRiver_Click"))
                {
                    Response.Redirect("wfRiverViewer.aspx?lake_id=" + lake_guid);
                }
            }
        }
    }
}