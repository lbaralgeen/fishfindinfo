<%@ Page Title="Fish Tracker" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="News.aspx.cs" Inherits="FishTracker.TNews" %>

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
        .auto-style11 {
            width: 857px;
        }
        .auto-style12 {
            width: 227px; vertical-align: top;
        }
        .auto-style13 {
            width: 436px;
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
            width: 864px;
        }
        .auto-style20 {
            width: 689px;
            height: 430px;
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
        .auto-style28 {
            height: 4px;
        }
        .auto-style29 {
            width: 860px;
        }
        </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <input  type="hidden" runat='server' id="hdNewsTitle" />
    <input  type="hidden" runat='server' id="hdNewsDate" />
    <input  type="hidden" runat='server' id="hdNewsAuthor" />
    <input  type="hidden" runat='server' id="hdNewsSource" />
    <input  type="hidden" runat='server' id="hdNews0" />
    <input  type="hidden" runat='server' id="hdNews1" />
    <input  type="hidden" runat='server' id="hdNewsCredit0" />
    <input  type="hidden" runat='server' id="hdNewsCreditLabel" />
    <input  type="hidden" runat='server' id="hdNewsFlag" Value="empty.gif" />
    <input  type="hidden" runat='server' id="hd_NewsAltFlag1"  Value="No image"/>
    <input  type="hidden" runat='server' id="hdNewsId" />
    <input  type="hidden" runat='server' id="hdTotal" />

    <table>
    <tr><td>
        <table>
        <tr><td class="auto-style25">      <!-- Top news -->
            <!-- Left Top news -->
            <table class="auto-style20">
              <tr><td class="auto-style16"><b><%=hdNewsTitle.Value%></b></td><td style="border-left: 1px solid red; padding: 5px;">&nbsp;</td></tr>
              <tr><td class="auto-style17">
                  <table class="auto-style11"><tr>
                    <td><%=hdNewsAuthor.Value%></td>
                    <td>
                      <img src="/Images/flag/<%=hdNewsFlag.Value%>" alt="<%=hd_NewsAltFlag1.Value%>">
                      <%=hdNewsSource.Value%></td>
                    <td><em><%=hdNewsDate.Value%></em></td>
                  </tr></table>
                  </td>
                  <td style="border-left: 1px solid red; padding: 1px;"></td></tr>
              <tr><td class="auto-style16" >
                  <table class="auto-style29"><tr><td class="auto-style12"><asp:Image ID="ImageNews0" runat="server" Visible="False" /><br><%=hdNewsCredit0.Value%></td>
                    <td class="auto-style13"><%=hdNews0.Value%></td>
                  </tr></table>
                  </td>
                  <td style="border-left: 1px solid red; padding: 5px;">&nbsp;</td></tr>
              <tr><td class="auto-style16"><p class="auto-style18"><%=hdNews1.Value%></p></td>
                  <td style="border-left: 1px solid red; padding: 5px;">&nbsp;</td></tr>
              <tr><td>
                  <table><tr>
                      <td class="auto-style27"><asp:HyperLink ID="hlLinkLake" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td class="auto-style27"><asp:HyperLink ID="hlfish1Lake" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td class="auto-style27"><asp:HyperLink ID="hlfish2Lake" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td class="auto-style27"><asp:HyperLink ID="hlfish3Lake" runat="server"  Visible="False">...</asp:HyperLink></td>
                      <td style="text-align:right" class="auto-style15"><asp:HyperLink ID="hlNewsSourceLink" runat="server" Target="_blank">Continue...</asp:HyperLink></td>
                  </tr></table>
                  </td>
                  <td style="border-left: 1px solid red; padding: 1px;"></td></tr>
              <tr><td>
                  <hr>
                  <asp:GridView ID="gvNews" runat="server" BackColor="White"
                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3"  
                        HorizontalAlign="Center" AutoGenerateColumns="False" Width="872px">
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White"
                            HorizontalAlign="Center" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <RowStyle ForeColor="#000066" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="News Id" />
                            <asp:HyperLinkField DataTextField="title" DataNavigateUrlFields="news_id" DataNavigateUrlFormatString="news.aspx?LeadID={0}" Text="Title" />
                            <asp:BoundField DataField="source" HeaderText="Source" />
                            <asp:BoundField DataField="stamp" HeaderText="Stamp" />
                            <asp:BoundField DataField="flag" HeaderText="country" />
                        </Columns></asp:GridView>
                  <hr class="auto-style28">
                  </td></tr>
                 <tr><td>
                    <table><tr>
                        <td><asp:HyperLink ID="hlFirstPage" runat="server">&#9664;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlLeft" runat="server">&larr;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlLeft1" runat="server" Visible="False">&hellip;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlLeft2" runat="server" Visible="False">&hellip;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlLeft3" runat="server" Visible="False">&hellip;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlLeftDots" runat="server" Visible="False">&hellip;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlCurrentPage" runat="server">&spades;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlRightDots" runat="server" Visible="False">&hellip;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlRight1" runat="server" Visible="False">&hellip;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlRight2" runat="server" Visible="False">&hellip;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlRight3" runat="server" Visible="False">&hellip;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlRight" runat="server">&rarr;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlLastPage" runat="server">&#9654;</asp:HyperLink></td>
                        <td><asp:HyperLink ID="hlNPages" runat="server"></asp:HyperLink></td>
                    </tr></table>  
                 </td></tr>
            </table>
        </td>
              <!-- Second news --> 
            <td class="auto-style26">

            </td>
        </tr>
        </table>  
    </td></tr>
    </table>  

</asp:Content>
