<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fishing.aspx.cs" Inherits="FishTracker.Forecast.Fishing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forecast</title>

    <style type="text/css">
        .auto-style2 {
            width: 76px;
        }
        .auto-style4 {
        width: 1px;
        border-width: 0px; padding: 0px; margin: 0px; 
        background-color: #dedee1;
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
     <input  type="hidden" runat='server' id="hiddenFishName" value="Bass" />
     <input  type="hidden" runat='server' id="hdPath" value="43" />
     <table>
       <tr><td>
           <table><tr>
               <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlForecast" runat="server" NavigateUrl="Forecast.aspx">Forecast</asp:HyperLink></td>
               <td class="auto-style11" style="text-align: center"><asp:HyperLink ID="hlScience" runat="server" NavigateUrl="Science.aspx">Science</asp:HyperLink></td>
               <td class="auto-style11" style="text-align: center">Fishing</td>
           </tr></table>
       </td></tr>
       <tr><td>
         <asp:Label ID="LabelInfo" runat="server" Font-Size="Small"></asp:Label>
         <table>
             <tr><td class="auto-style10"></td><td class="auto-style9"></td>
                 <td class="auto-style4"></td>
                 <td class="auto-style10"></td><td class="auto-style9"></td>
             </tr>
         </table>
       </td></tr>
    </table>
    </form>
</body>
</html>
