<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfRiverViewRegulations.aspx.cs" Inherits="FishTracker.Resources.Regulations" %>

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
    <input  type="hidden" runat='server' id="hdFishList"/>

    <table border="0">
        <tr>
            <td>[&nbsp;<asp:HyperLink ID="hlinkGeneral"     runat="server"  >General</asp:HyperLink>&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;<asp:HyperLink ID="hlinkFishing"     runat="server"  >Fishing</asp:HyperLink>&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;Regulations&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;Weather&nbsp;]</td><td>&nbsp;&nbsp;</td>
            <td>[&nbsp;<asp:HyperLink ID="HyperLinkEdit"    runat="server"  >Edit</asp:HyperLink>&nbsp;]</td>
        </tr>
    </table>

    <table style="width: 750px">
        <tr><td class="auto-style9"><table><tr><td class="auto-style14"><h3>Fishing on <%=riverName.Value%></h3></td><td class="auto-style13"><h3><%=stateCountry.Value%></h3></td></tr></table></td>
            <td><h3 class="auto-style44"><%=description.Value%></h3></td></tr>
    </table>
<hr/>
 <asp:PlaceHolder ID="phException" runat="server"> 
 </asp:PlaceHolder>
    <h3>Zone-wide Regulations for Fisheries Management <%=Zone.Value%></h3>
    <table style="width: 910px"><tr><td class="auto-style25">
        <tr>
            <td class="auto-style41"><b>Waters</b></td>
            <td class="auto-style40"><b>Species</b></td>
            <td class="auto-style38"><b>Close Time</b></td>
            <td class="auto-style40"><b>Sport Licence</b></td>
            <td class="auto-style40"><b>Recreational Licence</b></td>
        </tr>
        <%=hdFishList.Value%>
    </table>
  <hr/>
    <table>
        <tr><td class="auto-style16"><b>Fishing License</b>:</td><td class="auto-style17"><i>Required</i></td>
        <td class="auto-style18"><b>Access:</b></td><td class="auto-style19"><i>Public</i></td></tr>
    </table>
    <table>
        <tr>
            <td class="auto-style21"><b><%=stateName.Value%> Fishing Rules: </b><p><%=stateRules.Value%></p></td>
            <td>
                <table>
                    <tr><td class="auto-style22"><b><%=stateName.Value%> Residents</b></td><td class="auto-style22"><%=stateResidentFee.Value%></td></tr>
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
