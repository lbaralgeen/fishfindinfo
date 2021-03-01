<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Plot.aspx.cs" Inherits="FishTracker.Forecast.Plot" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forecast</title>

		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>

		<script type="text/javascript">
            function setEmptyLine( line )
            {
                if (line == null)
                {
                    return "null" + string(",null").repeat(22);
                }
                return line;
            }
            function dateList() {
                let rst = [];

                let i;
                let sline = '';
                let shift = 15;
                for (i = 0; i < 23; i++) {
                    let today = new Date();
                    today.setTime(today.getTime() - shift * 24 * 60 * 60 * 1000);
                    let startDay = today.toString().substring(0, 10);
                    startDay = startDay.substring(0, 4) + startDay.slice(-2);
                    rst.push(startDay);
                    shift = shift - 1;
                }
                return rst;
            }
		    $(function () {
		        var fishName = document.getElementById('<%=hiddenFishName.ClientID%>').value;
                var placeDesc = document.getElementById('<%=hiddenPlaceName.ClientID%>').value;

                if (null == placeDesc) {
                    return;
                }
		        var unitTemperature = document.getElementById('<%=sUnitTemperature.ClientID%>').value;

		        var unitLine1 = document.getElementById('<%=sUnitLine1.ClientID%>').value;
		        var nameLine1 = document.getElementById('<%=sNameLine1.ClientID%>').value;

		        var unitLine2 = document.getElementById('<%=sUnitLine2.ClientID%>').value;
		        var nameLine2 = document.getElementById('<%=sNameLine2.ClientID%>').value;

                var dates = dateList();

                g_Line1List = setEmptyLine(g_Line1List);
                g_Line2List = setEmptyLine(g_Line2List);
                g_TemperatureList = setEmptyLine(g_TemperatureList);
                g_Precipitation = setEmptyLine(g_Precipitation);

		        $('#container').highcharts({
		            chart: {
		                zoomType: 'xy'
		            },
		            title: {
		                text: placeDesc
		            },
		            subtitle: {
		                text: fishName
		            },
		            xAxis: [{
                        categories: dates, crosshair: true
		            }],
		            yAxis: [{ // Primary yAxis
		                labels: {
		                    format: '{value}',
		                    style: {
		                        color: Highcharts.getOptions().colors[2]
		                    }
		                },
		                title: {
		                    text: 'Temperature °' + unitTemperature,
		                    style: {
		                        color: Highcharts.getOptions().colors[2]
		                    }
		                },
		                opposite: true

		            }, { // Secondary yAxis
		                gridLineWidth: 0,
		                title: {
		                    text: 'Rainfall [mm]',
		                    style: {
		                        color: Highcharts.getOptions().colors[0]
		                    }
		                },
		                labels: {
		                    format: '{value}',
		                    style: {
		                        color: Highcharts.getOptions().colors[0]
		                    }
		                }

		            }, { // Secondary yAxis 2
		                gridLineWidth: 0,
		                title: {
		                    text: nameLine2 + ' [' + unitLine2 + ']',
		                    style: {
		                        color: Highcharts.getOptions().colors[3]
		                    }
		                },
		                labels: {
		                    format: '{value}',
		                    style: {
		                        color: Highcharts.getOptions().colors[3]
		                    }
		                }

		            }, { // Tertiary yAxis
		                gridLineWidth: 0,
		                title: {
		                    text: nameLine1 + ' [' + unitLine1 + ']',
		                    style: {
		                        color: Highcharts.getOptions().colors[1]
		                    }
		                },
		                labels: {
		                    format: '{value}',
		                    style: {
		                        color: Highcharts.getOptions().colors[1]
		                    }
		                },
		                opposite: true
		            }],
		            tooltip: {
		                shared: true
		            },
		            legend: {
		                layout: 'vertical',
		                align: 'left',
		                x: 80,
		                verticalAlign: 'top',
		                y: 55,
		                floating: true,
		                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
		            },
		            series: [
                   {
		                name: 'Rainfall',
		                type: 'spline',
		                yAxis: 1,
		                data: g_Precipitation,
		                tooltip: {
		                    valueSuffix: ' mm'
		                }

                   }, {
                       name: nameLine2,
                       type: 'spline',
                       yAxis: 2,
                       data: g_Line2List,
                       marker: {
                           enabled: false
                       },
                       dashStyle: 'shortdot',
                       tooltip: {
                           valueSuffix: ' ' + unitLine2
                       }

                   }, {
                       name: nameLine1,
		                type: 'spline',
		                yAxis: 3,
		                data: g_Line1List,
		                marker: {
		                    enabled: false
		                },
		                dashStyle: 'shortdot',
		                tooltip: {
		                    valueSuffix: ' ' + unitLine1
		                }

		            }, {
		                name: 'Temperature',
		                type: 'spline',
		                data: g_TemperatureList,
		                tooltip: {
		                    valueSuffix: ' °' + unitTemperature
		                }
		            }]
		        });
		    });

        </script>  

    <style type="text/css">
        .auto-style4 {
        width: 1px;
        border-width: 0px; padding: 0px; margin: 0px; 
        background-color: #dedee1;
        }
        .auto-style5 {
        width: 1px;
        border-width: 0px; padding: 0px; margin: 0px; 
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
        .auto-style19 {
            width: 800px;
            height: 463px;
        }
        .auto-style21 {
            height: 300px;
            width: 800px;
            left: 0px;
            top: 40px;
        }
        .HyperLinkStyle-place
        {
            Font-Size:Small;
            position:absolute;
            left:20px;
            top:470px;
        }
        .HyperLinkStyle-xy
        {
            position:absolute;
            left:20px;
            top:490px;
        }    
        .auto-style801 {
            position: absolute;
            left: 160px;
            width: 640px;
        }
        .PlotPos {
            position: absolute;
            width: 800px;
            top:120px;
            letter-spacing:0px;
        }
        .labelstyleBold {
            font-size: small;
            font-weight: bold;
        }
        table.fixed { table-layout:fixed; width:600px; }
        table.fixed td { font-size:smaller; overflow: hidden; width:12px; border-right: 1px solid; }
        .auto-style802 {
            width: 192px;
        }
    </style>
</head>
<body style="height: 480px; width: 800px;">
<script>
    const myVar = setInterval(function () { myTimer() }, 1000);

    function myTimer()
    {
        if (localStorage.secondFrameLocation && window.location != localStorage.secondFrameLocation) {
            window.location = localStorage.secondFrameLocation;
            localStorage.secondFrameLocation = '';
        }
    }
</script>

    <form id="PlotFrame" runat="server" class="auto-style19">
     <input id="hiddenPlaceName" runat='server' type="hidden" value="" />
     <input id="hiddenFishName" runat='server' type="hidden" value="" />
    <input  type="hidden" runat='server' id="hdPath" value="" />
     <input  type="hidden" runat='server' id="sWeatherLine" value="" />
     <input  type="hidden" runat='server' id="sMoonLine" value="" />
     <input  type="hidden" runat='server' id="sWindLine" value="" />
     <input  type="hidden" runat='server' id="sTextGrid" value="" />
     <input  type="hidden" runat='server' id="sUnitTemperature" value="" />

     <input  type="hidden" runat='server' id="sUnitLine1" value="" />
     <input  type="hidden" runat='server' id="sNameLine1" value="" />

     <input  type="hidden" runat='server' id="sUnitLine2" value="" />
     <input  type="hidden" runat='server' id="sNameLine2" value="" />

    <table>
        <tr>
        <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlForecast" runat="server" Font-Bold="True" Visible="False">Forecast</asp:HyperLink></td>
        <td class="auto-style4"></td>
        <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlScience" runat="server" NavigateUrl="<%=hdPath.Value%>Science.aspx" Enabled="False" Visible="False">Science</asp:HyperLink></td>
        <td class="auto-style5"></td>
        <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlFishing" runat="server" NavigateUrl="<%=hdPath.Value%>Fishing.aspx" Visible="False">Fishing</asp:HyperLink></td>
    </tr>
        <tr>
        <td class="auto-style11"></td>
        <td class="auto-style4"></td>
        <td class="auto-style12"></td>
        <td class="auto-style5"></td>
        <td class="auto-style12"></td>
        </tr>           
    </table>
    <table class="auto-style801"><tr><td>
        <table class="fixed">
           <%=sWeatherLine.Value%>
           <%=sMoonLine.Value%>
           <%=sWindLine.Value%>
        </table>
    </td></tr></table>
    <script src="/js/highcharts.js"         type="text/javascript"></script>
    <script src="/js/modules/exporting.js"  type="text/javascript"></script>   

    <table class="PlotPos"><tr><td>
        <div id="container" style="min-width: 200px; margin: 0 0px 0 0px; " class="auto-style21"></div>
    </td></tr></table>
    <p><asp:HyperLink ID="HyperLinkPlotRiver" Target="_blank" runat="server" CssClass="HyperLinkStyle-place">Fish Find Info</asp:HyperLink></p>
    <table class="HyperLinkStyle-xy"><tr>
       <td><asp:Label ID="LabelLattitude" runat="server" Text="Lattitude: " class="labelstyleBold"></asp:Label></td>
       <td><asp:Label ID="LabelLat" runat="server" Text="43" Font-Size="Small"></asp:Label></td>
       <td><asp:Label ID="LabelLongitude" runat="server" Text="Longitude: " class="labelstyleBold"></asp:Label></td>
       <td><asp:Label ID="LabelLon" runat="server" Text="-80" Font-Size="Small"></asp:Label></td>
       <td><asp:Label ID="LabelCountry" runat="server" Text="Country: " class="labelstyleBold"></asp:Label></td>
       <td><asp:Label ID="LabelCountryVal" runat="server" Text="CA" Font-Size="Small"></asp:Label></td>
       <td><asp:Label ID="LabelState" runat="server" Text="State: " class="labelstyleBold"></asp:Label></td>
       <td class="auto-style802"><asp:Label ID="LabelStateVal" runat="server" Text="ON" Font-Size="Small"></asp:Label></td>
    </tr>
    <tr><td class="labelstyleBold">MLI:</td>
        <td><asp:HyperLink ID="hlMLI" runat="server" Target="_blank"></asp:HyperLink></td>
        <td class="labelstyleBold">Update: </td><td>
        <asp:Label ID="LabelPlotDate" runat="server" Text=""></asp:Label>
        </td><td></td><td></td><td></td><td></td>
    </tr>
    </table>
    </form>
</body>
</html>
