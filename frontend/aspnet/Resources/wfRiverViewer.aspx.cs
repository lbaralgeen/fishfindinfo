using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;

namespace FishTracker.Resources
{
    public partial class wfRiverViewer : ResDbLayer
    {
        private int m_river = 2;
        private RPlace m_placeSource;
        private RPlace m_placeMouth;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }
            try
            {
                try { m_postal = Request.QueryString["Postal"]; } catch (Exception) { }
                try { HiddenCountry.Value = Request.QueryString["Country"]; } catch (Exception) { HiddenCountry.Value = "CA"; }
                try { HiddenState.Value = Request.QueryString["State"]; } catch (Exception) { }

                string riverId = GetArgGuid("LakeId", "lake_id", "lake", "stamp").ToString();

                hdLakeGuid.Value = riverId;

                var links = new Dictionary<string, HyperLink>
            {
                   {"Edit", HyperLinkEdit }
                ,  {"Fishing", hlinkFishing }
//                ,  {"Regulations", hlinkRegulations }
//                ,  {"Weather", hlinkWeather }
            };
                HiddenLinkPage.Value = "wfRiverViewer.aspx?LakeId=" + riverId;

                SetMenu(riverId, links);

                //            pholderMonitoring.Visible = !m_IsTrial;

                if (System.Diagnostics.Debugger.IsAttached && string.IsNullOrEmpty(riverId))
                {
                    riverId = "0c5e1097-849c-20c3-04f0-7bdd1e0a5ee5"; // "666A39DA-BA2A-11D8-92E2-080020A0F4C9"; //  
                }
                string title = string.Empty;
                string description = string.Empty;
                List<string> keywords = new List<string>();

                if (LoadRiver(riverId, out title, out description, out keywords))
                {
                    float? lat = float.TryParse(sourceLat.Value, out float latval) ? (float?)latval : null;
                    float? lon = float.TryParse(sourceLon.Value, out float lonval) ? (float?)lonval : null;

                    SetMetaTags(title, description, lat, lon, keywords);
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Resources.Page_Load");
            }
        }
        protected bool SetMetaTags(string title, string description, float? lat, float? lon, List<string> keywords)
        {
            // add meta tags
            Page.Title = title;

            if (!String.IsNullOrEmpty(description))
            {
                HtmlMeta tag = new HtmlMeta();
                tag.Name = "description";
                tag.Content = description;
                Header.Controls.Add(tag);
            }
            if ( lat != null && lon != null && lat > 0 && lon < 0)
            {
                HtmlMeta tag = new HtmlMeta();
                tag.Name = "ICBM";
                tag.Content = String.Format("{0} {1}", lat, lon);
                Header.Controls.Add(tag);
            }
            if (keywords != null && keywords.Count > 0)
            {
                HtmlMeta tag = new HtmlMeta();
                tag.Name = "keywords";
                tag.Content = (string.Join(", ", keywords.Select(x => x.ToString()).ToArray()));
                Header.Controls.Add(tag);
            }
            return true;
        }

