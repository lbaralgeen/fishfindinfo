<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FishListFrame.aspx.cs" Inherits="FishTracker.Forecast.FishListFrame" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fish List</title>
    <style type="text/css">

    .styleTbl
    {
        clip: rect(auto, auto, auto, auto); table-layout: auto; vertical-align: top;
    }
    </style>
</head>
<body>
    <form id="frameFish" runat="server">
    <div style="width: 201px">
        <asp:ListBox ID="cblFish" runat="server" 
            DataTextField="name" DataValueField="name" 
            Height="289px" 
            Width="200px" AutoPostBack="True" CssClass="styleTbl" onload="cblFish_Load">
        </asp:ListBox>
    </div>
    </form>
</body>
</html>
