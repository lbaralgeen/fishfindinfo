<%@ Page Title="River List" Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="RiverList.aspx.cs" Inherits="FishTracker.Forecast.RiverList" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-style1 {
            width: 75px;
        }
        .auto-style2 {
            width: 25px;
        }
        .auto-style4 {
            width: 125px;
        }

        </style>
    <script type="text/javascript">            function initialize() { } </script>


</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
 
      <table>
      <tr><td>
          <asp:RadioButtonList ID="RadioButtonListAZ" runat="server" RepeatColumns="26" Width="826px">
              <asp:ListItem Selected="True">A</asp:ListItem>
              <asp:ListItem>B</asp:ListItem>
              <asp:ListItem>C</asp:ListItem>
              <asp:ListItem>D</asp:ListItem>
              <asp:ListItem>E</asp:ListItem>
              <asp:ListItem>F</asp:ListItem>
              <asp:ListItem>G</asp:ListItem>
              <asp:ListItem>H</asp:ListItem>
              <asp:ListItem>I</asp:ListItem>
              <asp:ListItem>J</asp:ListItem>
              <asp:ListItem>K</asp:ListItem>
              <asp:ListItem>L</asp:ListItem>
              <asp:ListItem>M</asp:ListItem>
              <asp:ListItem>N</asp:ListItem>
              <asp:ListItem>O</asp:ListItem>
              <asp:ListItem>P</asp:ListItem>
              <asp:ListItem>Q</asp:ListItem>
              <asp:ListItem>R</asp:ListItem>
              <asp:ListItem>S</asp:ListItem>
              <asp:ListItem>T</asp:ListItem>
              <asp:ListItem>U</asp:ListItem>
              <asp:ListItem>X</asp:ListItem>
              <asp:ListItem>Y</asp:ListItem>
              <asp:ListItem>Z</asp:ListItem>
              <asp:ListItem Value="">ALL</asp:ListItem>
          </asp:RadioButtonList>
          </td></tr>
  </table>


  <table style="height: 24px; width: 892px;"><tr><td>
    <asp:DataList ID="DataListSpecies" runat="server" DataSourceID="CTRL" Width="845px" Height="24px" style="margin-right: 0px" CellPadding="4" ForeColor="#333333">
        <AlternatingItemStyle BackColor="White" />
        <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <ItemStyle BackColor="#EFF3FB" HorizontalAlign="Left" />
        <ItemTemplate>
            <table style="width: 800px"><tr>
                <td style="width: 25px"><%# Eval("num") %></td><td>|</td>
                <td style="width: 150px"><a href="/Forecast/wfRiverViewer.aspx?LakeId=<%# Eval("lake_id") %>" style="text-align: left"><%# Eval("lake_name") %></a></td><td>|</td>
                <td style="width: 75px"><%# Eval("alt_Name") %></td><td>|</td>
                <td style="width: 15px"><%# Eval("state") %></td><td>|</td>
                <td style="width: 15px"><%# Eval("country") %></td><td>|</td>
                <td style="width: 150px"><%# Eval("county") %></td><td> </td>
            </tr></table>
        </ItemTemplate>
        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    </asp:DataList>
  </td></tr></table>

    <asp:SqlDataSource ID="CTRL" runat="server" 
            ConnectionString="<%$ ConnectionStrings:fishConnectionString %>" 
            SelectCommand="SELECT * FROM dbo.fn_river_list( 'ON', 'CA', 1, 'Z' ) ORDER BY lake_name ASC">
    </asp:SqlDataSource>

</asp:Content>

