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
using System.Web.UI.HtmlControls;

#pragma warning disable IDE0028 
#pragma warning disable IDE0018

namespace FishTracker
{
    public partial class DbLayer : System.Web.UI.Page
    {
        static public int nPage = 25;           // number of rows per page

        public string m_connStr = "";
        protected string m_errors = "";
        public TPureDb m_dbObject = null;
        public static string s_connParameter = "xConnectionString";
        public Guid m_userGuid = Guid.Empty;
        public bool m_IsTrial = false;
        public float m_userLat = 43;
        public float m_userLon = -81;
        public string m_postal = "N2M5L4";
        public string m_ipAddress = "127.0.0.0";
        public bool m_IsAdmin = false;

        static public String[] CaStates = new String[] { "ON", "QC", "NS", "NB", "MB", "BC", "PE", "SK", "AB", "NL", "NT", "YT", "NU" };
        static public String[] USStates = new String[] { "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL"
        , "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM"
        , "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "DC"};

        static public String[] g_sShortCountry = new String[] { "CA", "US", "RU", "UK", "MX", "NO" };
        static public String[] g_sLongCountry = new String[] { "Canada", "USA", "Russia", "United Kingdom", "Mexica", "Norvey" };

        protected void Page_Init(object sender, EventArgs e)
        {
            try
            {
                var tr = Session["trial"];

                string trial = "";

                if (null != tr)
                {
                    trial = tr.ToString();
                }
                m_IsTrial = (trial == "1" || String.IsNullOrEmpty(trial)) ? true : false;
                m_IsAdmin = IsAdmin();
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "DbLayer>Page_Init");
            }
        }
        public bool IsAdmin()
        {
            try
            {
                if (HttpContext.Current.Session["user"] != null)
                {
                    m_userGuid = Guid.Parse(Session["user"].ToString());
                }
                return (Guid.Parse("bb30165a-fd1a-4b54-b921-9334242c9bf6") == m_userGuid);
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "DbLayer>IsAdmin");
            }
            return false;
        }
        ~DbLayer()
        {
        }
        public DbLayer()
        {
            try
            {
                if (!String.IsNullOrEmpty(s_connParameter))
                {
                    m_connStr = ConfigurationManager.ConnectionStrings[s_connParameter].ConnectionString;
                }
                if (!String.IsNullOrEmpty(m_connStr))
                {
                    m_dbObject = new TPureDb(DbEventLogger, m_connStr);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "DbLayer>DbLayer");
            }
        }
        public string DbEventLogger(Exception ex = null, string func_name = null, string message = null, int line = -1, bool isSilence = false)
        {
            string result = null;

            if (String.IsNullOrEmpty(func_name))
            {
                func_name = WhatsMyName();
            }
            if (line == -1 && ex != null)
            {
                var st = new StackTrace(ex, true); var frame = st.GetFrame(0); line = frame.GetFileLineNumber();
            }
            if (String.IsNullOrEmpty(message) && ex != null)
            {
                result = line + ":" + Tlog.ErrorFormat("[{0}] Exception: [{1}] ", func_name, ex.Message);
            }
            if (ex == null && !String.IsNullOrEmpty(message))
            {
                result = line + ":" + Tlog.ErrorFormat("[{0}] Exception: [{1}] ", func_name, message);
            }
            if (!String.IsNullOrEmpty(message) && ex != null)
            {
                result = line + ":" + Tlog.ErrorFormat("[{0}] Exception: [{1}] - {2}", func_name, ex.Message, message);
            }
            InsertDbMessage(m_connStr, ex.Message, func_name);

            ScriptManager.RegisterStartupScript(this, this.GetType(), WhatsMyName(), "alert('" + result + "');", true);
            Response.Write(result);

            return result;
        }
        public bool SaveDataIntervals(Guid instance_id, int type, TextBox min, TextBox low, TextBox avg, TextBox high, TextBox max, string callerName)
        {
            if (instance_id == Guid.Empty || type <= 0)
            {
                return false;
            }
            try
            {
                var prms = new List<Tuple<string, SqlDbType, dynamic>>();

                prms.Add(TValue.Create("min", SqlDbType.Float, min));
                if (low != null)
                {
                    prms.Add(TValue.Create("low", SqlDbType.Float, low));
                }
                if (avg != null)
                {
                    prms.Add(TValue.Create("avg", SqlDbType.Float, avg));
                }
                if (high != null)
                {
                    prms.Add(TValue.Create("high", SqlDbType.Float, high));
                }
                prms.Add(TValue.Create("max", SqlDbType.Float, max));
                prms.Add(TValue.Create("parent_id", SqlDbType.UniqueIdentifier, instance_id));
                prms.Add(TValue.Create("type", SqlDbType.TinyInt, type));

                m_dbObject.ExecSP(m_dbObject.m_connection, "sp_update_interval", prms, callerName);

                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, callerName);
            }
            return false;
        }
        public void InsertDbMessage(string connection_string, string message, string caller_name)
        {
            using (SqlConnection connection = new SqlConnection(connection_string))
            {
                connection.Open();

                m_dbObject.Insert(connection, "LogException", "msg, page_name,email"
                    , new SqlDbType[] { SqlDbType.NVarChar, SqlDbType.NVarChar, SqlDbType.NVarChar }
                    , new dynamic[] { message, caller_name, "tn@mail.ru" }, caller_name);
            }
        }
        public void InsertDbMessage(string message, string callername)
        {
            var types = new SqlDbType[] { SqlDbType.NVarChar, SqlDbType.NVarChar, SqlDbType.NVarChar, SqlDbType.DateTime2 };

            m_dbObject.Insert(m_dbObject.m_connection, "LogException", "msg,page_name, email,stamp"
                    , types, new dynamic[] { message, callername, "", DateTime.Now }, callername);
        }
        protected bool LoadCheckBoxListFromDb(string nameTable, CheckBoxList cbl, string callerName)
        {
            if (String.IsNullOrEmpty(nameTable) || cbl == null)
            {
                return false;
            }
            cbl.Items.Clear();
            string sqlCmd = String.Format("SELECT value, title FROM [{0}]", nameTable);
            var lst = m_dbObject.GetDicLS(m_dbObject.m_connection, sqlCmd, callerName);

            foreach (var item in lst)
            {
                cbl.Items.Add(new ListItem(item.Value, item.Key.ToString()));
            }
            return true;
        }
        protected bool? LoadFishName(string fishGuid, TextBox boxName, TextBox boxLatin)
        {
            if (String.IsNullOrEmpty(fishGuid))
            {
                return null;
            }
            string sqlCmd = "SELECT fish_id, fish_name, fish_latin from dbo.fish WHERE fish_id = @fish_id";
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = Guid.Parse(fishGuid);

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            boxName.Text = dr["fish_name"].ToString();
                            boxLatin.Text = dr["fish_latin"].ToString();

                            return true;
                        }
                    }
                }
                return false;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "DbLayer>LoadFishName");
            }
            return null;
        }
        protected bool? LoadFishImage(Guid fishGuid, int? imageId
                , TextBox boxLat, TextBox boxLon, TextBox boxTag, TextBox boxDate, CheckBox bGender
                , TextBox boxSrc, TextBox boxAuthor, TextBox boxLink, TextBox boxLabel, TextBox boxLoc)
        {
            if (fishGuid == Guid.Empty)
            {
                return null;
            }
            string sqlCmd = "SELECT * from dbo.fn_fish_image_info( @fish_id, @image_id )";
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlCmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@fish_id", SqlDbType.UniqueIdentifier).Value = fishGuid;

                    if (imageId == null)
                    {
                        cmd.Parameters.Add("@image_id", SqlDbType.Int).Value = DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@image_id", SqlDbType.Int).Value = (int)imageId;
                    }
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            boxLat.Text = dr["fish_image_lat"].ToString();
                            boxLon.Text = dr["fish_image_lon"].ToString();
                            boxTag.Text = dr["fish_image_tag"].ToString();

                            string date = dr["fish_image_stamp"].ToString();
                            boxDate.Text = Convert.ToDateTime(date).ToShortDateString();

                            bGender.Checked = ("1" == dr["fish_image_stamp"].ToString() ? true : false);
                            boxSrc.Text = dr["fish_image_source"].ToString();
                            boxAuthor.Text = dr["fish_image_author"].ToString();
                            boxLink.Text = dr["fish_image_link"].ToString();
                            boxLabel.Text = dr["fish_image_label"].ToString();
                            boxLoc.Text = dr["fish_image_location"].ToString();

                            return true;
                        }
                    }
                }
                return false;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "DbLayer>LoadFishImage");
            }
            return null;
        }

        protected bool SetInt(SqlCommand cmd, string param, TextBox control)
        {
            if (cmd == null || String.IsNullOrEmpty(param) || control == null)
            {
                return false;
            }
            int value = 0;

            if (Int32.TryParse(control.Text, out value))
            {
                cmd.Parameters.Add(param, SqlDbType.Int).Value = value;
            }
            else
            {
                cmd.Parameters.Add(param, SqlDbType.Int).Value = DBNull.Value;
            }
            return true;
        }
        protected bool SetFloat(SqlCommand cmd, string param, TextBox control)
        {
            if (cmd == null || String.IsNullOrEmpty(param) || control == null)
            {
                return false;
            }
            float value = 0;

            if (float.TryParse(control.Text, out value))
            {
                cmd.Parameters.Add(param, SqlDbType.Float).Value = value;
            }
            else
            {
                cmd.Parameters.Add(param, SqlDbType.Float).Value = DBNull.Value;
            }
            return true;
        }
        protected bool SetGuid(SqlCommand cmd, string param, TextBox control)
        {
            if (cmd == null || String.IsNullOrEmpty(param) || control == null)
            {
                return false;
            }
            Guid value = Guid.Empty;

            if (Guid.TryParse(control.Text, out value))
            {
                cmd.Parameters.Add(param, SqlDbType.UniqueIdentifier).Value = value;
            }
            else
            {
                cmd.Parameters.Add(param, SqlDbType.UniqueIdentifier).Value = DBNull.Value;
            }
            return true;
        }
        protected bool MaskToCheckList(CheckBoxList lst, int? value)
        {
            if (null == lst || value == null)
            {
                return false;
            }
            try
            {





                int iter = 0;
                int mask = 1;

                foreach (ListItem item in lst.Items)
                {
                    lst.Items[iter].Selected = ((value & mask) == mask);
                    mask = mask << 1;
                    iter++;
                }
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        protected ulong CheckListToMask(CheckBoxList lst)
        {
            ulong type = 0;
            string value = "";
            try
            {
                foreach (ListItem item in lst.Items)
                {
                    if (item.Selected)
                    {
                        value = (string)item.Value.ToString().Trim().Clone();

                        if (UInt64.TryParse(value, out UInt64 val))
                        {
                            type = type | val;
                        }
                    }
                }
                return type;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
            return 0;
        }
        protected void Record2CheckBoxList(SqlDataReader dr, string param, CheckBoxList lst)
        {
            if (dr == null || String.IsNullOrEmpty(param) || null == lst)
            {
                return;
            }
            try
            {
                string str = dr[param].ToString();

                if (!String.IsNullOrEmpty(str))
                {
                    int value = Convert.ToInt32(str);

                    MaskToCheckList(lst, value);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected void SetList(SqlDataReader dr, string param, CheckBoxList lst)
        {
            if (dr == null || String.IsNullOrEmpty(param) || null == lst)
            {
                return;
            }
            try
            {
                string str = dr[param].ToString();

                if (!String.IsNullOrEmpty(str))
                {
                    int value = Convert.ToInt32(str);
                    int iter = 0;
                    int mask = 1;

                    foreach (ListItem item in lst.Items)
                    {
                        lst.Items[iter].Selected = ((value & mask) == mask);
                        mask = mask << 1;
                        iter++;
                    }
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "DbLayer>SetList");
            }
        }
        protected void ReadSingle(SqlDataReader dr, string param, TextBox box)
        {
            try
            {
                string slen = dr[param].ToString();

                if (!String.IsNullOrEmpty(slen))
                {
                    box.Text = Convert.ToSingle(slen).ToString();
                }
            }
            catch(Exception ex) 
            {
                DbEventLogger(ex, "ReadSingle>" + param);
            }
        }

        protected string ReadString(SqlDataReader dr, string param)
        {
            if (String.IsNullOrEmpty(param) || !dr.HasColumn(param) )
            {
                return null;
            }
            try
            {
                if ( dr[param] != DBNull.Value)
                {
                    return dr[param].ToString();
                }
            }
            catch { }
            return null;
        }
        protected void ReadString(SqlDataReader dr, string param, System.Web.UI.HtmlControls.HtmlInputHidden box)
        {
            try
            {
                if ( !String.IsNullOrEmpty(param) && dr[param] != DBNull.Value )
                {
                    box.Value = dr[param].ToString();
                }
            }
            catch { }
        }
        protected bool? ReadBit(SqlDataReader dr, string param)
        {
            try
            {
                string value = dr[param].ToString();

                if (!String.IsNullOrEmpty(value))
                {
                    return (bool ?)( value.ToUpper() == "TRUE" );
                }
            }
            catch { }
            return null;
        }
        protected int? ReadInt(SqlDataReader dr, string param)
        {
            if( dr == null || String.IsNullOrEmpty(param))
            {
                return null;
            }
            try
            {
                string slen = dr[param].ToString();

                int result = 0;

                if (Int32.TryParse(slen, out result))
                {
                    return (int?)result;
                }
            }
            catch { }
            return null;
        }
        protected void ReadDate(SqlDataReader dr, string param, Label lbl)
        {
            try
            {
                string slen = dr[param].ToString();

                if (!String.IsNullOrEmpty(slen))
                {
                    lbl.Text = slen;
                }
            }
            catch { }
        }
        protected int GetComboType(DropDownList lst)
        {
            int type = 0;
            foreach (ListItem item in lst.Items)
                if (item.Selected)
                    type = type | Convert.ToInt32(item.Value);
            return type;
        }
        protected void ReadCombo(SqlDataReader dr, string param, DropDownList combo)
        {
            if (dr == null || String.IsNullOrEmpty(param) || null == combo)
            {
                return;
            }
            try
            {
                string slen = dr[param].ToString();

                if (!String.IsNullOrEmpty(slen))
                {
                    foreach (ListItem iter in combo.Items)
                    {
                        if (slen == iter.Value)
                        {
                            combo.SelectedIndex = combo.Items.IndexOf(iter);
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "DbLayer>ReadCombo");
            }
        }
        public void SetValueToCombo(int value, DropDownList combo)
        {
            if( null == combo || value < 0)
            {
                return;
            }
            try
            {
                foreach (ListItem iter in combo.Items)
                {
                    if (value.ToString() == iter.Value)
                    {
                        combo.SelectedIndex = combo.Items.IndexOf(iter);
                    }
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, WhatsMyName());
            }
        }
        protected void AddListParameter(SqlCommand cmd, String param, CheckBoxList lst)
        {
            cmd.Parameters.Add(param, SqlDbType.Int).Value = CheckListToMask(lst);
        }
        protected void AddListParameter(SqlCommand cmd, String param, DropDownList lst)
        {
            int type = 0;
            foreach (ListItem item in lst.Items)
                if (item.Selected)
                    type = type | Convert.ToInt32(item.Value);

            cmd.Parameters.Add(param, SqlDbType.Int).Value = type;
        }
        protected void AddFloatParameter(SqlCommand cmd, String param, TextBox txt)
        {
            string txtval = txt.Text.Trim();
            Single value = 0;

            if (!String.IsNullOrEmpty(txtval) && Single.TryParse(txtval, out value))
            {
                cmd.Parameters.Add(param, SqlDbType.Float).Value = value;
                return;
            }
            cmd.Parameters.Add(param, SqlDbType.Float).Value = DBNull.Value;
        }
        protected void AddIntParameter(SqlCommand cmd, String param, TextBox txt)
        {
            string txtval = txt.Text.Trim();
            int value = 0;

            if(  !String.IsNullOrEmpty(txtval) && Int32.TryParse(txtval, out value) )
            {
                cmd.Parameters.Add(param, SqlDbType.Int).Value = value;
                return;
            }
            cmd.Parameters.Add(param, SqlDbType.Float).Value = DBNull.Value;
        }
        protected void LoadStateList(DropDownList stateList, string country)
        {
            try
            {
                if(m_dbObject.m_connection.State == ConnectionState.Closed )
                {
                    m_dbObject.m_connection.Open();
                }
                stateList.Items.Clear();
                // load station data
                using (SqlCommand cmd = new SqlCommand("SELECT Value FROM dbo.fn_resource_state ( @country )", m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@country", SqlDbType.Char, 2).Value = country;
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        stateList.Items.Add(dr["Value"].ToString());
                    };
                }
                m_dbObject.m_connection.Close();
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "DbLayer>LoadStateList");
            }
        }
        public string GetRecordString(SqlDataReader dr, string colName)
        {
            if(dr == null || dr.IsClosed || String.IsNullOrEmpty(colName) )
            {
                return null;
            }
            if( !dr.HasColumn(colName) )
            {
                return null;
            }
            try
            {
                return dr[colName].ToString().Trim();
            }
            catch (Exception ex) 
            {
                string msg = ex.Message;
            }
            return null;
        }
        public int? GetRecordInt(SqlDataReader dr, string arg)
        {
            if (dr == null || dr.IsClosed || String.IsNullOrEmpty(arg))
            {
                return null;
            }
            try
            {
                string result =  dr[arg].ToString();

                if( String.IsNullOrEmpty(result))
                {
                    return null;
                }

                return Int32.Parse(result);
            }
            catch (Exception) { }
            return null;
        }
        public bool? GetRecordBit(SqlDataReader dr, string arg)
        {
            if (dr == null || dr.IsClosed || String.IsNullOrEmpty(arg))
            {
                return null;
            }
            try
            {
                string result = dr[arg].ToString();

                return (result == "True" ? true : false);
            }
            catch (Exception) { }
            return null;
        }
        public string GetRecordLatLon(SqlDataReader dr, string arg)
        {
            if (dr == null || dr.IsClosed || String.IsNullOrEmpty(arg))
            {
                return null;
            }
            try
            {
                string result = dr[arg].ToString();

                if( String.IsNullOrEmpty(result))
                {
                    return "";
                }
                return String.Format("{0:00.0}", Double.Parse(result));
            }
            catch (Exception) { }
            return null;
        }
        public double? GetRecordFloat(SqlDataReader dr, string arg)
        {
            if (dr == null || dr.IsClosed || String.IsNullOrEmpty(arg))
            {
                return null;
            }
            try
            {
                string result = dr[arg].ToString();

                return Double.Parse(result);
            }
            catch (Exception) { }
            return null;
        }
        public Guid? GetRecordGuid(SqlDataReader dr, string arg)
        {
            if (dr == null || dr.IsClosed || String.IsNullOrEmpty(arg))
            {
                return null;
            }
            try
            {
                string result = dr[arg].ToString();

                if( String.IsNullOrEmpty(result))
                {
                    return null;
                }

                return Guid.Parse(result);
            }
            catch (Exception) { }
            return null;
        }
        public DateTime? GetRecordDate(SqlDataReader dr, string arg)
        {
            if (dr == null || dr.IsClosed || String.IsNullOrEmpty(arg))
            {
                return null;
            }
            try
            {
                string result = dr[arg].ToString();

                return DateTime.Parse(result);
            }
            catch (Exception) { }
            return null;
        }
        /// <summary>
        /// provide html data having link and value
        /// used to display source or author
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="prefix"></param>
        /// <param name="link"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        protected bool Setlink(ref HtmlInputHidden obj, string prefix, string link, string value)
        {
            obj.Visible = false;

            if (obj == null)
            {
                return false;
            }
            obj.Visible = !String.IsNullOrEmpty(value);

            if (obj.Visible)
            {
                if (String.IsNullOrEmpty(link))
                {
                    obj.Value = value;
                }
                else
                {
                    obj.Value = String.Format("<a href=\"{0}\">{1}</a>", link, value);
                }
                obj.Value = prefix + " " + obj.Value;
            }
            return true;
        }

        protected bool LoadTopNews(SqlDataReader datareader, HtmlInputHidden date, HtmlInputHidden title
            , out string alink, out string author
            , HyperLink asource, out string source_name, out string credit, HtmlInputHidden text1
            , HtmlInputHidden text2, Image img, HtmlInputHidden flag
            , HyperLink linkLake, HyperLink[] fishes)
        {
            alink = string.Empty;
            author = string.Empty;
            source_name = string.Empty;
            credit = string.Empty;
            img.Visible = false;
            try
            {
                if (datareader.Read())
                {
                    string newsGuid = datareader["news_id"].ToString();
                    Guid topNewsId = Guid.Parse(newsGuid);
                    date.Value = ((DateTime)datareader["news_stamp"]).ToShortDateString();
                    string sflag = ReadString(datareader, "country");

                    flag.Value = String.IsNullOrEmpty(sflag) ? "empty.gif" : sflag + ".png";

                    ReadString(datareader, "news_title", title);
                    alink = ReadString(datareader, "news_author_link");
                    author = ReadString(datareader, "news_author" );
                    asource.NavigateUrl = ReadString(datareader, "news_source_link");
                    source_name = ReadString(datareader, "news_source");
                    credit = ReadString(datareader, "news_photo_author0");
                    string altpic = ReadString(datareader, "news_photo_alt0");
                    Guid? lakelink = GetRecordGuid(datareader, "lake_id");

                    if (lakelink != null)
                    {
                        linkLake.NavigateUrl = "Resources/wfRiverViewer.aspx?LakeId=" + (Guid)lakelink;
                        linkLake.Visible = true;
                        linkLake.Text = ReadString(datareader, "lake_name");
                    }
                    int index = 1;
                    foreach( var fish in fishes)
                    {
                        fish.Text = ReadString(datareader, String.Format("fish{0}_name", index));

                        fish.Visible = !String.IsNullOrEmpty(fish.Text);
                        fish.NavigateUrl = String.Format("https://en.wikipedia.org/wiki/{0}", fish.Text);

                        index++;
                    }
                    string paragraph0 = ReadString(datareader, "news_paragraph0");

                    if (!String.IsNullOrEmpty(paragraph0))
                    {
                        text1.Value = paragraph0.Replace("\n", "<br>");
                    }
                    string paragraph1 = ReadString(datareader, "news_paragraph1");

                    if (!String.IsNullOrEmpty(paragraph1))
                    {
                        text2.Value = paragraph1.Replace("\n", "<br>");
                    }
                    if (datareader["news_photo0"] != DBNull.Value)
                    {
                        img.Visible = false;
                        var bytes = (byte[])datareader["news_photo0"];

                        if (bytes != null && bytes.Length > 100)
                        {
                            string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                            img.ImageUrl = "data:image/png;base64," + base64String;
                            img.Width = 220;
                            img.Visible = true;
                            img.AlternateText = altpic;
                        }
                    }
                    date.Visible = true;
                    title.Visible = true;
                    asource.Visible = true;
                    text1.Visible = true;
                    text2.Visible = true;

                    return true;
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "DbLayer>LoadTopNews");
            }
            return false;
        }
        static public bool InitizlizeNavigator(string sPageName, int currPage, string traits, HashSet<HyperLink> controls)
        {
            if (String.IsNullOrEmpty(sPageName) || null == controls )
            {
                return false;
            }
            var lib = new Dictionary<string, HyperLink>();

            foreach( var item in controls)
            {
                lib[item.ID] = item;
            }
            if (lib.ContainsKey("hlFirstPage"))
            {
                lib["hlFirstPage"].Text = "&#9664;";
            }
            if (lib.ContainsKey("hlLeft"))
            {
                lib["hlLeft"].Text = "&larr;";
            }
            if (lib.ContainsKey("hlRight"))
            {
                lib["hlRight"].Text = "&rarr;";
            }
            if (lib.ContainsKey("hlCurrentPage"))
            {
                lib["hlCurrentPage"].Text = "&spades;";
            }
            if (currPage > 0)
            {
                traits = RemoveOffset( traits );

                if (lib.ContainsKey("hlFirstPage"))
                {
                    lib["hlFirstPage"].NavigateUrl = String.Format("{0}?Offset=0&{1}", sPageName, traits);
                }
                if (lib.ContainsKey("hlLeft"))
                {
                    traits = String.IsNullOrEmpty(traits) ? "" : "&" + traits;

                    lib["hlLeft"].NavigateUrl = String.Format("{0}?Offset={1}&{2}", sPageName, currPage - 1, traits);
                }
            }
            return HideDotNavigator(controls);
        }
        static public bool HideDotNavigator(HashSet<HyperLink> controls)
        {
            var arr = new HashSet<string>() { "hlLeft1", "hlLeft2", "hlLeft3", "hlRight1", "hlRight2", "hlRight3" };

            foreach( var item in controls)
            {
                if( arr.Contains(item.ID) )
                {
                    item.NavigateUrl = "";
                    item.Visible = false;
                    item.Text = ".";
                }
            }
            return true;
        }
        static string RemoveOffset(string traits)
        {
            if( String.IsNullOrEmpty(traits))
            {
                return null;
            }
            // remove Offset parameter
            string[] lstOpt = traits.Split('&');
            var TraitList = new List<string>();

            foreach (string opt in lstOpt)
            {
                if (opt.Contains('='))
                {
                    string name = opt.Substring(0, opt.IndexOf('='));
                    if (name == "Offset")
                    {
                        continue;
                    }
                }
                TraitList.Add(opt);
            }
            return string.Join("&", TraitList);
        }
        static public bool SetDotNavigator(string sPageName, string controlName, int nPage, int countPages, string traits, Dictionary<string, HyperLink> controls)
        {
            if (nPage  >= 0 && nPage <= countPages && null != controls && controls.ContainsKey(controlName) )
            {
                HyperLink control = controls[controlName];
                control.NavigateUrl = String.Format("{0}?Offset={1}&{2}", sPageName, nPage, traits);
                control.Visible = true;
                control.Text = nPage.ToString();

                return true;
            }
            return false;
        }
        /// <summary>
        /// Update navigator control when number of rows is known
        /// </summary>
        /// <param name="sPageName"></param>    // name pf aspx page where control located
        /// <param name="currPage"></param>     // current started row
        /// <param name="countRows"></param>    // number of rows in result
        /// <param name="traits"></param>       // additional items on page (id=100)
        /// <param name="controls"></param>     // list of controls for navigator
        /// <returns></returns>
        static public bool UpdateNavigator(string sPageName, int currPage, int countRows, string traits, HashSet<HyperLink> controls )
        {
            if (String.IsNullOrEmpty(sPageName) || null == controls || countRows <= 0 )
            { 
                return false;
            }
            var lib = new Dictionary<string, HyperLink>();

            foreach (var item in controls)
            {
                lib[item.ID] = item;
            }
            int nLastPage = countRows / nPage;

            if (lib.ContainsKey("hlNPages") && nLastPage > 0)
            {
                lib["hlNPages"].Text = "  " + currPage + " of [" + nLastPage + " - pages.]";
            }
            traits = RemoveOffset(traits);

            if (nLastPage < 10 && nLastPage > 3)
            {
                SetDotNavigator(sPageName, "hlLeft1", 1, nLastPage, traits, lib);
                SetDotNavigator(sPageName, "hlLeft2", 2, nLastPage, traits, lib);
                SetDotNavigator(sPageName, "hlLeft3", 3, nLastPage, traits, lib);

            }else
            if (nLastPage < 100 && nLastPage > 10)
            {
                SetDotNavigator(sPageName, "hlLeft1", 10, nLastPage, traits, lib);
                SetDotNavigator(sPageName, "hlLeft2", 20, nLastPage, traits, lib);
                SetDotNavigator(sPageName, "hlLeft3", 30, nLastPage, traits, lib);

            }
            else
            if ( nLastPage > 300)
            {
                SetDotNavigator(sPageName, "hlLeft1", 100, nLastPage, traits, lib);
                SetDotNavigator(sPageName, "hlLeft2", 200, nLastPage, traits, lib);
                SetDotNavigator(sPageName, "hlLeft3", 300, nLastPage, traits, lib);
            }
            if (nLastPage > 3)
            {
                if (nLastPage - 3 > 1)
                {
                    SetDotNavigator(sPageName, "hlRight3", nLastPage - 1, nLastPage, traits, lib);
                }
                if (nLastPage - 3 > 2)
                {
                    SetDotNavigator(sPageName, "hlRight2", nLastPage - 2, nLastPage, traits, lib);
                }
                if (nLastPage - 3 > 3)
                {
                    SetDotNavigator(sPageName, "hlRight1", nLastPage - 3, nLastPage, traits, lib);
                }
            }
            if (currPage < nLastPage )
            {
                if (lib.ContainsKey("hlLastPage"))
                {
                    lib["hlLastPage"].NavigateUrl = String.Format("{0}?Offset={1}&{2}", sPageName, nLastPage, traits);
                }
                if (lib.ContainsKey("hlRight"))
                {
                    lib["hlRight"].NavigateUrl = String.Format("{0}?Offset={1}&{2}", sPageName, currPage + 1, traits);
                }
            }
            return true;
        }
        public Guid? GetArgGuid(string name_argument, string fieldName, string tableName, string orderBy)
        {
            if (String.IsNullOrEmpty(name_argument))
            {
                return null;
            }
            string argument = Request.QueryString[name_argument];

            if (String.IsNullOrEmpty(argument))
            {
                if (!System.Diagnostics.Debugger.IsAttached)
                {
                    return null;
                }
                string sqlcmd = String.Format("SELECT TOP 1 CAST({0} AS varchar(36)) FROM {1} ORDER BY {2} DESC", fieldName, tableName, orderBy);
                argument = m_dbObject.GetSingleString(sqlcmd, null, null, "GetArgGuid\\" + name_argument);
            }
            if (!Guid.TryParse((String)argument, out Guid arg_id))
            {
                return null;
            }
            return arg_id;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static string WhatsMyName()
        {
            var st = new StackTrace(new StackFrame(1));
            return st.GetFrame(0).GetMethod().Name;
        }
    }
    public static class DataRecordExtensions
    {
        public static bool HasColumn(this IDataRecord dr, string columnName)
        {
            for (int i = 0; i < dr.FieldCount; i++)
            {
                if (dr.GetName(i).Equals(columnName, StringComparison.InvariantCultureIgnoreCase))
                    return true;
            }
            return false;
        }
    }
}
