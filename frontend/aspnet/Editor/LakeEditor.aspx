<%@ Page Title="Lake Editor" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="LakeEditor.aspx.cs" Inherits="FishTracker.Editor.LakeEditor" %>


<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-style1 { width: 106px;  }
        .auto-style41 { width: 82px; height: 1px; }
        .auto-style42 { width: 82px; height: 1px; }
        .auto-style43 { width: 220px;height: 1px;}
        .auto-style44 { height: 5px; width: 8px; }
        .auto-style45 { width: 8px; }
        .auto-style46 {width: 111px;height: 5px; }
        .auto-style47 {width: 111px; height: 1px; }
        .auto-style48 {width: 40px; height: 5px; }
        .auto-style49 {margin-left: 32px; }
        .auto-style50 {width: 800px; }
        .auto-style51 { width: 216px; height: 5px; }
        .auto-style52 { width: 205px; }
        .auto-style53 { width: 205px; height: 1px; }
        .auto-style54 { width: 205px;  height: 5px; }
        .auto-style55 {
            width: 257px;
        }
        .auto-style57 {
            width: 156px;
        }
        .auto-style58 {
            width: 203px;
        }
        </style>
    <script type="text/javascript">            function initialize() { } </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <input  type="hidden" runat='server' id="lakeGuid" value="" />

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
<table class="auto-style50">
    <tr>
        <td class="auto-style41">Lake Name:</td>
        <td class="auto-style43"><asp:TextBox ID="txtboxEditLake_LakeName" runat="server" style="margin-left: 35px" Width="220px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Alt. Name:</td>
        <td class="auto-style54"><asp:TextBox ID="txtboxEditLake_AltName" runat="server" style="margin-left: 35px" Width="220px"  Height="16px"></asp:TextBox></td>
    </tr> 
    <tr>
        <td class="auto-style41">GUID:</td>
        <td class="auto-style43"><asp:TextBox ID="txtboxEditLake_GuidLake" runat="server" style="margin-left: 35px" Width="220px" ReadOnly="True" ForeColor="#CCCCCC"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Native Name:</td>
        <td class="auto-style43"><asp:TextBox ID="txtboxEditLake_Native" runat="server" style="margin-left: 35px" Width="220px" ></asp:TextBox></td>
    </tr> 
    <tr>
        <td class="auto-style46">Source:</td>
        <td class="auto-style48"><asp:TextBox ID="txtboxEditLake_Source" runat="server" style="margin-left: 35px" Width="220px"  Height="16px" BackColor="#CCCCCC"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">French:</td>
        <td class="auto-style54"><asp:TextBox ID="txtboxEditLake_French" runat="server" style="margin-left: 35px" Width="220px"  Height="16px"></asp:TextBox></td>
    </tr> 
    <tr>
        <td class="auto-style46">Mouth:</td>
        <td class="auto-style54"><asp:TextBox ID="txtboxEditLake_Mouth" runat="server" style="margin-left: 35px" Width="220px"  Height="16px" BackColor="#CCCCCC"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">&nbsp;</td>
        <td class="auto-style54">&nbsp;</td>
    </tr> 
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td class="auto-style52"></td></tr> 
    <tr>
        <td class="auto-style41">Link:</td>
        <td class="auto-style43"><asp:TextBox ID="txtboxEditLake_Link" runat="server"  style="margin-left: 35px" Width="220px"></asp:TextBox></td>
        <td class="auto-style44">
            <asp:ImageButton ID="ImageButtonLink" runat="server" ImageUrl="~/Images/link.png"  />
        </td>
        <td class="auto-style46">Type:</td>
        <td class="auto-style54">
            <asp:DropDownList ID="ddlEditLake_LakeType" runat="server">
                <asp:ListItem Value="1">Lake</asp:ListItem>
                <asp:ListItem Value="2">River</asp:ListItem>
                <asp:ListItem Value="4">Stream</asp:ListItem>
                <asp:ListItem Value="8">Pond</asp:ListItem>
                <asp:ListItem Value="64">Creek</asp:ListItem>
                <asp:ListItem Value="128">Canal</asp:ListItem>
                <asp:ListItem Value="8192">Reservoir</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td class="auto-style52"></td></tr> 
    <tr>
        <td class="auto-style41">Length:</td>
        <td class="auto-style43"><table><tr><td><asp:TextBox ID="txtboxEditLake_Length" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[km]</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Width:</td>
        <td class="auto-style53"><table><tr><td><asp:TextBox ID="txtboxEditLake_Width" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[km]</td></tr></table></td>
    </tr> 
    <tr>
        <td class="auto-style41">Shoreline:</td>
        <td class="auto-style43"><table><tr><td><asp:TextBox ID="txtboxEditLake_Shoreline" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[km]</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Max. Depth:</td>
        <td class="auto-style53"><table><tr><td><asp:TextBox ID="txtboxEditLake_Depth" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[m]</td></tr></table></td>
    </tr> 
    <tr>
        <td class="auto-style41">Volume:</td>
        <td class="auto-style43"><table><tr><td><asp:TextBox ID="txtboxEditLake_Volume" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[km^3]</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Surface area:</td>
        <td class="auto-style53"><table><tr><td><asp:TextBox ID="txtboxEditLake_Surface" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[km^2]</td></tr></table></td>
    </tr> 
    <tr>
        <td class="auto-style41">Discharge:</td>
        <td class="auto-style43"><table><tr><td><asp:TextBox ID="txtboxEditLake_Discharge" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>m^3/s</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Basin:</td>
        <td class="auto-style54"><table><tr><td>
            <asp:TextBox ID="txtboxEditLake_Basin" runat="server" style="margin-left: 35px" Width="150px"></asp:TextBox>
            </td><td>km^2</td></tr></table>
        </td>
    </tr> 
    <tr>
        <td class="auto-style41">Watershield:</td>
        <td class="auto-style1"><table><tr><td>
            <asp:TextBox ID="txtboxEditLake_Watershield" runat="server" style="margin-left: 35px" Width="150px"></asp:TextBox>
            </td><td>&nbsp;</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Drainage:</td>
        <td class="auto-style54"><asp:TextBox ID="txtboxEditLake_Drainage" runat="server" style="margin-left: 35px" Width="150px"></asp:TextBox></td>
    </tr> 
    
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td class="auto-style52"></td></tr> 
    <tr>
        <td class="auto-style41">CGNDB:</td>
        <td class="auto-style1"><asp:TextBox ID="txtboxEditLake_CGNDB" runat="server" style="margin-left: 35px" Width="150px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Road Access:</td>
        <td class="auto-style54"><asp:TextBox ID="txtboxEditLake_access" runat="server" style="margin-left: 35px" Width="220px"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="auto-style41">MLI</td>
        <td class="auto-style43"><asp:TextBox ID="txtboxEditLake_MLI" runat="server" style="margin-left: 35px" Width="150px"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style51">
            <asp:CheckBox ID="checkboxEditLake_Prohibited" runat="server" Text="Fishing Prohibited" />
        </td>
        <td class="auto-style54">
            <table class="auto-style55"><tr>
            <td><asp:CheckBox ID="checkboxEditLake_Isolated" runat="server" Text="Isolated" /></td>
            <td><asp:CheckBox ID="checkboxEditLake_NoFish" runat="server" Text="No Fish" /></td>
            </tr></table>    
        </td>
    </tr> 
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td class="auto-style52"></td></tr> 
    <tr>
        <td class="auto-style41">Description:</td>
        <td class="auto-style43"><asp:TextBox ID="txtboxEditLake_Description" runat="server" style="margin-left: 35px" Width="220px" Height="149px" TextMode="MultiLine"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">
            <table>
                <tr><td>Path:</td><td><asp:FileUpload ID="FileUploadImage" runat="server" Width="163px" Enabled="False" /> </td></tr>
                <tr><td></td><td>&nbsp;</td></tr>
                <tr><td></td><td><asp:Button ID="iuImage" Text="Image Upload" runat="server"  Height="24px" Width="130px" OnClick="btnBriefUpload_Click" Enabled="False" /></td></tr>
                <tr><td>Date:&nbsp;</td><td><asp:TextBox ID="txtboxEditLake_ImageDate" runat="server" TextMode="Date"></asp:TextBox></td></tr>
                <tr><td>Author:&nbsp;</td><td><asp:TextBox ID="txtboxEditLake_Author" runat="server" TextMode="SingleLine"></asp:TextBox></td></tr>
                <tr><td>Source:&nbsp;</td><td><asp:TextBox ID="txtboxEditLake_SourceImage" runat="server" TextMode="SingleLine"></asp:TextBox></td></tr>
                <tr><td>Link:&nbsp;</td><td><asp:TextBox ID="txtboxEditLake_SourceLink" runat="server" TextMode="Url"></asp:TextBox></td></tr>
            </table>
        </td>
        <td class="auto-style54"><asp:Image ID="ImageRiver" runat="server" Height = "168px" Width = "242px" /></td>
    </tr>
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td class="auto-style52"></td></tr> 
        <tr><td class="auto-style39">
            <asp:CheckBox ID="cbxLock" runat="server" Text="Locked" Enabled="False" />
            </td>
            <td class="auto-style41">
            <asp:CheckBox ID="cbxLakeReviewed" runat="server" Text="Reviewed" Enabled="False" />
            </td>
            <td></td><td class="auto-style39">
                  <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" Width="108px" OnClick="ButtonSubmit_Click" />
                </td><td class="auto-style52">
                    <table>
                     <tr>
                            <td class="auto-style83"></td>
                            <td class="auto-style82">Edited by: </td>
                            <td class="auto-style85"><asp:Label ID="LabelEditedBy" runat="server" Text=""></asp:Label></td>
                            <td class="auto-style84"><asp:Label ID="LabelStamp" runat="server" Text="Label"></asp:Label></td>
                            <td><asp:Button ID="btDelRiver" runat="server" Text="X" OnClick="btDelRiver_Click" Enabled="False" /></td>
                            <td><asp:Button ID="btExchLatLonRiver" runat="server" Text="@" OnClick="btExchLatLonRiver_Click" Enabled="False"  /></td>
                    </tr>
                    </table>
            </td></tr> 
</table>
</asp:Content>

