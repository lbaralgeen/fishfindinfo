<%@ Page validateRequest="false" Title="Canadian Rivers" Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="RscRiverList.aspx.cs" Inherits="FishTracker.Resources.Water" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .auto-styleNum { width:  15px; padding: 1px; border-right: 1px solid black; text-align: right;}
        .auto-styleFullName { width: 150px; padding: 1px; border-right: 1px solid black; text-align: left;}
        .auto-styleName { width: 75px; padding: 1px; border-right: 1px solid black; text-align: left;}
        .auto-styleLocation { width: 50px; padding: 1px; border-right: 1px solid black;  text-align: left;}
        .auto-styleGUID { width: 250px; padding: 1px; border-right: 1px solid black;  text-align: left;}
        .auto-styleRow  { height: 1px; padding: 1px; border-bottom: 1px solid black; }
        .auto-style8 {
            height: 31px;
        }
        .auto-style10 {
            height: 24px;
        }
        .auto-style11 {
            width: 89px;
        }
        </style>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:HiddenField ID="HiddenCountry" runat="server" />
    <asp:HiddenField ID="HiddenState" runat="server" />
    <asp:HiddenField ID="recordline" runat="server" />
    <asp:HiddenField ID="HiddenRiverType" runat="server" />
    <asp:HiddenField ID="HiddenNavigator" runat="server" />
    <asp:HiddenField ID="hfGuid" runat="server" Value="Guid"/>
    <asp:HiddenField ID="hfSynonim" runat="server" Value="Synonim"/>

    <asp:HiddenField ID="hdCurrentPage" runat="server"  Value="1"/>
    <asp:HiddenField ID="hdTotalPages" runat="server"  Value="1"/>
    <asp:HiddenField ID="hdIsFish" runat="server"  Value="1"/>
    <asp:HiddenField ID="hd_rscRiverList_Letter" runat="server"  Value="$"/>

     <table style="height: 72px">
     <tr><td>
          <asp:RadioButtonList ID="RadioButtonListAZ" runat="server" RepeatColumns="14" Width="688px" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonListAZ_SelectedIndexChanged" OnTextChanged="RadioButtonListAZ_SelectedIndexChanged">
              <asp:ListItem Selected="True">A</asp:ListItem>
              <asp:ListItem Value="$">ALL</asp:ListItem>
          </asp:RadioButtonList>
          </td>
          <td class="auto-style8">
              <table>  
              <tr>
                  <td><asp:CheckBox ID="cbMonitor" runat="server" Text="Monitoring" AutoPostBack="True" OnCheckedChanged="cbMonitor_CheckedChanged" /></td>
                  <td><asp:CheckBox ID="cbFish" runat="server" Text="Fish" AutoPostBack="True" OnCheckedChanged="cbFish_CheckedChanged" Checked="True" /></td>
              </tr>
              <tr><td>
                  <asp:Label ID="lbState" runat="server" Text="State:"></asp:Label>
                  </td><td><asp:DropDownList ID="ddlState" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
              </asp:DropDownList>
                  </td></tr>
              </table>  
          </td>
      </tr>
     </table>
      <table class="auto-style10"><tr><td class="auto-style9">
          <tr><td>
              <table class="auto-style18">
                  <tr><td class="auto-styleNum">#</td><td class="auto-styleFullName">Name</td><td class="auto-styleNum">Lat</td><td class="auto-styleNum">Lon</td><td class="auto-styleNum">Cnt</td><td class="auto-styleNum">ste</td><td class="auto-styleName"><%=hfSynonim.Value%></td><td class="auto-styleName">Source</td><td class="auto-styleName">Mouth</td><td class="auto-styleGUID"><%=hfGuid.Value%></td><td class="auto-styleNum">Fish</td><td class="auto-styleNum">Well</td></tr>
                  <tr style="background-color: #CCCCCC" class="styleRow"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                  <%=recordline.Value%>
              </table>
          </td></tr>
          <tr><td>
              <table><tr><td>
              <asp:RadioButtonList ID="rblNavigator" runat="server" RepeatDirection="Horizontal" Width="722px" AutoPostBack="True" OnSelectedIndexChanged="rblNavigator_SelectedIndexChanged">
                  <asp:ListItem Value="0">Start</asp:ListItem>
                  <asp:ListItem Value="1">Back</asp:ListItem>
                  <asp:ListItem Value="-1">First</asp:ListItem>
                  <asp:ListItem Value="-1">Current</asp:ListItem>
                  <asp:ListItem Value="-1">Forward</asp:ListItem>
                  <asp:ListItem Value="99998">Next</asp:ListItem>
                  <asp:ListItem Value="99999">Last</asp:ListItem>
              </asp:RadioButtonList>
                  </td>
                  <td class="auto-style11">
                      <asp:Label ID="LabelTotalPages" runat="server" Text="0 - pages"></asp:Label>
              </td></tr></table>
          </td></tr>
      </table>
</asp:Content>

