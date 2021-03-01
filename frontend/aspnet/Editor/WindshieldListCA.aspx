<%@ Page validateRequest="false" Title="Windshield List Canada" Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="WindshieldListCA.aspx.cs" Inherits="FishTracker.Editor.WindshieldListCA" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-styleNum { width:  15px; padding: 1px; border-right: 1px solid black; text-align: right;}
        .auto-styleFullName { width: 150px; padding: 1px; border-right: 1px solid black; text-align: left;}
        .auto-styleName { width: 75px; padding: 1px; border-right: 1px solid black; text-align: left;}
        .auto-styleLocation { width: 50px; padding: 1px; border-right: 1px solid black;  text-align: left;}
        .auto-styleGUID { width: 250px; padding: 1px; border-right: 1px solid black;  text-align: left;}
        .auto-styleRow  { height: 1px; padding: 1px; border-bottom: 1px solid black; }
        </style>
    <script type="text/javascript">            function initialize() { } </script>


</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:HiddenField ID="recordline" runat="server" />
    <asp:HiddenField ID="HiddenCountry" runat="server" />
    <asp:HiddenField ID="HiddenState" runat="server" />
    <asp:HiddenField ID="HiddenRiverType" runat="server" />
    <asp:HiddenField ID="HiddenNavigator" runat="server" />

    <table style="width: 800px" tabindex="0">
    <tr>
      <td class="auto-style25">
          &nbsp;</td>
      <td class="auto-style23">
          <asp:DropDownList ID="ddlState" runat="server">
              <asp:ListItem Value="ON">ON</asp:ListItem>
              <asp:ListItem Value="AL">AL</asp:ListItem>
          </asp:DropDownList>
      </td>
      <td class="auto-style20">
          <asp:DropDownList ID="ddlWatershield" runat="server" >
              <asp:ListItem Value="1">Lake</asp:ListItem>
              <asp:ListItem Value="2">River</asp:ListItem>
              <asp:ListItem Value="4">Stream</asp:ListItem>
              <asp:ListItem Value="8">Pond</asp:ListItem>
              <asp:ListItem Value="32">Creek</asp:ListItem>
              <asp:ListItem Value="64">Canal</asp:ListItem>
              <asp:ListItem Value="128">Estuary</asp:ListItem>
              <asp:ListItem Value="8192">Reservoir</asp:ListItem>
          </asp:DropDownList>
      </td>
      <td class="auto-style21">
          <asp:Button ID="ButtonSubmit" runat="server" Text="Select" Width="108px" OnClick="ButtonSubmit_Click" />
      </td>
      <td class="auto-style24">
          <asp:TextBox ID="txSearch" runat="server" Width="253px"></asp:TextBox>
      </td>
      <td>
              <asp:Button ID="btSearch" runat="server" Text="Search" Width="108px" OnClick="btSearch_Click" />
              <asp:Button ID="ButtonRnCan" runat="server" OnClick="ButtonRnCan_Click" Text="rncan.gc.ca" />
      </td>
    </tr>
  </table>
 
      <table>
      <tr><td>
          <asp:RadioButtonList ID="RadioButtonListAZ" runat="server" RepeatColumns="26" Width="900px">
              <asp:ListItem Selected="True">A</asp:ListItem>
              <asp:ListItem Value="">ALL</asp:ListItem>
          </asp:RadioButtonList>
          </td></tr>
  </table>

  <table class="auto-style10"><tr><td class="auto-style9">
      <tr><td>
          <table class="auto-style18">
              <tr><td class="auto-styleNum">#</td><td class="auto-styleFullName">Name</td><td class="auto-styleNum">Lat</td><td class="auto-styleNum">Lon</td><td class="auto-styleNum">Cnt</td><td class="auto-styleNum">ste</td><td class="auto-styleName">synonim</td><td class="auto-styleName">Source</td><td class="auto-styleName">Mouth</td><td class="auto-styleGUID">Guid</td><td class="auto-styleNum">Fish</td><td class="auto-styleNum">Well</td></tr>
              <tr style="background-color: #CCCCCC" class="styleRow"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
              <%=recordline.Value%>
          </table>
      </td></tr>
      <tr>
          <td class="auto-style9">
              <asp:Button ID="ButtonNewRiver" runat="server" OnClick="ButtonNewRiver_Click" Text="New Item" Width="85px"/>
              <asp:Button ID="btMerge"   runat="server" OnClick="MergeRiver_Click" Text="Link" Width="85px"/>
              <asp:HyperLink ID="HyperLinkLastLake" runat="server">Last Lake</asp:HyperLink>
          </td>
      </tr>
  </table>
</asp:Content>

