using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;
using System.Diagnostics;
using System.Runtime.CompilerServices;

// Display rivers 

namespace FishTracker.Resources
{
    public partial class Water : ResDbLayer
    {
        protected void Page_Load(object sender, EventArgs e)  // ~/Forecast/RiverList.aspx?Country=CA&State=ON&River=1
        {
            if (IsPostBack)
            {
                return;
            }
            try
            {
                if (m_IsTrial)  // hide controls from unregistred users
                {
                    cbMonitor.Visible = false;
                    cbFish.Visible = false;
                    cbFish.Checked = false;
                    hfGuid.Value = "Location";
                    hdIsFish.Value = "1";
                }
                else
                {
                    try { hdIsFish.Value = Request.QueryString["Fish"]; } catch (Exception) { }
                    try { hd_rscRiverList_Letter.Value = Request.QueryString["Filter"]; } catch (Exception) { }
                    
                    cbFish.Checked = (hdIsFish.Value == "1") ? true : false ;
                    hfSynonim.Value = "Location";
                }
                try { HiddenState.Value = Request.QueryString["State"]; } catch (Exception) { }

                if (String.IsNullOrEmpty(HiddenState.Value) || HiddenState.Value.Length != 2)
                {
                    HiddenState.Value = "ON";
                }
                lbState.Text = HiddenCountry.Value.Equals("CA") ? "Province: " : "State: ";

                try { HiddenCountry.Value = Request.QueryString["Country"]; } catch (Exception) { }

                if (String.IsNullOrEmpty(HiddenCountry.Value) || HiddenCountry.Value.Length != 2)
                {
                    HiddenCountry.Value = "CA";
                }
                try { HiddenRiverType.Value = Request.QueryString["River"]; } catch (Exception) { }
                try { hdCurrentPage.Value = Request.QueryString["Offset"]; } catch (Exception) { hdCurrentPage.Value = "0"; }
                hdCurrentPage.Value = (Int32.TryParse(hdCurrentPage.Value, out int npages) ? npages : 0).ToString();

                int type = 2;

                Int32.TryParse(HiddenRiverType.Value, out type);

                if( type < 1 || type > 8192 || ( m_IsTrial && type > 2 ) )
                {
                    type = 2;
                }
                HiddenRiverType.Value = type.ToString();

                LoadStateList(ddlState, HiddenCountry.Value);
                ddlState.SelectedValue = HiddenState.Value;

                SetLikeList();

                if (!String.IsNullOrEmpty(hd_rscRiverList_Letter.Value))
                {
                    RadioButtonListAZ.SelectedValue = hd_rscRiverList_Letter.Value;
                }
                Refresh(WhatsMyName(), m_IsAdmin);
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Page_Load");
            }
        }
        int GetCurrentPage()
        {
            int npages = (Int32.TryParse(hdCurrentPage.Value, out npages) ? npages : 0);

            return (npages < 0 || npages > 1000 ? 0 : npages);
        }
        string BuildArgLine( int currentPage = -1 )
        {
            var laketypes = new HashSet<int>() {1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32468 };

            string state = HiddenState.Value;
            string country = HiddenCountry.Value;
            string riverType = HiddenRiverType.Value;

            if( String.IsNullOrEmpty(state) || state.Length != 2 )
            {
                state = "ON";
            }
            if (String.IsNullOrEmpty(country) || country.Length != 2 || !(country == "CA" || country == "US"))
            {
                country = "CA";
            }
            int npages = (currentPage < 0) ? GetCurrentPage() : currentPage;

            int rtype = (Int32.TryParse(HiddenRiverType.Value, out rtype) ? rtype : 1);
            int isfish = (Int32.TryParse(hdIsFish.Value, out isfish) ? isfish : 1);

            rtype = ( laketypes.Contains(rtype) ? rtype : 1);
            string letter = hd_rscRiverList_Letter.Value;

            return String.Format("Country={0}&State={1}&River={2}&Fish={3}&Offset={4}&Filter={5}"
                , country, state, riverType, isfish, npages, letter );
        }
        /// <summary>
        /// isGuid  - display guid only in admin mode
        /// </summary>
        /// <param name="l_state"></param>
        /// <param name="l_country"></param>
        /// <param name="l_type"></param>
        /// <param name="l_like"></param>
        /// <param name="isGuid"></param>
        private void LoadGrid(string l_state, string l_country, int l_type, string l_like, int l_page = 0, bool isGuid = true)
        {
            try
            {
                // <tr style="background-color: #CCCCCC" class="auto-style24"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>

               InitizlizeNavigator( ref rblNavigator, l_page);

                string sqlcmd = string.Format("SELECT * FROM dbo.fn_river_list(@state, @country, @river, @section, {0}, {1}, {2})"
                    , cbMonitor.Checked ? 1 : 0, cbFish.Checked ? 1 : 0, l_page);

                if (m_dbObject.m_connection.State == ConnectionState.Closed)
                {
                    m_dbObject.m_connection.Open();
                }
                int? countRows = 0;

                using (SqlCommand cmd = new SqlCommand(sqlcmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@state", SqlDbType.Char).Value = l_state;
                    cmd.Parameters.Add("@country", SqlDbType.Char).Value = l_country;
                    cmd.Parameters.Add("@river", SqlDbType.Int).Value = l_type;
                    cmd.Parameters.Add("@section", SqlDbType.NChar).Value = l_like;

                    recordline.Value = BuildGrid(cmd, isGuid, ref countRows);
                }
                if( null != countRows)
                {
                    InitizlizeNavigator(ref rblNavigator, l_page, (int)countRows);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.LoadGrid");
            }
            m_dbObject.m_connection.Close();
        }
        private string BuildGrid(SqlCommand cmd, bool isGuid, ref int? npages )
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
                        npages = GetRecordInt(dr, "itg");      // number of rows 
                        npages = (null == npages || npages < 0) ? 0 : npages;
                        hdTotalPages.Value = npages.ToString();

                        if ( String.IsNullOrEmpty(alt_name))
                        {
                            alt_name = GetRecordString(dr, "french_name");
                        }
                        if (String.IsNullOrEmpty(alt_name))
                        {
                            alt_name = GetRecordString(dr, "native");
                        }
                        string description = GetRecordString(dr, "description");

                        if (String.IsNullOrEmpty(alt_name) && !m_IsTrial)
                        {
                            string[] location = description.Split(',');
                            var words = new HashSet<string>();

                            foreach( string loc in location)
                            {
                                words.Add(loc.Trim());
                            }
                            description = String.Join(",", words);
                        }else
                            if(m_IsTrial && !String.IsNullOrEmpty(alt_name))
                        {
                            description = alt_name;
                        }
                        string source_name = GetRecordString(dr, "source_name");
                        string mouth_name = GetRecordString(dr, "mouth_name");
                        string lake_id = GetRecordString(dr, "lake_id");
                        bool? is_fish = GetRecordBit(dr, "isFish");
                        bool? is_well = GetRecordBit(dr, "isWell");
                        int? source_lat = (int?)GetRecordFloat(dr, "source_lat");
                        int? source_lon = (int?)GetRecordFloat(dr, "source_lon");
                        string source_country = GetRecordString(dr, "country");
                        string source_state = GetRecordString(dr, "state");
                        string guidloc = GetRecordString(dr, "guidloc");
                        bool? reviewed = GetRecordBit(dr, "reviewed");

                        if (String.Compare(description, guidloc) == 0 && m_IsTrial) // remove duplicate location in both columns for trial
                        {
                            description = String.Empty;
                        }
                        string link_well = (is_well == true) ? "<img src=\"../Images/monitor.png\"/>" : "";
                        string link_fish = (is_fish == true) ? "<img src=\"../Images/isfish.png\"/>" : "";

                        string numCell = String.Format("<td class=\"auto-{1}\">{0}</td>", num, "styleNum");

                        if (reviewed == true)
                        {
                            lake_name = "&ordm;" + lake_name;
                        }
                        string fullName = String.Format("<td class=\"auto-{1}\"><a href=\"wfRiverViewer.aspx?LakeId={2}\">{0}</a>"
                            , lake_name, "styleFullName", lake_id);

                        if (!String.IsNullOrEmpty(alt_name) && !m_IsTrial)
                        {
                            fullName += "<br>" + alt_name;
                        }
                        fullName += "</td>";
                        string sourceLatLon = String.Format("<td>{0}</td><td class=\"auto-{2}\">{1}</td>", source_lat, source_lon, "styleNum");
                        string sourceLocation = String.Format("<td>{0}</td><td class=\"auto-{2}\">{1}</td>", source_country, source_state, "styleNum");
                        string lake_guid = String.Format("<td class=\"auto-{1}\">{0}</td>", isGuid ? lake_id : guidloc, "styleGUID");
                        string fish_well = String.Format("<td>{0}</td><td class=\"auto-{2}\">{1}</td>", link_fish, link_well, "styleNum");
                        string backgroundRow = rowOdd ? "style=\"background-color:#E6FFFF\"" : "";

                        string line = "\t<tr " + backgroundRow + ">" + numCell + fullName + sourceLatLon + sourceLocation
                            + string.Format("<td>{0}</td><td>{1}</td><td>{2}</td>{3}{4}</tr>\n"
                            , description, source_name, mouth_name, lake_guid, fish_well);
                        records += line;
                        rowOdd = !rowOdd;
                    }
                }
                return records;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.BuildGrid");
            }
            return "";
        }
        protected void SetLikeList()
        {
            try
            {
                RadioButtonListAZ.Items.Clear();

                int type = Int32.Parse(HiddenRiverType.Value);
                string state = ddlState.SelectedValue;
                string country = HiddenCountry.Value;
                string starting = RadioButtonListAZ.SelectedValue;

                string sqlcmd = string.Format("SELECT DISTINCT symbol FROM dbo.fn_river_sym('{0}', '{1}', {2}, '$', {3}, {4} ) ORDER BY 1 ASC"
                                             , state, country, type, cbMonitor.Checked ? 1 : 0, cbFish.Checked ? 1 : 0);

                List<string> states = m_dbObject.GetListString(m_dbObject.m_connection, sqlcmd, "LoadStateList");
                bool isdigit = false;
                RadioButtonListAZ.ClearSelection();

                // load station data
                int index = 0;
                foreach ( var like in states)
                {
                    if( char.IsDigit(like[0]) )
                    {
                        isdigit = true;
                        continue;
                    }
                    var item = new System.Web.UI.WebControls.ListItem();
                    item.Text = like;
                    item.Value = like;
                    RadioButtonListAZ.Items.Add(item);

                    if (starting == like[0].ToString())
                    {
                        RadioButtonListAZ.SelectedIndex = index;
                    }
                    index++;
                }
                if(isdigit)
                {
                    RadioButtonListAZ.Items.Add("#");
                }
                RadioButtonListAZ.Items.Add("All");
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.SetLikeList");
            }
        }
        protected char GetSelectedFilter()
        {
            string val = RadioButtonListAZ.SelectedValue;

            if( String.IsNullOrEmpty(val))
            {
                return '$';
            }
            char starting  = ( (val == "All") ? '$' : val[0]);
            return starting;
        }
        private void Refresh(string fn_name ,bool isAdminMode)
        {
            string like = GetSelectedFilter().ToString();
            int type = Int32.Parse(HiddenRiverType.Value);
            string state = ddlState.SelectedValue;
            string country = HiddenCountry.Value;

            int npage = (int.TryParse(rblNavigator.SelectedValue, out npage) ? npage : GetCurrentPage());

            if(npage < -1)
            {
                npage = 0;
            }
            LoadGrid(state, country, type, like, npage, isAdminMode);
        }
        protected void RadioButtonListAZ_SelectedIndexChanged(object sender, EventArgs e)
        {
            hd_rscRiverList_Letter.Value = RadioButtonListAZ.SelectedValue;
            //hdCurrentPage.Value = "0";
            Refresh(WhatsMyName(), m_IsAdmin);
        }

        protected void cbMonitor_CheckedChanged(object sender, EventArgs e)
        {
            SetLikeList();
            Refresh(WhatsMyName(), m_IsAdmin);
        }

        protected void cbFish_CheckedChanged(object sender, EventArgs e)
        {
            SetLikeList();
            Refresh(WhatsMyName(), m_IsAdmin);
            hdIsFish.Value = cbFish.Checked == true ? "1" : "0";
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            HiddenCountry.Value = lbState.Text;
            SetLikeList();
            Refresh(WhatsMyName(), m_IsAdmin);
        }

        protected void rblNavigator_SelectedIndexChanged(object sender, EventArgs e)
        {
            Refresh(WhatsMyName(), false);
        }
        private bool InitizlizeNavigator(ref RadioButtonList nav, int nCurrentPage = -1, int nTotalrows = -1)
        {
            if (null == nav)
            {
                return false;
            }
            if (nCurrentPage < 0)
            {
                nCurrentPage = 0;
            }
            nav.Items.Clear();

            int iTotalPages = ((nTotalrows <= 25) ? 0 : (nTotalrows / 25));
            int iLast = iTotalPages;
            int iBack = (nCurrentPage > 0 ? nCurrentPage - 1 : nCurrentPage);
            int iNext = (nCurrentPage < iTotalPages) ? nCurrentPage + 1 : nCurrentPage;

            int? i1 = null; int? i2 = null; int? i3 = null;
            int? i7 = null; int? i8 = null; int? i9 = null;

            if (iTotalPages > 3 && iTotalPages < 30)
            {
                i1 = 1; i2 = 2; i3 = 3;
                i7 = iTotalPages - 3; i8 = iTotalPages - 2; i9 = iTotalPages - 1;
            }
            if (iTotalPages > 30 && iTotalPages < 100)
            {
                int round = (iTotalPages / 10) * 10;
                i1 = 10;    i2 = 20;    i3 = 30;
                i7 = round - 30; i8 = round - 20; i9 = round - 10;
            }
            if (iTotalPages > 300 && iTotalPages < 1000)
            {
                int round = (iTotalPages / 10) * 10;
                i1 = 100;   i2 = 200;   i3 = 300;
                i7 = round - 300; i8 = round - 200; i9 = round - 100;
            }
            LabelTotalPages.Text = String.Format("{0} ({1} - pages)", nCurrentPage, iTotalPages);
            var First = new ListItem("First", "0");
            var Back = new ListItem("Back", iBack.ToString());

            var item1 = i1 != null ? new ListItem(i1.ToString(), i1.ToString()) : null;
            var item2 = i2 != null ? new ListItem(i2.ToString(), i2.ToString()) : null;
            var item3 = i3 != null ? new ListItem(i3.ToString(), i3.ToString()) : null;

            var Current = new ListItem("Current", nCurrentPage.ToString());
            var Next = new ListItem("Next", iNext.ToString());
            var Last = new ListItem("Last", iLast.ToString());

            var item7 = i7 != null && i7 > i3 ? new ListItem(i7.ToString(), i7.ToString()) : null;
            var item8 = i8 != null && i8 > i3 ? new ListItem(i8.ToString(), i8.ToString()) : null;
            var item9 = i9 != null && i8 > i3 ? new ListItem(i9.ToString(), i9.ToString()) : null;

            nav.Items.Add(First);
            nav.Items.Add(Back);

            if (item1 != null){ nav.Items.Add(item1); } if (item2 != null){ nav.Items.Add(item2); } if (item3 != null){ nav.Items.Add(item3); }

            nav.Items.Add(Current);

            if (item7 != null) { nav.Items.Add(item7); } if (item8 != null) { nav.Items.Add(item8); } if (item9 != null) { nav.Items.Add(item9); }

            nav.Items.Add(Next);
            nav.Items.Add(Last);

            return true;
        }
    }
}