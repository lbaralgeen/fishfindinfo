<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForecastFrame.aspx.cs" Inherits="FishTracker.Forecast.ForecastFrame" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forecast</title>

		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>

		<script type="text/javascript">
		    $(function () {
		        var fishName = document.getElementById('<%=hiddenFishName.ClientID%>').value;
		        var placeDesc = document.getElementById('<%=hiddenPlaceName.ClientID%>').value;
		        var Dates = document.getElementById('<%=hiddenDates.ClientID%>').value;

		        $('#container').highcharts({
		            chart:    { zoomType: 'xy'  },
		            title:    { text: placeDesc },
		            subtitle: { text: fishName },
		            xAxis: [{  categories: g_datesList }],
		            yAxis: [
                       { // Primary yAxis
		                  labels: { formatter: function () { return this.value + '°C'; }, style: { color: '#89A54E' } },
		                  title:  { text: 'Temperature', style: { color: '#89A54E' } },
		                  opposite: true

		            }, { // Secondary yAxis
		                  gridLineWidth: 0,
		                  title: { text: 'Water Level', style: { color: '#4572A7' } }
		            }, { // Tertiary yAxis
		                gridLineWidth: 0,
		                title: { text: 'Discharge', style: { color: '#4572B4' } }
		            }, { // Fortyry yAxis
		                  gridLineWidth: 0,
		                  title: { text: 'Turbidity',   style: { color: '#AA4643' } },
		                  opposite: true
		            }],
		            tooltip: { shared: true },
		            series: [
                    {
		                name: 'Water Level',
		                color: '#4572A7',
		                type: 'spline',
		                data: g_WaterLevelList,
		                tooltip: { valueSuffix: ' [m]' }
                    },
                    {
                        name: 'Discharge',
                        color: '#453F17',
                        type: 'spline',
                        data: g_DischargeList,
                        tooltip: { valueSuffix: ' [m/c^3]' }
                    },
                    {
		                name: 'Turbidity',
		                type: 'spline',
		                color: '#AA4643',
		                yAxis: 1,
		                data: g_Turbidity,
		                marker: { enabled: false },
		                dashStyle: 'shortdot',
		                tooltip: { valueSuffix: ' [FNU]' }
                    },
                    {
		                name: 'Precipitation',
		                type: 'spline',
		                color: '#A04603',
		                data: g_Precipitation,
		                marker: { enabled: false },
		                dashStyle: 'shortdot',
		                tooltip: { valueSuffix: ' [mm]' }
                    },
                    {
		                name: 'Temperature',
		                color: '#89A54E',
		                type: 'spline',
		                data: g_TemperatureList,
		                marker: { enabled: false },
		                tooltip: { valueSuffix: ' [C]' }
                    }]
		        });
		    });
    </script>  

    <style type="text/css">
        .auto-style2 {
            width: 76px;
        }
        .auto-style4 {
        width: 1px;
        border-width: 0px; padding: 0px; margin: 0px; 
        background-color: #dedee1;
        }
        .auto-style5 {
        width: 1px;
        border-width: 0px; padding: 0px; margin: 0px; 
        }
        .auto-style6 {
            width: 40px;
        }
        .auto-style8 {
            width: 40px;
        }
        .auto-style9 {
            width: 100px;
            font-size: small;
        }
        .auto-style10 {
            width: 240px;
            font-size: small;
        }
        .auto-style11 {
            width: 142px;
        }
        .auto-style12 {
        width: 142px;
        height: 1px;
        border-width: 0px; padding: 0px; margin: 0px; 
        background-color: #dedee1;
        }
    </style>

</head>
<body>
    <form id="formForecast" runat="server">
     <input  type="hidden" runat='server' id="hiddenFishName" value="Bass" />
     <input id="hiddenPlaceName" runat='server' type="hidden" value="Victoria Park, Kitchener, ON" />
     <input  type="hidden" runat='server' id="hiddenDates" value="Sep 29" />
     <input  type="hidden" runat='server' id="sWeatherLine" value="" />
     <input  type="hidden" runat='server' id="sMoonLine" value="" />
     <input  type="hidden" runat='server' id="sWindLine" value="" />
     <input  type="hidden" runat='server' id="sTextGrid" value="" />
     <table>
       <tr><td>
           <table>
               <tr>
               <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlForecast" runat="server" Font-Bold="True">Forecast</asp:HyperLink></td>
               <td class="auto-style4"></td>
               <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlScience" runat="server" NavigateUrl="Science.aspx">Science</asp:HyperLink></td>
               <td class="auto-style5"></td>
               <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlFishing" runat="server" NavigateUrl="Fishing.aspx">Fishing</asp:HyperLink></td>
           </tr>
             <tr>
               <td class="auto-style11"></td>
               <td class="auto-style4"></td>
               <td class="auto-style12"></td>
               <td class="auto-style5"></td>
               <td class="auto-style12"></td>
             </tr>           
           </table>
       </td></tr>
       <tr><td>
         <table>
             <tr><td>
                 <table>  <!-- ======== the weather line ======== -->
                     <tr>
                         <td class="auto-style2"> </td>
                         <td class="auto-style4"></td>
                         <%=sWeatherLine.Value%>
                         <td class="auto-style6"></td>
                     </tr>
                     <tr>
                         <td class="auto-style2"> </td>
                         <td class="auto-style4"></td>
                         <%=sMoonLine.Value%>
                         <td class="auto-style6"></td>
                     </tr>
                     <tr>
                         <td class="auto-style2"> </td>
                         <td class="auto-style4"></td>
                         <%=sWindLine.Value%>
                         <td class="auto-style6"></td>
                     </tr>
                 </table>
             </td></tr>
             <tr><td class="auto-style8">
               <script src="/js/highcharts.js"         type="text/javascript"></script>
              <script src="/js/modules/exporting.js"  type="text/javascript"></script>   
              <div id="container" style="min-width: 200px; height: 300px; margin: 0 0px 0 0px; width: 700px; left: 0px;"></div>
             </td></tr>
         </table>
       </td></tr>
    </table>
    </form>
</body>
</html>
