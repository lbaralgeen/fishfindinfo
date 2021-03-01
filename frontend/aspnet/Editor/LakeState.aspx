<%@ Page Title="Lake State" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="LakeState.aspx.cs" Inherits="FishTracker.Editor.LakeState" %>


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
        .auto-style49 {margin-left: 32px; }
        .auto-style50 {width: 800px;
            height: 423px;
        }
        .auto-style52 { width: 205px; }
        .auto-style53 { width: 205px; height: 1px; }
        .auto-style54 { width: 205px;  height: 5px; }
        .auto-style55 {
            width: 285px;
        }
        .auto-style56 {
            width: 253px;
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
    <td><asp:HyperLink ID="hlFish" runat="server" >Fishing</asp:HyperLink></td><td>&nbsp;&bull;&nbsp;</td>
    <td><asp:HyperLink ID="HyperLinkView" runat="server">View</asp:HyperLink></td>
</tr></table>
<table class="auto-style50">
    <tr>
        <td class="auto-style41">Lake Name:</td>
        <td class="auto-style43"><asp:TextBox ID="txLakeName" runat="server" style="margin-left: 35px" Width="220px" ForeColor="#666666" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">GUID:</td>
        <td class="auto-style54"><asp:TextBox ID="txGuidLake" runat="server" style="margin-left: 35px" Width="220px"  Height="16px" ForeColor="#666666" ReadOnly="True" BackColor="#CCCCCC"></asp:TextBox></td>
    </tr> 
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td class="auto-style52"></td></tr> 
    <tr>
        <td class="auto-style41">Phosphorus:</td>
        <td class="auto-style43"><table><tr><td>
            <asp:TextBox ID="txPhosphorus" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[uS/cm]</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">pH:</td>
        <td class="auto-style53"><table><tr><td>
            <asp:TextBox ID="txPH" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[n/n]</td></tr></table></td>
    </tr> 
    <tr>
        <td class="auto-style41">Conductivity:</td>
        <td class="auto-style43"><table><tr><td>
            <asp:TextBox ID="txConductivity" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[<span class="st">mS/m</span>]</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">TDS:</td>
        <td class="auto-style53"><table><tr><td>
            <asp:TextBox ID="txTDS" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[mg/L]</td></tr></table></td>
    </tr> 
    <tr>
        <td class="auto-style41">Alkalinity:</td>
        <td class="auto-style43"><table><tr><td>
            <asp:TextBox ID="txAlkalinity" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[mg/L]</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Hardness:</td>
        <td class="auto-style53"><table><tr><td>
            <asp:TextBox ID="txHardness" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[mg/L]</td></tr></table></td>
    </tr> 
    <tr>
        <td class="auto-style41">Sodium:</td>
        <td class="auto-style43"><table><tr><td><asp:TextBox ID="txSodium" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox></td><td>[mg/L]</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Chloride:</td>
        <td class="auto-style54">
            <table><tr><td>
            <asp:TextBox ID="txChloride" runat="server" style="margin-left: 35px" Width="150px"></asp:TextBox>
            </td><td>[mg/L]</td></tr></table>
        </td>
    </tr> 
    <tr style="background-color: #b6b7bc" ><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td class="auto-style52"></td></tr> 
    <tr>
        <td class="auto-style41">Bicarbonate:</td>
        <td class="auto-style1">
            <table>
                <tr><td>
                    <asp:TextBox ID="txBicarbonate" runat="server" style="margin-left: 35px" Width="150px"></asp:TextBox>
                </td>
                <td>[mg/L]</td></tr>
            </table>
        <td class="auto-style44"></td>
        <td class="auto-style46">Transparency:</td>
        <td class="auto-style54">
            <table><tr><td>
                <asp:TextBox ID="txTransparency" runat="server" style="margin-left: 35px" Width="150px"></asp:TextBox></td>
                <td>[ppt]</td></tr>
            </table>
        </td>
    </tr> 
    <tr>
        <td class="auto-style41">Oxygen:</td>
        <td class="auto-style43"><table><tr><td>
            <asp:TextBox ID="txOxygen" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox>
            </td><td>[mg/L]</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46"><span class="st">Salinity</span>:</td>
        <td class="auto-style54">
            <table><tr>
                <td><asp:TextBox ID="txSalinity" runat="server"  style="margin-left: 35px" Width="150px" Height="16px" ></asp:TextBox></td>
                <td>[mg/L]</td>
            </tr></table>
            </td>
    </tr> 
    <tr>
        <td class="auto-style41">Water Clarity:</td>
        <td class="auto-style43"><table><tr><td>
            <asp:TextBox ID="txWaterClarity" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox>
            </td><td>[m]</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Velocity:</td>
        <td class="auto-style54">
            <table><tr>
                <td><asp:TextBox ID="txVelocity" runat="server"  style="margin-left: 35px" Width="150px" Height="16px" ></asp:TextBox></td>
                <td>[m/s]</td>
            </tr></table>
        </td>
    </tr> 
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td class="auto-style52"></td></tr> 
    <tr>
        <td class="auto-style41">Water Temperature: </td>
        <td class="auto-style43"><table><tr><td>
            <asp:TextBox ID="txWaterTemperature" runat="server" Width="150px" CssClass="auto-style49"></asp:TextBox>
            </td><td>[C]</td></tr></table></td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Air Temperature: </td>
        <td class="auto-style54">
            <table><tr>
                <td><asp:TextBox ID="txAirTemperature" runat="server"  style="margin-left: 35px" Width="150px" Height="16px" ></asp:TextBox></td>
                <td>[C]</td>
            </tr></table>
        </td>
    </tr>
    <tr>
        <td class="auto-style41">Water State</td>
        <td class="auto-style43">
            <asp:CheckBox ID="cbCold" runat="server" />
            <asp:CheckBox ID="cbCool" runat="server" />
        </td>
        <td class="auto-style44"></td>
        <td class="auto-style46">Flow State: </td>
        <td class="auto-style54">
            <asp:CheckBox ID="cbFlow" runat="server" />
            <asp:CheckBox ID="cbStand" runat="server" />
        </td>
    </tr>
    <tr style="background-color: #b6b7bc"><td class="auto-style42"></td><td class="auto-style40"></td><td class="auto-style45"></td><td class="auto-style47"></td><td class="auto-style52"></td></tr> 
        <tr><td class="auto-style39">
            <asp:CheckBox ID="cbxLock" runat="server" Text="Locked" />
            </td>
            <td class="auto-style41">
                <table class="auto-style56"><tr><td>Month: </td><td class="auto-style55">
                    <asp:DropDownList ID="DropDownListStateMonth" runat="server" Height="16px" Width="200px" AutoPostBack="True" OnSelectedIndexChanged="DropDownListStateMonth_SelectedIndexChanged">
                        <asp:ListItem Value="1">Jan</asp:ListItem>
                        <asp:ListItem Value="2">Feb</asp:ListItem>
                        <asp:ListItem Value="3">Mar</asp:ListItem>
                        <asp:ListItem Value="4">Apr</asp:ListItem>
                        <asp:ListItem Value="5">May</asp:ListItem>
                        <asp:ListItem Value="6">Jun</asp:ListItem>
                        <asp:ListItem Value="7">Jul</asp:ListItem>
                        <asp:ListItem Value="8">Aug</asp:ListItem>
                        <asp:ListItem Value="9">Sep</asp:ListItem>
                        <asp:ListItem Value="10">Oct</asp:ListItem>
                        <asp:ListItem Value="11">Nov</asp:ListItem>
                        <asp:ListItem Value="12">Dec</asp:ListItem>
                    </asp:DropDownList>
                    </td></tr></table>
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
                            <td>
                            </td>
                    </tr>
                    </table>
            </td></tr> 
</table>
</asp:Content>

