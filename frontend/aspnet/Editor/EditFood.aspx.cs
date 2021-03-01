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
    public partial class EditFood : DbLayer
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
            LinkButtonGeneral.Enabled = m_IsAdmin;

            try { hiddenFishGuid.Value = Request.QueryString["fishId"]; }catch (Exception) { }

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
            LoadEditedFood();
            LoadSavedFishAsFood();
        }
        protected void LoadEditedFood()
        {
            string sqlCmd = "SELECT * from dbo.vw_editor_fish_food WHERE fish_id = @fish_id ORDER BY fish_name ASC";
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    TextBoxGuid.Text = hiddenFishGuid.Value;
                    Guid fishid = Guid.Parse(hiddenFishGuid.Value);
                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = fishid;

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        TextBoxName.Text  = dr["fish_name"].ToString();
                        TextBoxLatin.Text = dr["fish_latin"].ToString();

                        txtFood.Text = dr["node_food_habitat"].ToString();
                        SetList(dr, "food_habitat", cblHabitat);
                        SetList(dr, "terrestrial_insects", cblTerrestrialInsects);
                        SetList(dr, "terrestrial_animals", cbTerrestrialAnimals);
                        SetList(dr, "crustaceans", cbCrustacean);

                        LabelEditedBy.Text = dr["editor"].ToString();
                        cbxLock.Checked = (bool)ReadBit(dr, "locked");
                        ReadDate(dr, "stamp", LabelStamp);
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
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
                using (SqlCommand cmd = new SqlCommand("spUpdateFishFood", m_dbObject.m_connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    Guid fishid = Guid.Parse(hiddenFishGuid.Value);

                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = fishid;

                    AddListParameter(cmd, "@food_habitat", cblHabitat);
                    AddListParameter(cmd, "@terrestrial_insects", cblTerrestrialInsects);
                    AddListParameter(cmd, "@terrestrial_animals", cbTerrestrialAnimals);
                    AddListParameter(cmd, "@crustaceans", cbCrustacean);

                    cmd.Parameters.Add("@locked", SqlDbType.Bit).Value = (cbxLock.Checked ? 1 : 0);

                    if ( m_userGuid == Guid.Empty )
                    {
                        cmd.Parameters.Add("@editor", SqlDbType.UniqueIdentifier).Value = DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@editor", SqlDbType.UniqueIdentifier).Value = m_userGuid;
                    }
                    cmd.Parameters.Add("@node_food_habitat", SqlDbType.NVarChar).Value = txtFood.Text;
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
        protected void LinkButtonSpawn_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditFishSpawn.aspx?fishId=" + hiddenFishGuid.Value);
        }
        protected void LinkButtonGeneral_Click(object sender, EventArgs e)
        {
            Response.Redirect("FishGeneral.aspx?fishId=" + hiddenFishGuid.Value);
        }

        bool LoadSavedFishAsFood()
        {
            Guid fishid = Guid.Parse(hiddenFishGuid.Value);
            DropDownListFishAsFood.Items.Clear();

            string sql = "SELECT CAST(f.fish_id AS varchar(36)), fish_name FROM fish f JOIN fish_predator p On f.fish_id = p.fish_id";

            var lst = m_dbObject.GetDicSS(m_dbObject.m_connection
                    , sql + " WHERE predator_id = '" + hiddenFishGuid.Value + "'"
                    , "LoadSavedFishAsFood");
            if( null != lst)
                foreach( var item in lst)
                {
                    DropDownListFishAsFood.Items.Add(item.Value);
                }
            return true;
        }

        protected void btAddFishAsFood_Click(object sender, EventArgs e)
        {
            string guidFish = txtBoxFishAsFood.Text.Trim();

            if (String.IsNullOrEmpty(guidFish))
                return;

            Guid uuidFish = Guid.Parse(guidFish);

            try
            {
                Guid fishid = Guid.Parse(hiddenFishGuid.Value);

                using (SqlCommand cmd = new SqlCommand("spUpdateFishPredator", m_dbObject.m_connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@fish_id",     SqlDbType.UniqueIdentifier).Value = uuidFish;
                    cmd.Parameters.Add("@predator_id", SqlDbType.UniqueIdentifier).Value = fishid;

                    cmd.ExecuteNonQuery();

                    string fish_name = m_dbObject.GetSingleString("SELECT fish_name FROM fish WHERE fish_id = @param0"
                        , SqlDbType.UniqueIdentifier, uuidFish, "btAddFishAsFood_Click");

                    if (!String.IsNullOrEmpty(fish_name))
                        DropDownListFishAsFood.Items.Add(fish_name);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
    }
}