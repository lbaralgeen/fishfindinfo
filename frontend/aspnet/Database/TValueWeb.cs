using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

#pragma warning disable 1591

namespace TDbInterface
{
    public partial class TValue
    {
        static public Tuple<string, SqlDbType, dynamic> Create(string l_name, SqlDbType l_type, TextBox txt)
        {
            if (String.IsNullOrEmpty(txt.Text))
            {
                return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, DBNull.Value);
            }
            if (l_type == SqlDbType.Float)
            {
                float flv = 0;

                if (float.TryParse(txt.Text, out flv))
                {
                    return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, flv);
                }
            }
            else if (l_type == SqlDbType.Int)
            {
                int value = 0;

                if (Int32.TryParse(txt.Text, out value))
                {
                    return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, value);
                }
            }
            else if (l_type == SqlDbType.UniqueIdentifier)
            {
                Guid value = Guid.Empty;

                if (Guid.TryParse(txt.Text, out value))
                {
                    return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, value);
                }
            }
            else if (l_type == SqlDbType.VarChar || l_type == SqlDbType.NVarChar || l_type == SqlDbType.Char || l_type == SqlDbType.NChar)
            {
                return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, txt.Text);
            }
            return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, DBNull.Value);
        }
        static public Tuple<string, SqlDbType, dynamic> Create(string l_name, CheckBox control)
        {
            return Tuple.Create<string, SqlDbType, dynamic>(l_name, SqlDbType.Bit, (control != null && control.Checked ? 1 : 0));
        }
        static public Tuple<string, SqlDbType, dynamic> Create(string l_name, CheckBoxList control)
        {
            int value = 0;
            if (control != null)
            {
                foreach (ListItem item in control.Items)
                {
                    if (item.Selected)
                    {
                        value = value | Convert.ToInt32(item.Value);
                    }
                }
            }
            return Tuple.Create<string, SqlDbType, dynamic>(l_name, SqlDbType.Int, value);
        }
    }
}