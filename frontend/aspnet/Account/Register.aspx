<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="FishTracker.RegisterAccount" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style16
        {
            height: 1px;
        }
    </style>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <script type="text/javascript">            function initialize() { } </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<p>Register new User Account</p>

<p>
    <table>
    <tr><td>

        <table Height="45px" BackColor="#CCFFFF" style="width: 548px">
            <tr>
                <td>Account Name *</td>
                <td Width="240px"><asp:TextBox ID="txtFIO" runat="server" Width="275px" MaxLength="64"></asp:TextBox></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Password *</td>
                <td Width="240px"><asp:TextBox ID="txtPassword" runat="server" Width="275px" MaxLength="128" TextMode="Password"></asp:TextBox></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Repeat Password *</td>
                <td Width="240px"><asp:TextBox ID="txtPasswordConf" runat="server" Width="275px" MaxLength="128" TextMode="Password"></asp:TextBox></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Email *</td>
                <td Width="240px"><asp:TextBox ID="txtEmail" runat="server" Width="275px" MaxLength="128" TextMode="Email"></asp:TextBox></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Confirm Email *</td>
                <td Width="240px"><asp:TextBox ID="txtEmailConf" runat="server" Width="275px" MaxLength="128" TextMode="Email"></asp:TextBox></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>First Name *</td>
                <td Width="240px"><asp:TextBox ID="TextBoxFName" runat="server" Width="275px" MaxLength="64"></asp:TextBox></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Last Name *</td>
                <td Width="240px"><asp:TextBox ID="TextBoxLName" runat="server" Width="275px" MaxLength="64"></asp:TextBox></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Country *</td>
                <td Width="120px">  
                    <table><tr><td><asp:RadioButton ID="rbCanada" runat="server" Checked="True" Text="Canada" /></td><td><asp:RadioButton ID="rbUSA" runat="server" Text="USA" /></td></tr></table>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>Postal Code</td>
                <td Width="120px"><asp:TextBox ID="TextBoxPostal" runat="server" Width="120px" MaxLength="8"></asp:TextBox></td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LabelMessage" runat="server" Text="." ForeColor="Red"></asp:Label>
                </td>
                <td Width="240px">
                    <div class="g-recaptcha" data-sitekey="6LfkBjgUAAAAAJJKAxuiw7QwIoGZ1CTVViAj1unr"></div>
                </td>
                <td></td>
            </tr>
            <tr><td></td>
                <td>
                    By clicking the button, I agree to Fish Forecast <a href="terms-of-service.html">Terms of Service.</a>
                </td>
            </tr>
                <td>
                </td>
                <td Width="240px" HorizontalAlign="center">
                        <asp:Button ID="btAddUser" runat="server" Text="Agree and Continue" OnClick="btAddUser_Click" Width="163px" />
                </td>
                <td></td>
            </tr>
        </table>

    </td></tr>
    </table>  
</p>
</asp:Content>
