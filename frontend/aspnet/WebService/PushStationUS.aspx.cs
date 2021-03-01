using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

namespace FishTracker.WebService
{

    public partial class PushStationUS : DbLayer
    {
        string m_state, m_mli;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                m_mli = Request.QueryString["mli"];   // "05RC001"; 
                m_state = Request.QueryString["state"];   // "ON"; 

                if (System.Diagnostics.Debugger.IsAttached)
                {
                    m_mli = "08313000";
                    m_state = "NY";
                }
                LabelMLI.Text = m_mli;
                LabelState.Text = m_state;
            }
            catch (Exception )
            {
                Label1.Text = "Bad input parameters";
                return;
            }
            if( string.IsNullOrEmpty(m_mli) || string.IsNullOrEmpty(m_state) )
            {
                Label1.Text = "Bad input parameters 2";
                return;
            }
            string fn_name = "WebService->Page_Load";
            String msg = "";
            try
            {
                // download data  WebClient  DownloadData
                string xmldoc = GetXmlUSWaterServer(m_state, m_mli, ref msg);

                XmlDocument document = new XmlDocument();

                // Load the XmlDocument with the XML.
                document.LoadXml(xmldoc);

                XmlNodeList dlst = document.SelectNodes("./timeSeriesResponse/timeSeries");

                if( null == dlst )
                {
                    return;
                }
                foreach (XmlNode node in dlst)
                {
                    XmlNode prepare = node.SelectFirstChild("variable/variableName");

                    string fullname = prepare.GetInnerText();

                    if( String.IsNullOrEmpty(fullname))
                    {
                        continue;
                    }
                    string[] lstNames = fullname.Split(',');
                    string name = lstNames[0];
                    string unit = null;

                    if (lstNames.Length > 1)
                    {
                        unit = lstNames[1].Replace("&#179;", "^3");  // "Streamflow, ft&#179;/s"
                    }
                    XmlNodeList datalst = prepare.ParentNode.ParentNode.SelectNodes("values/value");

                    if( null == datalst )
                    {
                        continue;
                    }
                    var data = new Dictionary<DateTime, string>();

                    foreach (XmlNode nodedata in datalst)
                    {
                        string sdate = nodedata.Attributes["dateTime"].Value;

                        DateTime dt;

                        if (DateTime.TryParse(sdate, out dt))
                        {
                            data[dt.Date] = nodedata.GetInnerText();
                        }
                    }
                    string newxml = String.Format("<root>");
                    foreach(var item in data)
                    {
                        newxml += String.Format("<a d={2}{0}{2} v={2}{1}{2} />", item.Key.ToString("yyyy-MM-dd"), item.Value, '"');
                    }
                    newxml += "</root>";

                    // EXEC sp_push_us_water_data '08313000', 'NY', 'Streamflow', 'ft^2/s', @data

                    var param = new List<Tuple<string, SqlDbType, dynamic>>();
                    param.Add(Tuple.Create<string, SqlDbType, dynamic>("mli", SqlDbType.VarChar, m_mli));
                    param.Add(Tuple.Create<string, SqlDbType, dynamic>("state", SqlDbType.VarChar, m_state));
                    param.Add(Tuple.Create<string, SqlDbType, dynamic>("name", SqlDbType.NVarChar, name));
                    param.Add(Tuple.Create<string, SqlDbType, dynamic>("unit", SqlDbType.VarChar, unit));
                    param.Add(Tuple.Create<string, SqlDbType, dynamic>("xmldoc", SqlDbType.Xml, newxml));

                    int? rs5 = m_dbObject.ExecSP("dbo.sp_push_us_water_data", param, fn_name);
                }
            }
            catch (Exception ex)
            {
                Label5.Text = fn_name;
                Label6.Text = ex.Message;
            }
        }
        /****
         * https://waterservices.usgs.gov/nwis/iv/?sites=08313000&period=P1D&format=waterml
         */
        protected string GetXmlUSWaterServer(String state, String mli, ref String msg)
        {
            try
            {
                // download data  WebClient  DownloadData
                string url = String.Format(@"https://waterservices.usgs.gov/nwis/iv/?sites={0}&period=P3D&format=waterml", mli);  // ON_02AB006_hourly_hydrometric.csv
                //string file = System.IO.Path.GetFileName(url);

                ServicePointManager.Expect100Continue = true;
                ServicePointManager.DefaultConnectionLimit = 9999;
                ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072 | SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls;

                using (WebClient cln = new WebClient())
                {
                    cln.Headers.Add("User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:48.0) Gecko/20100101 Firefox/48.0");
                    cln.Encoding = UTF8Encoding.UTF8;

                    byte[] data = cln.DownloadData(url);

                    string str = System.Text.UTF8Encoding.UTF8.GetString(data);
                    str = str.Replace("ns1:", "").Replace("ns2:", "");

                    return DecorateXMLStructure(str);
//                    System.IO.File.WriteAllText(@"k:\temp\path.xml", txt);
                }
            }
            catch (Exception ex)
            {
                msg = String.Format("GetDataFromCAWaterServer: [{0}] - {1} = {2} ", state, mli, ex.Message);
                Label1.Text = ex.Message;
            }
            Label3.Text = "No Data 2";
            return null ;
        }
        protected static string DecorateXMLStructure(string xml)
        {
            try
            {
                using (MemoryStream mStream = new MemoryStream())
                {
                    using (XmlTextWriter writer = new XmlTextWriter(mStream, Encoding.Unicode))
                    {
                        XmlDocument document = new XmlDocument();

                        // Load the XmlDocument with the XML.
                        document.LoadXml(xml);

                        writer.Formatting = Formatting.Indented;

                        // Write the XML into a formatting XmlTextWriter
                        document.WriteContentTo(writer);
                        writer.Flush();
                        mStream.Flush();

                        // Have to rewind the MemoryStream in order to read
                        // its contents.
                        mStream.Position = 0;

                        // Read MemoryStream contents into a StreamReader.
                        StreamReader sReader = new StreamReader(mStream);

                        // Extract the text from the StreamReader.
                        string formattedXml = sReader.ReadToEnd();

                        return formattedXml;
                    }
                }
            }
            catch (XmlException)
            {
                // Handle the exception
            }
            return "";
        }
        /// <summary>
        /// return time as HHmm
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        static public int ConvertTime(DateTime data)
        {
            TimeSpan value = data.TimeOfDay;
            return value.Hours * 100 + value.Minutes;
        }
    }
}