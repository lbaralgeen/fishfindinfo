<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Science.aspx.cs" Inherits="FishTracker.Forecast.Science" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forecast</title>

    <style type="text/css">
        .auto-style4 {
        width: 9px;
        border-width: 0px; padding: 0px; margin: 0px; 
        background-color: #dedee1;
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
        .auto-style13 {
            width: 500px;
            font-size: small;
        }
        .auto-style14 {
            width: 600px;
        }
        .auto-style15 {
            width: 410px;
        }
        .auto-style16 {
            width: 100px;
            font-size: small;
        }
        .auto-style17 {
            width: 303px;
            font-size: small;
        }
        .auto-style19 {
            width: 120px;
        }
        .auto-style20 {
            width: 338px;
        }
        .auto-style21 {
            width: 300px;
            font-size: small;
        }
        .auto-style22 {
            width: 273px;
            font-size: small;
            
        }
        .auto-style24 {
            width: 86px;
            font-size: small;
            font-weight: bold;
        }
        .auto-style25 {
            width: 4px;
            font-size: small;
        }
        .auto-style26 {
            width: 275px;
            font-size: small;
        }
        .auto-style27 {
            width: 34px;
            font-size: small;
        }
        .auto-style28 {
            width: 163px;
            font-size: small;
        }
    </style>

</head>
<body>
<script>
    var myVar = setInterval(function () { myTimer() }, 1000);

    function myTimer() {
        if (localStorage.secondFrameLocation && window.location != localStorage.secondFrameLocation) {
            window.location = localStorage.secondFrameLocation;
            localStorage.secondFrameLocation = '';
        }
    }
</script>
    <form id="formForecast" runat="server">
     <input id="hiddenPlaceName" runat='server' type="hidden" value="Victoria Park, Kitchener, ON" />
    <input  type="hidden" runat='server' id="hdPath" value="43" />
     <input  type="hidden" runat='server' id="sTextGrid" value="" />
     <table>
       <tr><td class="auto-style14">
           <table style="height: 27px">
             <tr>
               <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlForecast" runat="server" NavigateUrl="<%=hdPath.Value%>Plot.aspx">Forecast</asp:HyperLink></td>
               <td class="auto-style4"></td>
               <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlScience" runat="server" Font-Bold="True">Science</asp:HyperLink></td>
               <td class="auto-style4"></td>
               <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlFishing" runat="server" NavigateUrl="<%=hdPath.Value%>Fishing.aspx" Visible="False">Fishing</asp:HyperLink></td>
             </tr>
             <tr>
               <td class="auto-style12"></td>
               <td class="auto-style4"></td>
               <td class="auto-style11"></td>
               <td class="auto-style4"></td>
               <td class="auto-style12"></td>
             </tr>
           </table>
       </td></tr>
       <tr><td class="auto-style14">
         <table style="width: 868px">
             <tr>
                 <td class="auto-style13">MLI:</td>
                 <td class="auto-style21"><asp:HyperLink ID="hlMLI" runat="server" Target="_blank"></asp:HyperLink></td>
                 <td class="auto-style16"><asp:Label ID="LabelSID" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">&nbsp;</td>
                 <td class="auto-style13"><asp:Label ID="lbLocName" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style21"><asp:Label ID="lbCity" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16"><asp:Label ID="lbState" runat="server" Font-Size="Small"></asp:Label></td>
             </tr>
             <tr><td class="auto-style20">&nbsp;</td><td class="auto-style22">&nbsp;</td>
                 <td class="auto-style19"></td><td class="auto-style19">&nbsp;</td><td>&nbsp;</td><td></td><td></td></tr>
             <tr>
                 <td class="auto-style13">Last reading:</td>
                 <td class="auto-style21"><asp:Label ID="lbDate" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16"><asp:Label ID="lbTime" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">&nbsp;</td>
                 <td class="auto-style15"></td>
                 <td class="auto-style17">&nbsp;</td>
                 <td class="auto-style15">&nbsp;</td>
             </tr>
             <tr style="background-color: #CCFFFF">
                 <td class="auto-style13">Latitude:</td>
                 <td class="auto-style21"><asp:Label ID="lbLat" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">&nbsp;</td>
                 <td class="auto-style16">&nbsp;</td>
                 <td class="auto-style13">Longitude:</td>
                 <td class="auto-style21"><asp:Label ID="lbLon" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">&nbsp;</td>
             </tr>
             <tr>
                 <td class="auto-style13">Water Temperature:</td>
                 <td class="auto-style21"><asp:Label ID="lbTemperature" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">[<asp:Label ID="lbTempUnit" runat="server" Font-Size="Small"></asp:Label>]</td>
                 <td class="auto-style16">&nbsp;</td>
                 <td class="auto-style13">Discharge:</td>
                 <td class="auto-style21"><asp:Label ID="lbDischarge" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">[<asp:Label ID="lbDischUnit" runat="server" Font-Size="Small"></asp:Label>]</td>
             </tr>
             <tr style="background-color: #CCFFFF">
                 <td class="auto-style13">Water LeveL:</td>
                 <td class="auto-style21"><asp:Label ID="lbElevation" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">[<asp:Label ID="lbElevUnit" runat="server" Font-Size="Small"></asp:Label>]</td>
                 <td class="auto-style16">&nbsp;</td>
                 <td class="auto-style13">Velocity:</td>
                 <td class="auto-style21"><asp:Label ID="lbVelocity" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">[<asp:Label ID="lbVelUnit" runat="server" Font-Size="Small"></asp:Label>]</td>
             </tr>
             <tr>
                 <td class="auto-style13">Oxygen:</td>
                 <td class="auto-style21"><asp:Label ID="lbOxygen" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">[mg/l]</td>
                 <td class="auto-style16">&nbsp;</td>
                 <td class="auto-style13">PH:</td>
                 <td class="auto-style21"><asp:Label ID="lbPH" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">&nbsp;</td>
             </tr>
             <tr style="background-color: #CCFFFF">
                 <td class="auto-style13">Turbidity</td>
                 <td class="auto-style21"><asp:Label ID="lbTurbidity" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">[FTU]</td>
                 <td class="auto-style16">&nbsp;</td>
                 <td class="auto-style13"> Conductance:</td>
                 <td class="auto-style21"><asp:Label ID="lbConductance" runat="server" Font-Size="Small"></asp:Label></td>
                 <td class="auto-style16">[µS/cm]</td>
             </tr>
         </table>
       </td></tr>
    </table>
    <table style="width: 868px">
        <tr><td class="auto-style24">Guid: </td>
            <td class="auto-style26"><asp:Label ID="LabelGuid" runat="server" ></asp:Label></td>
            <td class="auto-style27"></td><td class="auto-style28"></td><td></td>
        </tr>
        <tr style="background-color: #CCFFFF">
            <td class="auto-style24">Fish: </td>
            <td class="auto-style26"><asp:Label ID="LabelFishName" runat="server" Font-Size="Small"></asp:Label></td>
            <td class="auto-style27"></td>
            <td class="auto-style24">Latin: </td>
            <td class="auto-style26"><asp:Label ID="LabelFishLatin" runat="server" Font-Size="Small"></asp:Label></td>
        </tr>
    </table>
    </form>
</body>
</html>
