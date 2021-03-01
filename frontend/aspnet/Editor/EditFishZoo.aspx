<%@ Page Title="Fish Editor Zoo" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="EditFishZoo.aspx.cs" Inherits="FishTracker.Editor.EditFishZoo" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-style9 {
            width: 99px;
        }
        .auto-style22 {
            width: 80px;
        }        
        .auto-styleHD31 {
            width: 75px;
        }
        .auto-styleHD33 {
            width: 24px;
        }
        .auto-style87 {
            margin-left: 0px;
        }
        .auto-style88 {
            width: 200px;
        }
        .auto-style39 {
            width: 25px;
        }
        .auto-style90 {
            width: 76px;
        }
        .auto-stylecoll {
            width: 800px;
            background-color: #b6b7bc;
        }
        .auto-styleWhite {
            width: 800px;
        }
        .auto-style91 {
            width: 904px;
        }
        </style>
    <script type="text/javascript">            function initialize() { } </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <input  type="hidden" runat='server' id="hiddenFishGuid" />
       <table>
           <tr class="auto-styleWhite">
           <td></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonEditor" runat="server" EnableViewState="False" OnClick="LinkButtonEditor_Click" >Habitat</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD33">Zoology</td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonSpawn" runat="server" EnableViewState="False" OnClick="LinkButtonSpawn_Click" >Reproduction</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonFood" runat="server" EnableViewState="False" OnClick="LinkButtonFood_Click" >Diet</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonGeneral" runat="server" EnableViewState="False" OnClick="LinkButtonGeneral_Click" >General</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
       </tr></table>

       <table class="auto-style91">
         <tr class="auto-styleWhite">
             <td class="auto-style88">Fish Name:</td>
             <td class="auto-style72"><asp:TextBox ID="TextBoxName" runat="server" ReadOnly="true"></asp:TextBox></td>
             <td class="auto-style79"></td>
             <td class="auto-style90">Latin Name:</td>
             <td class="auto-style80"><asp:TextBox ID="TextBoxLatin" runat="server" ReadOnly="True" ForeColor="#CCCCCC" Height="16px"></asp:TextBox></td>
         </tr> 
         <tr class="auto-styleWhite">
             <td class="auto-style88">GUID:</td>
             <td class="auto-style77"><asp:TextBox ID="TextBoxGuid" runat="server" ReadOnly="True" ForeColor="#CCCCCC"></asp:TextBox></td>
             <td class="auto-style79"></td>
             <td class="auto-style90"></td>
             <td class="auto-style80"></td>
         </tr> 
        <tr class="auto-stylecoll"><td class="auto-style9"></td><td class="auto-style40"></td><td></td><td class="auto-style90"></td><td></td></tr> 
         <tr class="auto-styleWhite">
             <td class="auto-style39">Fin:</td>
             <td class="auto-style22"><asp:TextBox ID="TextBoxFin" runat="server" TextMode="MultiLine"></asp:TextBox></td>
             <td style="background-color: #b6b7bc"></td>
             <td class="auto-style90">Natural Colors:</td>
                   <td class="auto-style22">
                     <asp:CheckBoxList ID="cblNaturalColor" runat="server" RepeatColumns="3"  Height="36px" Width="266px" CellPadding="0" CellSpacing="0">
                        <asp:ListItem Value="1">white</asp:ListItem>
                        <asp:ListItem Value="2">yellow</asp:ListItem>
                        <asp:ListItem Value="4">beige</asp:ListItem>
                        <asp:ListItem Value="8">purple</asp:ListItem>
                        <asp:ListItem Value="16">peach</asp:ListItem>
                        <asp:ListItem Value="32">blue</asp:ListItem>
                        <asp:ListItem Value="64">green</asp:ListItem>
                        <asp:ListItem Value="128">black</asp:ListItem>
                     </asp:CheckBoxList>
                       </td> 
         </tr> 
        <tr class="auto-stylecoll"><td class="auto-style38"></td><td class="auto-style40"></td><td></td><td class="auto-style90"></td><td></td></tr> 
         <tr class="auto-styleWhite">
             <td class="auto-style39">Body:</td>
             <td class="auto-style22"><asp:TextBox ID="TextBoxBody" runat="server" TextMode="MultiLine"></asp:TextBox></td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90">Max</td>
             <td class="auto-style22">
                  <table>
                      <tr><td>Length:&nbsp;</td><td><asp:TextBox ID="TextBoxLength" runat="server" TextMode="Number"></asp:TextBox></td><td>[cm]</td></tr>
                      <tr><td>Weight:&nbsp;</td><td><asp:TextBox ID="TextBoxWeight" runat="server" ></asp:TextBox></td><td>[kg]</td></tr>
                  </table>
             </td>
         </tr> 
        <tr class="auto-stylecoll"><td class="auto-style38"></td><td class="auto-style40"></td><td></td><td class="auto-style90"></td><td></td></tr> 
         <tr class="auto-styleWhite">
             <td class="auto-style39">Counts:</td>
             <td class="auto-style22"><asp:TextBox ID="TextBoxCounts" runat="server" TextMode="MultiLine"></asp:TextBox></td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90">Average</td>
             <td class="auto-style22">
                  <table>
                      <tr><td>Length:&nbsp;</td><td><asp:TextBox ID="TextBoxAvgLength" runat="server" TextMode="Number"></asp:TextBox></td><td>[cm]</td></tr>
                      <tr><td>Weight:&nbsp;</td><td><asp:TextBox ID="TextBoxAvgWeight" runat="server" ></asp:TextBox></td><td>[kg]</td></tr>
                  </table>
             </td>
         </tr> 
        <tr class="auto-stylecoll"><td class="auto-style38"></td><td class="auto-style40"></td><td></td><td class="auto-style90"></td><td></td></tr> 
         <tr class="auto-styleWhite">
             <td class="auto-style39">Shape:</td>
             <td class="auto-style22"><asp:TextBox ID="TextBoxShape" runat="server" TextMode="MultiLine"></asp:TextBox></td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90">Longevity</td>
             <td class="auto-style22"><table><tr><td><asp:TextBox ID="TextBoxLongevity" runat="server"  TextMode="Number"></asp:TextBox></td><td>[Year]</td></tr></table></td>
         </tr> 
        <tr class="auto-stylecoll"><td class="auto-style38"></td><td class="auto-style40"></td><td></td><td class="auto-style90"></td><td></td></tr> 
         <tr class="auto-styleWhite">
             <td class="auto-style39">External Morphology:</td>
             <td class="auto-style22"><asp:TextBox ID="TextBoxEM" runat="server"  TextMode="MultiLine"></asp:TextBox></td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90">Internal Morphology:</td>
             <td class="auto-style22"><asp:TextBox ID="TextBoxIM" runat="server" TextMode="MultiLine"></asp:TextBox></td>
         </tr> 
        <tr class="auto-stylecoll"><td class="auto-style38"></td><td class="auto-style40"></td><td></td><td class="auto-style90"></td><td></td></tr> 
         <tr class="auto-styleWhite">
             <td class="auto-style39">
                 <table>
                    <tr><td>Latt: </td><td><asp:TextBox ID="TextBoxLat" runat="server" ></asp:TextBox></td></tr>
                    <tr><td>Long: </td><td><asp:TextBox ID="TextBoxLon" runat="server" ></asp:TextBox></td></tr>
                    <tr><td>Tag:  </td><td><asp:TextBox ID="TextBoxTag" runat="server" ></asp:TextBox></td></tr>
                    <tr><td>Date: </td><td><asp:TextBox ID="TextBoxDate" runat="server" TextMode="DateTime"></asp:TextBox></td></tr>
                    <tr><td>Gender: </td><td><asp:CheckBox ID="CheckBoxGender" runat="server" Text="Male/Female" Checked="True" /></td></tr>
                 </table>
             </td>
             <td class="auto-style22"> 
                 <table>
                    <tr><td>Source: </td><td><asp:TextBox ID="TextBoxImageSource" runat="server"></asp:TextBox></td></tr>
                    <tr><td>Author: </td><td><asp:TextBox ID="TextBoxImageAuthor" runat="server" ></asp:TextBox></td></tr>
                    <tr><td>Link: </td><td><asp:TextBox ID="TextBoxImageLink" runat="server"  TextMode="Url"></asp:TextBox></td></tr>
                    <tr><td>Label: </td><td><asp:TextBox ID="TextBoxLabel" runat="server" ></asp:TextBox></td></tr>
                    <tr><td>Location: </td><td><asp:TextBox ID="TextBoxLocation" runat="server" ></asp:TextBox></td></tr>
                 </table>
             </td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90">
                <table> 
                    <tr><td>Select Image from disk:&nbsp;</td></tr>
                    <tr><td><asp:FileUpload ID="FileUpload" runat="server" Width="259px" /></td></tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr><td style="text-align:right">From url:&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnFemaleUpload" Text="Image Upload" runat="server" OnClick="UploadFile_Click" Height="24px" Width="130px" /></td></tr>
                    <tr><td><asp:TextBox ID="txtImgUrl" runat="server" CssClass="auto-style87" Width="248px"  ></asp:TextBox></td></tr>
                    <tr><td style="text-align:Left">

                        </td></tr>
                </table>
             </td>
             <td class="auto-style22"><asp:Image ID="ImageZoo" runat="server" Height = "130px" Width = "242px" /></td>
         </tr> 
       <tr class="auto-stylecoll"><td class="auto-style9"></td><td class="auto-style40"></td><td></td><td class="auto-style90"></td><td></td></tr> 
        <tr class="auto-styleWhite">
            <td class="auto-style39"></td>
            <td class="auto-style40">
                 
            </td>
            <td></td><td class="auto-style90">
                <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" Width="108px" OnClick="ButtonSubmit_Click" />
                </td><td>
            </td></tr> 
       </table>
</asp:Content>
