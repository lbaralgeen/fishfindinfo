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

namespace FishTracker.Resources
{
    public class RPlace
    {
        static string fldName = "id,name,country,state,district,region,municipality,county,city,elevation,zone,lat,lon,location,description";
        public Guid lake_id;
        public string name;
        public string country;
        public string state;
        public string district;
        public string region;
        public string municipality;
        public string county;
        public string city;
        public int? elevation, zone;
        public double? lat, lon;
        public string location;
        public string description;
        private DbLayer db;
        public string slat, slon;

        public RPlace(DbLayer l_db)
        {
            this.db = l_db;
        }
        /// <summary>
        /// read dataset for source or mouth - based on prefix
        /// </summary>
        /// <param name="prefix"></param>
        /// <param name="dr"></param>
        /// <returns></returns>
        public bool ReadPlace(string prefix, SqlDataReader dr)
        {
            string[] fields = fldName.Split(',');

            for (int i = 0; i < fields.Length - 1; i++)
            {
                fields[i] = prefix + "_" + fields[i];
            }
            int index = 0;
            string sguid = db.GetRecordString(dr, fields[index++]);

            if (!String.IsNullOrEmpty(sguid))
            {
                lake_id = Guid.Parse(sguid);
            }
            name = db.GetRecordString(dr, fields[index++]);
            country = db.GetRecordString(dr, fields[index++]);
            state = db.GetRecordString(dr, fields[index++]);
            district = db.GetRecordString(dr, fields[index++]);
            region = db.GetRecordString(dr, fields[index++]);
            municipality = db.GetRecordString(dr, fields[index++]);
            county = db.GetRecordString(dr, fields[index++]);
            city = db.GetRecordString(dr, fields[index++]);
            elevation = db.GetRecordInt(dr, fields[index++]);
            zone = db.GetRecordInt(dr, fields[index++]);
            lat = db.GetRecordFloat(dr, fields[index++]);
            lon = db.GetRecordFloat(dr, fields[index++]);
            location = db.GetRecordString(dr, fields[index++]);
            description = db.GetRecordString(dr, fields[index++]);
            slat = db.GetRecordLatLon(dr, prefix + "_" + "lat");
            slon = db.GetRecordLatLon(dr, prefix + "_" + "lon");

            if (!String.IsNullOrEmpty(district) && 0 == String.Compare(district, location, true))
            {
                district = null;
            }
            return true;
        }
    };
    public partial class ResDbLayer : DbLayer
    {
        protected bool SetMenu(string riverId, Dictionary<string, HyperLink> links)
        {
            if (String.IsNullOrEmpty(riverId))
            {
                return false;
            }
            SetEnabled(links, "Edit", m_IsAdmin);
            SetEnabled(links, "Fishing", m_IsAdmin);
            SetEnabled(links, "Regulations", m_IsAdmin);
            SetEnabled(links, "Weather", m_IsAdmin);

            if (m_IsAdmin)
            {
                SetUrl(links, "Fishing", "Resources", "wfRiverViewFishing", riverId);
                SetUrl(links, "Regulations", "Resources", "wfRiverViewRegulations", riverId);
                SetUrl(links, "Weather", "Resources", "wfRiverViewWeather", riverId);
                SetUrl(links, "Edit", "Editor", "LakeEditor", riverId);
            }
            return true;
        }
        private bool SetUrl(Dictionary<string, HyperLink> dic, string key, string path, string page, string id)
        {
            if (dic == null || dic.Count == 0 || String.IsNullOrEmpty(key) || String.IsNullOrEmpty(path) || String.IsNullOrEmpty(page) || String.IsNullOrEmpty(id))
            {
                return false;
            }
            if (dic.ContainsKey(key))
            {
                dic[key].NavigateUrl = String.Format("~/{2}/{0}.aspx?LakeId={1}", page, id, path);
            }
            return true;
        }
        private bool SetEnabled(Dictionary<string, HyperLink> dic, string key, bool state)
        {
            if (dic == null || dic.Count == 0 || String.IsNullOrEmpty(key))
            {
                return false;
            }
            if (dic.ContainsKey(key))
            {
                dic[key].Enabled = state;
            }
            return true;
        }
        /// <summary>
        /// remove description duplicats. for example: source and mouth have the same city
        /// </summary>
        /// <param name="source"></param>
        /// <param name="mouth"></param>
        /// <param name="result"></param>
        /// <returns></returns>
        private string PackDescription(ref string source, ref string mouth, string result)
        {
            if (source == null || mouth == null)
            {
                return null;
            }
            if (source.Equals(mouth) && !String.IsNullOrEmpty(source))
            {
                if (String.IsNullOrEmpty(result))
                {
                    result = source;
                }
                result += ",  " + source;
                source = null;
                mouth = null;
            }
            return result;
        }
        /// <summary>
        /// remove from source/mouth duplicates
        /// </summary>
        /// <returns></returns>
        public string MakeLakeGeneralDescription(RPlace source, RPlace mouth, out string twitName)
        {
            twitName = null;

            if (source == null || mouth == null)
            {
                return null;
            }
            string result = null;

            if (source.country.Equals(mouth.country))
            {
                result = (source.country == "CA" ? "Canada" : "USA");
                source.country = null;
                mouth.country = null;
            }
            if (!String.IsNullOrEmpty(result))
            {
                twitName += " ," + result;
            }
            result = PackDescription(ref source.state, ref mouth.state, result);
            result = PackDescription(ref source.district, ref mouth.district, result);
            result = PackDescription(ref source.region, ref mouth.region, result);
            result = PackDescription(ref source.municipality, ref mouth.municipality, result);
            result = PackDescription(ref source.county, ref mouth.county, result);

            return PackDescription(ref source.city, ref mouth.city, result);
        }

    }
}