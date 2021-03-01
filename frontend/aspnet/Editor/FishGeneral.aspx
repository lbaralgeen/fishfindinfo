<%@ Page Title="Fish General" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
     CodeBehind ="FishGeneral.aspx.cs" Inherits="FishTracker.Editor.FishGeneral" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-style34 {
            height: 143px;
            width: 342px;
        }
        .auto-style35 {
            width: 342px;
        }
        .auto-style36 {
            width: 3px;
        }
        .auto-styleHD31 {
            width: 75px;
        }
        .auto-styleHD33 {
            width: 24px;
        }
        .auto-style39 {
            width: 376px;
        }
        </style>
    <script type="text/javascript">            function initialize() { } </script>

</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <input  type="hidden" runat='server' id="g_sFishName" value="43" />
    <input  type="hidden" runat='server' id="g_sFishLatinName" value="43" />
    <input  type="hidden" runat='server' id="hiddenFishGuid" />
    <table><tr>
           <td></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonEditor" runat="server" EnableViewState="False" OnClick="LinkButtonEditor_Click" >Habitat</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonZoo" runat="server" EnableViewState="False" OnClick="LinkButtonZoo_Click" >Zoology</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonSpawn" runat="server" EnableViewState="False" OnClick="LinkButtonSpawn_Click" >Reproduction</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonFood" runat="server" EnableViewState="False" OnClick="LinkButtonFood_Click" >Diet</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31">General</td>
           <td class="auto-styleHD33">&deg;</td>
    </tr></table>
       <table style="width: 801px">
         <tr>
             <td class="auto-style88">Fish Name:</td>
             <td class="auto-style72"><asp:TextBox ID="TextBoxName" runat="server" style="margin-left: 35px" Width="230px" ReadOnly="true"></asp:TextBox></td>
             <td class="auto-style79"></td>
             <td class="auto-style90">Latin Name:</td>
             <td class="auto-style80"><asp:TextBox ID="TextBoxLatin" runat="server" style="margin-left: 35px" Width="204px" ReadOnly="True" ForeColor="#CCCCCC" Height="16px"></asp:TextBox></td>
         </tr> 
         <tr>
             <td class="auto-style88">GUID:</td>
             <td class="auto-style77"><asp:TextBox ID="TextBoxGuid" runat="server" style="margin-left: 35px" Width="230px" ReadOnly="True" ForeColor="#CCCCCC"></asp:TextBox></td>
             <td class="auto-style79"></td>
             <td class="auto-style90"></td>
             <td class="auto-style80"></td>
         </tr> 
       </table>
    <table style="width: 889px; height: 123px">
        <tr><td class="auto-style34">
            <asp:Image ID="ImageFish" runat="server" Height="155px" Width="400px" ImageUrl="../images/fish/Sebastes fasciatus.jpg" /></td><td class="auto-style36"></td><td></td>
        </tr>
        <tr><td class="auto-style35">
            <asp:TextBox ID="txtBoxFishGeneralDescription" runat="server" Height="92px" Width="379px" TextMode="MultiLine"></asp:TextBox>
        </td><td class="auto-style36"></td><td></td>
        </tr>    
    </table>
    <table> 
        <tr><td class="auto-style39">
            <asp:CheckBox ID="cbxLock" runat="server" Text="Locked" />
            </td>
            <td class="auto-style25">
            </td>
            <td></td><td class="auto-style11">
                <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" Width="108px" OnClick="ButtonSubmit_Click" />
            </td><td class="auto-style16">
                    <table><tr>
                        <td class="auto-style83"></td>
                        <td class="auto-style82">Edited by: </td>
                        <td class="auto-style85"><asp:Label ID="LabelEditedBy" runat="server" Text=""></asp:Label></td>
                        <td></td><td class="auto-style84"><asp:Label ID="LabelStamp" runat="server" Text="Label"></asp:Label></td>
                    </tr></table>
            </td></tr> 
       </table>
</asp:Content>
