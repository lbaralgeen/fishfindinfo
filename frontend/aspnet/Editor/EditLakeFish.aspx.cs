using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TDbInterface;
using System.Xml;
using System.Runtime.CompilerServices;

namespace FishTracker.Editor
{
    public partial class EditLakeFish : DbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            try
            {
                if (!m_IsAdmin)
                {
                    Response.Redirect("/Default.aspx");
                }
                Guid? lakeid = GetArgGuid( "LakeId", "lake_id", "lake", "stamp" );

                if (lakeid != null)
                {
                    hiddenLakeGuid.Value = lakeid.ToString();
                }
                LoadEditedLakeMenu(lakeid);
                hiddenGrid.Value = LoadPage( lakeid );
                HiddenCheckList.Value = LoadFishList(lakeid);
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected bool LoadEditedLakeMenu(Guid? lakeid)
        {
            if (lakeid == null || lakeid == Guid.Empty )
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
                    hlMouth.NavigateUrl  = String.Format("EditLakelink.aspx?LakeId={0}&Type={1}", lakeid, 32);
                    hlLink.NavigateUrl   = String.Format("EditTributary.aspx?LakeId={0}", lakeid );
                    hlWaterState.NavigateUrl = String.Format("LakeState.aspx?LakeId={0}", lakeid);
                    HyperLinkEditLakeFish.NavigateUrl = String.Format("EditLakeFish.aspx?LakeId={0}", lakeid);
                    HyperLinkView.NavigateUrl = "/Resources/wfRiverViewer.aspx?LakeId=" + lakeid;
                    return true;
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        protected string LoadFishList(Guid? lakeid)
        {
            if (lakeid == null || lakeid == Guid.Empty)
            {
                return string.Empty;
            }
            string grid = string.Empty;
            try
            {
                using (SqlCommand cmd = new SqlCommand("SELECT TOP 24 sid, fish_id, fish_name FROM dbo.fn_EditLakeHelpList(@lake) ORDER BY created DESC", m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lake", SqlDbType.UniqueIdentifier).Value = lakeid;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        for ( int id = 0;  dr.Read(); id++)
                        {
                            string fish_name = GetRecordString(dr, "fish_name");
                            string fish_id = GetRecordString(dr, "fish_id");
                            int? sid = GetRecordInt(dr, "sid");

                            string style = "class=\"auto-style43\"";
                            string delControl = String.Format("<input type=\"checkbox\" id=\"cbFish{0}\" onchange=\"saveFish(this.id)\" Value=\"{1}\"/>", sid, fish_id);
                            string name = String.Format("<table><tr><td {2}>{0}</td><td></td><td></td><td>{1}</td></tr></table>"
                                    , fish_name, delControl, style);
                            string line = string.Format("\t<tr><td>{0}</td><td>{1}</td><td></td><td></td><td>{2}</td></tr>\n"
                                            , sid, name, fish_id);
                            grid += line;
                        }
                    }
                }
                return grid;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return string.Empty;
        }
        protected string LoadPage( Guid? lakeid )
        {
            if(lakeid == null || lakeid == Guid.Empty)
            {
                return string.Empty;
            }
            string grid = string.Empty;
            try
            {

                XmlDocument xmldoc = m_dbObject.GetXmlDoc("SELECT dbo.fn_lake_fish(@param0)", SqlDbType.UniqueIdentifier, lakeid, WhatsMyName());
                
                XmlNode rootData = xmldoc.DocumentElement;

                txLakeName.Text = rootData.GetAttr("lake_name");

                int.TryParse(rootData.GetAttr("noFish"), out int noFish);
                int.TryParse(rootData.GetAttr("is_fishing_prohibited"), out int is_fishing_prohibited);
                int.TryParse(rootData.GetAttr("isFish"), out int isFish);

                cbNoFish.Checked            = ( ( noFish                == 1 ) ? true : false );
                cbFishingProhibited.Checked = (  (is_fishing_prohibited == 1 ) ? true : false );

                XmlNodeList fishlist = rootData.SelectNodes("//fish");

                if(fishlist != null && fishlist.Count > 0)
                {
                    foreach( XmlNode item in fishlist)
                    {
                        int.TryParse( item.GetAttr( "sid" ), out int sid );

                        string fish_name = item.GetAttr("fish_name");
                        string fish_id = item.GetAttr("fish_id");

                        int.TryParse(item.GetAttr("source_type"), out int source_type);

                        string prior = ( source_type == 0 ? "high" : "low");
                        string link = item.GetAttr("link");

                        string style = "class=\"auto-style43\"";
                        string delControl = String.Format("<input type=\"checkbox\" id=\"checkbox{0}\" onchange=\"doalert(this.id)\"/>", sid);
                        string name = String.Format("<table><tr><td {2}>{0}</td><td></td><td></td><td>{1}</td></tr></table>"
                                , fish_name, delControl, style);
                        string line = string.Format("\t<tr><td>{0}</td><td>{1}</td><td></td><td>{2}</td><td></td></tr>\n"
                                        , sid, name, prior);
                        grid += line;
                    }
                    return grid;
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return string.Empty;
        }
        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                int trustLevel = Int32.TryParse(ddlTrustLevel.SelectedValue, out trustLevel) ? trustLevel : 0; // 0 - highest
                string fish_name = TextBoxGuid.Text;
                string link = TextBoxSourceLink.Text;

                if( String.IsNullOrEmpty(link) && cbxLastHistory.Checked )
                {
                    link = m_dbObject.GetSingleString("SELECT TOP 1 link FROM lake_fish ORDER BY created DESC", null, null, "ibtPasteLastLinkFishLakeEditor_Click"); ;
                }
                int probability = 0;

                switch(trustLevel)
                {
                    case 0: probability = 100; break;
                    case 1: probability = 80; break;
                    case 2: probability = 65; break;
                    case 3: probability = 30; break;
                    default: probability = 10; break;
                }
                if ( string.IsNullOrEmpty(fish_name) )
                {
                    return;
                }
                Guid lake_id = Guid.TryParse(hiddenLakeGuid.Value, out lake_id) ? lake_id : Guid.Empty;

                if (lake_id == Guid.Empty)
                {
                    return;
                }
                Guid fish_id = Guid.TryParse(fish_name, out fish_id ) ? fish_id : Guid.Empty;

                if(fish_id == Guid.Empty) // if not guid then try to find guid by name
                {
                    string find_guid = m_dbObject.GetSingleString("SELECT TOP 1 CAST(fish_id AS varchar(36)) AS id FROM dbo.SearchFishList(@param0) ORDER BY irank ASC"
                                           , SqlDbType.NVarChar, fish_name, "EditLakeFish.LoadPage");

                    if (!Guid.TryParse(find_guid, out fish_id))
                    {
                        return;
                    }
                }
                HiddenLastFishUrl.Value = link; // save link for next usage

                var values = new dynamic[] { lake_id, fish_id, link, probability, trustLevel, DateTime.Now };

                int? insertedLakeId = m_dbObject.Insert("lake_fish", "Lake_id,fish_id,link,probability,probability_source_type,created", values, "EditLakeFish.ButtonSubmit_Click");

                processListOfLeselectedFishes(lake_id);

                Response.Redirect(String.Format("EditLakeFish.aspx?LakeId={0}", hiddenLakeGuid.Value));         // refresh the page
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected void processListOfLeselectedFishes( Guid lake_id)
        {
            if( Guid.Empty == lake_id)
            {
                return;
            }
            for(int i = 0; i < 10; i++)
            {

            }
        }
        protected void ButtonDelFish_Click(object sender, EventArgs e)
        {
            try
            {
                if (!String.IsNullOrEmpty(hiddenDelFishGuid.Value))
                {
                    string sid = hiddenDelFishGuid.Value;

                    if (int.TryParse(sid.Substring(8), out int fishlake_id) )
                    {

                        var twhere = new List<KeyValuePair<string, dynamic>>();
                        twhere.Add(new KeyValuePair<string, dynamic>("sid", fishlake_id));

                        if( 1 == m_dbObject.Delete(m_dbObject.m_connection, "lake_fish", twhere, "EditLakeFish.ButtonDelFish_Click") )
                        {
                            Response.Redirect(String.Format("EditLakeFish.aspx?LakeId={0}", hiddenLakeGuid.Value));         // refresh the page
                        }
                    }
                }
                hiddenDelFishGuid.Value = "";
            }
            catch (Exception)
            {

            }
        }

        protected void ibtPasteLastLinkFishLakeEditor_Click(object sender, ImageClickEventArgs e)
        {
            TextBoxSourceLink.Text = m_dbObject.GetSingleString("SELECT TOP 1 link FROM lake_fish ORDER BY created DESC", null, null, "ibtPasteLastLinkFishLakeEditor_Click");
        }

        protected void ibtDelSelectedLastLinkFishLakeEditor_Click(object sender, ImageClickEventArgs e)
        {
            TextBoxSourceLink.Text = "";
        }

        protected void btSaveFish_Click(object sender, EventArgs e)
        {
            try
            {
                if (!String.IsNullOrEmpty(hiddenDelFishGuid.Value))
                {
                    string sid = hiddenDelFishGuid.Value;
                    string extract = sid.Substring(6, sid.Length - 6);

                    if (int.TryParse(extract, out int fishid))
                    {
                        var prms = new List<Tuple<string, SqlDbType, dynamic>>();

                        Guid lake_id = Guid.Parse(hiddenLakeGuid.Value);
                        int trustLevel = Int32.TryParse(ddlTrustLevel.SelectedValue, out trustLevel) ? trustLevel : 0; // 0 - highest
                        string link = TextBoxSourceLink.Text;

                        prms.Add(TValue.Create("lakeid", SqlDbType.UniqueIdentifier, lake_id));
                        prms.Add(TValue.Create("fishid", SqlDbType.Int, fishid));
                        prms.Add(TValue.Create("link", SqlDbType.NVarChar, link));
                        prms.Add(TValue.Create("trustLevel", SqlDbType.Int, trustLevel));
                        prms.Add(TValue.Create("status", SqlDbType.TinyInt, (ckAtRisk.Checked ? 1 : 0) ));
                        prms.Add(TValue.Create("method", SqlDbType.NVarChar, txtHunting.Text));

                        if (1 == m_dbObject.ExecSP( "spAddFish", prms, "btSaveFish_Click"))
                        {
                        }
                        Response.Redirect(String.Format("EditLakeFish.aspx?LakeId={0}", hiddenLakeGuid.Value));         // refresh the page
                    }
                }
                hiddenDelFishGuid.Value = "";
            }
            catch (Exception)
            {

            }
        }
    }
}