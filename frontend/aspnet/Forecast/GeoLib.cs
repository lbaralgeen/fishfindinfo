using System;
using System.Collections.Generic;


namespace GeoSpace
{

    public class TLatLonPoint
    {
        public TLatLonPoint(double lat, double lon)
        {
            latitude = lat;
            longitude = lon;
        }
        public double latitude, longitude;
    };
    public class GeoLib
    {
      //  struct TRegion { public TLatLonPoint TopLeft, BottomRight; };

        TLatLonPoint getCenterLatLong(List<TLatLonPoint> latLongList)
        {
            double pi = Math.PI / 180;
            double xpi = 180 / Math.PI;
            double x = 0, y = 0, z = 0;

            if (latLongList.Count == 1)
            {
                return latLongList[0];
            }
            for (int i = 0; i < latLongList.Count; i++)
            {
                double latitude = latLongList[i].latitude * pi;
                double longitude = latLongList[i].longitude * pi;
                double c1 = Math.Cos(latitude);
                x = x + c1 * Math.Cos(longitude);
                y = y + c1 * Math.Sin(longitude);
                z = z + Math.Sin(latitude);
            }

            int total = latLongList.Count;
            x = x / total;
            y = y / total;
            z = z / total;

            double centralLongitude = Math.Atan2(y, x);
            double centralSquareRoot = Math.Sqrt(x * x + y * y);
            double centralLatitude = Math.Atan2(z, centralSquareRoot);

            return new GeoSpace.TLatLonPoint(centralLatitude * xpi, centralLongitude * xpi);
        }
    }
}