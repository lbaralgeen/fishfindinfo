<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfRiverViewWeather.aspx.cs" Inherits="FishTracker.Resources.RiverViewWeather" %>

<asp:Content ID="ContentHeadLakeRegulationItem" ContentPlaceHolderID="HeadContent" runat="server">

            <style type="text/css">
                .auto-style9 {
                    width: 592px;
                }
                .auto-style23 {
                    width: 63px;
                }
                .auto-style24 {
                    width: 87px;
                }
                .auto-style25 {
                    width: 740px;
                }
                .auto-style38 {
                    width: 88px;
                    height: 5px;
                }
                .auto-style40 {
                    width: 61px;
                }
                .auto-style41 {
                    width: 60px;
                    height: 5px;
                }
                .auto-style42 {
                    width: 54px;
                }
                .auto-style43 {
                    width: 938px;
                }
                .auto-style44 {
                    width: 476px;
                }
            </style>

</asp:Content>

<asp:Content ID="ContentMainFishEditItem" ContentPlaceHolderID="MainContent" runat="server">
    <input  type="hidden" runat='server' id="riverName" value="" />
    <input  type="hidden" runat='server' id="RegulationsTxt" value="" />
    <input  type="hidden" runat='server' id="lakeId" value="9C537DD1-FC59-489E-A7A1-018B2921F19F" />

    <input  type="hidden" runat='server' id="description" value="" />
    <input  type="hidden" runat='server' id="location" value="" />
    <input  type="hidden" runat='server' id="stateCountry" value="[US] New York" />
    <input  type="hidden" runat='server' id="stateName" value="Ontario" />
    <input  type="hidden" runat='server' id="stateRules" value="License" />
    <input  type="hidden" runat='server' id="stateResidentFee" value="10" />
    <input  type="hidden" runat='server' id="stateNonResidentFee" value="55" />
    <input  type="hidden" runat='server' id="stateParkRules" value="" />
    <input  type="hidden" runat='server' id="Zone" value="" />

    <table border="0">
        <tr>
            <td>[&nbsp;<asp:HyperLink ID="hlinkGeneral"     runat="server" >General</asp:HyperLink>&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;<asp:HyperLink ID="hlinkFishing"     runat="server"  >Fishing</asp:HyperLink>&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;Regulations&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;Weather&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;<asp:HyperLink ID="HyperLinkEdit"    runat="server" >Edit</asp:HyperLink>&nbsp;]</td>
        </tr>
    </table>

    <table style="width: 750px">
        <tr><td class="auto-style9"><table><tr><td class="auto-style14"><h3>Fishing on <%=riverName.Value%></h3></td><td class="auto-style13"><h3><%=stateCountry.Value%></h3></td></tr></table></td>
            <td><h3 class="auto-style44"><%=description.Value%></h3></td></tr>
    </table>
<hr/>
<asp:PlaceHolder ID="phException" runat="server">
    <h3>Zone-wide Regulations for Fisheries Management <%=Zone.Value%></h3>
    <table style="width: 910px"><tr><td class="auto-style25">
        <table style="height: 18px; width: 904px;">
        <tr>
            <td class="auto-style41"><b>Waters</b></td>
            <td class="auto-style40"><b>Species</b></td>
            <td class="auto-style38"><b>Close Time</b></td>
            <td class="auto-style40"><b>Sport Licence</b></td>
            <td class="auto-style40"><b>Recreational Licence</b></td>
            </tr></table>
        </td></tr>
        <tr><td class="auto-style25">     
        <asp:DataList ID="DataListSpecies" runat="server" DataSourceID="CTRL" Width="905px" Height="24px" style="margin-right: 0px" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" GridLines="Both" OnSelectedIndexChanged="DataListSpecies_SelectedIndexChanged">
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <ItemStyle BackColor="White" ForeColor="#003399" HorizontalAlign="Left" />
            <ItemTemplate>
                <table style="height: 18px; width: 846px;"><tr>
                    <td class="auto-style41"> <%#Eval("part")%></a></td>
                    <td class="auto-style40"> <%#Eval("fish_name")%></a></td>
                    <td class="auto-style38"> <%#Eval("close_time")%></a></td>
                    <td class="auto-style40"> <%#Eval("sport")%></a></td>
                    <td class="auto-style40"> <%#Eval("conservation")%></a></td>
                </tr></table>
            </ItemTemplate>
            <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
        </asp:DataList>
        </td></tr>
    <asp:SqlDataSource ID="CTRL" runat="server" 
            ConnectionString="<%$ ConnectionStrings:xConnectionString %>" 
            SelectCommand="SELECT part, fish_name, close_time, sport, conservation FROM dbo.fn_lake_regulation('<%=lakeId.Value%>'))">
    </asp:SqlDataSource>
    </table>
  <hr/>
</asp:PlaceHolder>
<!-- </asp:PlaceHolder> --> 
    <table>
        <tr><td class="auto-style16"><b>Fishing License</b>:</td><td class="auto-style17"><i>Required</i></td>
        <td class="auto-style18"><b>Access:</b></td><td class="auto-style19"><i>Public</i></td></tr>
    </table>
    <table>
        <tr>
            <td class="auto-style21"><b><%=stateName.Value%> Fishing Rules: </b><p><%=stateRules.Value%></p></td>
            <td>
                <table>
                    <tr><td class="auto-style22"><b><%=stateName.Value%> Residents<b></td><td class="auto-style22"><%=stateResidentFee.Value%></td></tr>
                    <tr><td><b>Non-Residents</b></td><td><%=stateNonResidentFee.Value%></td></tr>
                    <%=RegulationsTxt.Value%>
                </table>
            </td>
        </tr>
        <tr>
            <td class="auto-style21"><b>National Parks: </b><p><%=stateParkRules.Value%></p></td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
