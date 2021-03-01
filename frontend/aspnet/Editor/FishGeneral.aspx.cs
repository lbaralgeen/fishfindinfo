using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace FishTracker.Editor
{
    public partial class FishGeneral : DbLayer
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

            try { hiddenFishGuid.Value = Request.QueryString["fishId"]; } catch (Exception) { }

            if (String.IsNullOrEmpty(hiddenFishGuid.Value))
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
            LoadGeneralFish(hiddenFishGuid.Value);
        }

        protected bool LoadGeneralFish( string fish_guid )
        {
            if( String.IsNullOrEmpty(fish_guid))
            {
                return false;
            }
            string sqlCmd = "SELECT * FROM dbo.fn_edit_fish_general( @fish_id ) ";
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = Guid.Parse(fish_guid);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        TextBoxLatin.Text = dr["fish_latin"].ToString();
                        TextBoxName.Text = dr["fish_name"].ToString();
                        TextBoxGuid.Text = fish_guid;

                        txtBoxFishGeneralDescription.Text = dr["fish_description"].ToString();

                        int? imageId = ReadInt(dr, "fish_image_id");
                        ImageFish.ImageUrl = String.Format("~/Editor/HandlerImage.ashx?id={0}&sid={1}&page=2", fish_guid, imageId);

                        ImageFish.AlternateText = g_sFishLatinName.Value;
                        LabelEditedBy.Text = dr["editor"].ToString();
                        cbxLock.Checked = (bool)ReadBit(dr, "locked");
                        ReadDate(dr, "stamp", LabelStamp);
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
        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(hiddenFishGuid.Value))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ButtonSubmit_Click", "alert('Fish guid is empty');", true);
                return;
            }
            try
            {
                using (SqlCommand cmd = new SqlCommand("sp_update_fish_general", m_dbObject.m_connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    Guid fishid = Guid.Parse(hiddenFishGuid.Value);

                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = fishid;
                    cmd.Parameters.Add("@locked", SqlDbType.Bit).Value = (cbxLock.Checked ? 1 : 0);

                    if ( m_userGuid == Guid.Empty)
                    {
                        cmd.Parameters.Add("@editor", SqlDbType.UniqueIdentifier).Value = DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@editor", SqlDbType.UniqueIdentifier).Value = m_userGuid;
                    }
                    cmd.Parameters.Add("@fish_description", SqlDbType.NVarChar).Value = txtBoxFishGeneralDescription.Text;

                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected void LinkButtonZoo_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditFishZoo.aspx?fishId=" + hiddenFishGuid.Value);
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
    }
}