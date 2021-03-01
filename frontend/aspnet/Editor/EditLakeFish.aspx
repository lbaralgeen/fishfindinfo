<%@ Page validateRequest="false" Title="Fish Existence Editor" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="EditLakeFish.aspx.cs" Inherits="FishTracker.Editor.EditLakeFish" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
      .auto-style1 { width: 106px;  }
        .auto-style40 { width: 244px; }
        .auto-style41 {
            width: 137px;
            height: 5px;
        }
        .auto-style42 {
            width: 137px;
            height: 1px;
        }
        .auto-style43 {
            width: 280px;
            height: 5px;
        }
        .auto-style44 {
            height: 5px;
            width: 8px;
        }
        .auto-style45 {
            width: 8px;
        }
        .auto-style47 {
            width: 217px;
            height: 1px;
        }
        .auto-style48 {
            width: 40px;
            height: 5px;
        }
        .auto-style49 {
            width: 137px;
        }
        .auto-style51 {
            width: 217px;
            height: 5px;
        }
        .auto-style52 {
            width: 217px;
        }
        .auto-style53 {
            width: 321px;
            margin-left: 0px;
        }
        .auto-style54 { width: 30px; }
        </style>
    <script type="text/javascript">            
        function initialize() { } 
        function doalert(id)
        {
            if(document.getElementById(id).checked )
            {
                var bt = document.getElementById('<%=btDelFish.ClientID%>');
                var value=document.getElementById('<%=hiddenDelFishGuid.ClientID%>');

                if (bt != null && value != null)
                {
                    value.value = id;
                    bt.click();
                }
            }
        }
        function saveFish(id)
        {
            if(document.getElementById(id).checked )
            {
                var bt = document.getElementById('<%=btSaveFish.ClientID%>');
                var value=document.getElementById('<%=hiddenDelFishGuid.ClientID%>');

                if (bt != null && value != null)
                {
                    value.value = id;
                    bt.click();
                }
            }
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <input  type="hidden" runat='server' id="hiddenLakeGuid" />
    <asp:HiddenField ID="HiddenFieldSide" runat="server" />
    <asp:HiddenField ID="HiddenFieldPoint" runat="server" />
    <asp:HiddenField ID="hiddenGrid" runat="server" />
    <asp:HiddenField ID="hiddenDelFishGuid" runat="server" Value="1" />
    <asp:HiddenField ID="HiddenLastFishUrl" runat="server" />
    <asp:HiddenField ID="HiddenCheckList" runat="server" />
    <asp:HiddenField ID="HiddenSelectedFiesh" runat="server" />

<table><tr>
    <td><asp:HyperLink ID="hlLakeEdit" runat="server" NavigateUrl="LakeEditor.aspx">Description</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlWaterState" runat="server" >State</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlDocs" runat="server" >Maps</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlSource" runat="server" >Source</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlMouth" runat="server" >Mouth</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlLink" runat="server" >Tributary</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="HyperLinkEditLakeFish" runat="server" >Fishing</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="HyperLinkView" runat="server">View</asp:HyperLink></td>
</tr></table>
<table style="width: 889px">
    <tr>
        <td class="auto-style41">Lake Name:</td>
        <td class="auto-style43"><asp:TextBox ID="txLakeName" runat="server" style="margin-left: 35px" Width="280px" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">GUID:</td>
        <td class="auto-style1">
            <asp:TextBox ID="txGuidLake" runat="server" style="margin-left: 35px" Width="266px"  Height="16px" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox>
        </td>
    </tr> 
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
    <tr>
        <td class="auto-style41">Trust Level:</td>
        <td class="auto-style43">                
            <table class="auto-style53">
            <tr><td class="auto-style54"></td><td><asp:DropDownList ID="ddlTrustLevel" runat="server">
                <asp:ListItem Value="0">high priority</asp:ListItem>
                <asp:ListItem Value="1">site owner</asp:ListItem>
                <asp:ListItem Value="2">paid fisher</asp:ListItem>
                <asp:ListItem Value="3">unknown source</asp:ListItem>
            </asp:DropDownList></td></tr>
            </table>
        </td>
        <td class="auto-style44"></td>
        <td class="auto-style51">Link</td>
        <td class="auto-style1">
            <table><tr><td>
            <asp:TextBox ID="TextBoxSourceLink" runat="server" style="margin-left: 35px" Width="280px"></asp:TextBox>
                </td><td>
            <asp:ImageButton ID="ibtDelSelectedLastLinkFishLakeEditor" runat="server" ImageUrl="~/Images/delSel.png" OnClick="ibtDelSelectedLastLinkFishLakeEditor_Click" />
                </td><td>
            <asp:ImageButton ID="ibtPasteLastLinkFishLakeEditor" runat="server" ImageUrl="~/Images/paste.jpg" OnClick="ibtPasteLastLinkFishLakeEditor_Click" />
            </td></tr></table></td>
    </tr> 
    <tr>
        <td class="auto-style41">Guid:</td>
        <td class="auto-style48"><asp:TextBox ID="TextBoxGuid" runat="server" style="margin-left: 35px" Width="280px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">
            <asp:CheckBox ID="cbxLastHistory" runat="server" Text="History" />
        </td>
        <td class="auto-style43">
            <table> <tr>
                <td><asp:Button ID="ButtonSubmit" runat="server" Text="Add" Width="108px" OnClick="ButtonSubmit_Click" /></td> 
                <td><asp:CheckBox ID="ckAtRisk" runat="server" Text="At Risk" /></td>
            </tr></table> 
        </td>
    </tr> 
    <tr>
        <td class="auto-style41">How to:</td>
        <td class="auto-style48"><asp:TextBox ID="txtHunting" runat="server" style="margin-left: 35px" Width="280px" Height="43px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">
        </td>
        <td class="auto-style43">
            <table>
                <tr>
                    <td>
                        <asp:CheckBox ID="cbNoFish" runat="server" Text="No Fish" Enabled="False" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbFishingProhibited" runat="server" Text="Fishing Prohibited" Enabled="False" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
    <%=hiddenGrid.Value%>
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
    <%=HiddenCheckList.Value%>
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
        <tr><td class="auto-style49">
            <asp:CheckBox ID="cbxLock" runat="server" Text="Locked" />
            </td>
            <td class="auto-style40">
                <asp:CheckBox ID="CheckBoxDelFish" runat="server" Visible="False" ToolTip="1" />
                
            </td>
            <td></td><td class="auto-style52">
                </td><td>
                
                <asp:Button ID="btDelFish" runat="server" OnClick="ButtonDelFish_Click" Text="ButtonDelFish" />
                
                <asp:Button ID="btSaveFish" runat="server" OnClick="btSaveFish_Click" Text="SaveFish" />
                
            </td></tr> 
</table>
</asp:Content>

