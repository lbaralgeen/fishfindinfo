<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="FishTracker.TLogin" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style16
        {
            height: 1px;
        }
    </style>
    <script type="text/javascript">            function initialize() { } </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <table>
    <tr><td>

    <h2>
        Log In
    </h2>
    <p>
      Please enter your username and password.
      <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="False" NavigateUrl="Register.aspx"><b>Register</b></asp:HyperLink> if you don't have an account.
    </p>
    <span class="failureNotification">
        <asp:Literal ID="FailureText" runat="server"></asp:Literal>
    </span>

    <asp:Login ID="LoginUser" runat="server" EnableViewState="false" 
            RenderOuterTable="false" onloggingin="LoginUser_LoggingIn"></asp:Login>

        <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification" 
                ValidationGroup="LoginUserValidationGroup"/>
        </asp:ValidationSummary>
        <div class="accountInfo">

    </td></tr>
    </table>  

</asp:Content>
