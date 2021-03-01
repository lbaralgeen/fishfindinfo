<%@ Page Title="Trips" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Trips.aspx.cs" Inherits="FishTracker.Trips" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

<style type="text/css">
.formatText{color:Green;font-size:11px;font-family:Arial;font-weight:bold;}
</style>

</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

 <table>
    <tr>
      <td>
          <table><tr>
          <td class="style11">
              <asp:Label ID="LabelPostal" runat="server" Text="Postal" 
                  Font-Names="Arial" ForeColor="Black"></asp:Label></td>
          <td class="style11">
              <asp:Label ID="LabelLat" runat="server" Text="44.2366" 
                  Font-Names="Arial" ForeColor="Black"></asp:Label></td>
          <td class="style11">
              <asp:Label ID="LabelLon" runat="server" Text="-76.5549" 
                  Font-Names="Arial" ForeColor="Black"></asp:Label></td>
          </tr></table>
      </td>  
      <td>
    <input  type="hidden" runat='server' id="paramLat" value="43" />
    <input  type="hidden" runat='server' id="paramLon" value="-80" />

    <input  type="hidden" runat='server' id="mapLat" value="43" />
    <input  type="hidden" runat='server' id="mapLon" value="-80" />

      </td>
      <td>
<iframe style="border:1px grey solid;" frameborder="0" width="600px" height="480px" src="http://www.grandriver.ca/waterdata/kiwischarts/wq_watertemperature.html"></iframe>
      </td>
  </tr>
  </table>

</asp:Content>

