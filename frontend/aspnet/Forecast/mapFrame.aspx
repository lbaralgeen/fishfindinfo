<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapFrame.aspx.cs" Inherits="FishTracker.Forecast.MapFrame" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style type="text/css">
        .formatText{color:Green;font-size:11px;font-family:Arial;font-weight:bold;}

      #map {
        height: 100%;
      }

      html,
      body {
        height: 100%;
        margin: 0;
        padding: 0;
      }

      #legend {
        font-family: Arial, sans-serif;
        background: #fff;
        padding: 0px;
        margin: 0px;
        border: 1px solid #000;
            width: 173px;
        }
      #legend h3 {
        margin-top: 0;
      }
      #legend img {
        vertical-align: middle;
      }
        .auto-style1 {
            width: 89px;
        }
        .auto-style2 {
            width: 244px;
        }
        .auto-style3 {
            width: 718px;
            height: 64px;
        }
        .styleWarnReg {
            font-size:small;
            color: red;
            font-style: italic;
        }
        .auto-style4 {
            width: 740px;
        }
    </style>

    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBkCcQ6id-ksCLMuWLgirojcf7MIA1RTAY&callback=initMap&libraries=&v=weekly"
      defer
    ></script>

    <script type="text/javascript">
        "use strict";

        var map;

        function SetLegend(color, probability, counter, total)
        {
            var leftPart = '<table style="width: 182px"><tr><td class="auto-style12">';
            var div = document.createElement('div');
            var checkBox = '<input id="check_box' + color + '" type="checkbox" checked="checked"/>';
            var value = leftPart + '<img src="/Images/dot' + color + '.png"></td><td class="auto-style13">';
            if (1 < total)
                value += checkBox;
            div.innerHTML = value + '</td><td class="auto-style10">' + probability + ' Probability (' + counter + ')';
            return div;
        }
        function initMap()
        {
            var latCnt = document.getElementById('<%=mapLat.ClientID%>').value;
            var lonCnt = document.getElementById('<%=mapLon.ClientID%>').value;
            var bounds = new google.maps.LatLngBounds();

            var imageFishR = { url: '/Images/dotR.png', size: new google.maps.Size(16, 16) };
            var imageFishO = { url: '/Images/dotO.png', size: new google.maps.Size(16, 16) };
            var imageFishY = { url: '/Images/dotY.png', size: new google.maps.Size(16, 16) };
            var imageFishG = { url: '/Images/dotG.png', size: new google.maps.Size(16, 16) };
            var imageFishB = { url: '/Images/dotB.gif', size: new google.maps.Size(16, 16) };
            var imageFishSpot = { url: '/Images/spot.png', size: new google.maps.Size(16, 16) };

            const myLatLng = new google.maps.LatLng(latCnt, lonCnt);

            map = new google.maps.Map(document.getElementById("map"), { zoom: 10, center: myLatLng });

            try {

                if (null != g_locationList) {
                    var cntR = 0, cntO = 0, cntY = 0, cntG = 0, cntB = 0;  // counters for each probability
                    var total = 0;

                    for (var i = 0; i < g_locationList.length; i++) {
                        var args = g_locationList[i].split(",");  // parse for Lat/Long
                        var lon = args[1];
                        if (lon > 0) { lon = -1 * lon; }
                        var location = new google.maps.LatLng(args[0], lon);

                        if (0 < i && 1 < g_locationList.length) {
                            bounds.extend(location);
                        }
                        var station_id = 0;

                        if (2 < args.length) {
                            station_id = parseInt(args[3]);
                        }
                        var marker;
                        {
                            var pushedProbability = 10 * (parseInt(args[2]) + 1);

                            if (2 < args.length) {
                                if (0 < station_id) {
                                    if (10 >= pushedProbability) {
                                        cntR++;
                                        marker = new google.maps.Marker({ position: location, map: map, icon: imageFishR });
                                    }
                                    else if (10 < pushedProbability && pushedProbability <= 35) {
                                        cntO++;
                                        marker = new google.maps.Marker({ position: location, map: map, icon: imageFishO });
                                    }
                                    else if (35 < pushedProbability && pushedProbability <= 65) {
                                        cntY++;
                                        marker = new google.maps.Marker({ position: location, map: map, icon: imageFishY });
                                    }
                                    else if (65 < pushedProbability && pushedProbability <= 85) {
                                        cntG++;
                                        marker = new google.maps.Marker({ position: location, map: map, icon: imageFishG });
                                    }
                                    else if (85 < pushedProbability) {
                                        cntB++;
                                        marker = new google.maps.Marker({ position: location, map: map, icon: imageFishB, optimized: false });
                                    }
                                } else if (0 > station_id) {
                                    marker = new google.maps.Marker({ position: location, map: map, icon: imageFishSpot });
                                }
                            }
                        }
                        if (0 < station_id) {
                            marker.setTitle(args[3]);
                            attachFishSpot(marker, i);
                        }
                    }
                    if (0 < cntR) total++;
                    if (0 < cntO) total++;
                    if (0 < cntY) total++;
                    if (0 < cntG) total++;
                    if (0 < cntB) total++;
                    var leftPart = '<table style="width: 182px"><tr><td class="auto-style12">';

                    var legend = document.getElementById('legend');
                    if (0 < cntR) {
                        legend.appendChild(SetLegend('R', 'Low', cntR, total));
                    }
                    if (0 < cntO) {
                        legend.appendChild(SetLegend('O', '25%', cntO, total));
                    }
                    if (0 < cntY) {
                        legend.appendChild(SetLegend('Y', '50%', cntY, total));
                    }
                    if (0 < cntG) {
                        legend.appendChild(SetLegend('G', '75%', cntG, total));
                    }
                    if (0 < cntB) {
                        legend.appendChild(SetLegend('B', '100%', cntB, total));
                    }
                    if (0 < total) {
                        map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(legend);
                        legend.style.visibility = 'visible';
                        //   legend.style.display    = 'block';
                    }

                    //  Fit these bounds to the map
                    if (1 < g_locationList.length) {
                        map.fitBounds(bounds);
                    }
                }
            } catch (exception) { }
            
        }
        function getAbsolutePath() {
            var loc = window.location;
            var pathName = loc.pathname.substring(0, loc.pathname.lastIndexOf('/') + 1);
            return loc.href.substring(0, loc.href.length - ((loc.pathname + loc.search + loc.hash).length - pathName.length));
        }

        function attachFishSpot(marker, number) {
            if (0 > number) {
                return false;
            }
            var args = g_locationList[number].split(",");   // left - station id | place description
            var msg = '[<span class=formatText >' + args[3] + '</span>]';
            var infowindow = new google.maps.InfoWindow({ content: msg, size: new google.maps.Size(50, 50) });

            google.maps.event.addListener(marker, 'click', function ()
            {
                infowindow.open(map, marker);
                var parentWindow = window.parent;
                var placeSid = parseInt(args[3]);
                var win = null;
                var path = getAbsolutePath();
                var fpath = 'Plot.aspx?id=' + placeSid + '&fish=';
                var fllpath = path + fpath + document.getElementById('<%=fishGuid.ClientID%>').value;

                localStorage.secondFrameLocation = fllpath;
            });
        }

        function filterFishingRegionOnMap()
        {
            if (null != g_countyList)
            {
                let county = document.getElementById('<%=PlaceListMapRegion.ClientID%>').value;

                for (let i = 0; i < g_countyList.length; i++)
                {
                    let args = g_countyList[i].split("|");  // parse for Lat/Long

                    if (county == args[0])
                    {
                        let location = new google.maps.LatLng(args[1], args[2]);
                        map.setCenter(location);
                        map.setZoom(8);
                        return;
                    }
                }
            }
            return false;
        }
    </script>

  </head>
    <body style="width: 718px; height: 45px">
        <form id="formMapFrame" runat="server" class="auto-style4">

        <input  type="hidden" runat='server' id="paramLat" value="43" />
        <input  type="hidden" runat='server' id="paramLon" value="-80" />

        <input  type="hidden" runat='server' id="mapLat" value="43" />
        <input  type="hidden" runat='server' id="mapLon" value="-80" />
        <input  type="hidden" runat='server' id="fishGuid" value="" />
        <input  type="hidden" runat='server' id="zone51" value="" />
        <input  type="hidden" runat='server' id="HiddenRegisterWarning1" value="Please register to see more" />

        <table style="vertical-align: top; " class="auto-style3" > 
            <tr><td></td><td></td></tr>
            <tr><td class="styleWarnReg"><%=HiddenRegisterWarning1.Value%></td>
                <td class="styleWarnReg"></td></tr>
            <tr><td></td><td></td></tr>
            <tr><td class="auto-style1">Select fish: </td><td class="auto-style2">
                <asp:DropDownList ID="cblFish" runat="server" Height="24px" Width="200px" OnLoad="cblFish_Load" OnSelectedIndexChanged="cblFish_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
                </td></tr>
            <tr><td class="auto-style1">Filter Region: </td><td  class="auto-style2">
                    <asp:DropDownList ID="PlaceListMapRegion" runat="server" Height="24px" Width="200px">
                    </asp:DropDownList>
            </td></tr>
            <tr><td></td><td></td></tr>
            <tr><td></td><td></td></tr>
         </table>
        <div style="vertical-align: top; height: 361px; width: 720px;">
            <!-- ======== map 1 column ======== -->

            <div style="vertical-align: top; height: 361px; width: 720px;">
                <!-- ======== map 1 column ======== -->
                <div id="map"></div>
            <div id="legend" style="position: relative; margin: 5px;"></div>
        </div></div>

    </form>
   </body>
</html>
