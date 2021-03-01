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
    public partial class EditTributary : DbLayer
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
                Guid? lakeid = GetArgGuid("LakeId", "lake_id", "lake", "stamp");

                if (lakeid != null)
                {
                    hiddenLakeGuid.Value = lakeid.ToString();
                }
                LoadEditedLakeMenu(lakeid);
                hiddenGrid.Value = LoadPage( lakeid );
                hiddenGridTurb.Value = LoadTributary( lakeid );
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
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
        protected string LoadTributary(Guid? lakeid)
        {
            if (lakeid == null || lakeid == Guid.Empty)
            {
                return string.Empty;
            }
            string grid = string.Empty;
            try
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.fn_ViewTributary(@lake) ORDER BY lake_name ASC", m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lake", SqlDbType.UniqueIdentifier).Value = lakeid;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        bool rowOdd = false;    // to set odd row having geeen background

                        while (dr.Read())
                        {
                            string lake_id = GetRecordString(dr, "lake_id");
                            string lake_name = GetRecordString(dr, "lake_name");
                            string flowside = GetRecordString(dr, "way");

                            string lat = GetRecordLatLon(dr, "lat");
                            string lon = GetRecordLatLon(dr, "lon");

                            string latlon = String.Format("<td>{0},&nbsp;{1}</td>", lat, lon);

                            string styleName = "class=\"auto-style29\"";
                            string styleType = "class=\"auto-style35\"";
                            string link = "/Resources/wfRiverViewer.aspx?LakeId";
                            string backgroundRow = rowOdd ? "style=\"background-color:#E6FFFF\"" : "";

                            string tdLeft = String.Format("<td {2}><a href=\"{3}={0}\" target=\"_blank\"><i>{1}</i></a></td>"
                                    , lake_id, lake_name, styleName, link);
                            string tdright = String.Format("<td {0}>{1}</td>", styleType, flowside);

                            string line = String.Format("\t<tr {0}>{1}{2}<td>&nbsp;&nbsp;</td>{3}<td>&nbsp;<textarea {5}>{4}</textarea>&nbsp;</td></tr>\n"
                                    , backgroundRow, latlon, tdLeft, tdright, lake_id, "CLASS=\"GuidStyle\"");

                            grid += line;
                            rowOdd = !rowOdd;
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
            txGuidLake.Text = lakeid.ToString();
            string grid = string.Empty;
            try
            {
                txLakeName.Text = m_dbObject.GetSingleString("SELECT TOP 1 lake_name FROM lake WHERE @param0 = lake_id"
                        , SqlDbType.UniqueIdentifier, lakeid, "EditTributary.LoadPage");

                using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.fn_EditTributary(@lake)", m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lake", SqlDbType.UniqueIdentifier).Value = lakeid;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            string num = GetRecordString(dr, "num");
                            string lake_id = GetRecordString(dr, "lake_id");
                            string lake_name = GetRecordString(dr, "lake_name");
                            int? side = GetRecordInt(dr, "side");
                            string country = GetRecordString(dr, "country");
                            string state = GetRecordString(dr, "state");
                            string zone = GetRecordString(dr, "zone");
                            string tid = GetRecordString(dr, "id");
                            string lat = GetRecordLatLon(dr, "lat");
                            string lon = GetRecordLatLon(dr, "lon");

                            string flowside = GetRecordString(dr, "way");

                            if(side > 8)
                            {
                                continue;
                            }
                            string latlon = String.Format("{0} | {1}", lat, lon);

                            if (lat == null && lon == null)
                            {
                                latlon = lake_id;
                            }
                            if (String.IsNullOrEmpty(flowside))
                            {
                                switch (side)
                                {
                                    case 1: flowside = "Linked"; break;
                                    case 2: flowside = "Throw Lake"; break;
                                    case 4: flowside = "Inflow Lake"; break;
                                    case 8: flowside = "Outflow Lake"; break;
                                }
                            }
                            string style = "class=\"auto-style43\"";
                            string delControl = String.Format("<input type=\"checkbox\" id=\"checkbox{0}\" onchange=\"doalert(this.id)\"/>", tid);
                            string lk_name = String.Format("<a href=\"/Resources/wfRiverViewer.aspx?LakeId={0}\">{1}</a>", lake_id, lake_name);
                            string name = String.Format("<table><tr><td {0}>{1}</td><td>{2}</td><td>{3}</td><td>{4}</td></tr></table>"
                                    , style, lk_name, country, state, delControl);
                            string line = string.Format("\t<tr><td>{0} {1}</td><td>{2}</td><td></td><td>{4}</td><td>{3}</td></tr>\n"
                                , num, ( String.IsNullOrEmpty(zone) ? "" : " ["+zone+"]"), name, latlon, flowside);
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
        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                int flow = Int32.TryParse(ddlFlow.SelectedValue,  out flow)  ? flow : 0; // in, out, unknown

                string lat = TextBoxLat.Text;

                if( !String.IsNullOrEmpty(lat) )
                {
                    string[] coord = lat.Split(',');

                    if(coord.Length >= 2)
                    {
                        TextBoxLat.Text = coord[0].Trim();
                        TextBoxLon.Text = coord[1].Trim();
                    }
                }
                double? lattitude = ( double.TryParse(TextBoxLat.Text.Trim(), out double dbl) ? (double?)dbl : null );
                double? longitude = ( double.TryParse(TextBoxLat.Text.Trim(), out double dbt) ? (double?)dbt : null);
                double? level     = (double.TryParse(txtLevel.Text.Trim(), out double dbv) ? (double?)dbt : null);

                Guid lake_id = Guid.Empty;

                if (!Guid.TryParse(hiddenLakeGuid.Value, out lake_id))
                {
                    return;
                }
                Guid tributary_id = Guid.Empty;

                if (!string.IsNullOrEmpty(TextBoxGuid.Text))
                {
                    tributary_id = Guid.Parse(TextBoxGuid.Text);
                }
                // add Tributary to the main river
                string fields = "main_lake_id,lake_id,side,lat,lon,elevation";

                var values = new dynamic[] { lake_id, tributary_id, flow, lattitude, longitude, level };

                int? rs = m_dbObject.Insert("Tributaries", fields, values, WhatsMyName());

                 {
                    var tvalues = new List<Tuple<string, SqlDbType, dynamic>>();
                    tvalues.Add(Tuple.Create<string, SqlDbType, dynamic>("lake_id", SqlDbType.UniqueIdentifier, lake_id));

                    if (lattitude != null)
                    {
                        tvalues.Add(Tuple.Create<string, SqlDbType, dynamic>("lat", SqlDbType.Float, lattitude));
                    }
                    if (longitude != null)
                    {
                        tvalues.Add(Tuple.Create<string, SqlDbType, dynamic>("lon", SqlDbType.Int, longitude));
                    }
                    if (level != null)
                    {
                        tvalues.Add(Tuple.Create<string, SqlDbType, dynamic>("elevation", SqlDbType.Float, level));
                    }
                    tvalues.Add(Tuple.Create<string, SqlDbType, dynamic>("lake_id", SqlDbType.UniqueIdentifier, tributary_id));
                    tvalues.Add(Tuple.Create<string, SqlDbType, dynamic>("main_lake_id", SqlDbType.UniqueIdentifier, lake_id));
                    tvalues.Add(Tuple.Create<string, SqlDbType, dynamic>("side", SqlDbType.Int, flow));

                    int? rsm = m_dbObject.ExecSP( "sp_add_tributary", tvalues, "EditTributary.ButtonSubmit_Click");
                }
                Response.Redirect(String.Format("EditTributary.aspx?LakeId={0}", hiddenLakeGuid.Value));         // refresh the page
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }

        protected void ButtonDelTributary_Click(object sender, EventArgs e)
        {
            try
            {
                if (!String.IsNullOrEmpty(hiddenDelLakeGuid.Value))
                {
                    string sid = hiddenDelLakeGuid.Value;
                    if (int.TryParse(sid.Substring(8), out int tributary_id) )
                    {

                        var twhere = new List<KeyValuePair<string, dynamic>>();
                        twhere.Add(new KeyValuePair<string, dynamic>("id", tributary_id));

                        if( 1 == m_dbObject.Delete(m_dbObject.m_connection, "Tributaries", twhere, "EditTributary.ButtonDelTributary_Click") )
                        {
                            Response.Redirect(String.Format("EditTributary.aspx?LakeId={0}", hiddenLakeGuid.Value));         // refresh the page
                        }
                    }
                }
                hiddenDelLakeGuid.Value = "";
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
    }
}