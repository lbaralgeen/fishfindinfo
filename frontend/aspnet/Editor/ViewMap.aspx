<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="ViewMap.aspx.cs" Inherits="FishTracker.Editor.ViewMap" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

<script type="text/javascript">
    function initialize() {
        return;
    }
</script>

    <style type="text/css">
        .auto-style1 {
            height: 378px;
        }
        .auto-style7 {
            height: 378px;
        }
        .auto-style8 {
            width: 340px;
        }
        .formatText{color:Green;font-size:11px;font-family:Arial;font-weight:bold;}

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
    </style>
    <script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBkCcQ6id-ksCLMuWLgirojcf7MIA1RTAY&callback=initializeMap">
    </script>

<script type="text/javascript">

    function initializeMap()
    {
        const myLatlng = new google.maps.LatLng(43, -81);
        let bounds = new google.maps.LatLngBounds();
        const myOptions = { zoom: 8, center: myLatlng, mapTypeId: google.maps.roadmap }

        const mapValue = new google.maps.Map(document.getElementById('map_cvs'), myOptions);

        if (null != g_locationList)
        {
            let index = 0;
            g_locationList.forEach((item) =>
            {

                const args = item.split(',');  // parse for Lat/Long
                if (args.length > 1)
                {
                    let location = new google.maps.LatLng(args[0], args[1]);
                    bounds.extend(location);

                    let marker = new google.maps.Marker({ position: location, map: mapValue  });
                     
                    marker.setTitle(args[2], args[2]);
                    attachFishSpot(mapValue, marker, index++);
                }
            });
        }

    }
    google.maps.event.addDomListener(window, 'load', initializeMap);

    function attachFishSpot(mapValue, marker, number)
    {
        if (0 > number) {
            return false;
        }
        const msg = '[<span class=formatText >' + marker.title + '</span>]';
        const infowindow = new google.maps.InfoWindow({ content: msg, size: new google.maps.Size(50, 50) });

        google.maps.event.addListener(marker, 'click', function ()
        {
            infowindow.open(mapValue, marker);
            const parentWindow = window.parent;

            if (null != parentWindow && null != parentWindow.document)
            {
                const win = parentWindow.document.getElementById("ScienceId").contentWindow;

                let frameval = parentWindow.document.getElementById('ScienceId');
                frameval.height = 520;
                const placeSid = parseInt(marker.title, 36); // 263877  - 5NLX

                if (null != win)
                {
                    win.location = '../Forecast/Science.aspx?id=' + placeSid;
                }
            }
        });
    }
</script>

</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <input  type="hidden" runat='server' id="hdPath" value="" />
    <input  type="hidden" runat='server' id="hdxy" value="43,-81" />

    <table>
        <tr><td></td></tr>
        <tr><td style="text-align: center">Water Station Map</td></tr>
        <tr><td></td></tr>
        <tr> 
     <td class="auto-style18" style="vertical-align: top; clip: rect(auto, auto, auto, auto); ">
         <div style="vertical-align: top; height: 361px; width: 686px;">
             <!-- ======== map 1 column ======== -->
           <div id="map_cvs"  style="width: 700px; height:354px; vertical-align: top;"></div>   <!--  end right column with map== -->
           <div id="legend" style="position: relative;"></div>
         </div>
     </td></tr>
        <tr><td>
           <iframe  height: 429px; width: 595px;  scrolling="no" seamless="yes" src="<%=hdPath.Value%>Science.aspx?mli=123" id="ScienceId" name="ScienceName" style="border-style: hidden; border-width: 0px; width: 737px; height: 605px;"></iframe>
        </td></tr>
    </table>

</asp:Content>

