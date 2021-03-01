<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfRiverViewer.aspx.cs" Inherits="FishTracker.Resources.wfRiverViewer" %>

<asp:Content ID="ContentHeadLakeGeneralItem" ContentPlaceHolderID="HeadContent" runat="server">

            <style type="text/css">
                .auto-style9 { width: 388px;}
                .auto-style1 { width: 150px;}            
                .auto-styleRiverName { width: 314px; vertical-align: text-top; }
                .auto-style27 {width: 934px; }
                .auto-style28 { height: 1px; }
                .borderline { border:1px solid black; }

                .auto-style29 {
                    width: 246px;
                    height: 21px;
                }
                
                .auto-style33 {
                    width: 532px;
                }
                .auto-style35 {
                    width: 115px;
                    height: 21px;
                }

                .auto-style41 {
                    width: 520px;
                }

                .auto-style42 {
                    width: 71px;
                }

                .auto-style43 {
                    height: 1px;
                    width: 448px;
                }
                .auto-style44 {
                    width: 531px;
                }
                .auto-style45 {
                    width: 269px;
                    height: 21px;
                }
                .auto-style46 {
                    width: 269px;
                }
                .auto-style47 {
                    width: 469px;
                }

                .auto-style48 {
                    width: 448px;
                }
                .auto-style49 {
                    width: 445px;
                }
                .auto-style50 {
                    height: 1px;
                    width: 531px;
                }
                .auto-style51 {
                    width: 311px;
                    height: 21px;
                }
                .auto-style52 {
                    width: 311px;
                }
                .auto-style53 {
                    width: 128px;
                    height: 21px;
                }
                .auto-style54 {
                    width: 929px;
                }

            </style>
<script>
    var gMap;
    function initialize() {
    }

</script>

</asp:Content>

