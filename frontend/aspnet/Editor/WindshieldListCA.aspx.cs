using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using TDbInterface;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace FishTracker.Editor
{
    public partial class WindshieldListCA : DbLayer
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            int type = 1;
            try
            {
                if (!m_IsAdmin)
                {
                    Response.Redirect("/Default.aspx");
                }
                try { HiddenCountry.Value = Request.QueryString["Country"]; } catch (Exception) { HiddenCountry.Value = "CA"; }
                try
                {
                    HiddenState.Value = Request.QueryString["State"];
                } catch (Exception)
                {
                    HiddenState.Value = "ON";
                }
                if (Request.QueryString["Type"] != null)
                {
                    try { string val = Request.QueryString["Type"]; type = Int32.Parse(val); } catch (Exception) { }
                }
                if (String.IsNullOrEmpty(HiddenCountry.Value))
                {
                    HiddenCountry.Value = "CA";
                }

                if (HiddenCountry.Value == "CA")
                {
                    if (String.IsNullOrEmpty(HiddenState.Value))
                    {
                        HiddenState.Value = "ON";
                    }
                    LoadCanada();
                }
                else
                {
                    if (String.IsNullOrEmpty(HiddenState.Value))
                    {
                        HiddenState.Value = "NY";
                    }
                    LoadUSA();
                }
                string last_lake_guid = m_dbObject.GetSingleString("SELECT TOP 1 CAST(lake_id AS varchar(36)) FROM lake ORDER BY stamp DESC", null, null, "WindshieldListCA.Page_Load"); ;
                HyperLinkLastLake.NavigateUrl = String.Format("LakeEditor.aspx?LakeId={0}", last_lake_guid);

                string like = RadioButtonListAZ.SelectedValue;
                SetLikeList();

                string state   = HiddenState.Value;
                string country = HiddenCountry.Value;

                LoadGrid(state, country, type, like);
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected void SetLikeList()
        {
            string starting = RadioButtonListAZ.SelectedValue;
            try
            {
                RadioButtonListAZ.Items.Clear();

                int type = (Int32.TryParse(HiddenRiverType.Value, out type) ? type : 1);
                string state = ddlState.SelectedValue;
                string country = HiddenCountry.Value;

                string sqlcmd = string.Format("SELECT DISTINCT symbol FROM dbo.fn_river_sym('{0}', '{1}', {2}, '$', {3}, {4})"
                                             , state, country, type, 0, 0);

                List<string> states = m_dbObject.GetListString(m_dbObject.m_connection, sqlcmd, "LoadStateList");
                bool isdigit = false;
                RadioButtonListAZ.ClearSelection();

                // load station data
                int index = 0;
                foreach (var like in states)
                {
                    if (char.IsDigit(like[0]))
                    {
                        isdigit = true;
                        continue;
                    }
                    RadioButtonListAZ.Items.Add(like);

                    if (starting == like[0].ToString())
                    {
                        RadioButtonListAZ.SelectedIndex = index;
                    }
                    index++;
                }
                if (isdigit)
                {
                    RadioButtonListAZ.Items.Add("#");
                }
                RadioButtonListAZ.Items.Add("All");

                if( String.IsNullOrEmpty(RadioButtonListAZ.SelectedValue))
                {
                    RadioButtonListAZ.SelectedValue = starting;
                }

            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        private void LoadGrid( string l_state, string l_country, int l_type, string l_like)
        {
            string sqlcmd = "SELECT * FROM dbo.fn_river_list(@state, @country, @river, @section, 0, 0, 1)";

            using (SqlCommand cmd = new SqlCommand(sqlcmd, m_dbObject.m_connection))
            {
                cmd.Parameters.Add("@state", SqlDbType.Char).Value = l_state;
                cmd.Parameters.Add("@country", SqlDbType.Char).Value = l_country;
                cmd.Parameters.Add("@river", SqlDbType.Int).Value = l_type;
                cmd.Parameters.Add("@section", SqlDbType.NChar).Value = l_like;

                recordline.Value = BuildGrid(cmd);
            }
        }
        private string BuildGrid(SqlCommand cmd)
        {
            string records = "";
            try
            {
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    bool rowOdd = false;

                    while (dr.Read())
                    {
                        int? num = GetRecordInt(dr, "num");
                        string lake_name = GetRecordString(dr, "lake_name");
                        string alt_name = GetRecordString(dr, "alt_name");
                        string source_name = GetRecordString(dr, "source_name");
                        string mouth_name = GetRecordString(dr, "mouth_name");
                        string lake_id = GetRecordString(dr, "lake_id");
                        bool? is_fish = GetRecordBit(dr, "isFish");
                        bool? is_well = GetRecordBit(dr, "isWell");
                        string source_lat = GetRecordLatLon(dr, "source_lat");
                        string source_lon = GetRecordLatLon(dr, "source_lon");

                        string mouth_lat = GetRecordLatLon(dr, "mouth_lat");
                        string mouth_lon = GetRecordLatLon(dr, "mouth_lon");
                        string source_country = GetRecordString(dr, "country");
                        string source_state = GetRecordString(dr, "state");
                        string CGNDB = GetRecordString(dr, "CGNDB");

                        if(source_lat == null)
                        {
                            source_lat = mouth_lat;
                        }
                        if (source_lon == null)
                        {
                            source_lon = mouth_lon;
                        }
                        string source_loc = GetRecordString(dr, "source_loc");
                        string mouth_loc = GetRecordString(dr, "mouth_loc");

                        string location = String.IsNullOrEmpty(source_loc) ? mouth_loc  : source_loc;

                        if(String.IsNullOrEmpty(location))
                        {
                            location = CGNDB;
                        }
                        string link_well = (is_well == true) ? "<img src=\"..//Images/monitor.png\"/>" : "";
                        string link_fish = (is_fish == true) ? "<img src=\"..//Images/isfish.png\"/>" : "";

                        string numCell = String.Format("<td class=\"auto-{1}\">{0}</td>", num, "styleNum");

                        string fullName = String.Format("<td class=\"auto-{1}\"><a href=\"LakeEditor.aspx?LakeId={2}\">{0}</a><br>{3}</br></td>", lake_name, "styleFullName", lake_id, alt_name);

                        if( String.IsNullOrEmpty(alt_name) )
                        {
                            fullName = String.Format("<td class=\"auto-{1}\"><a href=\"LakeEditor.aspx?LakeId={2}\">{0}</a></td>", lake_name, "styleFullName", lake_id);
                        }
                        string sourceLatLon = String.Format("<td>{0}<br>{3}</br></td><td class=\"auto-{2}\">{1}<br>{4}</br></td>", source_lat, source_lon, "styleNum", mouth_lat, mouth_lon);

                        if(mouth_lat != null && source_lat != null && mouth_lon != null && source_lon != null &&  mouth_lat == source_lat && mouth_lon == source_lon
                            || mouth_lat == null && mouth_lon == null )
                        {
                            sourceLatLon = String.Format("<td>{0}</td><td class=\"auto-{2}\">{1}</td>", source_lat, source_lon, "styleNum");
                        }
                        string sourceLocation = String.Format("<td>{0}</td><td class=\"auto-{2}\">{1}</td>", source_country, source_state, "styleNum");
                        string lake_guid = String.Format("<td class=\"auto-{1}\">{0}</td>", lake_id, "styleGUID");
                        string fish_well = String.Format("<td>{0}</td><td class=\"auto-{2}\">{1}</td>", link_fish, link_well, "styleNum");

                        string backgroundRow = rowOdd ? "style=\"background-color:#E6FFFF\"" : "";

                        string line = "\t<tr " + backgroundRow + ">" + numCell + fullName + sourceLatLon + sourceLocation
                            + string.Format("<td>{0}</td><td>{1}</td><td>{2}</td>{3}{4}</tr>\n"
                            , location, source_name, mouth_name, lake_guid, fish_well);
                        records += line;
                        rowOdd = !rowOdd;
                    }
                }
                return records;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return "";
        }
        private void LoadGridSearch(string search)
        {
            string cols = " ROW_NUMBER() OVER (ORDER BY lake_name, source_country, source_state, source_lat, source_lon ASC) AS num, * ";
            string sql_cmd = String.Format("SELECT {0} FROM dbo.SearchLakeList(@search) ORDER BY irank ASC", cols);

            using (SqlCommand cmd = new SqlCommand(sql_cmd, m_dbObject.m_connection))
            {
                cmd.Parameters.Add("@search", SqlDbType.NVarChar).Value = search;

                recordline.Value = BuildGrid(cmd);
            }
        }
        private void LoadCanada()
        {
            ddlState.Items.Clear();
            foreach( string iter in CaStates )
            {
                ddlState.Items.Add(iter);
            }
        }
        private void LoadUSA()
        {
            ddlState.Items.Clear();
            foreach (string iter in USStates)
            {
                ddlState.Items.Add(iter);
            }
        }
        protected void ButtonSubmit_Click(object sender, EventArgs e)   // select
        {
            string sqlCmd = "";
            try
            {
                SetLikeList();

                string state = ddlState.SelectedValue;
                string lakeType = ddlWatershield.SelectedValue;
                string letter = RadioButtonListAZ.SelectedValue;

                int type = Int32.Parse(lakeType);
                LoadGrid(state, HiddenCountry.Value, type, letter);
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, null, sqlCmd);
            }
        }
        protected void btSearch_Click(object sender, EventArgs e)
        {
            string sqlCmd = "";
            try
            {
                string searchLine = txSearch.Text.Trim();

                if (String.IsNullOrEmpty(searchLine))
                {
                    return;
                }
                LoadGridSearch(searchLine);
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, null, sqlCmd);
            }
        }
        /// <summary>
        /// ?LakeId=00000000-0000-0000-0000-000000000000
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ButtonNewRiver_Click(object sender, EventArgs e)
        {
            Guid new_lake_guid = Guid.NewGuid();
            string srchlake = txSearch.Text.Trim();

            srchlake = String.IsNullOrEmpty(srchlake) ? "New lake name"  : srchlake;

            var values = new dynamic[] { new_lake_guid, srchlake, ddlWatershield.SelectedValue };
            int newiter = m_dbObject.Insert("Lake", "lake_id,lake_name,locType", values, "ButtonNewRiver_Click");

            string pageurl = String.Format("LakeEditor.aspx?LakeId={0}", new_lake_guid);
            Response.Write("<script> window.open('" + pageurl + "','_blank'); </script>");
        }
        protected void MergeRiver_Click(object sender, EventArgs e)
        {
            //int count = 0; //  DataListSpecies.Items.Count;

            string xmlval = "";
            int cnt = 0;
/*
            for (int i = 0; i < count; i++)
            {
                CheckBox check = DataListSpecies.Items[i].FindControl("cbJoin")   as CheckBox;
                TextBox lake_id = DataListSpecies.Items[i].FindControl("lake_id") as TextBox;

                if(check.Checked)
                {
                    xmlval += "<a>" + lake_id.Text + " </a>";
                    cnt++;
                }
            }
*/
            if (cnt > 1 && !String.IsNullOrEmpty(xmlval))
            {
                int? rs = m_dbObject.ExecSP(m_dbObject.m_connection, "sp_link_lake", "@link", SqlDbType.Xml, xmlval, "WindshieldListCA.MergeRiver_Click");
            }
            // refresh
            if ( !String.IsNullOrEmpty(txSearch.Text) )
            {
                btSearch_Click(null, null);
            }
            else
            {
                ButtonSubmit_Click(null, null);
            }
        }

        protected void ButtonRnCan_Click(object sender, EventArgs e)
        {
            string searchLine = txSearch.Text.Trim();

            searchLine = searchLine.Replace(' ', '+');

            string pageurl = String.Format("http://www4.rncan.gc.ca/search-place-names/search?q={0}&theme[]=979&category=O", searchLine);
            Response.Write("<script> window.open('" + pageurl + "','_blank'); </script>");
        }
    }
}