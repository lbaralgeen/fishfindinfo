<%@ Page Title="Fish List" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="FishList.aspx.cs" Inherits="FishTracker.TFishList" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-style1 {
            width: 373px;
        }
        .auto-style2 {
            width: 101px;
        }
        .auto-style4 {
            width: 107px;
            height: 46px;
        }
        .auto-style5 {
            height: 46px;
        }
        .auto-style6 {
            width: 372px;
            height: 24px;
        }
        .auto-style10 {
            width: 372px;
            height: 32px;
        }
        .auto-style11 {
            width: 250px;
            height: 32px;
        }
        .auto-style14 {
            width: 46px;
        }
        .auto-style15 {
            width: 300px;
            height: 32px;
        }
        .auto-style16 {
            width: 72px;
        }
        .auto-style17 {
            width: 103px;
        }
        </style>
    <script type="text/javascript">            function initialize() { } </script>


</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <table style="width: 306px"><tr><td class="auto-style17">Type of specie: </td>
      <td><asp:Label ID="LabelTypeFishes" runat="server" Text="All"></asp:Label>
      </td></tr></table>
  <table><tr><td>&deg;</td><td class="auto-style16"><a href="FishList.aspx">All</a></td>
             <td>&deg;</td><td class="auto-style16"><a href="FishList.aspx?fish_type=1">Sport</a></td>
             <td>&deg;</td><td class="auto-style16"><a href="FishList.aspx?fish_type=2">Commercial</a></td>
             <td>&deg;</td><td class="auto-style16"><a href="FishList.aspx?fish_type=4">Invading</a></td>
             <td>&deg;</td><td class="auto-style16"><a href="FishList.aspx?fish_type=8">Predator</a></td>
             <td>&deg;</td><td class="auto-style16"><a href="FishList.aspx?fish_type=-1">Unassigned</a></td> 
      <td>&deg;</td><td class="auto-style16"><asp:TextBox ID="tbFishSearch" runat="server" Width="200px"></asp:TextBox></td> 
      <td class="auto-style16"> 
          <asp:Button ID="btSearchFish" runat="server" Text="Search" Width="101px" OnClick="btSearchFish_Click" />
      </td> 
  </tr></table>
  <table><tr><td>
    <asp:DataList ID="DataListSpecies" runat="server" DataSourceID="CTRL" Width="845px" Height="24px" style="margin-right: 0px" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" GridLines="Both">
        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        <ItemStyle BackColor="White" ForeColor="#003399" HorizontalAlign="Left" />
        <ItemTemplate>
            <table style="height: 18px; width: 826px"><tr><td class="auto-style14">[<%# Eval("num") %>]</td><td class="auto-style15">
                <a href="/Editor/FishEditor.aspx?fishId=<%# Eval("fish_id") %>" style="text-align: left"><%# Eval("fish_name") %></a>
            </td><td class="auto-style10"> 
                 <asp:Label ID="LabelId" runat="server" Text='<%# Eval("fish_id") %>' style="font-weight: 700" /></td>
            </td><td class="auto-style11" style="text-align: left">
                    <asp:Label ID="latinLabel" runat="server" style="font-weight: 700" Text='<%# Eval("fish_latin") %>' />
                </td></tr>
            </table>
        </ItemTemplate>
        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
    </asp:DataList>
  </td></tr></table>

    <asp:SqlDataSource ID="CTRL" runat="server" 
            ConnectionString="<%$ ConnectionStrings:xConnectionString %>" 
            SelectCommand="select * from dbo.fn_get_fish_list_type( 32 ) ORDER BY fish_name ASC">
    </asp:SqlDataSource>

</asp:Content>

