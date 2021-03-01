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
    public partial class EditFishSpawn : DbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            ButtonSubmit.Enabled = m_IsAdmin;

            LinkButtonZoo.Enabled = m_IsAdmin;
            LinkButtonFood.Enabled = m_IsAdmin;
            LinkButtonGeneral.Enabled = m_IsAdmin;

            try { hiddenFishGuid.Value = Request.QueryString["fishId"]; } catch (Exception) { }

            if( String.IsNullOrEmpty(hiddenFishGuid.Value))
            {
                if (System.Diagnostics.Debugger.IsAttached)
                {
                    hiddenFishGuid.Value = "6b45fea3-5cbe-4982-89af-c241eb5c6a36";
                }
                else
                {
                    return;
                }
            }
            LoadUnEditedFish();
            LoadFishName(hiddenFishGuid.Value, TextBoxName, TextBoxLatin);
            TextBoxGuid.Text = hiddenFishGuid.Value;

            LoadSpawnGeneral();
        }
        protected void LoadUnEditedFish()
        {
            string sqlCmd = "SELECT * from dbo.vw_read_fish_spawn WHERE fish_id = @fish_id ORDER BY fish_name ASC";
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    Guid fishid = Guid.Parse(hiddenFishGuid.Value);
                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = fishid;

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        LabelEditedBy.Text = dr["editor"].ToString();
                        SetList(dr, "habitat", cbxSpawnAt);
                        SetList(dr, "spawnsOver", cbxSpawnOver);

                        int? startMonth = ReadInt(dr, "periodStart") - 1;

                        if (startMonth != null && startMonth >= 0 && startMonth < 12)
                        {
                            cbSpawnList.Items[(int)startMonth].Selected = true;
                        }
                        int? endMonth = ReadInt(dr, "periodEnd");

                        if (endMonth != null && endMonth >= 0 && endMonth < 12)
                        {
                            cbSpawnList.Items[(int)endMonth].Selected = true;
                        }
                        cbxLock.Checked = (bool)ReadBit(dr, "locked");

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
                        ReadSingle(dr, "fish_spawnDepth_min", TextBoxDepthMin);
                        ReadSingle(dr, "fish_spawnDepth_max", TextBoxDepthMax);

                        ReadDate(dr, "stamp", LabelStamp);
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "EditFishSpawn>LoadUnEditedFish");
            }
        }
        protected bool LoadSpawnGeneral()
        {
            string sqlCmd = "SELECT * from dbo.fn_fish_spawn( @fish_id )";
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    Guid fishid = Guid.Parse(hiddenFishGuid.Value);
                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = fishid;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            int? fish_spawn_age_male = ReadInt(dr, "fish_spawn_age_male");
                            if (fish_spawn_age_male != null)
                            {
                                TextBoxMaleAge.Text = fish_spawn_age_male.ToString();
                            }
                            int? fish_spawn_age_female = ReadInt(dr, "fish_spawn_age_female");
                            if (fish_spawn_age_female != null)
                            {
                                TextBoxFemaleAge.Text = fish_spawn_age_female.ToString();
                            }
                            ReadDate(dr, "fish_spawn_stamp", LabelStamp);

                            int? fish_spawn_eggs_min = ReadInt(dr, "fish_spawn_eggs_min");

                            if (fish_spawn_eggs_min != null)
                            {
                                TextBoxEggMin.Text = fish_spawn_eggs_min.ToString();
                            }
                            int? fish_spawn_eggs_max = ReadInt(dr, "fish_spawn_eggs_max");

                            if (fish_spawn_eggs_max != null)
                            {
                                TextBoxEggMax.Text = fish_spawn_eggs_max.ToString();
                            }
                            TextBoxDescription.Text = dr["fish_spawn_description"].ToString();
                            TextBoxLocation.Text = dr["fish_spawn_location"].ToString();
                        }
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "EditFishSpawn>LoadSpawnGeneral");
            }
            return false;
        }
        private bool SavePeriodSpawn()
        {
            string fn_name = WhatsMyName();
            try
            {
                Guid fish_id;
                fish_id = Guid.Parse(TextBoxGuid.Text);

                var where = new List<Tuple<SqlDbType, dynamic>>();
                where.Add(TValue.Create(SqlDbType.UniqueIdentifier, fish_id));
                where.Add(TValue.Create(SqlDbType.Int, -1));
                where.Add(TValue.Create(SqlDbType.Int, -1));

                Guid instance_id = m_dbObject.GetSingleGuid( "SELECT id FROM fish_rule WHERE fish_id=@param0 AND periodStart=@param1 AND periodEnd=@param2", where, fn_name);

                if (instance_id != Guid.Empty)
                {
                    SaveDataIntervals( instance_id, 2, TextBoxDepthMin, null, null, null, TextBoxDepthMax, fn_name);
                    SaveDataIntervals( instance_id, 8, TextBoxPhLD, TextBoxPhL, TextBoxPhC, TextBoxPhH, TextBoxPhHD, fn_name);
                    SaveDataIntervals( instance_id, 16, TextBoxTmLD, TextBoxTmL, TextBoxTmC, TextBoxTmH, TextBoxTmHD, fn_name);
                    SaveDataIntervals( instance_id, 24, TextBoxTuLD, TextBoxTuL, TextBoxTuC, TextBoxTuH, TextBoxTuHD, fn_name);
                    SaveDataIntervals( instance_id, 32, TextBoxOxLD, TextBoxOxL, TextBoxOxC, TextBoxOxH, TextBoxOxHD, fn_name);
                    SaveDataIntervals( instance_id, 40, TextBoxVeL, null, null, null, TextBoxVeH, fn_name);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "EditFishSpawn>SavePeriodSpawn");
            }
            return false;
        }
        private bool SaveGeneralSpawn( )
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("dbo.sp_save_fish_spawn_general", m_dbObject.m_connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    Guid fishid = Guid.Parse(hiddenFishGuid.Value);

                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = fishid;

                    AddIntParameter(cmd, "@age_female", TextBoxFemaleAge);
                    AddIntParameter(cmd, "@age_male", TextBoxMaleAge);
                    AddIntParameter(cmd, "@egg_min", TextBoxEggMin);
                    AddIntParameter(cmd, "@egg_max", TextBoxEggMax);
                    cmd.Parameters.Add("@desc", SqlDbType.NVarChar).Value = TextBoxDescription.Text;
                    cmd.Parameters.Add("@location", SqlDbType.NVarChar).Value = TextBoxLocation.Text;
                    cmd.Parameters.Add("@strategy", SqlDbType.NVarChar).Value = "";

                    cmd.ExecuteNonQuery();

                    return true;
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "EditFishSpawn>SaveGeneralSpawn");
            }
            return false;
        }
        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(hiddenFishGuid.Value))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), WhatsMyName(), "alert('Fish guid is empty');", true);
                return;
            }
            SavePeriodSpawn();
            SaveGeneralSpawn();
        }
        protected void LinkButtonEditor_Click(object sender, EventArgs e)
        {
            Response.Redirect("FishEditor.aspx?fishId=" + hiddenFishGuid.Value);
        }
        protected void LinkButtonZoo_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditFishZoo.aspx?fishId=" + hiddenFishGuid.Value);
        }
        protected void LinkButtonFood_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditFood.aspx?fishId=" + hiddenFishGuid.Value);
        }
        protected void LinkButtonGeneral_Click(object sender, EventArgs e)
        {
            Response.Redirect("FishGeneral.aspx?fishId=" + hiddenFishGuid.Value);
        }
    }
}