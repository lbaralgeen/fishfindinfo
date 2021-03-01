using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#pragma warning disable 1591

namespace TDbInterface
{
    public class TRTable
    {
        public TRTable(String tableName)
        {
            m_Name = tableName;
            Fields = new List<TRField>();
        }
        public string m_Name;
        public List<TRField> Fields;
        public String ExportToXml()
        {
            String result = "    <Table Name=\"" + m_Name + "\">";

            foreach (TRField field in Fields)
            {
                result += field.ExportToXml();
            }
            result += "  </Table>";

            return result;
        }
    };
}
