using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Xml;
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
    public partial class LakeState : DbLayer
    {
        Guid m_lakeid = Guid.NewGuid();

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
                    lakeGuid.Value = lakeid.ToString();

                    m_lakeid = (Guid)lakeid;

                    HyperLinkView.NavigateUrl = "/Resources/wfRiverViewer.aspx?LakeId=" + lakeid;
                    LoadLakeMenu(lakeid);
                    LoadStateLake(lakeid, GetMonth());
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected bool LoadLakeMenu(Guid? lakeid)
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
                    hlLink.NavigateUrl = String.Format("EditTributary.aspx?LakeId={0}", lakeid);
                    hlFish.NavigateUrl = String.Format("EditLakeFish.aspx?LakeId={0}", lakeid);
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
        protected bool LoadStateLake( Guid? lakeid, int month )
        {
            if(lakeid == null )
            {
                return false;
            }
            try
            {
                bool insert = false;
                string sqlcmd = "SELECT lake_id, lake_name, pH, phosphorus, TDS, Conductivity, Alkalinity, Hardness, Sodium";
                      sqlcmd += " , Chloride, Bicarbonate, transparency, oxygen, Salinity, Clarity, velocity, [water_degree]";
                      sqlcmd += " , [air_degree], cold_cool, flow_stand, Stamp ";
                      sqlcmd += " FROM dbo.fn_lake_state( @lake_id, @month) ";

                using (SqlCommand cmd = new SqlCommand(sqlcmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lake_id", SqlDbType.UniqueIdentifier).Value = lakeid;
                    cmd.Parameters.Add("@month",   SqlDbType.Int).Value = month;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            ReadDate(dr, "stamp", LabelStamp);

                            ReadSingle(dr, "phosphorus", txPhosphorus);
                            ReadSingle(dr, "ph", txPH);
                            ReadSingle(dr, "TDS", txTDS);
                            ReadSingle(dr, "Conductivity", txConductivity);
                            ReadSingle(dr, "Alkalinity", txAlkalinity);
                            ReadSingle(dr, "Hardness", txHardness);
                            ReadSingle(dr, "Sodium", txSodium);
                            ReadSingle(dr, "Chloride", txChloride);
                            ReadSingle(dr, "Bicarbonate", txBicarbonate);
                            ReadSingle(dr, "Transparency", txTransparency);
                            ReadSingle(dr, "Oxygen", txOxygen);
                            ReadSingle(dr, "Salinity", txSalinity);
                            ReadSingle(dr, "Clarity", txWaterClarity);
                            ReadSingle(dr, "velocity", txVelocity);
                            ReadSingle(dr, "water_degree", txWaterTemperature);
                            ReadSingle(dr, "air_degree",   txAirTemperature);

                            bool? temp = ReadBit(dr, "cold_cool");
                            cbCold.Checked = false;
                            cbCool.Checked = false;
                            if (null != temp)
                            {
                                cbCold.Checked = (bool)temp ? true : false;
                                cbCool.Checked = (bool)temp ? false : true;
                            }
                            bool? temp2 = ReadBit(dr, "flow_stand");
                            cbFlow.Checked = false;
                            cbStand.Checked = false;
                            if (null != temp2)
                            {
                                cbFlow.Checked  = (bool)temp ? true : false;
                                cbStand.Checked = (bool)temp ? false : true;
                            }

                            txLakeName.Text = ReadString(dr, "lake_name");
                            txGuidLake.Text = lakeid.ToString();

                            LabelStamp.Text = dr["stamp"].ToString();
                        }
                        else
                        {
                            insert = true;
                        }
                    }
                }
                if(insert)
                {
                    int rst = m_dbObject.Insert("lake_state", "lake_id", new dynamic[] { lakeid }, "LoadStateLake");
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        private bool SaveLakeState( Guid lake_id, int month  )
        {
            try
            {
                XmlDocument xdoc = new XmlDocument();

                xdoc.AppendChild(xdoc.CreateElement(string.Empty, "root", string.Empty));
                XmlElement root = xdoc.DocumentElement;

                root.SetAttr("PH", txPH.Text);
                root.SetAttr("phosphorus", txPhosphorus.Text);
                root.SetAttr("TDS", txTDS.Text);
                root.SetAttr("Conductivity", txConductivity.Text);
                root.SetAttr("Alkalinity", txAlkalinity.Text);
                root.SetAttr("Hardness", txHardness.Text);
                root.SetAttr("Sodium", txSodium.Text);
                root.SetAttr("Chloride", txChloride.Text);
                root.SetAttr("Bicarbonate", txBicarbonate.Text);
                root.SetAttr("Transparency", txTransparency.Text);
                root.SetAttr("Oxygen", txOxygen.Text);
                root.SetAttr("Salinity", txSalinity.Text);
                root.SetAttr("Clarity", txWaterClarity.Text);
                root.SetAttr("Velocity", txVelocity.Text);
                root.SetAttr("water_degree", txWaterTemperature.Text);
                root.SetAttr("air_degree",   txAirTemperature.Text);

                if(cbCold.Checked)
                    root.SetAttr("cold_cool", "0");
                else if( cbCool.Checked )
                    root.SetAttr("cold_cool", "1");
                else
                    root.RemoveAttr("cold_cool");

                if (cbFlow.Checked)
                    root.SetAttr("flow_stand", "0");
                else if (cbStand.Checked)
                    root.SetAttr("flow_stand", "1");
                else
                    root.RemoveAttr("flow_stand");

                var prms = new List<Tuple<string, SqlDbType, dynamic>>();
                string xmldoc = xdoc.GetXmlAsString();
                xmldoc = xmldoc.Substring(40, xmldoc.Length - 40);  // remove decorator

                prms.Add(TValue.Create("lake_id", SqlDbType.UniqueIdentifier, lake_id));
                prms.Add(TValue.Create("data", SqlDbType.Xml, xmldoc));
                prms.Add(TValue.Create("month",   SqlDbType.Int, month));

                int? rs2 = m_dbObject.ExecSP("sp_save_lake_state", prms, "LakeState.SaveLakeState");

                if (rs2 != 1)
                {
                    Response.Write("Failed to save LakeState ");

                    return false;
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
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

                if (SaveLakeState( lakeid, GetMonth()))
                {
                    LoadStateLake( lakeid, GetMonth());     // re-read data
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected int GetMonth()
        {
            return Convert.ToInt32(DropDownListStateMonth.SelectedValue);
        }
        protected void DropDownListStateMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            int month = GetMonth();
            LoadStateLake(m_lakeid, month);
        }
    }
}