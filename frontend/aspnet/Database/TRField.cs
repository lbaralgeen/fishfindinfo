using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;

#pragma warning disable 1591

namespace TDbInterface
{
    public class TRField
    {
        public enum data_type
        {
            dt_none, dt_int, dt_char, dt_smallint, dt_tinyint, dt_nchar, dt_varchar, dt_nvarchar
                              , dt_numeric, dt_real, dt_system, dt_bit, dt_text, dt_ntext, dt_bigint, dt_image
                              , dt_binary, dt_varbinary, dt_date, dt_time, dt_datetime, dt_datetime2, dt_smalldatetime, dt_money
                              , dt_timestamp, dt_uniqueidentifier, dt_xml, dt_hierarchyid, dt_geography, dt_geometry, dt_variant
        };
        IEnumerable<int> data_type_values = Enum.GetValues(typeof(data_type))
                                      .OfType<data_type>()
                                      .Select(s => (int)s);

        public TRField(String name)
        {
            m_Name = name;
            m_IsIdentity = false;
            m_Type = data_type.dt_none;
            m_IsNull = true;
            m_Length = 0;
        }
        public void SetType(string value)
        {
            if (String.IsNullOrEmpty(value))
            {
                return;
            }
            if (value.Equals("int"))
            {
                m_Type = data_type.dt_int;
                m_SqlDbType = SqlDbType.Int;
            }
            else if (value.Equals("bigint"))
            {
                m_Type = data_type.dt_bigint;
                m_SqlDbType = SqlDbType.BigInt;
            }
            else if (value.Equals("smallint"))
            {
                m_Type = data_type.dt_smallint;
                m_SqlDbType = SqlDbType.SmallInt;
            }
            else if (value.Equals("geography"))
            {
                m_Type = data_type.dt_geography;
            }
            else if (value.Equals("geometry"))
            {
                m_Type = data_type.dt_geometry;
            }
            else if (value.Equals("tinyint"))
            {
                m_Type = data_type.dt_tinyint;
                m_SqlDbType = SqlDbType.TinyInt;
            }
            else if (value.Equals("char"))
            {
                m_Type = data_type.dt_char;
                m_SqlDbType = SqlDbType.Char;
            }
            else if (value.Equals("nchar"))
            {
                m_Type = data_type.dt_nchar;
                m_SqlDbType = SqlDbType.NChar;
            }
            else if (value.Equals("varchar"))
            {
                m_Type = data_type.dt_varchar;
                m_SqlDbType = SqlDbType.VarChar;
            }
            else if (value.Equals("nvarchar"))
            {
                m_Type = data_type.dt_nvarchar;
                m_SqlDbType = SqlDbType.NVarChar;
            }
            else if (value.Equals("real") || value.Equals("float"))
            {
                m_Type = data_type.dt_real;
                m_SqlDbType = SqlDbType.Real;
            }
            else if (value.Equals("numeric"))
            {
                m_Type = data_type.dt_numeric;
                m_SqlDbType = SqlDbType.Decimal;
            }
            else if (value.Equals("system"))
            {
                m_Type = data_type.dt_system;
                m_SqlDbType = SqlDbType.NVarChar;
            }
            else if (value.Equals("bit"))
            {
                m_Type = data_type.dt_bit;
                m_SqlDbType = SqlDbType.Bit;
            }
            else if (value.Equals("image"))
            {
                m_Type = data_type.dt_image;
                m_SqlDbType = SqlDbType.Image;
            }
            else if (value.Equals("text"))
            {
                m_Type = data_type.dt_text;
                m_SqlDbType = SqlDbType.Text;
            }
            else if (value.Equals("ntext"))
            {
                m_Type = data_type.dt_ntext;
                m_SqlDbType = SqlDbType.NText;
            }
            else if (value.Equals("binary"))
            {
                m_Type = data_type.dt_binary;
                m_SqlDbType = SqlDbType.Binary;
            }
            else if (value.Equals("varbinary"))
            {
                m_Type = data_type.dt_varbinary;
                m_SqlDbType = SqlDbType.VarBinary;
            }
            else if (value.Equals("variant"))
            {
                m_Type = data_type.dt_variant;
                m_SqlDbType = SqlDbType.Variant;
            }
            else if (value.Equals("date"))
            {
                m_Type = data_type.dt_date;
                m_SqlDbType = SqlDbType.Date;
            }
            else if (value.Equals("time"))
            {
                m_Type = data_type.dt_time;
                m_SqlDbType = SqlDbType.Time;
            }
            else if (value.Equals("datetime"))
            {
                m_Type = data_type.dt_datetime;
                m_SqlDbType = SqlDbType.DateTime;
            }
            else if (value.Equals("smalldatetime"))
            {
                m_Type = data_type.dt_smalldatetime;
                m_SqlDbType = SqlDbType.SmallDateTime;
            }
            else if (value.Equals("datetime2"))
            {
                m_Type = data_type.dt_datetime2;
                m_SqlDbType = SqlDbType.DateTime2;
            }
            else if (value.Equals("money"))
            {
                m_Type = data_type.dt_money;
                m_SqlDbType = SqlDbType.Money;
            }
            else if (value.Equals("timestamp"))
            {
                m_Type = data_type.dt_timestamp;
                m_SqlDbType = SqlDbType.Timestamp;
            }
            else if (value.Equals("uniqueidentifier"))
            {
                m_Type = data_type.dt_uniqueidentifier;
                m_SqlDbType = SqlDbType.UniqueIdentifier;
            }
            else if (value.Equals("xml"))
            {
                m_Type = data_type.dt_xml;
                m_SqlDbType = SqlDbType.Xml;
            }
            else if (value.Equals("hierarchyid"))
            {
                m_Type = data_type.dt_hierarchyid;
            }
        }
        public string m_DefaultValue;
        public string m_Name;
        public int m_Ordinal;
        public data_type m_Type;
        public bool m_IsIdentity;
        public SqlDbType m_SqlDbType;
        public bool m_IsNull;
        public int m_Length;
        public int m_Precission;

        public String ExportToXml()
        {
            String result = "  <Field Name=\"" + m_Name + "\"";

            if (m_IsIdentity)
            {
                result += " Identity=\"Yes\"";
            }
            if (!m_IsNull)
            {
                result += " Null=\"No\"";
            }
            result += " Type=\"" + m_Type.ToString().Substring(3) + "\""; // remove: dt_

            if (0 < m_Length)
            {
                result += " Length=\"" + m_Length.ToString() + "\"";
            }
            if (0 < m_Precission)
            {
                result += " Precission=\"" + m_Precission.ToString() + "\"";
            }
            if (!String.IsNullOrEmpty(m_DefaultValue))
            {
                result += " Default=\"" + m_DefaultValue + "\"";
            }
            result += " />";

            return result;
        }
    }
}
