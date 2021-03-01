using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FishTracker
{
    static public class DistanceAlgorithm
    {
        const double PIx = 3.141592653589793;
        const double RADIUS = 6378.16;

        /// <summary>
        /// Convert degrees to Radians
        /// </summary>
        /// <param name="x">Degrees</param>
        /// <returns>The equivalent in radians</returns>
        public static double DegreeToRadian(double? angle)
        {
            return (double)angle * PIx / 180;
        }
        public static int MapSize(double length)
        {
            double[] lengths = new double[] { 70.0, 50.0, 20.0, 10.0, 5.0, 2.0, 1.0, 0.5, 0.2, 0.1, 0.05, 0.02 };
            int[] sizes = new int[] { 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 };

            int size = 5;
            int index = 0;
            foreach (var iter in lengths)
            {
                if (iter < length)
                {
                    size = sizes[index];
                    break;
                }
                index++;
            }
            return size - 2;
        }
        public static string GetMapImageAddress(double? xlat, double? xlon, double? ylat, double? ylon, List<Tuple<float, float, string>> Points)
        {
            if (xlat == null || xlon == null || ylat == null || ylon == null)
            {
                return null;
            }
            string apiKey = "AIzaSyBkCcQ6id-ksCLMuWLgirojcf7MIA1RTAY"; 
            string googleLink = "maps.googleapis.com/maps/api/staticmap";
            string sourceMarker = String.Format("markers=color:{2}%7Clabel:S%7C{0},{1}", xlat, xlon, "blue");
            string mouthMarker = String.Format("markers=color:{2}%7Clabel:M%7C{0},{1}", ylat, ylon, "black");

            string pnts = "";
            if(Points != null)
            {
                foreach(var item in Points)
                {
                    pnts += String.Format("&markers=size:tiny%7Ccolor:0x00ffff%7Clabel:M%7C{0},{1}", item.Item1, item.Item2);
                }
            }
            double? clat = null, clon = null;

            if (!GetMidPoint(xlat-0.1, xlon-0.1, ylat+0.1, ylon+0.1, ref clat, ref clon))
            {
                return null;
            }
            double lenBetweenPoints = DistanceAlgorithm.DistanceBetweenPlaces(xlat, xlon, ylat, ylon);

            int size = DistanceAlgorithm.MapSize(lenBetweenPoints);

            string result = String.Format("https://{1}?center={2},{3}&zoom={7}&size=381x305&maptype=hybrid&{4}&{5}{6}&key={0}"
                , apiKey, googleLink, clat, clon, sourceMarker, mouthMarker, pnts, size);

            return result;
        }
        static private bool GetMidPoint(double? xlat, double? xlon, double? ylat, double? ylon, ref double? clat, ref double? clon)
        {
            clat = null; clon = null;

            double dLon = DegreeToRadian(ylon - xlon);
            double Bx = Math.Cos(DegreeToRadian(ylat)) * Math.Cos(dLon);
            double By = Math.Cos(DegreeToRadian(ylat)) * Math.Sin(dLon);

            clat = RadiansToDegrees(Math.Atan2(
                         Math.Sin(DegreeToRadian(xlat)) + Math.Sin(DegreeToRadian(ylat)),
                         Math.Sqrt(
                             (Math.Cos(DegreeToRadian(xlat)) + Bx) *
                             (Math.Cos(DegreeToRadian(xlat)) + Bx) + By * By)));

            clon = xlon + RadiansToDegrees(Math.Atan2(By, Math.Cos(DegreeToRadian(xlat)) + Bx));

            return true;
        }
        public static double RadiansToDegrees(double radians)
        {
            return radians * 57.295779513082323d;
        }
        /// <summary>
        /// Calculate the distance between two places.
        /// </summary>
        /// <param name="lon1"></param>
        /// <param name="lat1"></param>
        /// <param name="lon2"></param>
        /// <param name="lat2"></param>
        /// <returns></returns>
        public static double DistanceBetweenPlaces(
            double? lon1,
            double? lat1,
            double? lon2,
            double? lat2)
        {
            double dlon = DegreeToRadian(lon2 - lon1);
            double dlat = DegreeToRadian(lat2 - lat1);

            double a = (Math.Sin(dlat / 2) * Math.Sin(dlat / 2)) + Math.Cos(DegreeToRadian(lat1)) * Math.Cos(DegreeToRadian(lat2)) * (Math.Sin(dlon / 2) * Math.Sin(dlon / 2));
            double angle = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
            return angle * RADIUS;
        }
    }

}