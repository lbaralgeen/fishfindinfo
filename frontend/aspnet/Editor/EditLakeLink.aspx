<%@ Page Title="Lake Editor" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="EditLakeLink.aspx.cs" Inherits="FishTracker.Editor.EditLakeLink" %>

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
        </style>
    <script type="text/javascript">            function initialize() { } </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <input  type="hidden" runat='server' id="hiddenLakeGuid" />
    <asp:HiddenField ID="HiddenFieldSide" runat="server" />
    <asp:HiddenField ID="HiddenFieldPoint" runat="server" />

<table><tr>
    <td><asp:HyperLink ID="hlLakeEdit" runat="server" NavigateUrl="LakeEditor.aspx">Description</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlWaterState" runat="server" >State</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlDocs" runat="server" >Maps</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlSource" runat="server" >Source</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlMouth" runat="server" >Mouth</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlLink" runat="server" >Tributary</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="hlFish" runat="server" >Fishing</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td>[&nbsp;<asp:HyperLink ID="HyperLinkView" runat="server">View</asp:HyperLink>&nbsp;]</td>
</tr></table>
<table style="width: 889px">
    <tr>
        <td class="auto-style41">Lake Name:</td>
        <td class="auto-style43"><asp:TextBox ID="txLakeName" runat="server" style="margin-left: 35px" Width="280px" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">GUID:</td>
        <td class="auto-style1"><asp:TextBox ID="txGuidLake" runat="server" style="margin-left: 35px" Width="280px"  Height="16px" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox></td>
    </tr> 
    <tr>
        <td class="auto-style41"><asp:Label ID="LabelPoint" runat="server" Text="Point"></asp:Label>:</td>
        <td class="auto-style43"><asp:TextBox ID="TextBoxPoint" runat="server" style="margin-left: 35px" Width="280px" BackColor="#CCCCCC" ReadOnly="True"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">GUID:</td>
        <td class="auto-style1"><asp:TextBox ID="TextBoxPointGuid" runat="server" style="margin-left: 35px" Width="280px"  Height="16px"></asp:TextBox></td>
    </tr> 
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
    <tr>
        <td class="auto-style41">Flow Type:</td>
        <td class="auto-style43">                
            <asp:DropDownList ID="ddlFlow" runat="server">
                    <asp:ListItem Selected="True"></asp:ListItem>
                    <asp:ListItem Value="4">Inflow</asp:ListItem>
                    <asp:ListItem Value="8">Outflow</asp:ListItem>
                    <asp:ListItem Value="16">Source</asp:ListItem>
                    <asp:ListItem Value="32">Mouth</asp:ListItem>
                </asp:DropDownList></td>
        <td class="auto-style44"></td>
        <td class="auto-style51"><asp:Label ID="LabelType" runat="server" Text="Side Type:"></asp:Label></td>
        <td class="auto-style1">
                <asp:DropDownList ID="ddlCoast" runat="server">
                    <asp:ListItem Selected="True"></asp:ListItem>
                    <asp:ListItem Value="R">Right</asp:ListItem>
                    <asp:ListItem Value="L">Left</asp:ListItem>
                </asp:DropDownList>
        </td>
    </tr> 
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
    <tr>
        <td class="auto-style41">Zone:</td>
        <td class="auto-style43"><asp:TextBox ID="TextBoxZone" runat="server" style="margin-left: 35px" Width="280px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">District:
        </td>
        <td class="auto-style48"><table><tr>
            <td><asp:TextBox ID="TextBoxDistrict" runat="server"  style="margin-left: 35px" Width="306px"></asp:TextBox></td>
            <td><asp:Button ID="btPrvLast" runat="server" Text="L" Height="17px" OnClick="btPrvLast_Click" Width="16px" /></td>
            </tr></table>
        </td>
    </tr> 
    <tr>
        <td class="auto-style41">Country:</td>
        <td class="auto-style43">
            <asp:RadioButton ID="RadioButtonCanada" runat="server" OnCheckedChanged="RadioButtonCanada_CheckedChanged" Text="Canada" AutoPostBack="True" />
            <asp:RadioButton ID="RadioButtonUSA" runat="server" Text="USA" AutoPostBack="True" OnCheckedChanged="RadioButtonCanada_CheckedChanged" />
        </td>
        <td class="auto-style44"></td>
        <td class="auto-style51">State:</td>
        <td class="auto-style1">
            <asp:DropDownList ID="DropDownListContry" runat="server">
            </asp:DropDownList>
        </td>
    </tr> 
    <tr>
        <td class="auto-style41">County:</td>
        <td class="auto-style43"><asp:TextBox ID="TextBoxCounty" runat="server"  style="margin-left: 35px" Width="280px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">City:</td>
        <td class="auto-style1"><asp:TextBox ID="TextBoxCity" runat="server" style="margin-left: 35px" Width="280px" Height="16px"></asp:TextBox></td>
    </tr> 
    <tr>
        <td class="auto-style41">Region:</td>
        <td class="auto-style43"><asp:TextBox ID="TextBoxRegion" runat="server" style="margin-left: 35px" Width="280px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">Municipality:</td>
        <td class="auto-style1"><asp:TextBox ID="TextBoxMunicipality" runat="server" style="margin-left: 35px" Width="280px"></asp:TextBox></td>
    </tr> 
    <tr>
        <td class="auto-style41">Lattitude:</td>
        <td class="auto-style43"><asp:TextBox ID="TextBoxLat" runat="server" style="margin-left: 35px" Width="280px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">Longitude:</td>
        <td class="auto-style1"><asp:TextBox ID="TextBoxLon" runat="server" style="margin-left: 35px" Width="280px"></asp:TextBox></td>
    </tr> 
    <tr>
        <td class="auto-style41">Elevation:</td>
        <td class="auto-style43"><asp:TextBox ID="TextBoxElevation" runat="server" style="margin-left: 35px" Width="280px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51"></td>
        <td class="auto-style48"></td>
    </tr> 
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td></td></tr> 
    <tr>
        <td class="auto-style41">Location:</td>
        <td class="auto-style43"><asp:TextBox ID="TextBoxLocation" runat="server" style="margin-left: 35px" Width="280px" Height="50px" TextMode="MultiLine" ></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">Description:</td>
        <td class="auto-style1"><asp:TextBox ID="TextBoxDescription" runat="server" style="margin-left: 35px" Width="280px" Height="50px" TextMode="MultiLine"></asp:TextBox></td>
    </tr> 
        <tr><td class="auto-style49">
            <asp:CheckBox ID="cbxLock" runat="server" Text="Locked" />
            </td>
            <td class="auto-style40">
                <asp:CheckBox ID="CheckBoxCopyToMouth" runat="server" Text="Copy To Mouth" />
            </td>
            <td></td><td class="auto-style52">
                  <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" Width="108px" OnClick="ButtonSubmit_Click" />
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
</table>
</asp:Content>

