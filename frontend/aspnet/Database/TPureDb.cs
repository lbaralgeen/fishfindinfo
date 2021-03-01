using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Xml;

#pragma warning disable 1591

namespace TDbInterface
{
    public delegate string typeLogger( Exception ex=null, string func_name = null, string message = null, int line=-1, bool isSilence = false);

    public partial class TPureDb
    {
        typeLogger m_logger = null;
        public string m_conn_str = null;
        public SqlConnection m_connection = null;
        public static Dictionary<Tuple<string, string>, List<TRTable>> m_table = new Dictionary<Tuple<string, string>, List<TRTable>>();
        List<TRTable> m_lstTableDets = null;  // load all tables with field details

        public SqlDbType[] GetTypes(string table_name, string fields)
        {
            if (String.IsNullOrEmpty(fields) || m_lstTableDets == null || m_lstTableDets.Count == 0 || String.IsNullOrEmpty(table_name) )
            {
                return null;
            }
            var flds = fields.Split(',');

            for (int i = 0; i < flds.Length; i++)
            {
                flds[i] = flds[i].Trim();
            }
            SqlDbType[] result = new SqlDbType[flds.Length];

            foreach(TRTable table in m_lstTableDets )
            {
                if(String.Equals(table_name, table.m_Name, StringComparison.InvariantCultureIgnoreCase) )
                {
                    for (int j = 0; j < flds.Length; j++)
                    {
                        string fld_name = flds[j];

                        foreach (TRField field in table.Fields)
                        {
                            if( field.m_Name.Equals(fld_name, StringComparison.InvariantCultureIgnoreCase) )
                            {
                                result[j] = field.m_SqlDbType;
                                break;
                            }
                        }
                    }
                }
            }
            return result;
        }
        public bool IsConnected()
        {
            return !(null == m_connection);
        }
        public bool MakeConnection()
        {
            {
                m_connection = new SqlConnection(m_conn_str);
                return null != m_connection;
            }
        }
        public String GetConnString()
        {
            return m_conn_str;
        }
        string[] Split(string values)
        {
            string[] fieldName = values.Split(',');

            for (int i = 0; i < fieldName.Length; i++)
            {
                fieldName[i] = fieldName[i].Trim();
            }
            return fieldName;
        }
        public string GetMasterConnString(string originConnStr, string callerName)
        {
            if( string.IsNullOrEmpty(originConnStr) )
            {
                return null;
            }
            string fn_name = WhatsMyName();
            try
            {
                SqlConnectionStringBuilder conn = new SqlConnectionStringBuilder(m_conn_str)
                { ConnectTimeout = 5, InitialCatalog = "master" };
                return conn.ConnectionString;
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName);
            }
            return null;
        }
        public bool SetConnection(string conn_str)
        {
            if( String.IsNullOrEmpty(conn_str))
            {
                return false;
            }
            try
            {
                // remove provider if exits
                var tokens = conn_str.Split(';');

                for (int i = 0; i < tokens.Length; i++)
                {
                    var pair = tokens[i].Split('=');

                    if (pair != null 
                        && (pair[0] == "Provider" || pair[0] == "Server SPN" || pair[0] == "Initial File Name"))
                    {
                        tokens[i] = "";
                    }
                }
                conn_str = string.Join(";", tokens);
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(conn_str);

                if( String.IsNullOrEmpty(builder.DataSource) )
                {
                    builder.DataSource = "localhost";
                }
                m_conn_str = builder.ConnectionString;
                m_connection = new SqlConnection(m_conn_str);
                m_connection.Open();

                Tuple<string, string> srvdb = GetServerDb(m_conn_str);

                if (!String.IsNullOrEmpty(srvdb.Item1) && !String.IsNullOrEmpty(srvdb.Item2))
                {
                    LoadTableData();

                    if (!m_table.ContainsKey(srvdb))
                    {
                        m_table[srvdb] = m_lstTableDets;
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                m_logger(ex, WhatsMyName(), conn_str);
            }
            return false;
        }
        public TPureDb( typeLogger logger, string conn_str )
        {
            m_logger = (logger == null ? logger : PureDbEventLogger);
            SetConnection(conn_str);
        }
        public static string PureDbEventLogger(Exception ex = null, string func_name = null,string message = null, int line = -1, bool isSilence = false)
        {
            if( String.IsNullOrEmpty(func_name) )
            {
                func_name = WhatsMyName();
            }
            if (line == -1 && ex != null)
            {
                var st = new StackTrace(ex, true); var frame = st.GetFrame(0); line = frame.GetFileLineNumber();
            }
            if(String.IsNullOrEmpty(message) && ex != null)
            {
                return line + ":" + Tlog.ErrorFormat("[{0}] Exception: [{1}] ", func_name, ex.Message);
            }
            if( ex == null && !String.IsNullOrEmpty(message))
            {
                return line + ":" + Tlog.ErrorFormat("[{0}] Exception: [{1}] ", func_name, message);
            }
            if (!String.IsNullOrEmpty(message) && ex != null)
            {
                return line + ":" + Tlog.ErrorFormat("[{0}] Exception: [{1}] - {2}", func_name, ex.Message, message);
            }
            return null;
        }
        public static bool ConnectionTest(String connString, out string dbname)
        {
            dbname = null;

            if (String.IsNullOrEmpty(connString))
            {
                return false;
            }
            try
            {
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();

                    using (SqlCommand myCommand = connection.CreateCommand())
                    {
                        myCommand.CommandType = CommandType.Text;
                        myCommand.CommandText = "SELECT CAST(db_name() AS sysname) AS name";

                        using (SqlDataReader reader = myCommand.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                dbname = reader.GetString(0);
                                return true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                PureDbEventLogger(ex, WhatsMyName());
            }
            return false;
        }
        //--------------------------------------------------------------------------------------------------------------------------------------------
        //--------------------------------------------------------------------------------------------------------------------------------------------
        public int? GetSingleInt(String sqlCmd, String callerName)
        {
            return ReadSingleInt(m_connection, sqlCmd, null, null, callerName);
        }
        public int? ReadSingleInt(SqlConnection connection, String sqlCmd, String ParentCall)
        {
            return ReadSingleInt(connection, sqlCmd, null, null, ParentCall);
        }
        //--------------------------------------------------------------------------------------------------------------------------------------------
        public int? GetSingleInt(String sqlCmd, SqlDbType? paramType, dynamic paramValue, String callerName)
        {
            if (paramType == null)
            {
                return ReadSingleInt(m_connection, sqlCmd, null, null, callerName);
            }
            return ReadSingleInt(m_connection, sqlCmd, paramType, paramValue, callerName);
        }
        public int? ReadSingleInt(SqlConnection connection, String sqlCmd, SqlDbType? paramType, dynamic paramValue, String callerName)
        {
            if(paramType == null || paramValue == null )
            {
                List<KeyValuePair<SqlDbType?, dynamic>> parameters = null;

                return ReadSingleInt(connection, sqlCmd, parameters, callerName);
            }
            var values = new List<KeyValuePair<SqlDbType?, dynamic>>() { new KeyValuePair<SqlDbType?, dynamic>(paramType, paramValue) };

            return ReadSingleInt(connection, sqlCmd, values, callerName);
        }

        public int? ReadSingleInt(SqlConnection connection, String sqlCmd, List<KeyValuePair<SqlDbType?, dynamic>> parameters, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || null == connection)
            {
                return null;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (parameters != null)
                    {
                        int index = 0;
                        foreach (var param in parameters)
                        {
                            myCommand.Parameters.Add("@param" + index, (SqlDbType)param.Key);
                            myCommand.Parameters[index++].Value = (param.Value == null) ? DBNull.Value : param.Value;
                        }
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (reader.IsDBNull(0))
                            {
                                return null;
                            }
                            int result = reader.GetInt32(0);

                            return result;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        //--------------------------------------------------------------------------------------------------------------------------------------------
        public int? ReadSingleInt(SqlConnection connection, String sqlCmd, List<Tuple<SqlDbType, dynamic>> parameters, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || null == connection)
            {
                return null;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (parameters != null)
                    {
                        int index = 0;
                        foreach (var param in parameters)
                        {
                            myCommand.Parameters.Add("@param" + index, param.Item1);
                            myCommand.Parameters[index++].Value = (param.Item2 == null) ? DBNull.Value : param.Item2;
                        }
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (reader.IsDBNull(0))
                            {
                                return null;
                            }
                            int result = reader.GetInt32(0);

                            return result;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        //--------------------------------------------------------------------------------------------------------------------------------------------
        //--------------------------------------------------------------------------------------------------------------------------------------------
        public Int64? GetSingleInt64(String sqlCmd, String callerName)
        {
            return ReadSingleInt64(m_connection, sqlCmd, null, callerName);
        }
        public Int64? ReadSingleInt64(SqlConnection connection, String sqlCmd, String ParentCall)
        {
            return ReadSingleInt64(connection, sqlCmd, null, ParentCall);
        }
        //--------------------------------------------------------------------------------------------------------------------------------------------
        public Int64? GetSingleInt64(String sqlCmd, SqlDbType? paramType, dynamic paramValue, String callerName)
        {
            if (paramType == null)
            {
                return ReadSingleInt64(m_connection, sqlCmd, null, callerName);
            }
            return ReadSingleInt64(m_connection, sqlCmd, paramType, paramValue, callerName);
        }
        public Int64? ReadSingleInt64(SqlConnection connection, String sqlCmd, SqlDbType? paramType, dynamic paramValue, String callerName)
        {
            var values = new List<KeyValuePair<SqlDbType?, dynamic>>() { new KeyValuePair<SqlDbType?, dynamic>(paramType, paramValue) };

            return ReadSingleInt64(connection, sqlCmd, values, callerName);
        }
        //--------------------------------------------------------------------------------------------------------------------------------------------
        public Int64? ReadSingleInt64(SqlConnection connection, String sqlCmd, List<KeyValuePair<SqlDbType?, dynamic>> parameters, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || null == connection)
            {
                return null;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (parameters != null)
                    {
                        int index = 0;
                        foreach (var param in parameters)
                        {
                            myCommand.Parameters.Add("@param" + index, (SqlDbType)param.Key);
                            myCommand.Parameters[index++].Value = (param.Value == null) ? DBNull.Value : param.Value;
                        }
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return (reader.IsDBNull(0) ? null : (int?)reader.GetInt64(0));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public List<int> LoadInt32s(string sqlcmd, string callerName)
        {
            var result = new List<int>();

            if (String.IsNullOrEmpty(sqlcmd))
            {
                return result;
            }
            try
            {
                if (m_connection.State == ConnectionState.Closed)
                {
                    m_connection.Open();
                }
                using (SqlCommand myCommand = m_connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlcmd;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        while (reader.Read() && !reader.IsDBNull(0) )
                        {
                            result.Add ( reader.GetInt32(0) );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                var st = new StackTrace(ex, true); var frame = st.GetFrame(0); var line = frame.GetFileLineNumber();
                string message = Tlog.ErrorFormat("[{0}:{1} - {2}] Exception: [{3}] ", callerName, WhatsMyName(), line, ex.Message);
            }
            return result;
        }
        public List<int> LoadInts(String tableName, String fieldName, String clause, string callerName)
        {
            List<int> result = new List<int>();

            if (String.IsNullOrEmpty(tableName))
            {
                return result;
            }
            String sqlCmd = String.Format("SELECT [{0}] FROM [{1}] {2} ORDER BY 1 ASC"
                 , fieldName, tableName, (String.IsNullOrEmpty(clause) ? "" : " WHERE " + clause));

            return LoadInt32s(sqlCmd, callerName);
        }
        public List<Int64> LoadInts64(String tableName, String fieldName, String clause, string callerName)
        {
            List<Int64> result = new List<Int64>();

            if (String.IsNullOrEmpty(tableName))
            {
                return result;
            }
            String sqlcmd = String.Format("SELECT CAST({0} AS bigint) FROM {1} {2} ORDER BY 1 ASC", fieldName, tableName, (String.IsNullOrEmpty(clause) ? "" : " WHERE " + clause));
            try
            {
                if (m_connection.State == ConnectionState.Closed)
                {
                    m_connection.Open();
                }
                using (SqlCommand myCommand = m_connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlcmd;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        while (reader.Read() && !reader.IsDBNull(0))
                        {
                            result.Add(reader.GetInt64(0));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                var st = new StackTrace(ex, true); var frame = st.GetFrame(0); var line = frame.GetFileLineNumber();
                string message = Tlog.ErrorFormat("[{0}:{1} - {2}] Exception: [{3}] ", callerName, WhatsMyName(), line, ex.Message);
            }
            return result;
        }
        //--------------------------------------------------------------------------------------------------------------------------------------------
        //--------------------------------------------------------------------------------------------------------------------------------------------
        public String GetSingleString(String sqlCmd, string callerName)
        {
            return ReadSingleString(m_connection, sqlCmd, null, null, callerName);
        }
        public string GetSingleString(String sqlCmd, SqlDbType? vtype, dynamic param0, String callerName)
        {
            return ReadSingleString(m_connection, sqlCmd, vtype, param0, callerName);
        }
        /// <summary>
        /// read single string
        /// </summary>
        /// <param name="connection"></param>
        /// <param name="sqlCmd"></param>
        /// <param name="vtype"></param>
        /// <param name="param0"></param>
        /// <param name="callerName"></param>
        /// <returns></returns>
        public string ReadSingleString( SqlConnection connection, String sqlCmd, SqlDbType? vtype, dynamic param0, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || connection == null)
            {
                return null;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (vtype != null)
                    {
                        myCommand.Parameters.Add("@param0", (SqlDbType)vtype);
                        myCommand.Parameters[0].Value = (param0 == null ? DBNull.Value : param0);
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return reader.GetString(0);
                        }
                    }
                    return "";
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public String ReadSingleString(SqlConnection connection, String sqlCmd, string callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || connection == null)
            {
                return null;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return reader.GetString(0);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public Tuple<Guid, int, string> ReadTupleValue(SqlConnection connection, String sqlCmd, SqlDbType? vtype, dynamic param0, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || connection == null)
            {
                return null;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (vtype != null)
                    {
                        myCommand.Parameters.Add("@param0", (SqlDbType)vtype);
                        myCommand.Parameters[0].Value = (param0 == null ? DBNull.Value : param0);
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            Guid gid = reader.GetGuid(0);
                            int lid = reader.GetInt32(1);
                            string s = reader.GetString(2);
                            Tuple<Guid, int, string> result = Tuple.Create<Guid, int, string>(gid, lid, s);
                            return result;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public Tuple<Guid, int, string> GetTupleValue(String sqlCmd, SqlDbType? vtype, dynamic param0, String callerName)
        {
            return ReadTupleValue(m_connection, sqlCmd, vtype, param0, callerName);
        }
        public Dictionary<string, string> GetDictSS(SqlConnection connection, string sqlCmd, string callerName)
        {
            var result = new Dictionary<string, string>();

            if( connection == null )
            {
                return result;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;
                    myCommand.CommandTimeout = 5000;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string key = reader.GetString(0);
                            string value = reader.GetString(1);

                            result[key] = value;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return result;
        }
        public Dictionary<string, string> GetDicSS(SqlConnection connection, String sqlCmd, string callerName)
        {
            var result = new Dictionary<string, string>();

            if(connection == null)
            {
                return result;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = connection;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sqlCmd;
                    cmd.CommandTimeout = 5000;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.IsClosed && reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                string id = reader.GetString(0);
                                string sid = reader.GetString(1);
                                result[id] = sid;
                            }
                        }
                    }
                }
                return result;
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public Dictionary<int, int> GetDicII(SqlConnection connection, String sqlCmd, string callerName)
        {
            var result = new Dictionary<int, int>();

            if (connection == null)
            {
                return result;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = connection;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sqlCmd;
                    cmd.CommandTimeout = 5000;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.IsClosed && reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                int key = reader.GetInt32(0);
                                int ival = reader.GetInt32(1);
                                result[key] = ival;
                            }
                        }
                    }
                    return result;
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public Dictionary<long, string> GetDicLS(SqlConnection connection, String sqlCmd, string callerName)
        {
            var result = new Dictionary<long, string>();

            if (connection == null)
            {
                return result;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = connection;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sqlCmd;
                    cmd.CommandTimeout = 5000;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.IsClosed && reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                long key = reader.GetInt64(0);
                                string val = reader.GetString(1);

                                result[key] = val;
                            }
                        }
                    }
                    return result;
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public Dictionary<int, Tuple<int, string, string>> GetDicIISS(SqlConnection connection, String sqlCmd, string callerName)
        {
            var result = new Dictionary<int, Tuple<int, string, string>>();

            if (connection == null)
            {
                return result;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = connection;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sqlCmd;
                    cmd.CommandTimeout = 5000;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.IsClosed && reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                int key = reader.GetInt32(0);
                                int ival = reader.GetInt32(1);
                                string sval = reader.GetString(2);
                                string sval2 = reader.GetString(3);
                                result[key] = Tuple.Create<int, string, string>(ival, sval, sval2);
                            }
                        }
                    }
                    return result;
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public Dictionary<int, Tuple<int, int, string>> GetDicIIIS(SqlConnection connection, String sqlCmd, string callerName)
        {
            var result = new Dictionary<int, Tuple<int, int, string>>();

            if (connection == null)
            {
                return result;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = connection;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sqlCmd;
                    cmd.CommandTimeout = 5000;

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.IsClosed && reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                int key = reader.GetInt32(0);
                                int ival = reader.GetInt32(1);
                                int ival2 = reader.GetInt32(2);
                                string sval = reader.GetString(3);
                                result[key] = Tuple.Create<int, int, string>(ival, ival2, sval);
                            }
                        }
                    }
                    return result;
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public Tuple<int, int, int> GetListTupleIII(SqlConnection connection, string sqlcmd, string callerName)
        {
            if (null == connection || String.IsNullOrEmpty(sqlcmd))
            {
                return null;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlcmd;
                    myCommand.CommandTimeout = 5000;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int i0 = 0, i1 = 0, i2 = 0;

                            if (reader[0] != DBNull.Value)
                            {
                                i0 = reader.GetInt32(0);
                            }
                            if (reader[1] != DBNull.Value)
                            {
                                i1 = reader.GetInt32(1);
                            }
                            if (reader[2] != DBNull.Value)
                            {
                                i2 = reader.GetInt32(2);
                            }
                            return new Tuple<int, int, int>(i0, i1, i2);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlcmd);
            }
            return null;
        }
        public int Insert( String tableName, string fieldList, dynamic[] values, string callerName )
        {
            var types = GetTypes(tableName, fieldList.Replace(';', ','));

            return Insert(m_connection, tableName, fieldList, types, values, callerName);
        }
        public int Insert( String tableName, string fieldList, SqlDbType[] types, dynamic[] values, string callerName )
        {
            return Insert( m_connection, tableName, fieldList, types, values, callerName );
        }
        /// <summary>
        /// insert strings
        /// </summary>
        /// <param name="connection"></param>
        /// <param name="tableName"></param>
        /// <param name="fieldList"></param>
        /// <param name="types"></param>
        /// <param name="values"></param>
        /// <param name="callerName"></param>
        /// <returns></returns>
        public int Insert(SqlConnection connection, String tableName, string fieldList, SqlDbType[] types, dynamic[] values, string callerName)
        {
            if (String.IsNullOrEmpty(tableName) || connection == null)
            {
                return -1;
            }
            string[] fieldName = Split(fieldList);

            if (null == fieldName || values == null || types == null || fieldName.Length == 0
               || fieldName.Length != values.Length || fieldName.Length != types.Length)
            {
                return -2;
            }
            string sqlcmd = null;

            foreach (string fldName in fieldName)
            {
                sqlcmd += (sqlcmd == null ? " INSERT INTO " + tableName + " ( " : ", ") + fldName.Trim();
            }
            sqlcmd += " ) VALUES (";
            int param = 0;

            foreach (string fldName in fieldName)
            {
                sqlcmd += (param == 0 ? "" : ", ") + "@p" + param++;
            }
            sqlcmd += " );select CAST(SCOPE_IDENTITY() AS INT) AS GENERATED_KEYS ";
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                int result = 0;

                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlcmd;
                    int index = 0;

                    foreach (string fldName in fieldName)
                    {
                        myCommand.Parameters.Add("@p" + index, types[index]);
                        myCommand.Parameters[index].Value = (values[index] == null ? DBNull.Value : values[index]);
                        index++;
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (!reader.IsDBNull(0))
                            {
                                result = reader.GetInt32(0);
                            }
                            else
                            {
                                string idenname = GetIdentityName(tableName);

                                if (!string.IsNullOrEmpty(idenname))
                                {
                                    string sqlidn = String.Format("SELECT CAST(MAX({0}) AS INT) AS cnt FROM [{1}]", GetIdentityName(tableName), tableName);
                                    result = (int)GetSingleInt(sqlidn, callerName + "->" + WhatsMyName());
                                }
                            }
                        }
                    }
                }
                return result;
            }
            catch (Exception ex)
            {
                string vals = "";
                foreach (var val in values)
                {
                    vals += "| " + val;
                }
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlcmd);
            }
            return -3;
        }
        /// <summary>
        /// insert strings
        /// </summary>
        /// <param name="connection"></param>
        /// <param name="tableName"></param>
        /// <param name="fieldName"></param>
        /// <param name="types"></param>
        /// <param name="values"></param>
        /// <param name="callerName"></param>
        /// <returns></returns>
        public int Insert(SqlConnection connection, String tableName, string[] fieldName, SqlDbType[] types, dynamic[] values, string callerName)
        {
            if (String.IsNullOrEmpty(tableName))
            {
                return -1;
            }
            if (null == fieldName || values == null || types == null || fieldName.Length == 0
               || fieldName.Length != values.Length || fieldName.Length != types.Length)
            {
                return -2;
            }
            string sqlcmd = null;

            foreach (string fldName in fieldName)
            {
                sqlcmd += (sqlcmd == null ? " INSERT INTO " + tableName + " ( " : ", ") + fldName.Trim();
            }
            sqlcmd += " ) VALUES (";
            int param = 0;

            foreach (string fldName in fieldName)
            {
                sqlcmd += (param == 0 ? "" : ", ") + "@p" + param++;
            }
            sqlcmd += " );select CAST(SCOPE_IDENTITY() AS INT) AS GENERATED_KEYS ";
            try
            {
                bool isConnExists = false;

                if (connection == null)
                {
                    connection = new SqlConnection(m_conn_str);
                    connection.Open();
                    isConnExists = true;
                }
                int result = 0;
                try
                {
                    using (SqlCommand myCommand = connection.CreateCommand())
                    {
                        myCommand.CommandType = CommandType.Text;
                        myCommand.CommandText = sqlcmd;
                        int index = 0;

                        foreach (string fldName in fieldName)
                        {
                            myCommand.Parameters.Add("@p" + index, types[index]);
                            myCommand.Parameters[index].Value = (values[index] == null ? DBNull.Value : values[index]);
                            index++;
                        }
                        using (SqlDataReader reader = myCommand.ExecuteReader())
                        {
                            if (reader.Read() && !reader.IsDBNull(0))
                            {
                                result = reader.GetInt32(0);
                            }
                        }
                    }
                }
                finally
                {
                    if (isConnExists)
                    {
                        connection.Close();
                    }
                }
                return result;
            }
            catch (Exception ex)
            {
                string vals = "";
                foreach (string val in values)
                {
                    vals += "| " + val;
                }
                Tlog.Warn(sqlcmd + vals);
                var st = new StackTrace(ex, true); var frame = st.GetFrame(0); var line = frame.GetFileLineNumber();
                string message = Tlog.ErrorFormat("[{0} -> {1}]{2} Exception: [{3}] ", callerName, WhatsMyName(), line, ex.Message);
            }
            return -3;
        }
        public List<string> GetListString(SqlConnection connection, String sqlCmd, SqlDbType? paramType, dynamic paramValue, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || connection == null || connection.State == ConnectionState.Closed)
            {
                return null;
            }
            List<string> result = new List<string>();
            try
            {
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (paramType != null)
                    {
                        myCommand.Parameters.Add("@param0", (SqlDbType)paramType);
                        myCommand.Parameters[0].Value = (paramValue == null) ? DBNull.Value : paramValue;
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result.Add(reader.IsDBNull(0) ? null : reader.GetString(0));
                        }
                        return result;
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public List<String> GetListString( SqlConnection connection, String sqlCmd, string callerName )
        {
            List<String> result = new List<String>();

            if (String.IsNullOrEmpty(sqlCmd) || connection == null)
            {
                return result;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result.Add(reader.GetString(0));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return result;
        }
        public int Update(SqlConnection connection, String tableName, List<Tuple<string, SqlDbType, dynamic>> valueList, List<Tuple<string, SqlDbType, dynamic>> whereList, string callerName)
        {
            if (String.IsNullOrEmpty(tableName) || valueList == null || valueList.Count == 0 || connection == null)
            {
                return -1;
            }
            string sqlcmd = "UPDATE " + tableName + " SET ";
            int index = 0;

            foreach (var field in valueList)
            {
                sqlcmd += String.Format("{0} [{1}] = @p{2}", (index == 0 ? "" : ", "), field.Item1, index);
                index++;
            }
            int idx = index;

            if (whereList != null && whereList.Count > 0)
            {
                sqlcmd += " WHERE ";

                foreach (var value in whereList)
                {
                    if (value.Item1 == null)
                    {
                        sqlcmd += String.Format("{0} @p{1} IS NULL", (idx == index ? "" : " AND "), idx);
                    }
                    else
                    {
                        sqlcmd += String.Format("{0} {1} = @p{2}", (idx == index ? "" : " AND "), value.Item1, idx);
                    }
                    idx++;
                }
            }
            try
            {
                int result = 0;

                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlcmd;

                    int num = 0;
                    foreach (var field in valueList)
                    {
                        myCommand.Parameters.Add("@p" + num, field.Item2);
                        if (field.Item3 == null)
                        {
                            myCommand.Parameters[num].Value = DBNull.Value;
                        }
                        else
                        {
                            myCommand.Parameters[num].Value = field.Item3;
                        }
                        num++;
                    }
                    foreach (var value in whereList)
                    {
                        myCommand.Parameters.Add("@p" + num, value.Item2);
                        myCommand.Parameters[num].Value = value.Item3;
                        num++;
                    }
                    result = myCommand.ExecuteNonQuery();
                }
                return result;
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlcmd);
            }
            return -3;
        }
        public int UpdateKeyValue(SqlConnection connection, String tableName, String keyName, int keyId, String valName, dynamic value, string callerName)
        {
            if (String.IsNullOrEmpty(tableName) || String.IsNullOrEmpty(keyName) || String.IsNullOrEmpty(valName) || connection == null )
            {
                return -1;
            }
            string sqlCmd = " UPDATE " + tableName + " SET " + valName + " = @val WHERE " + keyName + " = @id ;SELECT @@ROWCOUNT AS cnt";
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;
                    myCommand.Parameters.Add("@val", SqlDbType.NVarChar);
                    myCommand.Parameters[0].Value = value;
                    myCommand.Parameters.Add("@id", SqlDbType.Int);
                    myCommand.Parameters[1].Value = keyId;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return reader.GetInt32(0);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return -2;
        }
        public int UpdateKeyValue(SqlConnection connection, String tableName, String keyName, Guid keyId, String valName, dynamic value, SqlDbType valType, string callerName)
        {
            if (String.IsNullOrEmpty(tableName) || String.IsNullOrEmpty(keyName) || String.IsNullOrEmpty(valName) || connection == null)
            {
                return -1;
            }
            string sqlCmd = " UPDATE [" + tableName + "] SET [" + valName + "] = @val WHERE [" + keyName + "] = @id ;SELECT @@ROWCOUNT AS cnt";
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;
                    myCommand.Parameters.Add("@val", valType);
                    myCommand.Parameters[0].Value = value;
                    myCommand.Parameters.Add("@id", SqlDbType.UniqueIdentifier);
                    myCommand.Parameters[1].Value = keyId;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return reader.GetInt32(0);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return -2;
        }
        public Int64 UpdateKeyValue(SqlConnection connection, String tableName, List<KeyValuePair<string, dynamic>> vals
                                   , String whereKeyName, dynamic whereKeyValue, string callerName)
        {
            if (String.IsNullOrEmpty(tableName) || String.IsNullOrEmpty(whereKeyName) || vals == null || 0 == vals.Count)
            {
                return -1;
            }
            if (connection == null)
            {
                connection = m_connection;
            }
            string sqlCmd = "UPDATE [" + tableName + "]";
            //            string sqlCmd = String.Format("UPDATE {0}  SET " + valName + " = @val WHERE " + keyName + " = @id ;SELECT @@ROWCOUNT AS cnt", tableName );
            try
            {
                int index = 0;

                string fieldList = "";
                foreach (var item in vals)
                {
                    fieldList += (String.IsNullOrEmpty(fieldList) ? "" : ",") + item.Key;
                }
                var types = GetTypes(tableName, fieldList);

                foreach (var item in vals)
                {
                    sqlCmd += String.Format("{0}[{1}] = @param{2}", (index == 0 ? " SET " : ", "), item.Key, index);
                    index++;
                }
                sqlCmd += " WHERE [" + whereKeyName + "] = @param" + index;

                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;
                    index = 0;

                    foreach (var item in vals)
                    {
                        myCommand.Parameters.Add("@param" + index, types[index]);
                        myCommand.Parameters[index].Value = ((item.Value == null) ? DBNull.Value : item.Value);
                        index++;
                    }
                    myCommand.Parameters.Add("@param" + index, SqlDbType.Int);
                    myCommand.Parameters[index].Value = whereKeyValue;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return reader.GetInt32(0);
                        }
                    }
                    return 0;
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return -2;
        }
        public Int64 UpdateKeyValue(SqlConnection connection, String tableName, List<KeyValuePair<string, dynamic>> vals
                                   , List<KeyValuePair<string, dynamic>> where, string callerName)
        {
            if (String.IsNullOrEmpty(tableName) || vals == null || 0 == vals.Count)
            {
                return -1;
            }
            if (connection == null)
            {
                connection = m_connection;
            }
            string sqlCmd = "UPDATE [" + tableName + "]";
            try
            {
                int index = 0;

                string fieldList = "";
                foreach (var item in vals)
                {
                    fieldList += (String.IsNullOrEmpty(fieldList) ? "" : ",") + item.Key;
                }
                var types = GetTypes(tableName, fieldList);

                foreach (var item in vals)
                {
                    sqlCmd += String.Format("{0}[{1}] = @param{2}", (index == 0 ? " SET " : ", "), item.Key, index);
                    index++;
                }
                string whereList = "";
                foreach (var item in where)
                {
                    whereList += (String.IsNullOrEmpty(whereList) ? "" : ",") + item.Key;
                }
                var whereTypes = GetTypes(tableName, whereList);
                bool start = true;

                foreach (var item in where)
                {
                    sqlCmd += String.Format("{0}[{1}] = @param{2}", (start ? " WHERE " : " AND "), item.Key, index);
                    index++;
                    start = false;
                }

                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;
                    index = 0;

                    foreach (var item in vals)
                    {
                        myCommand.Parameters.Add("@param" + index, types[index]);
                        myCommand.Parameters[index].Value = ((item.Value == null) ? DBNull.Value : item.Value);
                        index++;
                    }
                    int idx = 0;
                    foreach (var item in where)
                    {
                        myCommand.Parameters.Add("@param" + index, whereTypes[idx]);
                        myCommand.Parameters[index].Value = ((item.Value == null) ? DBNull.Value : item.Value);
                        index++; idx++;
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return reader.GetInt32(0);
                        }
                    }
                    return 0;
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return -2;
        }
        public int Delete(SqlConnection connection, String tableName, List<KeyValuePair<string, dynamic>> where, string callerName)
        {
            if (String.IsNullOrEmpty(tableName) || where == null || 0 == where.Count)
            {
                return -1;
            }
            if (connection == null)
            {
                connection = m_connection;
            }
            string sqlCmd = "DELETE FROM [" + tableName + "]";
            try
            {
                int index = 0;

                foreach (var item in where)
                {
                    sqlCmd += String.Format("{0}[{1}] = @param{2}", (index == 0 ? " WHERE " : " AND "), item.Key, index);
                    index++;
                }
                string whereList = "";
                foreach (var item in where)
                {
                    whereList += (String.IsNullOrEmpty(whereList) ? "" : ",") + item.Key;
                }
                var whereTypes = GetTypes(tableName, whereList);

                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;
                    index = 0;

                    index = 0;
                    foreach (var item in where)
                    {
                        myCommand.Parameters.Add("@param" + index, whereTypes[index]);
                        myCommand.Parameters[index].Value = ((item.Value == null) ? DBNull.Value : item.Value);
                        index++;
                    }
                    int rows = myCommand.ExecuteNonQuery();

                    return rows;
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return -2;
        }
        public int Delete(String tableName, string colName, SqlDbType colType, dynamic colValue, string callerName)
        {
            if (String.IsNullOrEmpty(tableName) || String.IsNullOrEmpty(colName))
            {
                return -1;
            }
            string sqlCmd = "DELETE FROM [" + tableName + "] ";

            if (colValue == null)
            {
                sqlCmd += " WHERE [" + colName + "] IS NULL";
            }
            else
            {
                sqlCmd += " WHERE @param0 = [" + colName + "]";
            }
            try
            {
                int index = 0;

                if (m_connection.State == ConnectionState.Closed)
                {
                    m_connection.Open();
                }
                using (SqlCommand myCommand = m_connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    myCommand.Parameters.Add("@param0", colType);
                    myCommand.Parameters[index].Value = ((colValue == null) ? DBNull.Value : colValue);
                    int rows = myCommand.ExecuteNonQuery();

                    return rows;
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return -2;
        }
        public int? ExecSP( String spName, List<Tuple<string, SqlDbType, dynamic>> paramList, string callerName )
        {
            return ExecSP( m_connection, spName, paramList, callerName );
        }
        public int? ExecSP(SqlConnection connection, String spName, string paramName, SqlDbType type, dynamic value, string callerName)
        {
            var paramList = new List<Tuple<string, SqlDbType, dynamic>>();
            paramList.Add(Tuple.Create<string, SqlDbType, dynamic>(paramName, type, value));

            return ExecSP(connection, spName, paramList, callerName);
        }
        /// <summary>
        /// execute paritrized procedure
        /// </summary>
        /// <param name="connection"></param>
        /// <param name="spName"></param>
        /// <param name="paramList"></param>
        /// <param name="callerName"></param>
        /// <returns></returns>
        public int? ExecSP(SqlConnection connection, String spName, List<Tuple<string, SqlDbType, dynamic>> paramList, string callerName)
        {
            if (String.IsNullOrEmpty(spName) || connection == null )
            {
                return null;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = new SqlCommand(spName, connection))
                {
                    myCommand.CommandType = CommandType.StoredProcedure;

                    if (paramList != null && paramList.Count > 0)
                    {
                        int index = 0;
                        foreach (var entry in paramList)
                        {
                            myCommand.Parameters.Add(entry.Item1, entry.Item2);

                            if (entry.Item3 == null)
                            {
                                myCommand.Parameters[index++].Value = DBNull.Value;
                            }
                            else
                            {
                                myCommand.Parameters[index++].Value = entry.Item3;
                            }
                        }
                    }
                    return myCommand.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), spName);
            }
            return null;
        }
        public int? ExecCmd(String sqlCmd, string callerfunction, bool isSilient = false)
        {
            List<Tuple<SqlDbType, dynamic>> paramList = null;

            return ExecCmd(m_connection, sqlCmd, paramList, callerfunction, isSilient);
        }
        public int? ExecCmd(SqlConnection connection, String sqlCmd, string callerfunction, bool isSilient = false)
        {
            List<Tuple<SqlDbType, dynamic>> paramList = null;

            return ExecCmd(connection, sqlCmd, paramList, callerfunction, isSilient);
        }
        public int? ExecCmd(SqlConnection connection, String sqlCmd, SqlDbType type, dynamic value, string callerfunction, bool isSilient = false)
        {
            var paramList = new List<Tuple<SqlDbType, dynamic>>();
            paramList.Add(new Tuple<SqlDbType, dynamic>(type, value));

            return ExecCmd(connection, sqlCmd, paramList, callerfunction, isSilient);
        }
        public int? ExecCmd(SqlConnection connection, String sqlCmd, List<Tuple<SqlDbType, dynamic>> paramList, string callerName, bool isSilient = false)
        {
            if (String.IsNullOrEmpty(sqlCmd) || connection == null )
            {
                return null;
            }
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;
                    myCommand.CommandTimeout = 0;

                    if (paramList != null && paramList.Count > 0)
                    {
                        int index = 0;
                        foreach (var entry in paramList)
                        {
                            myCommand.Parameters.Add("@param" + index, entry.Item1);

                            if (entry.Item2 == null)
                            {
                                myCommand.Parameters[index++].Value = DBNull.Value;
                            }
                            else
                            {
                                myCommand.Parameters[index++].Value = entry.Item2;
                            }
                        }
                    }
                    return myCommand.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                if (!isSilient)
                {
                    m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
                }
            }
            return null;
        }
        public int ExecCmdIndentity(SqlConnection connection, String sqlCmd, string callerName)
        {
            if (connection == null)
            {
                return -2;
            }
            try
            {
                sqlCmd += ";select CAST(SCOPE_IDENTITY() AS INT) AS GENERATED_KEYS";

                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;
                    myCommand.CommandTimeout = 0;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                            if (reader.Read() && !reader.IsDBNull(0))
                            {
                                return reader.GetInt32(0);
                            }
                    }
                }
                return 0;
            }
            catch (Exception ex)
            {
                Tlog.ErrorFormat("[{0} -> {1}] Exception: {2}", callerName, WhatsMyName(), ex.Message);
            }
            return -1;
        }
        public Guid GetSingleGuid(String sqlCmd, List<Tuple<SqlDbType, dynamic>> parameters, String callerName)
        {
            return GetSingleGuid(m_connection, sqlCmd, parameters, callerName);
        }
        public Guid GetSingleGuid( String sqlCmd, SqlDbType type, dynamic value, String callerName )
        {
            var parameters = new List<Tuple<SqlDbType, dynamic>>();
            parameters.Add(Tuple.Create<SqlDbType, dynamic>(type, value));

            return GetSingleGuid(m_connection, sqlCmd, parameters, callerName);
        }
        public XmlDocument GetXmlDoc(String sqlCmd, SqlDbType type, dynamic value, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || m_connection == null)
            {
                return null;
            }
            try
            {
                using (SqlCommand myCommand = m_connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    myCommand.Parameters.Add("@param0", type);
                    myCommand.Parameters[0].Value = (value == null) ? DBNull.Value : value;

                    using (XmlReader reader = myCommand.ExecuteXmlReader())
                    {
                        if (reader.Read())
                        {
                            XmlDocument xdoc = new XmlDocument();

                            xdoc.Load(reader);

                            return xdoc;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public Guid GetSingleGuid(SqlConnection connection, String sqlCmd, List<Tuple<SqlDbType, dynamic>> parameters, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || connection == null)
            {
                return Guid.Empty;
            }
            try
            {
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (parameters != null)
                    {
                        int idx = 0;
                        foreach (var entry in parameters)
                        {
                            myCommand.Parameters.Add("@param" + idx, (SqlDbType)entry.Item1);
                            myCommand.Parameters[idx].Value = (entry.Item2 == null) ? DBNull.Value : entry.Item2;
                            idx++;
                        }
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return (reader.IsDBNull(0) ? Guid.Empty : reader.GetGuid(0));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return Guid.Empty;
        }
        public Guid GetSingleGuid(SqlConnection connection, String sqlCmd, SqlDbType? paramType, dynamic paramValue, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || connection == null)
            {
                return Guid.Empty;
            }
            try
            {
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (paramType != null)
                    {
                        myCommand.Parameters.Add("@param0", (SqlDbType)paramType);
                        myCommand.Parameters[0].Value = (paramValue == null) ? DBNull.Value : paramValue;
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return (reader.IsDBNull(0) ? Guid.Empty : reader.GetGuid(0));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return Guid.Empty;
        }
        public DateTime? GetSingleDate(SqlConnection connection, String sqlCmd, List<Tuple<SqlDbType, dynamic>> parameters, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || connection == null)
            {
                return null;
            }
            try
            {
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (parameters != null)
                    {
                        int idx = 0;
                        foreach (var entry in parameters)
                        {
                            myCommand.Parameters.Add("@param" + idx, (SqlDbType)entry.Item1);
                            myCommand.Parameters[idx].Value = (entry.Item2 == null) ? DBNull.Value : entry.Item2;
                            idx++;
                        }
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (reader.IsDBNull(0))
                            {
                                return null;
                            }
                            else
                            {
                                return reader.GetDateTime(0);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public DateTime? GetSingleDate(SqlConnection connection, String sqlCmd, SqlDbType? paramType, dynamic paramValue, String callerName)
        {
            if (String.IsNullOrEmpty(sqlCmd) || connection == null)
            {
                return null;
            }
            if (m_connection.State == ConnectionState.Closed)
            {
                m_connection.Open();
            }
            try
            {
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (paramType != null)
                    {
                        myCommand.Parameters.Add("@param0", (SqlDbType)paramType);
                        myCommand.Parameters[0].Value = (paramValue == null) ? DBNull.Value : paramValue;
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (reader.IsDBNull(0))
                            {
                                return null;
                            }
                            return reader.GetDateTime(0);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }

        public Tuple<string, string, string> GetSingleSSS(SqlConnection connection, String sqlCmd, SqlDbType? paramType, dynamic paramValue, String callerName)
        {
            var result = new Tuple<string, string, string>(null, null, null);

            if (String.IsNullOrEmpty(sqlCmd) || connection == null)
            {
                return result;
            }
            try
            {
                using (SqlCommand myCommand = connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    if (paramType != null)
                    {
                        myCommand.Parameters.Add("@param0", (SqlDbType)paramType);
                        myCommand.Parameters[0].Value = (paramValue == null) ? DBNull.Value : paramValue;
                    }
                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string s1 = (reader.IsDBNull(0) ? null : reader.GetString(0));
                            string s2 = (reader.IsDBNull(1) ? null : reader.GetString(1));
                            string s3 = (reader.IsDBNull(2) ? null : reader.GetString(2));

                            return Tuple.Create<string, string, string>(s1, s2, s3);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, callerName + "->" + WhatsMyName(), sqlCmd);
            }
            return null;
        }
        public bool WaitUntil( String dbName )
        {
            if( String.IsNullOrEmpty(dbName) )
            {
                return false;
            }
            string sqlcmd = String.Format("SELECT CAST(state AS INT), state_desc FROM sys.databases WHERE [name] = '{0}'", dbName); ;
            try
            {
                string masterconn = GetMasterConnString(this.m_conn_str, "WaitUntil");

                using (SqlConnection connection = new SqlConnection(masterconn))
                {
                    connection.Open();

                    using (SqlCommand myCommand = connection.CreateCommand())
                    {
                        myCommand.CommandType = CommandType.Text;
                        myCommand.CommandText = sqlcmd;
                        DateTime start = DateTime.Now;
                        DateTime end = start.AddMinutes(5);
                        Tlog.InfoFormat("[WaitUntil] [{0}] ", sqlcmd);

                        for (DateTime iter = start; iter < end; iter = iter.AddSeconds(1))
                        {

                            using (SqlDataReader reader = myCommand.ExecuteReader())
                            {
                                if( reader.Read() )
                                {
                                    int state = reader.GetInt32(0);

                                    if (state == 0)
                                    {
                                        string desc = (reader.IsDBNull(0) ? null : reader.GetString(1));

                                        if (desc == "ONLINE")
                                        {
                                            Tlog.InfoFormat("[WaitUntil] [{0}] ", dbName + " - database ONLINE");
                                            return true;
                                        }
                                    }
                                }
                            }
                            System.Threading.Thread.Sleep(1024);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, WhatsMyName(), sqlcmd);
            }
            return false;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static string WhatsMyName()
        {
            var st = new StackTrace(new StackFrame(1));
            return st.GetFrame(0).GetMethod().Name;
        }
    };
}
