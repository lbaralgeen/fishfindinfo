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
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace FishTracker.Editor
{
    public partial class EditLakeLink : DbLayer
    {
        private int m_link_type = 64;
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
                Guid? lakeid = GetArgGuid("LakeId", "lake_id", "lake", "stamp");

                if (lakeid != null)
                {
                    hiddenLakeGuid.Value = lakeid.ToString();
                }
                try { m_link_type = Int32.Parse(Request.QueryString["Type"].ToString()); } catch (Exception) { }

                var lake = m_dbObject.GetTupleValue("SELECT lake_id, locType, lake_name FROM lake WHERE lake_id = @param0", SqlDbType.UniqueIdentifier, lakeid, "Page_Load");

                if (LoadEditedLakeMenu(lakeid)
                    && LoadPage(lakeid, m_link_type)
                    && lake != null)
                {
                    HiddenFieldSide.Value = m_link_type.ToString();
                    HiddenFieldPoint.Value = TextBoxPointGuid.Text;

                    if (m_link_type == 32 || m_link_type == 16)
                    {
                        ddlCoast.Visible   = (m_link_type == 32);
                        LabelType.Visible = (m_link_type == 32);
                        ddlFlow.Enabled = false;

                        if (txGuidLake.Text == TextBoxPointGuid.Text)
                        {
                            TextBoxPoint.Text = "";
                            TextBoxPointGuid.Text = "";
                        }
                    }
                    CheckBoxCopyToMouth.Visible = (m_link_type == 16);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "Editor>Page_Load");
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
                    hlMouth.NavigateUrl  = String.Format("EditLakelink.aspx?LakeId={0}&Type={1}", lakeid, 32);
                    hlWaterState.NavigateUrl = String.Format("LakeState.aspx?LakeId={0}", lakeid);
                    hlLink.NavigateUrl   = String.Format("EditTributary.aspx?LakeId={0}", lakeid );
                    hlFish.NavigateUrl = String.Format("EditLakeFish.aspx?LakeId={0}", lakeid);
                    HyperLinkView.NavigateUrl = "/Resources/wfRiverViewer.aspx?LakeId=" + lakeid;
                    return true;
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "Editor>LoadEditedLakeMenu");
            }
            return false;
        }
        protected bool LoadPage( Guid? lakeid, int m_link_type)
        {
            if(lakeid == null || lakeid == Guid.Empty)
            {
                return false;
            }
            try
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.fn_EditLakeLink(@lake, @type)", m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lake", SqlDbType.UniqueIdentifier).Value = lakeid;
                    cmd.Parameters.Add("@type", SqlDbType.Int).Value = m_link_type;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            txLakeName.Text = dr["tname"].ToString(); txGuidLake.Text = hiddenLakeGuid.Value;
                            TextBoxPoint.Text = dr["lake_name"].ToString(); TextBoxPointGuid.Text = dr["t_id"].ToString();

                            switch (m_link_type)
                            {
                                case 1: ddlCoast.SelectedValue = "Left"; break;
                                case 2: ddlCoast.SelectedValue = "Right"; break;
                                case 4: ddlFlow.SelectedValue = "Inflows"; break;
                                case 5: ddlCoast.SelectedValue = "Left"; ddlFlow.SelectedValue = "4"; break;
                                case 6: ddlCoast.SelectedValue = "Left"; ddlFlow.SelectedValue = "4"; break;
                                case 8: ddlFlow.SelectedValue = "Outflows"; break;
                                case 9: ddlCoast.SelectedValue = "Left"; ddlFlow.SelectedValue = "8"; break;
                                case 10: ddlCoast.SelectedValue = "Right"; ddlFlow.SelectedValue = "8"; break;
                                case 16: LabelPoint.Text = "Source"; ddlFlow.SelectedValue = "16"; break;
                                case 32: LabelPoint.Text = "Mouth"; ddlFlow.SelectedValue = "32"; break;
                                case 64: ddlFlow.SelectedValue = "64"; break;
                                default: LabelPoint.Text = "Linked"; break;
                            }
                            TextBoxZone.Text = dr["zone"].ToString();
                            TextBoxDistrict.Text = dr["district"].ToString();
                            string country = dr["Country"].ToString();
                            string state = dr["State"].ToString();

                            if (country == "CA")
                            {
                                RadioButtonCanada.Checked = true;
                                LoadProvince();
                            }
                            else if (country == "US")
                            {
                                RadioButtonUSA.Checked = true;
                                LoadState();
                            }
                            DropDownListContry.SelectedValue = state;

                            TextBoxCounty.Text = dr["County"].ToString();
                            TextBoxCity.Text = dr["City"].ToString();
                            TextBoxRegion.Text = dr["Region"].ToString();
                            TextBoxMunicipality.Text = dr["Municipality"].ToString();
                            TextBoxLat.Text = dr["lat"].ToString();
                            TextBoxLon.Text = dr["lon"].ToString();
                            TextBoxElevation.Text = dr["elevation"].ToString();
                            TextBoxLocation.Text = dr["Location"].ToString();
                            TextBoxDescription.Text = dr["descript"].ToString();
                        }
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "Editor>LoadPage");
            }
            return false;
        }
        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                char? coast = String.IsNullOrEmpty(ddlCoast.SelectedValue) ? null : (char?)ddlCoast.SelectedValue[0];
                int flow = Int32.TryParse(ddlFlow.SelectedValue,  out flow)  ? flow : 0;

                m_link_type = Int32.Parse(HiddenFieldSide.Value);

                string lat = TextBoxLat.Text;

                if( !String.IsNullOrEmpty(lat) )
                {
                    string[] coord = lat.Split(',');

                    if(coord.Length == 2)
                    {
                        TextBoxLat.Text = coord[0];
                        TextBoxLon.Text = coord[1];
                    }
                }
                var prms = new List<Tuple<string, SqlDbType, dynamic>>();

                Guid t_id = Guid.Empty;
                Guid lake_id = Guid.Empty;
                Guid old_point_id = Guid.Empty;

                if (!Guid.TryParse(HiddenFieldPoint.Value, out old_point_id))
                {
                    return;
                }
                if ( (flow == 32 || flow == 16) && String.IsNullOrEmpty(TextBoxPointGuid.Text) )
                {
                    TextBoxPointGuid.Text = txGuidLake.Text;
                }
                if ( !Guid.TryParse( TextBoxPointGuid.Text, out t_id) )
                {
                    return;
                }
                if (!Guid.TryParse(txGuidLake.Text, out lake_id))
                {
                    return;
                }
                prms.Add(TValue.Create("lat", SqlDbType.Float, TextBoxLat));
                prms.Add(TValue.Create("lon", SqlDbType.Float, TextBoxLon));
                prms.Add(TValue.Create("elevation", SqlDbType.Float, TextBoxElevation));

                if( RadioButtonCanada.Checked )
                {
                    prms.Add(TValue.Create("Country", SqlDbType.Char, "CA"));
                }else
                    if (RadioButtonUSA.Checked)
                {
                    prms.Add(TValue.Create("Country", SqlDbType.Char, "US"));
                }else
                {
                    prms.Add(TValue.Create("Country", SqlDbType.Char, DBNull.Value));
                }
                string state = DropDownListContry.SelectedValue;
                prms.Add(TValue.Create("state", SqlDbType.Char, state));
                prms.Add(TValue.Create("city", SqlDbType.NVarChar, TextBoxCity));
                prms.Add(TValue.Create("county", SqlDbType.NVarChar, TextBoxCounty));
                prms.Add(TValue.Create("district", SqlDbType.NVarChar, TextBoxDistrict));
                prms.Add(TValue.Create("descript", SqlDbType.NVarChar, TextBoxDescription));
                prms.Add(TValue.Create("location", SqlDbType.NVarChar, TextBoxLocation));
                prms.Add(TValue.Create("municipality", SqlDbType.NVarChar, TextBoxMunicipality));
                prms.Add(TValue.Create("region", SqlDbType.NVarChar, TextBoxRegion));
                prms.Add(TValue.Create("zone", SqlDbType.Int, TextBoxZone));
                prms.Add(TValue.Create("coast", SqlDbType.VarChar, coast));

                if (t_id != old_point_id)
                {
                    prms.Add(TValue.Create("lake_id", SqlDbType.UniqueIdentifier, t_id));
                }
                var where = new List<Tuple<string, SqlDbType, dynamic>>();
                where.Add(TValue.Create("lake_id", SqlDbType.UniqueIdentifier, old_point_id));
                where.Add(TValue.Create("main_lake_id", SqlDbType.UniqueIdentifier, lake_id));
                where.Add(TValue.Create("side", SqlDbType.Int, m_link_type));

                int? rs = m_dbObject.Update(m_dbObject.m_connection, "Tributaries", prms, where, "EditLakeLink.ButtonSubmit_Click");

                if (rs != null)
                {
                    rs = m_dbObject.ExecSP(m_dbObject.m_connection, "sp_assign_border", "@lake_id", SqlDbType.UniqueIdentifier, lake_id, "EditLakeLink.ButtonSubmit_Click");
                }
                if (m_link_type == 16 )
                {
                    if (t_id == old_point_id)
                    {
                        if (CheckBoxCopyToMouth.Checked == true)
                        {
                            where.Clear();
                            where.Add(TValue.Create("main_lake_id", SqlDbType.UniqueIdentifier, lake_id));
                            where.Add(TValue.Create("side", SqlDbType.Int, 32));

                            rs = m_dbObject.Update(m_dbObject.m_connection, "Tributaries", prms, where, "EditLakeLink.ButtonSubmit_Click");
                        }
                    }
                    else
                    {
                        CheckBoxCopyToMouth.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "Editor>ButtonSubmit_Click");
            }
        }
        private bool LoadProvince()
        {
            DropDownListContry.Items.Clear();

            foreach (string province in CaStates)
            {
                DropDownListContry.Items.Add(province);
            }
            return true;
        }
        private bool LoadState()
        {
            DropDownListContry.Items.Clear();

            foreach (string state in USStates)
            {
                DropDownListContry.Items.Add(state);
            }
            return true;
        }
        protected void RadioButtonCanada_CheckedChanged(object sender, EventArgs e)
        {
            DropDownListContry.Items.Clear();
            RadioButton rb = (RadioButton)sender;

            if (rb == RadioButtonCanada && RadioButtonCanada.Checked == true)
            {
                RadioButtonUSA.Checked = false;
                LoadProvince();
            }
            else
            if (RadioButtonUSA.Checked == true)
            {
                RadioButtonCanada.Checked = false;
                LoadState();
            }
        }
        protected void btPrvLast_Click(object sender, EventArgs e)
        {
            Tuple < Guid, int, string > val = m_dbObject.ReadTupleValue(m_dbObject.m_connection, "SELECT TOP 1 lake_id, source_zone, source_district FROM vw_lake WHERE source_district IS NOT NULL ORDER BY stamp DESC", null, null, "btPrvLast_Click");

            if (val != null)
            {
                TextBoxDistrict.Text = val.Item3;
                TextBoxZone.Text = val.Item2.ToString();
                CheckBoxCopyToMouth.Checked = true;
            }
        }
    }
}