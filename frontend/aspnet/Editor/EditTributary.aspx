<%@ Page validateRequest="false" Title="Tributary Editor" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="EditTributary.aspx.cs" 
        Inherits="FishTracker.Editor.EditTributary" %>

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
            margin-left: 4px;
        }
        .auto-style54 {
            width: 244px;
            height: 1px;
        }
        .auto-style55 {
            width: 8px;
            height: 1px;
        }
        .auto-style56 {
            height: 1px;
        }
        textarea.GuidStyle { resize:none; width: 300px; height: 16px; overflow: auto; }
        </style>
    <script type="text/javascript">            
        function initialize() { } 
        function doalert(id)
        {
            if(document.getElementById(id).checked )
            {
                var bt = document.getElementById('<%=ButtonDelHidden.ClientID%>');
                var value=document.getElementById('<%=hiddenDelLakeGuid.ClientID%>');

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
    <asp:HiddenField ID="hiddenGridTurb" runat="server" />
    <asp:HiddenField ID="hiddenDelLakeGuid" runat="server" Value="1" />

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
        <td class="auto-style1"><asp:TextBox ID="txGuidLake" runat="server" style="margin-left: 35px" Width="280px"  Height="16px" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox></td>
    </tr> 
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style54"></td><td class="auto-style55"></td><td class="auto-style47"></td><td class="auto-style56"></td></tr> 
    <tr>
        <td class="auto-style41">&nbsp;</td>
        <td class="auto-style43">                
            &nbsp;</td>
        <td class="auto-style44"></td>
        <td class="auto-style51">
            <asp:Label ID="LabelFlow0" runat="server" Text="Flow Type:"></asp:Label>
        </td>
        <td class="auto-style1">
            <asp:DropDownList ID="ddlFlow" runat="server" Height="16px">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="4">Inflow Lake</asp:ListItem>
                <asp:ListItem Value="8">Outflow Lake</asp:ListItem>
                <asp:ListItem Value="1">Link</asp:ListItem>
                <asp:ListItem Value="2">Throw</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr> 
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
    <tr>
        <td class="auto-style41">Lattitude:</td>
        <td class="auto-style43"><asp:TextBox ID="TextBoxLat" runat="server" style="margin-left: 35px" Width="280px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">Level:&nbsp;</td>
        <td class="auto-style1">
           <table><tr><td>
               <asp:TextBox ID="txtLevel" runat="server" Width="88px" CssClass="auto-style53"></asp:TextBox>
               </td><td>[m]</td></tr></table>
         </td>
    </tr> 
    <tr>
        <td class="auto-style41">Longitude:</td>
        <td class="auto-style43"><asp:TextBox ID="TextBoxLon" runat="server" style="margin-left: 35px" Width="280px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">Guid:</td>
        <td class="auto-style48"><asp:TextBox ID="TextBoxGuid" runat="server" Width="280px" CssClass="auto-style53"></asp:TextBox></td>
    </tr> 
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
    <%=hiddenGrid.Value%>
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
    <tr><td class="auto-style49">
        <asp:CheckBox ID="cbxLock" runat="server" Text="Locked" />
        </td>
        <td class="auto-style40">
            <asp:CheckBox ID="CheckBoxDelRiver" runat="server" Visible="False" ToolTip="1" />
            <asp:Button ID="ButtonDelHidden" runat="server" Text="X" OnClick="ButtonDelTributary_Click" Height="16px" Width="16px" />
        </td>
        <td></td><td class="auto-style52">
                <asp:Button ID="ButtonSubmit" runat="server" Text="Add" Width="108px" OnClick="ButtonSubmit_Click" />
            </td><td>
                <table>
                    <tr>
                        <td class="auto-style83"></td>
                        <td class="auto-style82">Edited by: </td>
                        <td class="auto-style85"><asp:Label ID="LabelEditedBy" runat="server" Text=""></asp:Label></td>
                        <td class="auto-style84"><asp:Label ID="LabelStamp" runat="server" Text="Label"></asp:Label></td>
                </tr>
                </table>
    </td></tr> 
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
    <%=hiddenGridTurb.Value%>
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
</table>
</asp:Content>

