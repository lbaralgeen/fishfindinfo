<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfRiverViewer.aspx.cs" Inherits="FishTracker.Editor.wfRiverViewer" %>

<asp:Content ID="ContentHeadFishEditItem" ContentPlaceHolderID="HeadContent" runat="server">

            <style type="text/css">
                .auto-style9 {
                    width: 388px;
                }
                .auto-style1 {
                    width: 150px;
                }            
                .auto-style11 {
                    width: 134px;
                    height: 5px;
                }
                .auto-style12 {
                    height: 209px;
                }
                .auto-style13 {
                    width: 314px;
                }
                .auto-style14 {
                    width: 841px;
                }
                .auto-style16 {
                    width: 120px;
                }
                .auto-style17 {
                    width: 107px;
                }
                .auto-style18 {
                    width: 69px;
                }
                .auto-style19 {
                    width: 67px;
                }
            </style>
    <script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?v=3.11&key=AIzaSyCyr_JducfQD9qbqIe4vvqf5UU8nYN6IF4&sensor=false">
    </script>

<script type="text/javascript">
    var map;

    function initialize() {
        var mapLatX = document.getElementById('<%=mapLatX.ClientID%>').value;
        var mapLonX = document.getElementById('<%=mapLonX.ClientID%>').value;
        var mapLatY = document.getElementById('<%=mapLatY.ClientID%>').value;
        var mapLonY = document.getElementById('<%=mapLonY.ClientID%>').value;
        var cLat = document.getElementById('<%=cLat.ClientID%>').value;
        var cLon = document.getElementById('<%=cLon.ClientID%>').value;

        var myLatlng = new google.maps.LatLng(cLat, cLon);
        var myOptions = { zoom: 8, center: myLatlng, mapTypeId: google.maps.MapTypeId.envionx2014 }

         var bounds = new google.maps.LatLngBounds();
         bounds.extend(new google.maps.LatLng(mapLatY, mapLonY));
         bounds.extend(new google.maps.LatLng(mapLatX, mapLonX));

        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
        map.fitBounds(bounds);
    }

</script>

</asp:Content>

<asp:Content ID="ContentMainFishEditItem" ContentPlaceHolderID="MainContent" runat="server">
    <input  type="hidden" runat='server' id="mapLatX" value="41" />
    <input  type="hidden" runat='server' id="mapLonX" value="-80" />
    <input  type="hidden" runat='server' id="mapLatY" value="43" />
    <input  type="hidden" runat='server' id="mapLonY" value="-82" />
    <input  type="hidden" runat='server' id="riverName" value="" />
    <input  type="hidden" runat='server' id="description" value="" />
    <input  type="hidden" runat='server' id="stateCountry" value="[US] New York" />
    <input  type="hidden" runat='server' id="cLat" value="41" />
    <input  type="hidden" runat='server' id="cLon" value="-80" />
    <input  type="hidden" runat='server' id="lakeId" value="9C537DD1-FC59-489E-A7A1-018B2921F19F" />
    <table style="width: 750px">
        <tr><td class="auto-style9"><table><tr><td class="auto-style14"><h3><%=riverName.Value%> Fishing</h3></td><td class="auto-style13"><h3><%=stateCountry.Value%></h3></td></tr></table></td>
            <td><h3><%=description.Value%></h3></td></tr>
        <tr>
            <td class="auto-style9">
                <div id="map_canvas"  style="width: 381px; height:305px; vertical-align: top;"></div>   <!--  end right column with map== -->
            </td>
            <td style="vertical-align: top;">
                <table><tr><td>
                        <table style="height: 18px; width: 379px;">
                        <tr>
                         <td class="auto-style11"><b>Fish</b></td>
                          <td class="auto-style1"><b>Probability</b></td>
                          </tr></table>
                    </td></tr>
                    <tr><td class="auto-style12">     
                    <asp:DataList ID="DataListSpecies" runat="server" DataSourceID="CTRL" Width="391px" Height="24px" style="margin-right: 0px" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" GridLines="Both">
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                        <ItemStyle BackColor="White" ForeColor="#003399" HorizontalAlign="Left" />
                        <ItemTemplate>
                            <table style="height: 18px; width: 365px;"><tr>
                                <td class="auto-style11"> <%#Eval("fish_name")%></a></td>
                                <td class="auto-style1"> <%#Eval("today")%></a></td>
                            </tr>
                            </table>
                        </ItemTemplate>
                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    </asp:DataList>
                  </td></tr>
    <asp:SqlDataSource ID="CTRL" runat="server" 
            ConnectionString="<%$ ConnectionStrings:fishConnectionString %>" 
            SelectCommand=" SELECT * FROM dbo.fn_river_viewer_fish('<%=lakeId.Value%>') ORDER BY today, fish_name DESC">
    </asp:SqlDataSource>
                </table>
            </td>
        </tr>
        <tr><td><table><tr><td class="auto-style16"><b>Fishing License</b>:</td><td class="auto-style17"><i>Required</i></td>
                           <td class="auto-style18"><b>Access:</b></td><td class="auto-style19"><i>Public</i></td></tr></table></td>
            <td></td></tr>
    </table>

</asp:Content>
