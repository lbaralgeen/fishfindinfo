<%@ Page Title="Canadian Rivers Menu" Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="RscMenu.aspx.cs" Inherits="FishTracker.Resources.RscMenu" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .LinkStyleHD {  width: 480px;  font-size: 12px; }
        .LinkStyleUD {  width: 480px;  font-size: 24px; }
        .auto-style8 {  width: 223px; }
        .auto-style9 {  width: 159px; }
        .auto-style10 {
            width: 223px;
            height: 72px;
        }
        .auto-style11 {
            width: 159px;
            height: 52px;
        }
        </style>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:HiddenField ID="HiddenCountry" runat="server" />

    <table>
        <tr><td class="auto-style10"><asp:HyperLink ID="hl1" runat="server" CssClass="LinkStyleHD" Font-Size="XX-Large">Lake</asp:HyperLink></td><td class="auto-style11"><asp:Label ID="lb1" runat="server" Text="0"></asp:Label></td></tr>
        <tr><td class="auto-style10"><asp:HyperLink ID="hl2" runat="server" CssClass="LinkStyleHD" Font-Size="XX-Large">River</asp:HyperLink></td><td class="auto-style9"><asp:Label ID="lb2" runat="server" Text="0"></asp:Label></td></tr>
        <tr><td class="auto-style10"><asp:HyperLink ID="hl4" runat="server" CssClass="LinkStyleHD" Font-Size="XX-Large">Stream</asp:HyperLink></td><td class="auto-style9"><asp:Label ID="lb4" runat="server" Text="0"></asp:Label></td></tr>
        <tr><td class="auto-style10"><asp:HyperLink ID="hl8" runat="server" CssClass="LinkStyleHD" Font-Size="XX-Large">Pond</asp:HyperLink></td><td class="auto-style9"><asp:Label ID="lb8" runat="server" Text="0"></asp:Label></td></tr>
        <tr><td class="auto-style10"><asp:HyperLink ID="hl32" runat="server" CssClass="LinkStyleHD" Font-Size="XX-Large">Backwater</asp:HyperLink></td><td class="auto-style9"><asp:Label ID="lb32" runat="server" Text="0"></asp:Label></td></tr>
        <tr><td class="auto-style10"><asp:HyperLink ID="hl64" runat="server" CssClass="LinkStyleHD" Font-Size="XX-Large">Creek</asp:HyperLink></td><td class="auto-style9"><asp:Label ID="lb64" runat="server" Text="0"></asp:Label></td></tr>
        <tr><td class="auto-style10"><asp:HyperLink ID="hl128" runat="server" CssClass="LinkStyleHD" Font-Size="XX-Large">Canal</asp:HyperLink></td><td class="auto-style9"><asp:Label ID="lb128" runat="server" Text="0"></asp:Label></td></tr>
        <tr><td class="auto-style10"><asp:HyperLink ID="hl8192" runat="server" CssClass="LinkStyleHD" Font-Size="XX-Large">Reservoir</asp:HyperLink></td><td class="auto-style9"><asp:Label ID="lb8192" runat="server" Text="0"></asp:Label></td></tr>
        <tr><td class="auto-style8"></td><td class="auto-style9"></td></tr>
        <tr><td class="auto-style8"></td><td class="auto-style9"></td></tr>
        <tr><td class="auto-style8">Version: <%= Request.Browser.EcmaScriptVersion %></td><td class="auto-style9">Platform: <%= Request.Browser.Platform %></td></tr>
        <tr><td class="auto-style8">Crawler: <%= Request.Browser.Crawler %></td><td class="auto-style9">Browser: <%= Request.Browser.Browser %></td></tr>
        <tr><td class="auto-style8">Hight:</td><td class="auto-style9"><asp:Label ID="lbHeight" runat="server" Text="0"></asp:Label></td></tr>
        <tr><td class="auto-style8">Weight:</td><td class="auto-style9"><asp:Label ID="lbWeight" runat="server" Text="0"></asp:Label></td></tr>
    </table>
</asp:Content>
