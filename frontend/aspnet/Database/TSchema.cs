using System;
using System.Collections.Generic;
using Microsoft.Win32;
using System.Diagnostics;
using System.Data;
using System.Linq;
using System.Data.SqlClient;

#pragma warning disable 1591

namespace TDbInterface
{
    public partial class TPureDb
    {
        private string m_cmd_stat = "DECLARE @tbl TABLE (name sysname, cnt bigint); INSERT INTO @tbl EXEC sp_msforeachTable 'SELECT ''?'' AS name, COUNT(*) AS cnt FROM ?';SELECT LEFT(name, LEN(name)-1) AS name, cnt FROM (SELECT SUBSTRING(name, CHARINDEX('.', name)+2, LEN(name)) AS name, cnt FROM @tbl)x;";
        public class RObject
        {
            public int m_iObjectId = 0;
            public int m_iObjectParentId = 0;
            public String m_sName;
            public String m_sXType;

            public RObject(int id, string name, string type, int parent)
            {
                m_iObjectId = id;
                m_sName = name;
                m_sXType = type;
                m_iObjectParentId = parent;

                if ("U" == m_sXType)
                {
                    m_PTable = new RTable();
                }
            }
            public String GetName() { return m_sName; }
            public class RTable
            {
                public List<int> m_listFkTables;

            };
            public RTable m_PTable = null;
        };

        public Dictionary<int, RObject> m_lstObjects = new Dictionary<int, RObject>();

        public bool LoadTableData()
        {
            m_lstTableDets = LoadTableDetails();  // load all tables with field details

            return m_lstTableDets.Count() > 0;
        }
        public static string GetLocalMSSQL()
        {
            RegistryView registryView = Environment.Is64BitOperatingSystem ? RegistryView.Registry64 : RegistryView.Registry32;
            using (RegistryKey hklm = RegistryKey.OpenBaseKey(RegistryHive.LocalMachine, registryView))
            {
                RegistryKey instanceKey = hklm.OpenSubKey(@"SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL", false);
                if (instanceKey != null)
                {
                    foreach (var instanceName in instanceKey.GetValueNames())
                    {
                        if (instanceName == "MSSQLSERVER")
                        {
                            return Environment.MachineName;
                        }
                        else
                        {
                            return Environment.MachineName + @"\" + instanceName;
                        }
                    }
                }
            }
            return "localhost";
        }

