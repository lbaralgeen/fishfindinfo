<%@ Page Title="Fish Editor Food and Predators" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="EditFood.aspx.cs" Inherits="FishTracker.Editor.EditFood" %>


<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-style1 {
            width: 373px;
        }
        .auto-styleHD31 {
            width: 75px;
        }
        .auto-styleHD33 {
            width: 24px;
        }
        .auto-style22 {
            width: 2px;
        }
        .auto-style31 {
            top: auto;
            width: 360px;
        }
        .auto-style32 {
            top: auto;
            width: 386px;
        }
        .auto-style82 {
            width: 68px;
        }

        .auto-style84 {
            width: 218px;
        }

        .auto-style85 {
            width: 106px;
        }
        .auto-style86 {
            width: 18px;
        }
        .auto-style87 {
            width: 349px;
        }
        .auto-style88 {
            width: 46px;
        }
        .auto-style89 {
            width: 397px;
        }
        </style>
    <script type="text/javascript">            function initialize() { } </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <input  type="hidden" runat='server' id="hiddenFishGuid" />

       <table style="width: 801px">
           <tr>
           <td></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonEditor" runat="server" EnableViewState="False" OnClick="LinkButtonEditor_Click" >Habitat</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonZoo" runat="server" EnableViewState="False" OnClick="LinkButtonSpawn_Click" >Zoology</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonSpawn" runat="server" EnableViewState="False" OnClick="LinkButtonSpawn_Click" >Reproduction</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD33">Diet</td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonGeneral" runat="server" EnableViewState="False" OnClick="LinkButtonGeneral_Click" >General</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
       </tr>
       </table>

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
     <table style="width: 917px"><tr style="background-color: #b6b7bc" ><td class="auto-style22"></td></tr></table>
        <table>
          <tr>
              <td class="auto-style31" style="clip: rect(auto, auto, auto, auto); vertical-align: top">
                  <table> <tr><td class="auto-style39">Aquatic Insects</td></tr>
                    <tr>
                        <td class="auto-style22"> 
                          <asp:CheckBoxList ID="cblHabitat" runat="server" RepeatColumns="3"  Height="36px" Width="354px">
                        <asp:ListItem Value="1">Bottom Feeder</asp:ListItem>
                        <asp:ListItem Value="2">Predator</asp:ListItem>
                        <asp:ListItem Value="4">Fish Eggs</asp:ListItem>
                        <asp:ListItem Value="8">Kannibal</asp:ListItem>
                     </asp:CheckBoxList> 
                    </td></tr><tr><td>
                      <asp:TextBox ID="txtFood" runat="server" Height="81px" Width="340px" TextMode="MultiLine"></asp:TextBox>
                    </td></tr>
                  </table>
              </td>
              <td style="background-color: #b6b7bc" ></td>
              <td class="auto-style32" style="clip: rect(auto, auto, auto, auto); vertical-align: top">
                  <table style="margin: auto; top: auto; vertical-align: top"> <tr><td class="auto-style39">Terrestrial Insects</td></tr>
                    <tr><td class="auto-style22"> 
                 <asp:CheckBoxList ID="cblTerrestrialInsects" runat="server" RepeatColumns="4" Height="36px" Width="408px" style="margin-left: 0px">
                     <asp:ListItem Value="1">Silverfish</asp:ListItem>
                     <asp:ListItem Value="2">Dragonflies</asp:ListItem>
                     <asp:ListItem Value="4">Crickets</asp:ListItem>
                     <asp:ListItem Value="8">Earwigs</asp:ListItem>
                     <asp:ListItem Value="16">Cicadas</asp:ListItem>
                     <asp:ListItem Value="32">True Bugs</asp:ListItem>
                     <asp:ListItem Value="64">Lacewings</asp:ListItem>
                     <asp:ListItem Value="128">Beetles</asp:ListItem>
                     <asp:ListItem Value="256">Butterflies</asp:ListItem>
                     <asp:ListItem Value="512">Flies</asp:ListItem>
                     <asp:ListItem Value="1024">Sawflies</asp:ListItem>
                    <asp:ListItem Value="2048">Corixidae</asp:ListItem>

                     <asp:ListItem Value="4096">Mayfly</asp:ListItem>
                     <asp:ListItem Value="8192">Nymphs</asp:ListItem>

                     <asp:ListItem Value="16394">Caddisflies</asp:ListItem>
                     <asp:ListItem Value="32768">Stoneflies</asp:ListItem>

                 </asp:CheckBoxList>
                     </td></tr>
                     <tr><td>
                         <table class="auto-style89">
                             <tr><td>
                                 <asp:TextBox ID="txtBoxFishAsFood" runat="server" Width="275px"></asp:TextBox>
                                 <asp:Button ID="btAddFishAsFood" runat="server" Text="Add Fish" OnClick="btAddFishAsFood_Click" />
                             </td></tr>
                              <tr><td>
                                  <asp:DropDownList ID="DropDownListFishAsFood" runat="server" Height="16px" Width="331px">
                                  </asp:DropDownList>
                             </td></tr>
                         </table>
                     </td></tr>
                  </table>
         </td></tr>
       </table> 
       <table style="width: 917px"><tr style="background-color: #b6b7bc"  ><td class="auto-style22"></td></tr></table>
        <table>
          <tr>
              <td class="auto-style31" style="clip: rect(auto, auto, auto, auto); vertical-align: top">
                  <table> <tr><td class="auto-style39">Crustacean</td></tr>
                    <tr>
                        <td class="auto-style22"> 
                  <asp:CheckBoxList ID="cbCrustacean" runat="server" RepeatColumns="3"  Height="36px" Width="354px">
                    <asp:ListItem Value="1">Crabs</asp:ListItem>
                    <asp:ListItem Value="2">Lobsters</asp:ListItem>
                    <asp:ListItem Value="4">Crayfish</asp:ListItem>
                    <asp:ListItem Value="8">Shrimp</asp:ListItem>
                    <asp:ListItem Value="16">Krill</asp:ListItem>
                    <asp:ListItem Value="32">Barnacles</asp:ListItem>
                    <asp:ListItem Value="64">Larvae</asp:ListItem>
                    <asp:ListItem Value="128">Woodlice</asp:ListItem>
                    <asp:ListItem Value="256">Sandhoppers</asp:ListItem>
                    <asp:ListItem Value="512">Amphipods</asp:ListItem>
                    <asp:ListItem Value="1024">Conchostraca</asp:ListItem>
                    <asp:ListItem Value="2048">Clam</asp:ListItem>
                    <asp:ListItem Value="4096">Plankton</asp:ListItem>
                    <asp:ListItem Value="8192">Salamander</asp:ListItem>

                 </asp:CheckBoxList> 
                    </td></tr>
                  </table>
              </td>
              <td style="background-color: #b6b7bc" ></td>
              <td class="auto-style32" style="clip: rect(auto, auto, auto, auto); vertical-align: top">
                  <table style="margin: auto; top: auto; vertical-align: top"> <tr><td class="auto-style39">Terrestrial Animals</td></tr>
                    <tr><td class="auto-style22"> 
                 <asp:CheckBoxList ID="cbTerrestrialAnimals" runat="server" RepeatColumns="4" Height="36px" Width="408px" style="margin-left: 0px">
                     <asp:ListItem Value="1">Birds</asp:ListItem>
                     <asp:ListItem Value="2">Snakes</asp:ListItem>
                     <asp:ListItem Value="4">Snails</asp:ListItem>
                     <asp:ListItem Value="8">Slugs</asp:ListItem>
                     <asp:ListItem Value="16">Leeches</asp:ListItem>
                     <asp:ListItem Value="32">Worms</asp:ListItem>
                     <asp:ListItem Value="64">Frogs</asp:ListItem>
                     <asp:ListItem Value="128">Bats</asp:ListItem>
                     <asp:ListItem Value="256">Mammal</asp:ListItem>
                     <asp:ListItem Value="512">Mouse</asp:ListItem>
                     <asp:ListItem Value="1024">Turtle</asp:ListItem>
                 </asp:CheckBoxList>
                           </td></tr>
                  </table>
         </td></tr>
       </table> 
<table style="width: 917px"><tr style="background-color: #b6b7bc" ><td class="auto-style22"></td></tr></table>
    <table> 
        <tr><td class="auto-style39">&nbsp;</td>
            <td class="auto-style40">
            </td>
            <td class="auto-style87"></td><td class="auto-style39">
                <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" Width="108px" OnClick="ButtonSubmit_Click" />
                </td><td>
                    <table>
                        <tr>
                            <td class="auto-style82">Edited by: </td><td class="auto-style85"><asp:Label ID="LabelEditedBy" runat="server" Text=""></asp:Label>
                            </td><td class="auto-style84"><asp:Label ID="LabelStamp" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr><td class="auto-style86"><asp:CheckBox ID="cbxLock" runat="server" Text="Locked" /></td><td></td><td></td></tr>
                    </table>
            </td></tr> 
       </table>


</asp:Content>

