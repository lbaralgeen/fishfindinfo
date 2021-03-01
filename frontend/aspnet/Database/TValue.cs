using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

#pragma warning disable 1591

namespace TDbInterface
{
    public class TValue
    {
        public string name;
        public SqlDbType type;
        public dynamic value;

        public TValue(string l_name, SqlDbType l_type, dynamic l_value)
        {
            name = l_name;
            type = l_type;
            value = l_value;
        }
        static public Tuple<string, SqlDbType, dynamic> Create(string l_name, SqlDbType l_type, dynamic l_value)
        {
            return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, l_value);
        }
        static public Tuple<SqlDbType, dynamic> Create(SqlDbType l_type, dynamic l_value)
        {
            return Tuple.Create<SqlDbType, dynamic>(l_type, l_value);
        }
        public List<Tuple<string, SqlDbType, dynamic>> GetList()
        {
            var result = new List<Tuple<string, SqlDbType, dynamic>>();
            var val = Tuple.Create<string, SqlDbType, dynamic>(name, type, value);
            result.Add(val);

            return result;
        }
        static public Tuple<string, SqlDbType, dynamic> Create(string l_name, SqlDbType l_type, CheckBox box)
        {
            if(box == null)
            {
                return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, DBNull.Value);
            }
            return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, (box.Checked ? 1 : 0));
        }
        static public Tuple<string, SqlDbType, dynamic> Create(string l_name, SqlDbType l_type, TextBox txt)
        {
            if (String.IsNullOrEmpty(txt.Text))
            {
                return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, DBNull.Value);
            }
            string textValue = txt.Text.Trim();

            if (l_type == SqlDbType.Float)
            {
                float flv = 0;

                if (float.TryParse(textValue, out flv))
                {
                    return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, flv);
                }
            }
            else if (l_type == SqlDbType.Int)
            {
                int value = 0;

                if (Int32.TryParse(textValue, out value))
                {
                    return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, value);
                }
            }
            else if (l_type == SqlDbType.UniqueIdentifier)
            {
                Guid value = Guid.Empty;

                if (Guid.TryParse(textValue, out value))
                {
                    return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, value);
                }
            }
            else if (l_type == SqlDbType.VarChar || l_type == SqlDbType.NVarChar || l_type == SqlDbType.Char || l_type == SqlDbType.NChar)
            {
                return Tuple.Create<string, SqlDbType, dynamic>(l_name, l_type, textValue);
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
};