<asp:Content ID="ContentMainFishEditItem" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="HiddenCountry" runat="server" />
    <asp:HiddenField ID="HiddenState" runat="server" />
    <input  type="hidden" runat='server' id="HiddenLakeImageLabel" value="" />
    <input  type="hidden" runat='server' id="sourceLat" value="41" />
    <input  type="hidden" runat='server' id="sourceLon" value="-80" />
    <input  type="hidden" runat='server' id="mouthLat" value="43" />
    <input  type="hidden" runat='server' id="mouthLon" value="-82" />
    <input  type="hidden" runat='server' id="pinXLat" value="41" />
    <input  type="hidden" runat='server' id="pinXLon" value="-80" />
    <input  type="hidden" runat='server' id="pinYLat" value="43" />
    <input  type="hidden" runat='server' id="pinYLon" value="-82" />

    <input  type="hidden" runat='server' id="isRealSrc" value="0" />
    <input  type="hidden" runat='server' id="isRealMth" value="0" />
    <input  type="hidden" runat='server' id="riverName" value="" />
    <input  type="hidden" runat='server' id="HiddenLakeName" value="" />
    <input  type="hidden" runat='server' id="HiddenAltRiverName" value="" />
    <input  type="hidden" runat='server' id="HiddenNativeRiverName" value="" />
    <input  type="hidden" runat='server' id="HiddenLink" value="" />
    <input  type="hidden" runat='server' id="HiddenLinkPage" value="" />
    <input  type="hidden" runat='server' id="HiddenTwitterPage" value="" />
    <input  type="hidden" runat='server' id="HiddenCGNDB" value="" />
    <input  type="hidden" runat='server' id="description" value="" />
    <input  type="hidden" runat='server' id="location" value="" />
    <input  type="hidden" runat='server' id="LakeAGRLocation" value="" />
    <input  type="hidden" runat='server' id="cLat" value="41" />
    <input  type="hidden" runat='server' id="cLon" value="-80" />
    <input  type="hidden" runat='server' id="Zone" value="" />
    <input  type="hidden" runat='server' id="HiddenTributaryL" value="" />
    <input  type="hidden" runat='server' id="HiddenTributaryR" value="" />
    <input  type="hidden" runat='server' id="HiddenRVFishL" value="" />
    <input  type="hidden" runat='server' id="HiddenRVFishR" value="" />
    <input  type="hidden" runat='server' id="HiddenCloseByL" value="" />
    <input  type="hidden" runat='server' id="HiddenCloseByR" value="" />
    <input  type="hidden" runat='server' id="HiddenNewsL" value="" />
    <input  type="hidden" runat='server' id="HiddenNewsR" value="" />

    <input  type="hidden" runat='server' id="pointName" value="" />
    <input  type="hidden" runat='server' id="pointTemperature" value="" />
    <input  type="hidden" runat='server' id="pointDischarge" value="" />
    <input  type="hidden" runat='server' id="pointOxygen" value="" />
    <input  type="hidden" runat='server' id="pointPH" value="" />
    <input  type="hidden" runat='server' id="pointTurbidity" value="" />
    <input  type="hidden" runat='server' id="pointVelocity" value="" />

    <input  type="hidden" runat='server' id="Watershield" value="" />
    <input  type="hidden" runat='server' id="fishing" value="" />
    <input  type="hidden" runat='server' id="otherfish" value="" />

    <input  type="hidden" runat='server' id="SourceLakeName" value="" />
    <input  type="hidden" runat='server' id="SourceLakeGuid" value="" />
    <input  type="hidden" runat='server' id="SourceElevation" value="" />
    <input  type="hidden" runat='server' id="SourceZone" value="" />
    <input  type="hidden" runat='server' id="HiddenSourceLink" value="" />

    <input  type="hidden" runat='server' id="MouthElevation" value="" />
    <input  type="hidden" runat='server' id="MouthLakeName" value="" />
    <input  type="hidden" runat='server' id="MouthLakeGuid" value="" />
    <input  type="hidden" runat='server' id="MouthZone" value="" />

    <input  type="hidden" runat='server' id="HiddenLake1" value="" />
    <input  type="hidden" runat='server' id="HiddenLake2" value="" />
    <input  type="hidden" runat='server' id="HiddenLakeSource" value="" />
    <input  type="hidden" runat='server' id="HiddenLakeMouth" value="" />
    <input  type="hidden" runat='server' id="HiddenSourceLocation" value="" />
    <input  type="hidden" runat='server' id="HiddenMouthLocation" value="" />
    <input  type="hidden" runat='server' id="HiddenMouthLink" value="" />

    <input  type="hidden" runat='server' id="HiddenEncodedMsg" value="test" />
    <input  type="hidden" runat='server' id="HiddenMapImage" value="test" />
    <input  type="hidden" runat='server' id="hdLakeGuid" value="test" />
    <input  type="hidden" runat='server' id="RiverLastChange" value="" />
    <input  type="hidden" runat='server' id="RiverWaterLastChange" value="" />
    <input  type="hidden" runat='server' id="HiddenFishSpots" value="" />
    
    <table border="0">
        <tr>
            <td>[&nbsp;General&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;<asp:HyperLink ID="hlinkFishing" runat="server"  >Fishing</asp:HyperLink>&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;Regulations&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;Weather&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;<asp:HyperLink ID="HyperLinkEdit"    runat="server"  >Edit</asp:HyperLink>&nbsp;]</td>
        </tr>
    </table>
    <table class="auto-style27">
        <tr><td class="auto-style9">
                <table>
                    <tr><td class="auto-styleRiverName"><h3>Fishing on <%=HiddenLakeName.Value%></h3></td></tr>
                    <tr><td><%=HiddenAltRiverName.Value%> <%=HiddenNativeRiverName.Value%></td></tr>
                    <tr><td class="auto-styleRiverName"><h3"><%=LakeAGRLocation.Value%></h3></td></tr>
                </table>
            </td>
            <td>
                <table>
                    <tr><td class="auto-style41"><table>
                        <tr><td><a href="<%=HiddenLinkPage.Value%>">Link</a></td><td>&nbsp;|&nbsp;</td>
                        <td><a href="http://www.twitter.com/share?url=<%=HiddenTwitterPage.Value%>&text=<%=HiddenEncodedMsg.Value%>" target=\"_blank\">
                                <img src="/Images/social-icons/twitter.png"/></a></td><td>&nbsp;|&nbsp;</td>
                        <td><%=HiddenCGNDB.Value%></td><td>&nbsp;&nbsp;</td>
                        </tr></table>
                        </td>
                    </tr>
                    <tr><td class="auto-style41"><%=description.Value%></td></tr>
                </table>
            </td>
        </tr>
        <!--  lake general description   -->
        <tr><td><%=HiddenLake1.Value%></td><td><%=HiddenLake2.Value%></td></tr>
        <tr><td class="auto-style28" style="background-color: #CCCCCC"></td><td class="auto-style28" style="background-color: #CCCCCC"></td></tr>
        <tr><td style="vertical-align: top;">
                <table>
                <asp:PlaceHolder ID="phSource" runat="server">
                    <tr><td><img src="/Images/sourcePin.png"/></td><td><b>Source  :</b></td><td><%=SourceLakeName.Value%></td><td><%=HiddenSourceLink.Value%></td></tr>
                    <tr><td><asp:Label ID="LabelSourceLat" runat="server" Text="Lattitude:"></asp:Label></td><td><%=sourceLat.Value%></td><td></td></tr>
                    <tr><td><asp:Label ID="LabelSourceLon" runat="server" Text="Longitude:"></asp:Label></td><td><%=sourceLon.Value%></td><td></td></tr>
                    <%=SourceElevation.Value%>
                    <%=SourceZone.Value%>
                    <%=HiddenSourceLocation.Value%>
                </asp:PlaceHolder>
                </table>
            </td>
            <td><%=HiddenLakeSource.Value%></td>
        </tr>
        <tr><td class="auto-style28" style="background-color: #CCCCCC"></td><td class="auto-style28" style="background-color: #CCCCCC"></td></tr>
        <tr><td style="vertical-align: top;">
                <asp:PlaceHolder ID="phMouth" runat="server">
                <table>
                    <tr><td><img src="/Images/endPin.png"/></td><td><b>Mouth  :</b></td><td><%=MouthLakeName.Value%></td><td><%=HiddenMouthLink.Value%></td></tr>
                    <tr><td><asp:Label ID="LabelMouthLat" runat="server" Text="Lattitude:"></asp:Label></td><td><%=mouthLat.Value%></td><td></td></tr>
                    <tr><td><asp:Label ID="LabelMouthLon" runat="server" Text="Longitude:"></asp:Label></td><td><%=mouthLon.Value%></td><td></td></tr>
                    <%=MouthElevation.Value%>
                    <%=MouthZone.Value%>
                    <%=HiddenMouthLocation.Value%>
                </table>
                </asp:PlaceHolder>
        </td>
            <td><%=HiddenLakeMouth.Value%></td>
        </tr>
        <tr><td class="auto-style28" style="background-color: #CCCCCC"></td><td class="auto-style28" style="background-color: #CCCCCC"></td></tr>
        <tr>
            <td>
                <asp:PlaceHolder ID="PlaceHolderMap" runat="server">
                    <img src="<%=HiddenMapImage.Value%>" />
                </asp:PlaceHolder>
            </td>
            <td><table>
                <tr><td><asp:Image ID="ImageRiver" runat="server" Height = "245px" Width = "405px" /></td></tr>
                <tr><td><%=HiddenLakeImageLabel.Value%></td></tr>
                </table>    
            </td>
        </tr>
        <asp:PlaceHolder ID="PlaceHolderFishList" runat="server">
        <!--  fish list   -->
        <tr><td class="auto-style28" style="background-color: #CCCCCC"></td><td class="auto-style28" style="background-color: #CCCCCC"></td></tr>
        <tr>
            <td style="vertical-align:top;">
                    <table>
                        <tr><td class="auto-style29"><b>Fish Species</b></td><td>&nbsp;</td><td>&nbsp;</td></tr>
                        <tr style="height: 2px;"><td style="background-color: #CCCCCC"></td><td>&nbsp;</td><td style="background-color: #CCCCCC"></td></tr>
                        <%=HiddenRVFishL.Value%>
                    </table>
            </td>
            <td style="vertical-align:top;">
                    <table class="auto-style33">
                        <tr><td class="auto-style29">&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
                        <tr style="height: 2px;"><td style="background-color: #CCCCCC"></td><td>&nbsp;</td><td style="background-color: #CCCCCC"></td></tr>
                        <%=HiddenRVFishR.Value%>
                    </table>
            </td>
        </tr>
        </asp:PlaceHolder>
        <asp:PlaceHolder ID="PlaceHolderTributary" runat="server">
        <!--  river/lake list   -->
        <tr><td class="auto-style28" style="background-color: #CCCCCC"></td><td class="auto-style28" style="background-color: #CCCCCC"></td></tr>
        <tr>
            <td style="vertical-align:top;">
                    <table>
                        <tr><td class="auto-style29"><b>Tributary</b></td><td>Lat/Lon</td><td>&nbsp;|&nbsp;</td><td class="auto-style35"><b>Connected</b></td><td>&nbsp;&nbsp;</td></tr>
                        <tr><td style="background-color: #CCCCCC"></td><td>&nbsp;</td><td style="background-color: #CCCCCC"></td><td style="background-color: #CCCCCC"></td><td style="background-color: #CCCCCC"></td></tr>
                        <%=HiddenTributaryL.Value%>
                    </table>
            </td>
            <td style="vertical-align:top;">
                    <table class="auto-style33">
                        <tr><td class="auto-style29"><b>Tributary</b></td><td>Lat/Lon</td><td>&nbsp;|&nbsp;</td><td class="auto-style35"><b>Connected</b></td><td>&nbsp;&nbsp;</td></tr>
                        <tr><td style="background-color: #CCCCCC"></td><td>&nbsp;</td><td style="background-color: #CCCCCC"></td><td style="background-color: #CCCCCC"></td><td style="background-color: #CCCCCC"></td></tr>
                        <%=HiddenTributaryR.Value%>
                    </table>
            </td>
        </tr>
        </asp:PlaceHolder>
     <asp:PlaceHolder ID="PlaceHolderCloseBy" runat="server">
        <!--  river/lake list   -->
        <tr><td class="auto-style28" style="background-color: #CCCCCC"></td><td class="auto-style28" style="background-color: #CCCCCC"></td></tr>
        <tr>
            <td style="vertical-align:top;">
                    <table>
                        <tr><td class="auto-style29"><b>Close By</b></td><td>Lat/Lon</td><td>&nbsp;|&nbsp;</td><td class="auto-style35">&nbsp;</td><td>&nbsp;&nbsp;</td></tr>
                        <tr><td style="background-color: #CCCCCC"></td><td>&nbsp;</td><td style="background-color: #CCCCCC"></td><td style="background-color: #CCCCCC"></td><td style="background-color: #CCCCCC"></td></tr>
                        <%=HiddenCloseByL.Value%>
                    </table>
            </td>
            <td style="vertical-align:top;">
                    <table class="auto-style33">
                        <tr><td class="auto-style29"><b>Lakes and Rivers</b></td><td>Lat/Lon</td><td>&nbsp;|&nbsp;</td><td class="auto-style35">&nbsp;</td><td>&nbsp;&nbsp;</td></tr>
                        <tr><td style="background-color: #CCCCCC"></td><td>&nbsp;</td><td style="background-color: #CCCCCC"></td><td style="background-color: #CCCCCC"></td><td style="background-color: #CCCCCC"></td></tr>
                        <%=HiddenCloseByR.Value%>
                    </table>
            </td>
        </tr>
        </asp:PlaceHolder>
    </table>

    <asp:PlaceHolder ID="PlaceHolderNews" runat="server">
    <!--  river/lake list   -->
    <table class="auto-style54">
        <tr><td class="auto-style43" style="background-color: #CCCCCC"></td><td class="auto-style50" style="background-color: #CCCCCC"></td></tr>
        <tr>
            <td style="vertical-align:top;" class="auto-style48">
                    <table class="auto-style49">
                        <tr><td class="auto-style45"><b>Last News</b></td><td class="auto-style42">Date</td><td>&nbsp;|&nbsp;</td><td class="auto-style35">Source</td></tr>
                        <tr><td style="background-color: #CCCCCC" class="auto-style46"></td><td class="auto-style42">&nbsp;</td><td style="background-color: #CCCCCC"></td></tr>
                        <%=HiddenNewsL.Value%>
                    </table>
            </td>
            <td style="vertical-align:top;" class="auto-style44">
                    <table class="auto-style47">
                        <tr><td class="auto-style51"><b>Last News</b></td><td class="auto-style42">Date</td><td>&nbsp;|&nbsp;</td><td class="auto-style53">Source</td></tr>
                        <tr><td style="background-color: #CCCCCC" class="auto-style52"></td><td class="auto-style42">&nbsp;</td><td style="background-color: #CCCCCC"></td></tr>
                        <%=HiddenNewsR.Value%>
                    </table>
            </td>
        </tr>
    </table>
    </asp:PlaceHolder>
    <p><asp:Label ID="LabelViewRiver" runat="server" Text="Last change:&nbsp;">      </asp:Label><%=RiverLastChange.Value%>&nbsp;&nbsp;
       <asp:Label ID="LabelWaterRiver" runat="server" Text="Last data change:&nbsp;"></asp:Label><%=RiverWaterLastChange.Value%>
</asp:Content>
