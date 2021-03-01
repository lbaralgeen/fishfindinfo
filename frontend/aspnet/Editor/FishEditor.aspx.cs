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

namespace FishTracker
{
    public partial class TFishEditor : DbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            ButtonSubmit.Enabled = m_IsAdmin;
            LinkButtonZoo.Enabled = m_IsAdmin;
            LinkButtonSpawn.Enabled = m_IsAdmin;
            LinkButtonFood.Enabled = m_IsAdmin;
            LinkButtonGeneral.Enabled = m_IsAdmin;

            hiddenFishGuid.Value = Request.QueryString["fishId"];

            if (System.Diagnostics.Debugger.IsAttached)
            {
                hiddenFishGuid.Value = "6b45fea3-5cbe-4982-89af-c241eb5c6a36";
            }
            LoadUnEditedFish();
            //LinkButtonWiki.Attributes.Add("onClick", "return valSubmitWiki();");
        }
        protected bool LoadUnEditedFish( )
        {
            string sqlCmd = "select * from dbo.fn_read_fish_edit_list() ORDER BY fish_name ASC";
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        string fishGuid = dr["fish_id"].ToString();
                        string nameFish = dr["fish_name"].ToString();

                        switch (nameFish[0])
                        {
                            case 'A': if (String.IsNullOrEmpty(ButtonA.ToolTip)) { ButtonA.ToolTip = fishGuid; } break;
                            case 'B': if (String.IsNullOrEmpty(ButtonB.ToolTip)) { ButtonB.ToolTip = fishGuid; } break;
                            case 'C': if (String.IsNullOrEmpty(ButtonC.ToolTip)) { ButtonC.ToolTip = fishGuid; } break;
                            case 'D': if (String.IsNullOrEmpty(ButtonD.ToolTip)) { ButtonD.ToolTip = fishGuid; } break;
                            case 'E': if (String.IsNullOrEmpty(ButtonE.ToolTip)) { ButtonE.ToolTip = fishGuid; } break;
                            case 'F': if (String.IsNullOrEmpty(ButtonF.ToolTip)) { ButtonF.ToolTip = fishGuid; } break;
                            case 'G': if (String.IsNullOrEmpty(ButtonG.ToolTip)) { ButtonG.ToolTip = fishGuid; } break;
                            case 'H': if (String.IsNullOrEmpty(ButtonH.ToolTip)) { ButtonH.ToolTip = fishGuid; } break;
                            case 'K': if (String.IsNullOrEmpty(ButtonK.ToolTip)) { ButtonK.ToolTip = fishGuid; } break;
                            case 'L': if (String.IsNullOrEmpty(ButtonL.ToolTip)) { ButtonL.ToolTip = fishGuid; } break;
                            case 'M': if (String.IsNullOrEmpty(ButtonM.ToolTip)) { ButtonM.ToolTip = fishGuid; } break;
                            case 'N': if (String.IsNullOrEmpty(ButtonN.ToolTip)) { ButtonN.ToolTip = fishGuid; } break;
                            case 'P': if (String.IsNullOrEmpty(ButtonP.ToolTip)) { ButtonP.ToolTip = fishGuid; } break;
                            case 'R': if (String.IsNullOrEmpty(ButtonR.ToolTip)) { ButtonR.ToolTip = fishGuid; } break;
                            case 'S': if (String.IsNullOrEmpty(ButtonS.ToolTip)) { ButtonS.ToolTip = fishGuid; } break;
                            case 'T': if (String.IsNullOrEmpty(ButtonT.ToolTip)) { ButtonT.ToolTip = fishGuid; } break;
                            case 'W': if (String.IsNullOrEmpty(ButtonW.ToolTip)) { ButtonW.ToolTip = fishGuid; } break;
                            case 'Z': if (String.IsNullOrEmpty(ButtonK.ToolTip)) { ButtonZ.ToolTip = fishGuid; } break;
                        }
                        if (String.IsNullOrEmpty(ButtonFirst.ToolTip)
                              && (String.IsNullOrEmpty(hiddenFishGuid.Value) || (hiddenFishGuid.Value == fishGuid)))
                        {
                            TextBoxGuid.Text = fishGuid;
                            TextBoxName.Text = nameFish;
                            TextBoxName.ToolTip = dr["synonims"].ToString();
                            TextBoxLatin.Text = dr["fish_latin"].ToString();
                            TextBoxSynonim.Text = dr["synonims"].ToString();

                            SetList(dr, "water_type", cblWaterType);
                            SetList(dr, "fish_Type", ddListType);
                            SetList(dr, "fish_ability", cblFishWay);
                            SetList(dr, "feedsOver", CheckBoxListFeedsOver);
                            SetList(dr, "react_color", cblReactColor);
                            SetList(dr, "habitat", CheckBoxListHabitat);

                            ReadSingle(dr, "tuLD", TextBoxTuLD);
                            ReadSingle(dr, "tuL", TextBoxTuL);
                            ReadSingle(dr, "tuC", TextBoxTuC);
                            ReadSingle(dr, "tuH", TextBoxTuH);
                            ReadSingle(dr, "tuHD", TextBoxTuHD);

                            ReadSingle(dr, "tmLD", TextBoxTmLD);
                            ReadSingle(dr, "tmL", TextBoxTmL);
                            ReadSingle(dr, "tmC", TextBoxTmC);
                            ReadSingle(dr, "tmH", TextBoxTmH);
                            ReadSingle(dr, "tmHD", TextBoxTmHD);

                            ReadSingle(dr, "oxLD", TextBoxOxLD);
                            ReadSingle(dr, "oxL", TextBoxOxL);
                            ReadSingle(dr, "oxC", TextBoxOxC);
                            ReadSingle(dr, "oxH", TextBoxOxH);
                            ReadSingle(dr, "oxHD", TextBoxOxHD);

                            ReadSingle(dr, "phLD", TextBoxPhLD);
                            ReadSingle(dr, "phL", TextBoxPhL);
                            ReadSingle(dr, "phC", TextBoxPhC);
                            ReadSingle(dr, "phH", TextBoxPhH);
                            ReadSingle(dr, "phHD", TextBoxPhHD);

                            ReadSingle(dr, "veL", TextBoxVeL);
                            ReadSingle(dr, "veH", TextBoxVeH);

                            ReadSingle(dr, "depthMin", TextBoxDepthMin);
                            ReadSingle(dr, "depthMax", TextBoxDepthMax);

                            ReadSingle(dr, "saltL", TextBoxSoltMin);
                            ReadSingle(dr, "saltH", TextBoxSoltMax);

                            ReadSingle(dr, "PhosphateL", TextBoxPhosphateL);
                            ReadSingle(dr, "PhosphateH", TextBoxPhosphateH);
                            ReadSingle(dr, "NitrateL", TextBoxNitrateL);
                            ReadSingle(dr, "NitrateH", TextBoxNitrateH);

                            ReadSingle(dr, "home_range", TextBoxHomeRange);

                            ReadDate(dr, "stamp", LabelStamp);

                            ButtonFirst.ToolTip = fishGuid;
                            hiddenFishGuid.Value = fishGuid;
                            LabelEditedBy.Text = dr["editor"].ToString();
                            cbxLock.Checked = (bool)ReadBit(dr, "locked");

                            if (dr.Read())
                            {
                                string nextGuid = dr["fish_id"].ToString();
                                ButtonNext.Enabled = !String.IsNullOrEmpty(nextGuid);
                                ButtonNext.ToolTip = nextGuid;
                            }
                        }
                    }
                    dr.Close();
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        private bool SaveFishEditData()
        {
            try
            {
                var prms = new List<Tuple<string, SqlDbType, dynamic>>();

                prms.Add(TValue.Create("fish_name", SqlDbType.NVarChar, TextBoxName));
                prms.Add(TValue.Create("alt_name", SqlDbType.NVarChar, TextBoxSynonim));
                prms.Add(TValue.Create("fish_latin", SqlDbType.NVarChar, TextBoxLatin));
                prms.Add(TValue.Create("stamp", SqlDbType.DateTime2, DateTime.UtcNow));
                prms.Add(TValue.Create("water_type", cblWaterType));
                prms.Add(TValue.Create("fish_Type", ddListType));
                prms.Add(TValue.Create("fish_ability", cblFishWay));
                prms.Add(TValue.Create("fish_home_range", SqlDbType.Int, TextBoxHomeRange));

                var where = new List<Tuple<string, SqlDbType, dynamic>>();
                where.Add(TValue.Create("fish_id", SqlDbType.UniqueIdentifier, TextBoxGuid));

                m_dbObject.Update(m_dbObject.m_connection, "fish", prms, where, WhatsMyName());

                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        private bool SaveFishEditFishRules()
        {
            try
            {
                string userName = "system";

                if( m_userGuid != Guid.Empty )
                {
                    userName = m_dbObject.GetSingleString( "SELECT TOP 1 userName FROM Users WHERE @param0=id", SqlDbType.UniqueIdentifier, m_userGuid, WhatsMyName());
                }
                var prms = new List<Tuple<string, SqlDbType, dynamic>>();

                prms.Add(TValue.Create("habitat", CheckBoxListHabitat));
                prms.Add(TValue.Create("feedsOver", CheckBoxListFeedsOver));
                prms.Add(TValue.Create("react_color", cblReactColor));
                prms.Add(TValue.Create("locked", cbxLock));
                prms.Add(TValue.Create("editor", SqlDbType.VarChar, userName));

                prms.Add(TValue.Create("stamp", SqlDbType.DateTime2, DateTime.UtcNow));

                var where = new List<Tuple<string, SqlDbType, dynamic>>();
                where.Add(TValue.Create("fish_id", SqlDbType.UniqueIdentifier, TextBoxGuid));
                where.Add(TValue.Create("periodStart", SqlDbType.Int, -1));
                where.Add(TValue.Create("periodStart", SqlDbType.Int, -1));

                m_dbObject.Update(m_dbObject.m_connection, "fish_Rule", prms, where, WhatsMyName());

                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        private bool SaveFishEditFishIntervals( Guid instance_id )
        {
            if ( instance_id == Guid.Empty )
            {
                return false;
            }
            try
            {
                var prms = new List<Tuple<string, SqlDbType, dynamic>>();

                prms.Add(TValue.Create("min", SqlDbType.Float, TextBoxDepthMin));
                prms.Add(TValue.Create("max", SqlDbType.Float, TextBoxDepthMax));

                prms.Add(TValue.Create("parent_id", SqlDbType.UniqueIdentifier, instance_id));
                prms.Add(TValue.Create("type", SqlDbType.TinyInt, 2));

                m_dbObject.ExecSP(m_dbObject.m_connection, "sp_update_interval", prms, WhatsMyName());

                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(TextBoxName.Text) || m_IsAdmin )
            {
                return;
            }
            Guid fish_id;
            fish_id = Guid.Parse(TextBoxGuid.Text);
            string fn_name = WhatsMyName();
            try
            {
                var where = new List<Tuple<SqlDbType, dynamic>>();
                where.Add(TValue.Create(SqlDbType.UniqueIdentifier, fish_id));
                where.Add(TValue.Create(SqlDbType.Int, -1));
                where.Add(TValue.Create(SqlDbType.Int, -1));

                Guid instance_id = m_dbObject.GetSingleGuid( "SELECT id FROM fish_rule WHERE fish_id=@param0 AND periodStart=@param1 AND periodEnd=@param2", where, fn_name);

                SaveFishEditData();
                SaveFishEditFishRules();

                if (instance_id != Guid.Empty)
                {
                    SaveDataIntervals(instance_id, 3, TextBoxDepthMin, null, null, null, TextBoxDepthMax, fn_name);
                    SaveDataIntervals(instance_id, 9, TextBoxPhLD, TextBoxPhL, TextBoxPhC, TextBoxPhH, TextBoxPhHD, fn_name);
                    SaveDataIntervals(instance_id, 17, TextBoxTmLD, TextBoxTmL, TextBoxTmC, TextBoxTmH, TextBoxTmHD, fn_name);
                    SaveDataIntervals(instance_id, 25, TextBoxTuLD, TextBoxTuL, TextBoxTuC, TextBoxTuH, TextBoxTuHD, fn_name);
                    SaveDataIntervals(instance_id, 33, TextBoxOxLD, TextBoxOxL, TextBoxOxC, TextBoxOxH, TextBoxOxHD, fn_name);
                    SaveDataIntervals(instance_id, 41, TextBoxVeL, null, null, null, TextBoxVeH, fn_name);
                    SaveDataIntervals(instance_id, 49, TextBoxSoltMin, null, null, null, TextBoxSoltMax, fn_name);
                    SaveDataIntervals(instance_id, 57, TextBoxPhosphateL, null, null, null, TextBoxPhosphateH, fn_name);
                    SaveDataIntervals(instance_id, 65, TextBoxNitrateL, null, null, null, TextBoxNitrateH, fn_name);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected void ButtonFirst_Click(object sender, EventArgs e)
        {
            Response.Redirect("FishEditor.aspx");
        }
        protected void ButtonA_Click(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.Button bt = (Button)sender;

            Response.Redirect("FishEditor.aspx?fishId=" + bt.ToolTip);
        }
        protected void ButtonNext_Click(object sender, EventArgs e)
        {
            Response.Redirect("FishEditor.aspx?fishId=" + ButtonNext.ToolTip);
        }

        protected void LinkButtonZoo_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditFishZoo.aspx?fishId=" + hiddenFishGuid.Value);
        }
        protected void LinkButtonGeneral_Click(object sender, EventArgs e)
        {
            Response.Redirect("FishGeneral.aspx?fishId=" + hiddenFishGuid.Value);
        }
        protected void LinkButtonSpawn_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditFishSpawn.aspx?fishId=" + TextBoxGuid.Text);
        }
        protected void LinkButtonFood_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditFood.aspx?fishId=" + hiddenFishGuid.Value);
        }
    }
}