        public List<String> LoadTableList()  // load all tables in dependency order
        {
            List<String> result = new List<String>();

            String sqlCmd = "WITH cte ( from_table, to_table ) AS ("
    + " select DISTINCT o1.Name as from_table, o2.Name as to_table from sys.foreign_keys fk inner join sys.objects o1"
    + " on fk.parent_object_id = o1.object_id inner join sys.schemas s1 on o1.schema_id = s1.schema_id"
    + " inner join sys.objects o2 on fk.referenced_object_id = o2.object_id inner join sys.schemas s2"
    + " on o2.schema_id = s2.schema_id where not ( s1.name = s2.name and o1.name = o2.name)"
    + " ) SELECT * FROM cte"
    + " union SELECT name, null  FROM sys.tables t where NOT EXISTS (select * from cte where cte.from_table = t.name) order by 1";
            try
            {
                using (SqlCommand myCommand = m_connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        string lastTable = "";

                        while (reader.Read())
                        {
                            String fromtable = reader.GetString(0);
                            String toTable = reader.GetString(1);

                            if (String.IsNullOrEmpty(toTable))
                            {
                                result.Add(fromtable);          // table without dependeces
                                lastTable = "";
                                continue;
                            }
                            if (!result.Contains(toTable))
                            {
                                result.Add(toTable);            // parent table
                            }
                            if (!String.IsNullOrEmpty(lastTable) && 0 != lastTable.CompareTo(fromtable) && !result.Contains(lastTable))
                            {
                                result.Add(lastTable);     // child table
                            }
                            lastTable = fromtable;
                            PushFKTable(fromtable, toTable);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                PureDbEventLogger(ex, WhatsMyName(), sqlCmd);
            }
            return result;
        }
        public SqlDbType? GetColumnType( string tableName, string columnName )  // load all tables with field details
        {
            if( String.IsNullOrEmpty(tableName) || String.IsNullOrEmpty(columnName) || m_lstTableDets == null || m_lstTableDets.Count ==  0)
            {
                return null;
            }
            foreach(TRTable entry in m_lstTableDets)
            {
                if(entry.m_Name == tableName)
                {
                    List<TRField> Fields = entry.Fields;

                    if(Fields == null || Fields.Count == 0)
                    {
                        return null;
                    }
                    foreach(TRField fld in Fields)
                    {
                        if (fld.m_Name == columnName)
                        {
                            return fld.m_SqlDbType;
                        }
                    }
                }
            }
            return null;
        }
        /// <summary>
        /// return current transactional model
        /// </summary>
        /// <returns></returns>
        public Tuple<string, int, int> GetIsolationLevel()
        {
            var result = new Tuple<string, int, int>(null, -1, -1);
            try
            {
                if(m_connection.State == ConnectionState.Closed)
                {
                    m_connection.Open();
                }
                String sqlCmd = " SELECT CASE WHEN transaction_isolation_level = 1 THEN 'READ UNCOMMITTED' WHEN transaction_isolation_level = 2 AND is_read_committed_snapshot_on = 1 THEN 'READ COMMITTED SNAPSHOT'  "
                                + " WHEN transaction_isolation_level = 2 AND is_read_committed_snapshot_on = 0 THEN 'READ COMMITTED' WHEN transaction_isolation_level = 3 THEN 'REPEATABLE READ' "
                                + " WHEN transaction_isolation_level = 4 THEN 'SERIALIZABLE' WHEN transaction_isolation_level = 5 THEN 'SNAPSHOT' ELSE NULL END AS TRANSACTION_ISOLATION_LEVEL "
                                + ", CAST(transaction_isolation_level AS INT), CAST(is_read_committed_snapshot_on AS INT) FROM sys.dm_exec_sessions AS s CROSS JOIN sys.databases AS d WHERE  session_id = @@SPID AND  d.database_id = DB_ID(); ";

                using (SqlCommand myCommand = m_connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {

                        if( reader.Read() )
                        {
                            String model = reader.GetString(0);

                            if( !String.IsNullOrEmpty(model) )
                            {
                                int transaction_isolation_level  = reader.GetInt32(1);
                                int is_read_committed_snapshot_on = reader.GetInt32(2);

                                result = new Tuple<string, int, int>(model, transaction_isolation_level, is_read_committed_snapshot_on);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, "GetIsolationLevel");
            }
            return result;
        }
        public string GetIdentityName( string tableName )
        {
            if (String.IsNullOrEmpty(tableName) || m_lstTableDets == null || m_lstTableDets.Count == 0)
            {
                return null;
            }
            foreach (TRTable entry in m_lstTableDets)
            {
                if (entry.m_Name == tableName)
                {
                    List<TRField> Fields = entry.Fields;

                    if (Fields == null || Fields.Count == 0)
                    {
                        return null;
                    }
                    foreach (TRField fld in Fields)
                    {
                        if( fld.m_IsIdentity )
                        {
                            return fld.m_Name;
                        }
                    }
                }
            }
            return null;
        }
        public List<TRTable> LoadTableDetails()  // load all tables with field details
        {
            var result = new List<TRTable>();

            String sqlCmd = "SELECT LOWER(a.TABLE_NAME), LOWER(COLUMN_NAME), ORDINAL_POSITION, "
                            + " IS_NULLABLE, DATA_TYPE, CASE WHEN CHARACTER_OCTET_LENGTH IS NULL THEN 0 ELSE CHARACTER_OCTET_LENGTH END AS OCTET_LENGTH, "
                            + " CASE WHEN NUMERIC_PRECISION IS NULL THEN 0 ELSE NUMERIC_PRECISION END AS NUMERIC_PRECISION, "
                            + " CAST(columnproperty(OBJECT_ID(a.TABLE_NAME), COLUMN_NAME, 'IsIdentity') AS int) as IsIdentity, COLUMN_DEFAULT "
                            + " FROM INFORMATION_SCHEMA.COLUMNS a, INFORMATION_SCHEMA.TABLES b "
                            + " WHERE a.TABLE_NAME NOT LIKE N'sysdiagrams' AND a.TABLE_NAME=b.TABLE_NAME AND b.TABLE_TYPE='BASE TABLE' "
                            + " ORDER BY a.TABLE_NAME, ORDINAL_POSITION, COLUMN_NAME ";
            try
            {
                using (SqlCommand myCommand = m_connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = sqlCmd;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        TRTable table = null;
                        string tableName = "";

                        while (reader.Read())
                        {
                            String TABLE_NAME = reader.GetString(0);

                            if (String.IsNullOrEmpty(tableName) || !tableName.Equals(TABLE_NAME))
                            {
                                table = new TRTable(TABLE_NAME);

                                if (!String.IsNullOrEmpty(tableName))
                                {
                                    result.Add(table);
                                }
                                tableName = TABLE_NAME;
                            }
                            String COLUMN_NAME = reader.GetString(1);

                            TRField field = new TRField(COLUMN_NAME);
                            field.m_Ordinal = reader.GetInt32(2);
                            field.m_IsNull = reader.GetString(3).Equals("Yes");

                            string type_name = reader.GetString(4);
                            field.SetType(type_name);

                            field.m_Length = reader.GetInt32(5);
                            field.m_Precission = reader.GetInt32(6);
                            field.m_IsIdentity = (reader.GetInt32(7) == 1);
                            field.m_DefaultValue = reader.IsDBNull(8) ? null : reader.GetString(8);

                            table.Fields.Add(field);
                        }
                        if (null != table)
                        {
                            result.Add(table);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex);
            }
            return result;
        }
        public Int64 GetTableCount(String tableName, String callerName)
        {
            return (Int64)GetSingleInt64("SELECT CAST(COUNT(*) AS bigint) AS cnt FROM [" + tableName + "]", callerName);
        }
        public Int64 GetTableCountIf(String tableName, String condition)
        {
            return (Int64)GetSingleInt64("SELECT CAST(COUNT(*) AS bigint) AS cnt FROM [" + tableName + "] WHERE " + condition, WhatsMyName());
        }
        private Tuple<string, string> GetServerDb(string conn_str)
        {
            var result = Tuple.Create<string, string>(null, null);

            if (String.IsNullOrEmpty(conn_str))
            {
                return result;
            }
            string[] pars = conn_str.Split(';');

            if (pars == null)
            {
                return result;
            }
            string serverName = null;
            string dbName = null;

            foreach (string part in pars)
            {
                string[] lines = part.Split('=');

                if (lines[0] == "Data Source" || lines[0] == "server")
                {
                    serverName = lines[1];
                }
                else
                    if (lines[0] == "Initial Catalog" || lines[0] == "database")
                {
                    dbName = lines[1];
                }
            }
            if (!String.IsNullOrEmpty(serverName) && !String.IsNullOrEmpty(serverName))
            {
                return Tuple.Create<string, string>(serverName, dbName);
            }
            return result;
        }
        public List<KeyValuePair<string, Int64>> GetTableStat()
        {
            var result = new List<KeyValuePair<string, Int64>>();
            try
            {
                if(m_connection.State == ConnectionState.Closed)
                {
                    m_connection.Open();
                }
                using (SqlCommand myCommand = m_connection.CreateCommand())
                {
                    myCommand.CommandType = CommandType.Text;
                    myCommand.CommandText = m_cmd_stat;

                    using (SqlDataReader reader = myCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            String key = reader.GetString(0);
                            Int64 value  = reader.GetInt64(1);

                            if (!String.IsNullOrEmpty(key))
                            {
                                result.Add(new KeyValuePair<string, Int64>(key, value));
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                m_logger(ex, "GetTableStat");
            }
            return result;
        }
        public bool PushFKTable(String tableName, String fkTableName)
        {
            if (String.IsNullOrEmpty(tableName) || String.IsNullOrEmpty(fkTableName) || 0 == m_lstObjects.Count)
            {
                return false;
            }
            return true;
            /*
                        try
                        {
                            var robject = m_lstObjects.First(pair => pair.Value.m_PTable != null);
            //                KeyValuePair<int, RObject> robject = lstObjects.First(pair => pair.Value.m_sName == tableName && pair.Value.m_sXType == "U");
                            var rparent = m_lstObjects.First(pair => pair.Value.m_sName == fkTableName && pair.Value.m_sXType == "U");

                            int objectId = robject.Key;
                            int fkObjectId = rparent.Key;

                            if (m_lstObjects.ContainsKey(objectId))
                            {
                                m_lstObjects[objectId].m_PTable.m_listFkTables.Add(fkObjectId);
                            }
                            return true;
                        }
                        catch (Exception ex)
                        {
                            log.Error(ex.Message);
                        }
                        return false;
            */
        }
    }
}
