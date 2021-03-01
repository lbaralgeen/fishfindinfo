<%@ Page Title="Fish Tracker" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="FishTracker._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style>
        .style3
        {
            width: 189px;
            text-align: left;
        }
        .style4
        {
            width: 904px;
        }
        .style10
        {
            color: #006600;
            text-align: center;
        }
        .auto-style1 {
            color: #006600;
            text-align: left;
            width: 40px;
        }
        .auto-style9 {
            width: 668px;
        }
        .auto-style10 {
            width: 668px;
            text-align: left;
        }
        .auto-style11 {
            width: 662px;
        }
        .auto-style12 {
            width: 227px; vertical-align: top;
        }
        .auto-style13 {
            width: 424px;
        }
        .auto-style15 {
            height: 29px;
            width: 667px;
        }
        .auto-style16 {
            width: 667px;
        }
        .auto-style17 {
            width: 667px;
            text-align: left;
        }
        .auto-style18 {
            width: 661px;
        }
        .auto-style20 {
            width: 689px;
        }
        .auto-style22 {
            height: 110px;
        }
        .auto-style23 {
            width: 919px;
            vertical-align: top;
            height: 21px;
        }
        .auto-style24 {
            width: 919px;
            vertical-align: top;
            height: 16px;
        }
        .auto-style25 {
            width: 702px;
            height: 138px;
        }
        .auto-style26 {
            width: 919px;
            vertical-align: top;
            vertical-align: top;
            height: 138px;
        }
        .auto-style27 {
            width: 372px;
        }
        </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <input  type="hidden" runat='server' id="hd_NewsTitleA" />
    <input  type="hidden" runat='server' id="hd_NewsDateA" />
    <input  type="hidden" runat='server' id="hd_NewsAuthorA" />
    <input  type="hidden" runat='server' id="hd_NewsSourceA" />
    <input  type="hidden" runat='server' id="hd_News0A" />
    <input  type="hidden" runat='server' id="hd_News1A" />
    <input  type="hidden" runat='server' id="hd_NewsCredit0A" />
    <input  type="hidden" runat='server' id="hd_NewsFlag1" Value="empty.gif" />
    <input  type="hidden" runat='server' id="hd_NewsAltFlag1"  Value="No image"/>

    <input  type="hidden" runat='server' id="hd_NewsTitleB" />
    <input  type="hidden" runat='server' id="hd_NewsDateB" />
    <input  type="hidden" runat='server' id="hd_NewsAuthorB" />
    <input  type="hidden" runat='server' id="hd_NewsSourceB" />
    <input  type="hidden" runat='server' id="hd_News0B" />
    <input  type="hidden" runat='server' id="hd_News1B" />
    <input  type="hidden" runat='server' id="hd_NewsCredit0B" />
    <input  type="hidden" runat='server' id="hd_NewsFlag2" Value="empty.gif"/>
    <input  type="hidden" runat='server' id="hd_NewsAltFlag2" Value="No image" />

    <input  type="hidden" runat='server' id="hd_LastEditedRiver" />
    <input  type="hidden" runat='server' id="hd_LastEditedRiverDate" />
    <input  type="hidden" runat='server' id="hd_LastEditedRiverNative" />
    <input  type="hidden" runat='server' id="hd_LastEditedRiverLink" />
    <input  type="hidden" runat='server' id="hd_LastRiverText" />

    <input  type="hidden" runat='server' id="hd_LastEditedLake" />
    <input  type="hidden" runat='server' id="hd_LastEditedLakeDate" />
    <input  type="hidden" runat='server' id="hd_LastEditedLakeNative" />
    <input  type="hidden" runat='server' id="hd_LastEditedLakeLink" />
    <input  type="hidden" runat='server' id="hd_LastLakeText" />

    <input  type="hidden" runat='server' id="hd_NewsTitleSmall1" />
    <input  type="hidden" runat='server' id="hd_NewsDateSmall1" />
    <input  type="hidden" runat='server' id="hd_NewsSourceSmall1" />
    <input  type="hidden" runat='server' id="hd_NewsSmall1" />

    <input  type="hidden" runat='server' id="hd_NewsTitleSmall2" />
    <input  type="hidden" runat='server' id="hd_NewsDateSmall2" />
    <input  type="hidden" runat='server' id="hd_NewsSourceSmall2" />
    <input  type="hidden" runat='server' id="hd_NewsSmall2" />

    <input  type="hidden" runat='server' id="hd_NewsTitleSmall3" />
    <input  type="hidden" runat='server' id="hd_NewsDateSmall3" />
    <input  type="hidden" runat='server' id="hd_NewsSourceSmall3" />
    <input  type="hidden" runat='server' id="hd_NewsSmall3" />
    <input  type="hidden" runat='server' id="hd_LastTop10" />

    <table>
    <tr><td>
        <table>
        <tr><td class="auto-style25">      <!-- Top news -->
            <!-- Left Top news -->
            <table class="auto-style20">
              <tr><td class="auto-style16"><b><%=hd_NewsTitleA.Value%></b></td><td style="border-left: 1px solid red; padding: 5px;">&nbsp;</td></tr>
              <tr><td class="auto-style17">
                  <table class="auto-style11"><tr>
                    <td><%=hd_NewsAuthorA.Value%></td>
                    <td>
                      <img src="/Images/flag/<%=hd_NewsFlag1.Value%>" alt="<%=hd_NewsAltFlag1.Value%>">
                      <%=hd_NewsSourceA.Value%></td>
                    <td><em><%=hd_NewsDateA.Value%></em></td>
                  </tr></table>
                  </td>
                  <td style="border-left: 1px solid red; padding: 1px;"></td></tr>
              <tr><td class="auto-style16" >
                  <table><tr>
                        <td class="auto-style12"><asp:Image ID="Image_News0" runat="server" /><br><%=hd_NewsCredit0A.Value%></td>
                        <td class="auto-style13"><%=hd_News0A.Value%></td>
                  </tr></table>
                  </td>
                  <td style="border-left: 1px solid red; padding: 5px;">&nbsp;</td></tr>
              <tr><td class="auto-style16"><p class="auto-style18"><%=hd_News1A.Value%></p></td>
                  <td style="border-left: 1px solid red; padding: 5px;">&nbsp;</td></tr>
              <tr><td>
                  <table><tr>
                      <td class="auto-style27"><asp:HyperLink ID="hl_LinkLake1" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td class="auto-style27"><asp:HyperLink ID="hl_fish1Lake1" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td class="auto-style27"><asp:HyperLink ID="hl_fish2Lake1" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td class="auto-style27"><asp:HyperLink ID="hl_fish3Lake1" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td style="text-align:right" class="auto-style15"><asp:HyperLink ID="hl_NewsSourceLinkA" runat="server" Target="_blank">Continue...</asp:HyperLink></td>
                  </tr></table>
                  </td>
                  <td style="border-left: 1px solid red; padding: 1px;"></td></tr>
              <tr><td><hr></td></tr>
              <!-- Second news --> 
              <tr><td class="auto-style9"><b><%=hd_NewsTitleB.Value%></b></td>
                  <td style="border-left: 1px solid red; padding: 1px;"></td>
              </tr>
              <tr><td class="auto-style10">
                    <table class="auto-style11"><tr>
                        <td><%=hd_NewsAuthorB.Value%></td>
                        <td>
                            <img src="/Images/flag/<%=hd_NewsFlag2.Value%>" alt="<%=hd_NewsAltFlag2.Value%>">
                            <%=hd_NewsSourceB.Value%></td>
                        <td><em><%=hd_NewsDateB.Value%></em></td>
                    </tr></table>
                  </td>
                  <td style="border-left: 1px solid red; padding: 1px;"></td>
              </tr>
              <tr><td class="auto-style9" >
                  <table><tr>
                      <td class="auto-style12"><asp:Image ID="Image_News1" runat="server" /><br><%=hd_NewsCredit0B.Value%></td>
                      <td class="auto-style13"><%=hd_News0B.Value%></td>
                  </tr></table>
                  </td>
                  <td style="border-left: 1px solid red; padding: 5px;">&nbsp;</td>
              </tr>
              <tr><td class="auto-style9"><p><%=hd_News1B.Value%></p></td>
                  <td style="border-left: 1px solid red; padding: 5px;">&nbsp;</td>
              </tr>
              <tr><td>
                  <table><tr>
                      <td class="auto-style27"><asp:HyperLink ID="hl_LinkLake2" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td class="auto-style27"><asp:HyperLink ID="hl_fish1Lake2" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td class="auto-style27"><asp:HyperLink ID="hl_fish2Lake2" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td class="auto-style27"><asp:HyperLink ID="hl_fish3Lake2" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td style="text-align:right" class="auto-style15"><asp:HyperLink ID="hl_NewsSourceLinkB" runat="server" Target="_blank">Continue...</asp:HyperLink></td>
                  </tr></table>
                  </td>
                  <td style="border-left: 1px solid red; padding: 5px;">&nbsp;</td></tr>
            </table>
        </td>
            <td class="auto-style26">
            <table class="auto-style22">
                <tr><td class="auto-style24">Last edited:&nbsp;<a href="<%=hd_LastEditedRiverLink.Value%>"><%=hd_LastEditedRiver.Value%></a>
                        <br><i><%=hd_LastEditedRiverNative.Value%></i>&nbsp;<em><%=hd_LastEditedRiverDate.Value%></em></td></tr>
                <tr><td class="auto-style23"><%=hd_LastRiverText.Value%></td></tr>
                <tr><td><hr></td></tr>
                <tr><td class="auto-style24">Last edited:&nbsp;<a href="<%=hd_LastEditedLakeLink.Value%>"><%=hd_LastEditedLake.Value%></a>
                        <br><i><%=hd_LastEditedLakeNative.Value%></i>&nbsp;<em><%=hd_LastEditedLakeDate.Value%></em></td></tr>
                <tr><td class="auto-style23"><%=hd_LastLakeText.Value%></td></tr>
                <tr><td><hr></td></tr>
                <tr><td class="auto-style24">&middot;<b><%=hd_NewsTitleSmall1.Value%></b>
                <br><i><%=hd_NewsSourceSmall1.Value%></i>&nbsp;<em><%=hd_NewsDateSmall1.Value%></em></td></tr>
                <tr><td class="auto-style23"><%=hd_NewsSmall1.Value%><br><asp:HyperLink ID="hl_SmallNewsLink1" runat="server" Target="_blank">Link...</asp:HyperLink></td></tr>
                <tr><td><hr></td></tr>
                <tr><td class="auto-style24">&middot;<b><%=hd_NewsTitleSmall2.Value%></b>
                <br><i><%=hd_NewsSourceSmall2.Value%></i>&nbsp;<em><%=hd_NewsDateSmall2.Value%></em></td></tr>
                <tr><td class="auto-style23"><%=hd_NewsSmall2.Value%><br><asp:HyperLink ID="hl_SmallNewsLink2" runat="server" Target="_blank">Link...</asp:HyperLink></td></tr>
                <tr><td><hr></td></tr>
                <tr><td class="auto-style24">&middot;<b><%=hd_NewsTitleSmall3.Value%></b>
                <br><i><%=hd_NewsSourceSmall3.Value%></i>&nbsp;<em><%=hd_NewsDateSmall3.Value%></em></td></tr>
                <tr><td class="auto-style23"><%=hd_NewsSmall3.Value%><br><asp:HyperLink ID="hl_SmallNewsLink3" runat="server" Target="_blank">Link...</asp:HyperLink></td></tr>
                <tr><td><hr></td></tr>
                <%=hd_LastTop10.Value%>
                <tr><td><hr></td></tr>
            </table>
            </td>
        </tr>
        </table>  
    </td></tr>
    </table>  

</asp:Content>
