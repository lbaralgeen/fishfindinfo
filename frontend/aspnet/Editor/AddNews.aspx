<%@ Page Title="Add News" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="AddNews.aspx.cs" Inherits="FishTracker.Editor.AddNews" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-style1 {
            width: 373px;
        }
        .auto-style11 {
            width: 68px;
        }
        .auto-styleHD31 {
            width: 75px;
        }
        .auto-styleHD33 {
            width: 24px;
        }
        .auto-style82 {
            width: 68px;
        }

        .auto-style84 {
            width: 156px;
        }

        .auto-style85 {
            width: 91px;
        }
        .auto-style86 {
            width: 144px;
        }
        .auto-style87 {
            margin-left: 10px;
        }
        .auto-style88 {
            margin-left: 8px;
            width: 75px;
        }
        .auto-style89 {
            margin-left: 11px;
        }
        .auto-style90 {
            width: 93px;
        }
        .auto-style91 {
            margin-left: 5px;
        }
        .auto-style92 {
            width: 167px;
        }
        .auto-style93 {
            margin-left: 8px;
            width: 75px;
            height: 26px;
        }
        .auto-style94 {
            height: 26px;
        }
        .auto-style95 {
            width: 93px;
            height: 26px;
        }
        .auto-style96 {
            width: 200px;
        }
        </style>
    <script type="text/javascript">            function initialize() { } </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
            <asp:HiddenField ID="HiddenFieldNews" runat="server" />

       <table style="width: 889px">
         <tr>
             <td class="auto-style88">Title</td>
             <td class="auto-style72"><asp:TextBox ID="TextBoxTitle" runat="server" Width="230px" CssClass="auto-style89"  ></asp:TextBox></td>
             <td class="auto-style79"></td>
             <td class="auto-style90">Date:</td>
             <td class="auto-style80"><asp:TextBox ID="txDate" runat="server" TextMode="Date"></asp:TextBox></td>
         </tr> 
         <tr>
             <td class="auto-style93">Source:</td>
             <td class="auto-style94"><asp:TextBox ID="TextBoxSource" runat="server" Width="230px" CssClass="auto-style87"  ></asp:TextBox></td>
             <td class="auto-style94"></td>
             <td class="auto-style95">Source Link:</td>
             <td class="auto-style94"><asp:TextBox ID="TextBoxSourceLink" runat="server" style="margin-left: 35px" Width="230px" TextMode="Url"  ></asp:TextBox></td>
         </tr> 
         <tr>
             <td class="auto-style88">Author:</td>
             <td class="auto-style77"><asp:TextBox ID="TextBoxAuthor" runat="server" Width="230px" CssClass="auto-style87"  ></asp:TextBox></td>
             <td class="auto-style79"></td>
             <td class="auto-style90">Author Link:</td>
             <td class="auto-style77"><asp:TextBox ID="TextBoxAuthorLink" runat="server" style="margin-left: 35px" Width="230px" TextMode="Url"  ></asp:TextBox></td>
         </tr> 
         <tr>
             <td class="auto-style88">Lake Id:</td>
             <td class="auto-style77"><asp:TextBox ID="txtNewsLakeId" runat="server" Width="230px" CssClass="auto-style87"  ></asp:TextBox></td>
             <td class="auto-style79"></td>
             <td class="auto-style90">Country</td>
             <td class="auto-style77">
                            <asp:DropDownList ID="ddlNewsCountry" runat="server">
                                <asp:ListItem>CA</asp:ListItem>
                                <asp:ListItem>US</asp:ListItem>
                                <asp:ListItem>UK</asp:ListItem>
                            </asp:DropDownList>
                            </td>
         </tr> 
        <tr style="background-color: #b6b7bc"><td class="auto-styleHD31"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td></td></tr> 
         <tr>
             <td class="auto-styleHD31">
                  <table>
                      <tr><td>Author:&nbsp;</td></tr>
                      <tr><td><asp:TextBox ID="TextBoxParagraphAuthor0" runat="server" Width="145px" CssClass="auto-style91"></asp:TextBox></td></tr>
                      <tr><td>&nbsp;</td></tr>
                      <tr><td>Text:&nbsp;</td></tr>
                      <tr><td><asp:TextBox ID="TextBoxPictureAlt0" runat="server" Width="145px" CssClass="auto-style91"></asp:TextBox></td></tr>
                      <tr><td>Fish ID:</td></tr>
                  </table>
             </td>
             <td class="auto-style22">
                 <table>
                 <tr><td><asp:TextBox ID="TextBoxParagraph0" runat="server" style="margin-left: 7px" Width="250px" Height="113px" TextMode="MultiLine"></asp:TextBox></td></tr>
                 <tr><td><asp:TextBox ID="txtFishId1" runat="server" Width="245px" CssClass="auto-style91"></asp:TextBox></td></tr>
                 </table>
             </td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90">
                 <table>
                     <tr><td class="auto-style96"><asp:FileUpload ID="FileUploadParagraph0" runat="server" Width="175px" /> </td></tr>
                     <tr><td class="auto-style96">&nbsp;</td></tr>
                     <tr><td class="auto-style96"><asp:Button ID="ButtonParagraph0" Text="Image Upload" runat="server"  Height="24px" Width="163px" OnClick="btnBriefUpload_Click" /></td></tr>
                     <tr><td class="auto-style96">&nbsp;</td></tr>
                     <tr><td class="auto-style96"><asp:TextBox ID="txtLink0" runat="server" Width="175px" CssClass="auto-style87"  ></asp:TextBox></td></tr>
                 </table>
             </td>
             <td class="auto-style22">
                  <asp:Image ID="ImageParagraph0" runat="server" Height = "130px" Width = "242px" />
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc"><td class="auto-styleHD31"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td></td></tr> 
         <tr>
             <td class="auto-styleHD31">
                  <table class="auto-style92">
                      <tr><td>Author:&nbsp;</td></tr>
                      <tr><td><asp:TextBox ID="TextBoxParagraphAuthor1" runat="server" Width="145px" CssClass="auto-style91"></asp:TextBox></td></tr>
                      <tr><td>&nbsp;</td></tr>
                      <tr><td>Text:&nbsp;</td></tr>
                      <tr><td><asp:TextBox ID="TextBoxPictureAlt1" runat="server" Width="145px" CssClass="auto-style91"></asp:TextBox></td></tr>
                      <tr><td>Fish ID:</td></tr>
                  </table>
             </td>
             <td class="auto-style22">
                 <table>
                 <tr><td><asp:TextBox ID="TextBoxParagraph1" runat="server" style="margin-left: 7px" Width="250px" Height="113px" TextMode="MultiLine"></asp:TextBox></td></tr>
                 <tr><td><asp:TextBox ID="txtFishId2" runat="server" Width="245px" CssClass="auto-style91"></asp:TextBox></td></tr>
                 </table>
             </td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90">
                 <table>
                     <tr><td><asp:FileUpload ID="FileUploadParagraph1" runat="server" Width="175px" /> </td></tr>
                     <tr><td>&nbsp;</td></tr>
                     <tr><td><asp:Button ID="ButtonParagraph1" Text="Image Upload" runat="server"  Height="24px" Width="130px" OnClick="btnBriefUpload_Click" /></td></tr>
                     <tr><td class="auto-style96">&nbsp;</td></tr>
                     <tr><td class="auto-style96"><asp:TextBox ID="txtLink1" runat="server" Width="175px" CssClass="auto-style87"  ></asp:TextBox></td></tr>
                 </table>
             </td>
             <td class="auto-style22">
                  <asp:Image ID="ImageParagraph1" runat="server" Height = "130px" Width = "242px" />
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc"><td class="auto-styleHD31"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td></td></tr> 
         <tr>
             <td class="auto-styleHD31">
                  <table class="auto-style92">
                      <tr><td>Author:&nbsp;</td></tr>
                      <tr><td><asp:TextBox ID="TextBoxParagraphAuthor2" runat="server" Width="145px" CssClass="auto-style91"></asp:TextBox></td></tr>
                      <tr><td>&nbsp;</td></tr>
                      <tr><td>Text:&nbsp;</td></tr>
                      <tr><td><asp:TextBox ID="TextBoxPictureAlt2" runat="server" Width="145px" CssClass="auto-style91"></asp:TextBox></td></tr>
                      <tr><td>Fish ID:</td></tr>
                  </table>
             </td>
             <td class="auto-style22">
                 <table>
                 <tr><td><asp:TextBox ID="TextBoxParagraph2" runat="server" style="margin-left: 7px" Width="250px" Height="113px" TextMode="MultiLine"></asp:TextBox></td></tr>
                 <tr><td><asp:TextBox ID="txtFishId3" runat="server" Width="245px" CssClass="auto-style91"></asp:TextBox></td></tr>
                 </table>
             </td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90">
                 <table>
                     <tr><td><asp:FileUpload ID="FileUploadParagraph2" runat="server" Width="175px" /> </td></tr>
                     <tr><td>&nbsp;</td></tr>
                     <tr><td><asp:Button ID="ButtonParagraph2" Text="Image Upload" runat="server"  Height="24px" Width="130px" OnClick="btnBriefUpload_Click" /></td></tr>
                     <tr><td class="auto-style96">&nbsp;</td></tr>
                     <tr><td class="auto-style96"><asp:TextBox ID="txtLink2" runat="server" Width="175px" CssClass="auto-style87"  ></asp:TextBox></td></tr>
                 </table>
             </td>
             <td class="auto-style22">
                  <asp:Image ID="ImageParagraph2" runat="server" Height = "130px" Width = "242px" />
             </td>
         </tr> 
       <tr style="background-color: #b6b7bc"><td class="auto-styleHD31"></td><td class="auto-style40"></td><td></td><td class="auto-style11"></td><td></td></tr> 
        <tr><td>Youtube Link:</td>
            <td class="auto-style40">
                 <asp:TextBox ID="txtYoutube" runat="server" Width="243px" CssClass="auto-style91"></asp:TextBox></td>
            <td></td><td class="auto-style39">
                <asp:Button ID="ButtonSubmitAddNews" runat="server" Text="Submit" Width="108px" OnClick="ButtonSubmitAddNews_Click" />
                </td><td>
                    <table>
                        <tr>
                            <td class="auto-style82">Edited by: </td><td class="auto-style85">
                            &nbsp;</td><td class="auto-style84">&nbsp;</td>
                        </tr>
                        <tr><td class="auto-style86"><asp:CheckBox ID="cbxLock" runat="server" Text="Locked" /></td><td></td><td></td></tr>
                    </table>
            </td></tr> 
       </table>

</asp:Content>
