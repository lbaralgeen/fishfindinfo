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
    public partial class FishUI : System.Web.UI.Page
    {
        protected string m_connStr = "";
        protected string m_fishGuid = "";
        protected string m_userGuid = "";
        protected string m_errors = "";
        protected string m_lakeGuid = "";
        protected string m_logger = "";

        protected string LoadConnection(string callerName)
        {
            if( String.IsNullOrEmpty(callerName))
            {
                callerName = WhatsMyName();
            }
            try
            {
                m_connStr = ConfigurationManager.ConnectionStrings["fishConnectionString"].ConnectionString;

                if (String.IsNullOrEmpty(m_connStr))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Cannot get connection string", "alert('["+ callerName + "]');", true);
                    return null;
                }
                return m_connStr;
            }
            catch (Exception ex)
            {
                string mess = String.Format("[{0}] Exception: {1}", callerName, ex.Message);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('" + mess + "');", true);
                Response.Write(mess);
            }
            return null;
        }

        protected void SetList(SqlDataReader dr, string param, CheckBoxList lst, string callerName)
        {
            if (dr == null || String.IsNullOrEmpty(param) || null == lst)
            {
                return;
            }
            if (String.IsNullOrEmpty(callerName))
            {
                callerName = WhatsMyName();
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
                string mess = String.Format("[{0}] Exception: {1}", WhatsMyName(), ex.Message);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('" + mess + "');", true);
                Response.Write(mess);
            }
        }
        public void ReadSingle(SqlDataReader dr, string param, TextBox box, string callerName)
        {
            if (String.IsNullOrEmpty(callerName))
            {
                callerName = WhatsMyName();
            }

            string slen = dr[param].ToString();

            if (!String.IsNullOrEmpty(slen))
            {
                box.Text = Convert.ToSingle(slen).ToString();
            }
        }
        public static bool ReadBit(SqlDataReader dr, string param, string callerName)
        {
            if (String.IsNullOrEmpty(callerName))
            {
                callerName = WhatsMyName();
            }

            string slen = dr[param].ToString();

            if (!String.IsNullOrEmpty(slen))
            {
                return ((slen == "True") ? true : false);
            }
            return false;
        }
        public int ReadInt(SqlDataReader dr, string param, string callerName)
        {
            if (String.IsNullOrEmpty(callerName))
            {
                callerName = WhatsMyName();
            }
            string slen = dr[param].ToString();

            if (!String.IsNullOrEmpty(slen))
            {
                return Int32.Parse(slen);
            }
            return -1;
        }
        public static void ReadDate(SqlDataReader dr, string param, Label lbl, string callerName)
        {
            if (String.IsNullOrEmpty(callerName))
            {
                callerName = WhatsMyName();
            }
            string slen = dr[param].ToString();

            if (!String.IsNullOrEmpty(slen))
            {
                lbl.Text = slen;
            }
        }
        protected void ReadCombo(SqlDataReader dr, string param, DropDownList combo, string callerName)
        {
            if (dr == null || String.IsNullOrEmpty(param) || null == combo)
            {
                return;
            }
            if (String.IsNullOrEmpty(callerName))
            {
                callerName = WhatsMyName();
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
                string mess = String.Format("[{0}] Exception: {1}", WhatsMyName(), ex.Message);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('" + mess + "');", true);
                Response.Write(mess);
            }
        }
        protected void AddListParameter(SqlCommand cmd, String param, CheckBoxList lst, string callerName)
        {
            if (String.IsNullOrEmpty(callerName))
            {
                callerName = WhatsMyName();
            }
            int type = 0;
            foreach (ListItem item in lst.Items)
                if (item.Selected)
                    type = type | Convert.ToInt32(item.Value);

            cmd.Parameters.Add(param, SqlDbType.Int).Value = type;
        }
        protected void AddFloatParameter(SqlCommand cmd, String param, TextBox txt, string callerName)
        {
            if (String.IsNullOrEmpty(callerName))
            {
                callerName = WhatsMyName();
            }
            string txtval = txt.Text.Trim();

            if (!String.IsNullOrEmpty(txtval))
            {
                cmd.Parameters.Add(param, SqlDbType.Float).Value = Convert.ToSingle(txtval);
            }
            else
            {
                cmd.Parameters.Add(param, SqlDbType.Float).Value = DBNull.Value;
            }
        }
        [MethodImpl(MethodImplOptions.NoInlining)]
        private static string WhatsMyName()
        {
            var st = new StackTrace(new StackFrame(1));
            return st.GetFrame(0).GetMethod().Name;
        }
    }
}
