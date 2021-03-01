
using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Collections;
using Microsoft.SqlServer.Server;


namespace FishTracker.Update
{
    public class TExport
    {
        String m_sConnStr = "";
        public void SetConnection(String sConnStr) 
        {
            m_sConnStr = sConnStr;
        }
        public bool Export1HrToJSON(String sFileName, int hrs, ref int rows)
        {
            if (String.IsNullOrEmpty(sFileName) || 0 >= hrs)
            {
                return false;
            }
            String sqlWaterData = " SELECT *  FROM dbo.GetLastHourWaterData( " + hrs.ToString() + " ) ";

            using (SqlConnection connection = new SqlConnection(m_sConnStr))
            {
                connection.Open();
                using (StreamWriter outfile = new StreamWriter(sFileName))
                {
                    outfile.Write("{ ");

                    if (ExportTableToJSON(connection, outfile, "WaterData", sqlWaterData, ref rows))
                    {

                    }
                    outfile.Write(" }");
                }
                connection.Close();
                return true;
            }
        }
        // http://fishportal.biz/WebService/Update.aspx?WaterData=A29B196D-B909-30A0-B719-6AFC8C3DE123
        public bool Export1HrWaterDataToJSON(List<String> outfile, int hrs, ref int rows)
        {
            outfile.Clear();

            if (  0 >= hrs )
            {
                return false;
            }
            String sqlWaterData = " SELECT *  FROM dbo.GetLastHourWaterData( " + hrs.ToString() + " ) ";

            using (SqlConnection connection = new SqlConnection(m_sConnStr))
            {
                connection.Open();
                {
                    outfile.Add( "{ ");

                    if (ExportTableToJSON(connection, outfile, "WaterData", sqlWaterData, ref rows ))
                    {
                        
                    }
                    outfile.Add(" }");
                }
                connection.Close();
                return true;
            }
        }
        // http://fishportal.biz/WebService/Update.aspx?FishLocation=75501A06-5176-4465-B299-D6041D25931C
        public bool Export1HrFishLocationToJSON(List<String> outfile, int hrs, ref int rows)
        {
            outfile.Clear();

            if (0 >= hrs)
            {
                return false;
            }
            String sqlWaterData = " SELECT * FROM dbo.GetLastHourFishLocation( " + hrs.ToString() + " ) ";

            using (SqlConnection connection = new SqlConnection(m_sConnStr))
            {
                connection.Open();
                {
                    outfile.Add("{ ");

                    if (ExportTableToJSON(connection, outfile, "FishLocation", sqlWaterData, ref rows))
                    {

                    }
                    outfile.Add(" }");
                }
                connection.Close();
                return true;
            }
        }
        public bool ExportFListToJSON(List<String> outfile, Guid userGuid, ref int rows)
        {
            outfile.Clear();
            string sqlCmd = "SELECT fish_id, fish_name FROM dbo.fn_get_trial_fish_byuser( @guid ) ORDER BY 1";

            using (SqlConnection connection = new SqlConnection(m_sConnStr))
            {
                connection.Open();
                {
                    outfile.Add("{ ");

                    if (ExportTableToJSON(connection, outfile, "FishList", sqlCmd, ref rows))
                    {

                    }
                    outfile.Add(" }");
                }
                connection.Close();
                return true;
            }
        }
        private String GetValue(int index, SqlDataReader reader)
        {
            String result = reader.GetValue(index).ToString();

            if (String.IsNullOrEmpty(result))
            {
                return result;
            }
            String fieldName = reader.GetName(index);
            String dataType = reader.GetDataTypeName(index);
            bool decorate = (dataType.Equals("string", StringComparison.OrdinalIgnoreCase)
                           || dataType.Equals("uniqueidentifier", StringComparison.OrdinalIgnoreCase)
                           || dataType.Equals("varchar", StringComparison.OrdinalIgnoreCase)
                           || dataType.Equals("char", StringComparison.OrdinalIgnoreCase)
                           || dataType.Equals("datetime", StringComparison.OrdinalIgnoreCase)) ? true : false;

            if (!String.IsNullOrEmpty(result))
            {
                result = "\"" + fieldName + "\":" + (decorate ? "\"" : "") + result + (decorate ? "\"" : "");
            }
            return result;
        }
        private bool ExportTableToJSON(SqlConnection connection, StreamWriter outfile, String sTableName, String sqlCmd, ref int rows)
        {
            rows = 0;

            if (String.IsNullOrEmpty(m_sConnStr)   || String.IsNullOrEmpty(sTableName)
                || null == connection              || String.IsNullOrEmpty(sqlCmd))
            {
                return false;
            }
            outfile.Write( sTableName + " : { [\n");
            using (SqlCommand myCommand = connection.CreateCommand())
            {
                myCommand.CommandType = CommandType.Text;
                myCommand.CommandText = sqlCmd;

                using (SqlDataReader reader = myCommand.ExecuteReader())
                {
                    string point = "";
                    while (reader.Read())
                    {
                        StringBuilder sb = new StringBuilder();

                        sb.Append(point + "{ ");
                        string rowstr = "";
                        if( string.IsNullOrEmpty(point))
                        {
                            point =  ","; 
                        }
                        for (int index = 0; index < reader.FieldCount; index++)
                        {
                            string value = GetValue(index, reader);

                            if (string.IsNullOrEmpty(rowstr))
                            {
                                rowstr += (string.IsNullOrEmpty(value) ? "" : value);
                            }
                            else
                            {
                                rowstr += (string.IsNullOrEmpty(value) ? "" : (", " + value));
                            }
                        }
                        sb.AppendLine(rowstr + " }");
                        outfile.Write(sb.ToString());
                        rows++;
                    }
                }
            }
            outfile.Write(" ] }\n");
            return true;
        }
        private bool ExportTableToJSON(SqlConnection connection, List<String> outfile, String sTableName, String sqlCmd, ref int rows)
        {
            rows = 0;

            if (String.IsNullOrEmpty(m_sConnStr) || String.IsNullOrEmpty(sTableName)
                || null == connection            || String.IsNullOrEmpty(sqlCmd))
            {
                return false;
            }
            outfile.Add( "\"" +sTableName + "\" : [\n");
            using (SqlCommand myCommand = new SqlCommand(sqlCmd, connection))
            {
                using (SqlDataReader reader = myCommand.ExecuteReader())
                {
                    string point = "";
                    while (reader.Read())
                    {
                        StringBuilder sb = new StringBuilder();

                        sb.Append(point + "{ ");
                        string rowstr = "";
                        if (string.IsNullOrEmpty(point))
                        {
                            point = ",";
                        }

                        for (int index = 0; index < reader.FieldCount; index++)
                        {
                            string value = GetValue(index, reader);

                            if (string.IsNullOrEmpty(rowstr))
                            {
                                rowstr += (string.IsNullOrEmpty(value) ? "" : value);
                            }
                            else
                            {
                                rowstr += (string.IsNullOrEmpty(value) ? "" : (", " + value));
                            }
                        }
                        sb.AppendLine(rowstr + " }");
                        outfile.Add(sb.ToString());
                        rows++;
                    }
                }
            }
            outfile.Add(" ]\n");
            return true;
        }
        private bool ExportProcedureToJSON(SqlConnection connection, List<String> outfile, String sTableName, String spProcedureName, ref int rows)
        {
            rows = 0;

            if (String.IsNullOrEmpty(m_sConnStr) || String.IsNullOrEmpty(sTableName)
                || null == connection || String.IsNullOrEmpty(spProcedureName))
            {
                return false;
            }
            outfile.Add("\"" + sTableName + "\" : [\n");
            using (SqlCommand myCommand = connection.CreateCommand())
            {
                myCommand.CommandType = CommandType.StoredProcedure;
                myCommand.CommandText = spProcedureName;

                using (SqlDataReader reader = myCommand.ExecuteReader())
                {
                    string point = "";
                    while (reader.Read())
                    {
                        StringBuilder sb = new StringBuilder();

                        sb.Append(point + "{ ");
                        string rowstr = "";
                        if (string.IsNullOrEmpty(point))
                        {
                            point = ",";
                        }

                        for (int index = 0; index < reader.FieldCount; index++)
                        {
                            string value = GetValue(index, reader);

                            if (string.IsNullOrEmpty(rowstr))
                            {
                                rowstr += (string.IsNullOrEmpty(value) ? "" : value);
                            }
                            else
                            {
                                rowstr += (string.IsNullOrEmpty(value) ? "" : (", " + value));
                            }
                        }
                        sb.AppendLine(rowstr + " }");
                        outfile.Add(sb.ToString());
                        rows++;
                    }
                }
            }
            outfile.Add(" ]\n");
            return true;
        }
    }
};