        private void LoadRiverSource( RPlace place )
        {
            try
            {
                string displayed_source_name = String.IsNullOrEmpty(place.name) ? place.location : place.name;
                string src_link = String.Format("<a href=\"wfRiverViewer.aspx?LakeId={0}\">{1}</a>", place.lake_id, displayed_source_name);
                SourceLakeName.Value = place.lake_id == Guid.Empty ? displayed_source_name : src_link;

                if (!String.IsNullOrEmpty(place.slat) && !String.IsNullOrEmpty(place.slon))
                {
                    if (double.TryParse(place.slat, out double lat) && double.TryParse(place.slon, out double lon))
                    {
                        sourceLat.Value = place.lat.ToString();
                        sourceLon.Value = place.lon.ToString();

                        LabelSourceLat.Visible = true;
                        LabelSourceLon.Visible = true;
                        pinXLat.Value = place.lat.ToString();
                        pinXLon.Value = place.lon.ToString();

                        if (LabelSourceLat.Visible && LabelSourceLon.Visible)
                        {
                            string link = String.Format("https://www.google.com/maps/@{0},{1},14z", place.lat, place.lon);
                            HiddenSourceLink.Value = "<a href=\"" + link + "\" target=\"_blank\"><img src=\"/Images/link.png\"/></a>";
                        }
                    }
                    else
                    {
                        LabelSourceLat.Visible = false;
                        LabelSourceLon.Visible = false;
                    }
                }
                if (null != place.elevation)
                {
                    SourceElevation.Value = String.Format("<tr><td>Elevation:</td><td>{0}</td><td>[m]</td></tr>", place.elevation);
                }
                if (null != place.zone)
                {
                    HiddenSourceLocation.Value = String.Format("<tr><td>Zone:</td><td>{0}</td><td></td></tr>", place.zone);
                }
                if (!String.IsNullOrEmpty(place.location))
                {
                    HiddenSourceLocation.Value = String.Format("<tr><td>Location:</td><td>{0}</td><td></td></tr>", place.location);
                }
                string country = "", state = "", county = "", city = "", district = "", region = "", municipality = "";

                if (!String.IsNullOrEmpty(place.country) || !String.IsNullOrEmpty(place.city)
                    || !String.IsNullOrEmpty(place.county) || !String.IsNullOrEmpty(place.state) || !String.IsNullOrEmpty(place.district))
                {
                    if (!String.IsNullOrEmpty(place.country))
                    {
                        country = String.Format("<tr><td>Country:</td><td>{0}</td></tr>", place.country);
                    }
                    if (!String.IsNullOrEmpty(place.state))
                    {
                        state = String.Format("<tr><td>State:</td><td>{0}</td></tr>", place.state);
                    }
                    if (!String.IsNullOrEmpty(place.county))
                    {
                        county = String.Format("<tr><td>County:</td><td>{0}</td></tr>", place.county);
                    }
                    if (!String.IsNullOrEmpty(place.city))
                    {
                        city = String.Format("<tr><td>City:</td><td>{0}</td></tr>", place.city);
                    }
                    if (!String.IsNullOrEmpty(place.district))
                    {
                        district = String.Format("<tr><td>District:</td><td>{0}</td></tr>", place.district);
                    }
                    if (!String.IsNullOrEmpty(place.region))
                    {
                        region = String.Format("<tr><td>Region:</td><td>{0}</td></tr>", place.region);
                    }
                    if (!String.IsNullOrEmpty(place.municipality))
                    {
                        municipality = String.Format("<tr><td>Municipality:</td><td>{0}</td></tr>", place.municipality);
                    }
                    HiddenLakeSource.Value = String.Format("<table>{0}{1}{2}{3}{4}{5}{6}</table>", country, state, county, city, district, region, municipality);
                }
                else
                {
                    if (!LabelSourceLat.Visible && !LabelSourceLon.Visible && String.IsNullOrEmpty(place.name))
                    {
                        phSource.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Resources.LoadRiverSource");
            }
        }
        private void LoadRiverMouth( RPlace place )
        {
            try
            {
                MouthLakeName.Value = String.Format("<a href=\"wfRiverViewer.aspx?LakeId={0}\">{1}</a>", place.lake_id, place.name);

                if (!String.IsNullOrEmpty(place.slat) && !String.IsNullOrEmpty(place.slat))
                {
                    if (double.TryParse(place.slat, out double lat) && double.TryParse(place.slon, out double lon))
                    {
                        mouthLat.Value = place.lat.ToString();
                        mouthLon.Value = place.lon.ToString();
                        pinYLat.Value = place.lat.ToString();
                        pinYLon.Value = place.lon.ToString();

                        LabelMouthLat.Visible = true;
                        LabelMouthLon.Visible = true;

                        if (LabelMouthLat.Visible && LabelMouthLon.Visible)
                        {
                            string link = String.Format("https://www.google.com/maps/@{0},{1},14z", place.lat, place.lon);
                            HiddenMouthLink.Value = "<a href=\"" + link + "\" target=\"_blank\"><img src=\"/Images/link.png\"/></a>";
                        }
                    }
                    else
                    {
                        LabelMouthLat.Visible = false;
                        LabelMouthLon.Visible = false;
                    }
                }
                if (place.elevation != null)
                {
                    MouthElevation.Value = String.Format("<tr><td>Elevation:</td><td>{0}</td><td>[m]</td></tr>", place.elevation);
                }
                if (null != place.zone)
                {
                    MouthZone.Value = String.Format("<tr><td>Zone:</td><td>{0}</td><td></td></tr>", place.zone);
                }
                if (!String.IsNullOrEmpty(place.location))
                {
                    HiddenMouthLocation.Value = String.Format("<tr><td>Location:</td><td>{0}</td><td></td></tr>", place.location);
                }
                string mouth_country = "";
                string mouth_state = "";
                string mouth_county = "";
                string mouth_city = "";
                string mouth_district = "";
                string mouth_region = "";
                string mouth_municipality = "";

                if (!String.IsNullOrEmpty(place.country) || !String.IsNullOrEmpty(place.city)
                    || !String.IsNullOrEmpty(place.county) || !String.IsNullOrEmpty(place.state) || !String.IsNullOrEmpty(place.district))
                {
                    if (!String.IsNullOrEmpty(place.country))
                    {
                        mouth_country = String.Format("<tr><td>Country:</td><td>{0}</td></tr>", place.country);
                    }
                    if (!String.IsNullOrEmpty(place.state))
                    {
                        mouth_state = String.Format("<tr><td>State:</td><td>{0}</td></tr>", place.state);
                    }
                    if (!String.IsNullOrEmpty(place.county))
                    {
                        mouth_county = String.Format("<tr><td>County:</td><td>{0}</td></tr>", place.county);
                    }
                    if (!String.IsNullOrEmpty(place.city))
                    {
                        mouth_city = String.Format("<tr><td>City:</td><td>{0}</td></tr>", place.city);
                    }
                    if (!String.IsNullOrEmpty(place.district))
                    {
                        mouth_district = String.Format("<tr><td>District:</td><td>{0}</td></tr>", place.district);
                    }
                    if (!String.IsNullOrEmpty(place.region))
                    {
                        mouth_region = String.Format("<tr><td>Region:</td><td>{0}</td></tr>", place.region);
                    }
                    if (!String.IsNullOrEmpty(place.municipality))
                    {
                        mouth_municipality = String.Format("<tr><td>Municipality:</td><td>{0}</td></tr>", place.municipality);
                    }
                    HiddenLakeMouth.Value = String.Format("<table>{0}{1}{2}{3}{4}{5}{6}</table>"
                                           , mouth_country, mouth_state, mouth_county, mouth_city, mouth_district, mouth_region, mouth_municipality);
                }
                else
                {
                    if (!LabelMouthLat.Visible && !LabelMouthLon.Visible && String.IsNullOrEmpty(place.name))
                    {
                        phMouth.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Resources.LoadRiverMouth");
            }
        }
        private bool LoadRiver( string sRiverGuid, out string river_name, out string meta_description, out List<string> keywords)
        {
            river_name = string.Empty;
            meta_description = string.Empty;
            keywords = new List<string>();

            if (String.IsNullOrEmpty(sRiverGuid))
            {
                return false;
            }
            try
            {
                Guid id_river = Guid.Parse(sRiverGuid);

                XmlDocument xmldoc = m_dbObject.GetXmlDoc("SELECT doc FROM dbo.fn_lake_view_info(@param0)", SqlDbType.UniqueIdentifier, id_river, WhatsMyName());

                if (xmldoc == null)
                {
                    return false;
                }
                XmlNode rootData = xmldoc.DocumentElement;
                XmlNode lakeNode = rootData.SelectSingleNode("lake");
                XmlNode scienceNode = rootData.SelectSingleNode("science");
                XmlNode fishspotNode = rootData.SelectSingleNode("fishspot");

                if ( scienceNode!= null)
                {
                    scienceNode = scienceNode.SelectSingleNode("science");
                }
                XmlNodeList fish_spots = null;

                if (fishspotNode != null)
                {
                    fish_spots = fishspotNode.SelectChildren("fishspot");
                }
                string lake_id = lakeNode.GetAttr("lake_id");

                if (Int32.TryParse(lakeNode.GetAttr("locType"), out int locType))
                {
                    m_river = locType;
                    keywords.Add(lakeNode.GetAttr("type"));
                }
                XmlNode lakeNodeNode = rootData.SelectSingleNode("node[@name='lake_name']");

                if (null != lakeNodeNode)
                {
                    riverName.Value = lakeNodeNode.InnerText;
                }
                XmlNode lakeAltNodeNode = rootData.SelectSingleNode("node[@name='alt_name']");

                if (null != lakeAltNodeNode)
                {
                    HiddenAltRiverName.Value = lakeAltNodeNode.InnerText;
                }
                if (String.Equals(riverName.Value, HiddenAltRiverName.Value, StringComparison.InvariantCulture))
                {
                    HiddenAltRiverName.Value = null;
                }
                XmlNode lakeNativeNodeNode = rootData.SelectSingleNode("node[@name='native_name']");

                if (null != lakeNativeNodeNode)
                {
                    HiddenAltRiverName.Value = lakeNativeNodeNode.InnerText;
                }
                if (String.Equals(riverName.Value, HiddenNativeRiverName.Value, StringComparison.InvariantCulture))
                {
                    HiddenNativeRiverName.Value = null;
                }
                if (String.Equals(HiddenAltRiverName.Value, HiddenNativeRiverName.Value, StringComparison.InvariantCulture))
                {
                    HiddenNativeRiverName.Value = null;
                }
                HiddenNativeRiverName.Value = String.IsNullOrEmpty(HiddenNativeRiverName.Value) ? "" : ("<i>{" + HiddenNativeRiverName.Value + "}</i>");

                XmlNode lakeLinkNode = rootData.SelectSingleNode("node[@name='link']");

                if (null != lakeLinkNode)
                {
                    HiddenLink.Value = lakeLinkNode.InnerText;
                }
                string CGNDB = lakeNode.GetAttr("CGNDB");

                if (!String.IsNullOrEmpty(CGNDB))
                {
                    keywords.Add(CGNDB);
                }
                if(lakeNode != null )
                {  // label lastriver change
                    string stampRiverView = lakeNode.GetAttr("stamp");
                    LabelViewRiver.Visible = !String.IsNullOrEmpty(stampRiverView);
                    RiverLastChange.Value = "";

                    if (LabelViewRiver.Visible && stampRiverView.Length >= 10)
                    {
                        RiverLastChange.Value = stampRiverView.Substring(0, 10);
                    }
                }
                if (scienceNode != null)
                {  // label water river change
                    string stampRiverView = scienceNode.GetAttr("dt");
                    LabelWaterRiver.Visible = !String.IsNullOrEmpty(stampRiverView);
                    RiverWaterLastChange.Value = "";

                    if (RiverWaterLastChange.Visible && stampRiverView.Length >= 10)
                    {
                        RiverWaterLastChange.Value = stampRiverView.Substring(0, 10);
                    }
                    else
                    {
                        LabelWaterRiver.Visible = false;
                    }
                }
                string twitName = riverName.Value;

                if (!String.IsNullOrEmpty(HiddenAltRiverName.Value))
                {
                    twitName += "(" + HiddenAltRiverName.Value + ") ";
                }
                string linkCGNDB = "http://www4.rncan.gc.ca/search-place-names/unique/"
                    + (String.IsNullOrEmpty(CGNDB) ? "unique?id=" + lake_id.Replace("-", String.Empty) : CGNDB);

                if (!String.IsNullOrEmpty(HiddenLink.Value))
                {
                    HiddenLakeName.Value = String.Format("<a href=\"{1}\">{0}</a>", riverName.Value, HiddenLink.Value);
                }
                else
                {
                    if (!String.IsNullOrEmpty(linkCGNDB))
                    {
                        HiddenLakeName.Value = String.Format("<a href=\"{1}\">{0}</a>", riverName.Value, linkCGNDB);
                    }
                }
                XmlNode locationNode = rootData.SelectSingleNode("node[@name='location']");

                if (null != locationNode)
                {
                    location.Value = locationNode.InnerText;
                }
                string volume = lakeNode.GetAttr("volume");
                string shoreline = lakeNode.GetAttr("shoreline");
                string length = lakeNode.GetAttr("length");
                string depth = lakeNode.GetAttr("depth");

                string road_access = "";
                XmlNode road_accessNode = rootData.SelectSingleNode("node[@name='road_access']");

                if (null != road_accessNode)
                {
                    road_access = road_accessNode.InnerText;
                }
                if (float.TryParse(lakeNode.GetAttr("lat"), out float lat) && float.TryParse(lakeNode.GetAttr("lon"), out float lon))
                {
                    cLat.Value = lat.ToString();
                    cLon.Value = lon.ToString();
                }
                if (road_access.Contains(" District"))
                {
                    road_access = string.Empty;
                }
                if (!String.IsNullOrEmpty(volume) || !String.IsNullOrEmpty(shoreline) || !String.IsNullOrEmpty(length) || !String.IsNullOrEmpty(depth) || !String.IsNullOrEmpty(road_access))
                {
                    if (!String.IsNullOrEmpty(volume))
                    {
                        if (float.TryParse(volume, out float fvolume))
                        {
                            volume = String.Format("<tr><td>Volume:</td><td>{0}</td><td>[km^3]</td></tr>", fvolume);
                        }
                    }
                    if (!String.IsNullOrEmpty(shoreline))
                    {
                        shoreline = String.Format("<tr><td>Shoreline:</td><td>{0}</td><td>[km]</td></tr>", shoreline);
                    }
                    if (!String.IsNullOrEmpty(length))
                    {
                        length = String.Format("<tr><td>Length:</td><td>{0}</td><td>[km]</td></tr>", length);
                    }
                    if (!String.IsNullOrEmpty(depth))
                    {
                        depth = String.Format("<tr><td>Depth:</td><td>{0}</td><td>[m]</td></tr>", depth);
                    }
                    if (!String.IsNullOrEmpty(road_access))
                    {
                        road_access = String.Format("<tr><td>Road Access:</td><td>{0}</td><td>&nbsp;</td></tr>", road_access);
                    }
                    HiddenLake1.Value = String.Format("<table>{0}{1}{2}{3}{4}</table>", volume, shoreline, length, depth, road_access);
                }

                string discharge = lakeNode.GetAttr("Discharge");
                string drainage = lakeNode.GetAttr("Drainage");
                string surface = lakeNode.GetAttr("surface");
                string width = lakeNode.GetAttr("width");

                if (!String.IsNullOrEmpty(discharge) || !String.IsNullOrEmpty(shoreline) || !String.IsNullOrEmpty(length) || !String.IsNullOrEmpty(width))
                {
                    if (!String.IsNullOrEmpty(discharge))
                    {
                        discharge = String.Format("<tr><td>Discharge:</td><td>{0}</td><td>[m^3]</td></tr>", discharge);
                    }
                    if (!String.IsNullOrEmpty(drainage))
                    {
                        drainage = String.Format("<tr><td>Drainage:</td><td>{0}</td><td>[km^2]</td></tr>", drainage);
                    }
                    if (!String.IsNullOrEmpty(surface))
                    {
                        surface = String.Format("<tr><td>Surface:</td><td>{0}</td><td>[km^2]</td></tr>", surface);
                    }
                    if (!String.IsNullOrEmpty(width))
                    {
                        width = String.Format("<tr><td>Length:</td><td>{0}</td><td>[km]</td></tr>", width);
                    }
                    HiddenLake2.Value = String.Format("<table>{0}{1}{2}</table>", discharge, drainage, surface, width);
                }
                var Points = new List<Tuple<float, float, string>>();

                if (null != fish_spots)
                {
                    foreach (XmlNode spot in fish_spots)
                    {
                        try
                        {
                            float flat = (float)Convert.ToDouble(spot.GetAttr("spot_lat"));
                            float flon = (float)Convert.ToDouble(spot.GetAttr("spot_lon"));

                            if (flat > m_placeSource.lat && flat < m_placeMouth.lat
                                && flon > m_placeSource.lon && flon < m_placeMouth.lon)
                            {
                                Points.Add(Tuple.Create(flat, flon, "yellow"));
                            }
                        }
                        catch (Exception) { }
                    }
                }
                m_placeSource = new RPlace(this);
                m_placeMouth = new RPlace(this);


                // load station data
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.vw_lake WHERE @lake_id = lake_id", m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lake_id", SqlDbType.UniqueIdentifier).Value = Guid.Parse(sRiverGuid);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {

                        m_placeSource.ReadPlace("source", dr);
                        m_placeMouth.ReadPlace("mouth", dr);

                        HiddenMapImage.Value = DistanceAlgorithm.GetMapImageAddress(m_placeSource.lat
                                             , m_placeSource.lon, m_placeMouth.lat, m_placeMouth.lon, Points);

                        PlaceHolderMap.Visible = m_placeSource.lat != null && m_placeSource.lon != null && m_placeMouth.lat != null && m_placeMouth.lon != null; // disble map if there is not coordinates


                        string ph = GetRecordString(dr, "ph");
                        twitName = riverName.Value;

                        LakeAGRLocation.Value = MakeLakeGeneralDescription(m_placeSource, m_placeMouth, out twitName);

                        if ((m_river == 1 || m_river == 8 || m_river == 8192)
                            && (m_placeSource.elevation != null || m_placeMouth.elevation != null))
                        {
                            HiddenLake2.Value += " Elevation: " + (m_placeSource.elevation == null ? m_placeMouth.elevation : m_placeSource.elevation) + " [m]";
                            m_placeSource.elevation = null;
                            m_placeMouth.elevation = null;
                        }
                        // -----------------------------------------------------------------------------------------------------------------------
                        LoadRiverSource( m_placeSource );  // pass data from database to interface
                        // -----------------------------------------------------------------------------------------------------------------------
                        LoadRiverMouth( m_placeMouth );    // pass data from database to interface


                        // prepare lake picture
                        string image_source = GetRecordString(dr, "lake_image_source");
                        string image_author = GetRecordString(dr, "lake_image_author");
                        string image_link = GetRecordString(dr, "lake_image_link");
                        string image_stamp = GetRecordString(dr, "lake_image_stamp");
                        string label = null;

                        if( !String.IsNullOrEmpty(image_source) )
                        {
                            label = "(C) " + image_source;
                        }
                        if (!String.IsNullOrEmpty(image_author))
                        {
                            label = (String.IsNullOrEmpty(label) ? "(C) " : " ") + image_author;
                        }
                        if (!String.IsNullOrEmpty(image_link))
                        {
                            label = String.Format("<a href=\"{0}\">{1}</a>", image_link, label);
                        }
                        if (!String.IsNullOrEmpty(label))
                        {
                            HiddenLakeImageLabel.Value = label;
                            ImageRiver.ImageUrl = String.Format("~/Editor/HandlerImage.ashx?lake={0}", sRiverGuid);
                            ImageRiver.AlternateText = riverName.Value;
                        }
                        else
                        {
                            ImageRiver.Visible = false;
                        }
                        // -----------------------------------------------------------------------------------------------------------------------
                        string desc = ReadString(dr, "descript");

                        if (!String.IsNullOrEmpty(desc))
                        {
                            description.Value = desc.Replace("\n", "<br>");
                        }
                        if (!String.IsNullOrEmpty(desc))
                        {
                            meta_description = (desc.Length > 100 ? desc.Substring(0, 100) : desc);
                        }
                        HiddenTwitterPage.Value = "http://www.fishfind.info/Resources/" + HiddenLinkPage.Value;
                        HiddenEncodedMsg.Value = HttpUtility.UrlEncode(twitName);

                        if (!String.IsNullOrEmpty(CGNDB))
                        {
                            HiddenCGNDB.Value = String.Format("<a href=\"{0}\" target=\"_blank\">{1}</a>", linkCGNDB, CGNDB);
                        }
                    }
                    dr.Close();
                }
                HiddenTributaryL.Value = LoadTributary(Guid.Parse(sRiverGuid), 'L');
                HiddenTributaryR.Value = LoadTributary(Guid.Parse(sRiverGuid), 'R');
                PlaceHolderTributary.Visible = !String.IsNullOrEmpty(HiddenTributaryL.Value) || !String.IsNullOrEmpty(HiddenTributaryL.Value);

                HiddenRVFishL.Value = LoadFish(Guid.Parse(sRiverGuid), 'L');
                HiddenRVFishR.Value = LoadFish(Guid.Parse(sRiverGuid), 'R');
                PlaceHolderFishList.Visible = !String.IsNullOrEmpty(HiddenRVFishL.Value) || !String.IsNullOrEmpty(HiddenRVFishR.Value);


                HiddenCloseByL.Value = LoadCloseBy(Guid.Parse(sRiverGuid), 'L');
                HiddenCloseByR.Value = LoadCloseBy(Guid.Parse(sRiverGuid), 'R');
                PlaceHolderCloseBy.Visible = !String.IsNullOrEmpty(HiddenCloseByL.Value) || !String.IsNullOrEmpty(HiddenCloseByR.Value);

                HiddenNewsL.Value = LoadNews(Guid.Parse(sRiverGuid), 'L');
                HiddenNewsR.Value = LoadNews(Guid.Parse(sRiverGuid), 'R');
                PlaceHolderNews.Visible = !String.IsNullOrEmpty(HiddenNewsL.Value) || !String.IsNullOrEmpty(HiddenNewsR.Value);
                
                return true;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Resources");
            }
            return false;
        }
        protected string LoadTributary(Guid lakeid, char side)
        {
            if (lakeid == Guid.Empty)
            {
                return string.Empty;
            }
            string grid = string.Empty;
            string sqlcmd = String.Format("SELECT * FROM dbo.fn_ViewTributary(@lake) WHERE {0} = num % 2 ORDER BY lake_name ASC", side == 'L' ? 1 : 0);
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlcmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lake", SqlDbType.UniqueIdentifier).Value = lakeid;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        bool rowOdd = false;    // to set odd row having geeen background

                        while (dr.Read())
                        {
                            string lake_id = GetRecordString(dr, "lake_id");
                            string lake_name = GetRecordString(dr, "lake_name");
                            string flowside = GetRecordString(dr, "way");

                            string lat = GetRecordLatLon(dr, "lat");
                            string lon = GetRecordLatLon(dr, "lon");

                            string latlon = String.Format("<td>{0}&nbsp;{1}</td>", lat, lon);

                            string styleName = "class=\"auto-style29\"";
                            string styleType = "class=\"auto-style35\"";
                            string link = "/Resources/wfRiverViewer.aspx?LakeId";
                            string backgroundRow = rowOdd ? "style=\"background-color:#E6FFFF\"" : "";

                            string tdLeft = String.Format("<td {2}><a href=\"{3}={0}\" target=\"_blank\">{1}</a></td>"
                                    , lake_id, lake_name, styleName, link);
                            string tdright = String.Format("<td {0}>{1}</td>", styleType, flowside);

                            string line = String.Format("\t<tr {0}>{1}{2}<td>&nbsp;&nbsp;</td>{3}<td>&nbsp;&nbsp;</td></tr>\n"
                                    , backgroundRow, tdLeft, latlon, tdright);

                            grid += line;
                            rowOdd = !rowOdd;
                        }
                    }
                }
                return grid;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Resources.LoadTributary");
            }
            return string.Empty;
        }
        protected string LoadCloseBy(Guid lakeid, char side)
        {
            if (lakeid == Guid.Empty)
            {
                return string.Empty;
            }
            string grid = string.Empty;
            string sqlcmd = String.Format("SELECT * FROM dbo.fn_GetCloseLake(@lake) WHERE {0} = num % 2 ORDER BY lake_name ASC", side == 'L' ? 1 : 0);
            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlcmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lake", SqlDbType.UniqueIdentifier).Value = lakeid;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        bool rowOdd = false;    // to set odd row having geeen background

                        while (dr.Read())
                        {
                            string lake_id = GetRecordString(dr, "lake_id");
                            string lake_name = GetRecordString(dr, "lake_name");

                            string lat = GetRecordLatLon(dr, "lat");
                            string lon = GetRecordLatLon(dr, "lon");
                            int closest = (int)GetRecordInt(dr, "closest");

                            string latlon = String.Format("<td>{0}&nbsp;{1}</td>", lat, lon);

                            string styleName = "class=\"auto-style29\"";
                            string styleType = "class=\"auto-style35\"";
                            string link = "/Resources/wfRiverViewer.aspx?LakeId";
                            string backgroundRow = rowOdd ? "style=\"background-color:#E6FFFF\"" : "";

                            string tdLeft = String.Format("<td {2}><a href=\"{3}={0}\" target=\"_blank\">{1}</a></td>"
                                    , lake_id, lake_name, styleName, link);
                            string tdright = String.Format("<td {0}>{1} km</td>", styleType, closest);

                            string line = String.Format("\t<tr {0}>{1}{2}<td>&nbsp;&nbsp;</td>{3}<td>&nbsp;&nbsp;</td></tr>\n"
                                    , backgroundRow, tdLeft, latlon, tdright);

                            grid += line;
                            rowOdd = !rowOdd;
                        }
                    }
                }
                return grid;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Resources.LoadCloseBy");
            }
            return string.Empty;
        }
        protected string ProduceRVFishCurrLine(string key, string value, bool rowOdd, string style )
        {
            string tdLeft = String.Format("<td {1}>{0}</td>", key, style);

            if (!String.IsNullOrEmpty(value))
            {
                tdLeft = String.Format("<td {1}><a href=\"{2}\">{0}</a></td>", key, style, value);
            }
            return tdLeft;
        }
        protected string ProduceRVFishNextLine(string key, string value, bool rowOdd, string style)
        {
            string tdRight = String.Format("<td {0}>{1}</td>", style, key);

            if (!String.IsNullOrEmpty(value))
            {
                tdRight = String.Format("<td {0}><a href=\"{1}\">{2}</a></td>", style, value, key);
            }
            return tdRight;
        }
        protected string LoadFish(Guid lakeid, char side)
        {
            if (lakeid == Guid.Empty || !(side == 'L' || side == 'R') )
            {
                return string.Empty;
            }
            string grid = string.Empty;
            try
            {
                using (SqlCommand cmd = new SqlCommand("SELECT fish_name, link FROM dbo.fn_EditLakeFish(@lake)", m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lake", SqlDbType.UniqueIdentifier).Value = lakeid;

                    var listFish = new Dictionary<string, string>();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            string fish_name = GetRecordString(dr, "fish_name");
                            string link = GetRecordString(dr, "link");

                            listFish[fish_name] = link;
                        }
                    }
                    bool rowOdd = false;    // to set odd row having geeen background
                    var arrDic = listFish.ToArray();
                    var firstArray = arrDic.Take((arrDic.Length + 1) / 2).ToArray();
                    var secondArray = arrDic.Skip((arrDic.Length + 1) / 2).ToArray();
                    var targetArray = (side == 'L') ? firstArray : secondArray;

                    // left part of fish grid
                    for (int i = 0 ; i < targetArray.Length; i+= 2)
                    {
                        string style38 = "class=\"auto-style38\"";
                        string style37 = "class=\"auto-style37\"";

                        string tdLeft = ProduceRVFishNextLine(targetArray[i].Key, targetArray[i].Value, rowOdd, style38);
                        string tdRight = String.Format("<td {0}></td>", style38);
                        string backgroundRow = rowOdd ? "style=\"background-color:#E6FFFF\"" : "";

                        if (i + 1 < targetArray.Length)
                        {
                            tdRight = ProduceRVFishNextLine(targetArray[i + 1].Key, targetArray[i + 1].Value, rowOdd, style38);
                        }
                        string line = String.Format("\t<tr {0}>{1}<td {3}>&nbsp;&nbsp;</td>{2}</tr>\n"
                                                   , backgroundRow, tdLeft, tdRight, style37);

                        grid += line;
                        rowOdd = !rowOdd;
                    }
                }
                return grid;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Resources.LoadFish");
            }
            return string.Empty;
        }
        protected string LoadNews(Guid lakeid, char side)
        {
            if (lakeid == Guid.Empty)
            {
                return string.Empty;
            }
            string subquery = String.Format("select top 12 row_number() over (order by news_stamp desc) as num, news_id, news_title, CONVERT(varchar(10), news_stamp, 103) AS news_stamp, news_source from news where lake_id = @lake ");
            string grid = string.Empty;
            string sqlcmd = String.Format("select news_id, news_title, news_stamp, news_source from ({0})x where {1} = num % 2 order by news_stamp desc", subquery, side == 'L' ? 1 : 0);

            try
            {
                using (SqlCommand cmd = new SqlCommand(sqlcmd, m_dbObject.m_connection))
                {
                    cmd.Parameters.Add("@lake", SqlDbType.UniqueIdentifier).Value = lakeid;

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        bool rowOdd = false;    // to set odd row having geeen background

                        while (dr.Read())
                        {
                            string news_id = GetRecordString(dr, "news_id");
                            string news_title = GetRecordString(dr, "news_title");
                            string news_stamp = GetRecordString(dr, "news_stamp");
                            string news_source = GetRecordString(dr, "news_source");

                            string latlon = String.Format("<td>{0}&nbsp;</td>", news_stamp );

                            string styleName = "class=\"auto-style29\"";
                            string styleType = "class=\"auto-style35\"";
                            string link = "/news.aspx?LeadID";
                            string backgroundRow = rowOdd ? "style=\"background-color:#E6FFFF\"" : "";

                            string tdLeft = String.Format("<td {2}><a href=\"{3}={0}\" target=\"_blank\">{1}</a></td>"
                                    , news_id, news_title, styleName, link);
                            string tdright = String.Format("<td {0}>{1}  </td>", styleType, news_source);

                            string line = String.Format("\t<tr {0}>{1}{2}<td>&nbsp;&nbsp;</td>{3}<td>&nbsp;&nbsp;</td></tr>\n"
                                    , backgroundRow, tdLeft, latlon, tdright);
                            grid += line;
                            rowOdd = !rowOdd;
                        }
                    }
                }
                return grid;
            }
            catch (Exception ex)
            {
                DbEventLogger(ex, "FishTracker.Resources.LoadCloseBy");
            }
            return string.Empty;
        }

    }
}