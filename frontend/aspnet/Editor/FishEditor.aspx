<%@ Page Title="Fish Editor" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="FishEditor.aspx.cs" Inherits="FishTracker.TFishEditor" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-style1 {
            width: 373px;
        }
        .auto-style2 {
            width: 101px;
        }
        .auto-style4 {
            width: 107px;
            height: 46px;
        }

        .auto-style22 {
            height: 32px;
            width: 360px;
        }
        .auto-style24 {
            height: 1px;
            width: 360px;
        }
        .auto-style40 {
            width: 360px;
        }
        .auto-style26 {
            height: 27px;
        }
        .auto-style29 {
            height: 22px;
        }
        .auto-styleHD31 {
            width: 75px;
        }
        .auto-styleHD33 {
            width: 24px;
        }
        .auto-style38 {
            width: 63px;
            height: 1px;
        }
        .auto-style88 {
            width: 64px;
        }
        .auto-style43 {
            height: 22px;
            width: 325px;
        }

        .auto-style72 {
            height: 5px;
            width: 208px;
        }

        .auto-style77 {
            width: 208px;
        }

        .auto-style79 {
            width: 3px;
        }
        .auto-style80 {
            width: 340px;
            height: 5px;
        }

        .auto-style82 {
            width: 68px;
        }

        .auto-style83 {
            width: 16px;
        }

        .auto-style84 {
            width: 156px;
        }

        .auto-style85 {
            width: 91px;
        }

        .auto-style87 {
            width: 72px;
        }

        .auto-style88 {
            width: 50px;
        }
        .auto-style89 {
            width: 55px;
            height: 1px;
        }

        .auto-style90 {
            width: 63px;
        }

        .auto-style91 {
            width: 889px;
        }
        .auto-style92 {
            width: 340px;
        }
        .auto-style93 {
            height: 32px;
            width: 340px;
        }
        .auto-style94 {
            height: 22px;
            width: 340px;
        }
        .auto-style95 {
            width: 25px;
        }

        </style>
    <script type="text/javascript">            function initialize() { } </script>

    <script type="text/javascript">
        function valSubmitWiki() 
        {
            window.open('http://en.wikipedia.org/wiki/' + document.getElementById('<%=TextBoxLatin.ClientID%>').value, 'Wiki');
        }
        function valSubmitON() {
            window.open('http://www.ontariofishes.ca/home.htm', 'Ontario');
        }
     </script>


</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <input  type="hidden" runat='server' id="hiddenFishGuid" />

       <table><tr>
           <td></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31">Habitat</td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonZoo" runat="server" EnableViewState="False" OnClick="LinkButtonZoo_Click" >Zoology</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonSpawn" runat="server" EnableViewState="False" OnClick="LinkButtonSpawn_Click" >Reproduction</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonFood" runat="server" EnableViewState="False" OnClick="LinkButtonFood_Click" >Diet</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonGeneral" runat="server" EnableViewState="False" OnClick="LinkButtonGeneral_Click" >General</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td>[&nbsp;<asp:HyperLink ID="HyperLinkView" runat="server">View</asp:HyperLink>&nbsp;]</td>
       </tr></table>
       <table class="auto-style91">
         <tr>
             <td class="auto-style88">Fish Name:</td>
             <td class="auto-style72"><asp:TextBox ID="TextBoxName" runat="server" style="margin-left: 35px" Width="230px"></asp:TextBox></td>
             <td class="auto-style79"></td>
             <td class="auto-style90">Latin Name:</td>
             <td class="auto-style80"><asp:TextBox ID="TextBoxLatin" runat="server" style="margin-left: 35px" Width="204px" ReadOnly="True" ForeColor="#CCCCCC" Height="16px"></asp:TextBox></td>
         </tr> 
         <tr>
             <td class="auto-style88">GUID:</td>
             <td class="auto-style77"><asp:TextBox ID="TextBoxGuid" runat="server" style="margin-left: 35px" Width="230px" ReadOnly="True" ForeColor="#CCCCCC"></asp:TextBox></td>
             <td class="auto-style79"></td>
             <td class="auto-style90">Synonims:</td>
             <td class="auto-style80"><asp:TextBox ID="TextBoxSynonim" runat="server" style="margin-left: 35px" Width="207px"></asp:TextBox></td>
         </tr> 
        <tr style="background-color: #b6b7bc"><td class="auto-style89"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td class="auto-style92"></td></tr> 
        <tr>
             <td class="auto-style88">Habitat Characteristics</td>
             <td class="auto-style22">
                <asp:CheckBoxList ID="cblWaterType" runat="server" RepeatColumns="3"  Height="36px" Width="327px">
                    <asp:ListItem Value="1">Freshwater</asp:ListItem>
                    <asp:ListItem Value="2">Saltwater</asp:ListItem>
                    <asp:ListItem Value="4">Clear water</asp:ListItem>
                    <asp:ListItem Value="8">Low velocity</asp:ListItem>
                    <asp:ListItem Value="16">Moderate velocity</asp:ListItem>
                    <asp:ListItem Value="32">High velocity</asp:ListItem>
                    <asp:ListItem Value="64">Turbid waters</asp:ListItem>
                    <asp:ListItem Value="128">Moderately Turbid waters</asp:ListItem>
                 </asp:CheckBoxList>
             </td>
             <td style="background-color: #b6b7bc" class="auto-style22"></td>
             <td class="auto-style90">
                 <table style="width: 98px">
                     <tr><td class="auto-style87">Reactive Colors:</td></tr>
                 </table>
             </td>
             <td class="auto-style93">
                 <table><tr>
                   <td class="auto-style22"> 
                    <asp:CheckBoxList ID="cblReactColor" runat="server" RepeatColumns="3"  Height="36px" Width="289px">
                        <asp:ListItem Value="1">hot pink</asp:ListItem>
                        <asp:ListItem Value="2">hot orange</asp:ListItem>
                        <asp:ListItem Value="4">chartreuse</asp:ListItem>
                     </asp:CheckBoxList>
                   </td>
                   </tr>
                 </table>
                 &nbsp;</td>
         </tr> 
        <tr style="background-color: #b6b7bc"><td class="auto-style89"></td><td></td><td></td><td class="auto-style38"></td><td class="auto-style92"></td></tr> 
         <tr>
             <td class="auto-style88">Feeds Over:</td>
             <td class="auto-style22"> 
                 <asp:CheckBoxList ID="CheckBoxListFeedsOver" runat="server" RepeatColumns="3"  Height="36px" Width="289px">
                     <asp:ListItem Value="1">Rock</asp:ListItem>
                     <asp:ListItem Value="2">Gravel</asp:ListItem>
                     <asp:ListItem Value="4">Sand</asp:ListItem>
                     <asp:ListItem Value="8">Mud</asp:ListItem>
                     <asp:ListItem Value="16">Grass</asp:ListItem>
                     <asp:ListItem Value="32">Rubble</asp:ListItem>
                     <asp:ListItem Value="64">Boulder</asp:ListItem>
                     <asp:ListItem Value="128">Silt</asp:ListItem>
                     <asp:ListItem Value="256">Cobble</asp:ListItem>
                     <asp:ListItem Value="1024">LimeStone</asp:ListItem>
                     <asp:ListItem Value="2048">Clay</asp:ListItem>
                 </asp:CheckBoxList>
             </td>
             <td style="background-color: #b6b7bc"></td>
             <td class="auto-style90">Habitat at:</td>
             <td class="auto-style93"> 
                 <asp:CheckBoxList ID="CheckBoxListHabitat" runat="server" RepeatColumns="4" Height="36px" Width="366px" style="margin-left: 0px">
                     <asp:ListItem Value="1">Lake</asp:ListItem>
                     <asp:ListItem Value="2">River</asp:ListItem>
                     <asp:ListItem Value="4">Stream</asp:ListItem>
                     <asp:ListItem Value="8">Pond</asp:ListItem>
                     <asp:ListItem Value="16">Backwater</asp:ListItem>
                     <asp:ListItem Value="32">Creek</asp:ListItem>
                     <asp:ListItem Value="64">Canal</asp:ListItem>
                     <asp:ListItem Value="128">Estuary</asp:ListItem>
                     <asp:ListItem Value="256">Reservoir</asp:ListItem>
                     <asp:ListItem Value="16385">Ocean</asp:ListItem>
                     <asp:ListItem Value="1024">Drain</asp:ListItem>
                     <asp:ListItem Value="2048">Ditch</asp:ListItem>
                 </asp:CheckBoxList>
             </td>
         </tr> 
         <tr style="background-color: #b6b7bc"><td class="auto-style89"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td class="auto-style92"></td></tr> 
         <tr>
             <td class="auto-style88">Turbidity:</td>
             <td class="auto-style40">
                 <table><tr>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxTuLD"   runat="server" style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxTuL"    runat="server" style="margin-left: 2px" Width="45px"></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxTuC"    runat="server" style="margin-left: 2px" Width="45px" BackColor="Aqua" ></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxTuH"    runat="server" style="margin-left: 2px" Width="45px"></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxTuHD"   runat="server" style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"></asp:TextBox></td>
                   <td class="auto-style24"></td><td class="auto-style24">[FBU]</td>
                 </tr></table>
             </td>
             <td style="background-color: #b6b7bc" ></td>
             <td class="auto-style90">Temperature:</td>
             <td class="auto-style93">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxTmLD" runat="server"   style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxTmL" runat="server"  style="margin-left: 2px" Width="45px"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxTmC" runat="server" style="margin-left: 2px" Width="45px" BackColor="Aqua"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxTmH" runat="server"   style="margin-left: 2px" Width="45px"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxTmHD" runat="server"    style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"></asp:TextBox></td>
                   <td></td><td>[C]</td>
                 </tr></table>
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc"><td class="auto-style89"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td class="auto-style92"></td></tr> 
         <tr>
             <td class="auto-style88">Oxigen:</td>
             <td class="auto-style22">
                 <table><tr>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxOxLD" runat="server"   style="margin-left:2px" Width="45px" BackColor="#FFCCFF"></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxOxL" runat="server"   style="margin-left: 2px" Width="45px"></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxOxC" runat="server"   style="margin-left: 2px" Width="45px" BackColor="Aqua"></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxOxH" runat="server"   style="margin-left: 2px" Width="45px"></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxOxHD" runat="server"  style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"></asp:TextBox></td>
                   <td></td><td>[mg/l]</td>
                 </tr></table>
             </td>
             <td style="background-color: #b6b7bc"  class="auto-style26"></td>
             <td class="auto-style90">PH:</td>
             <td class="auto-style93">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxPhLD" runat="server"    style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxPhL" runat="server"   style="margin-left: 2px" Width="45px"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxPhC" runat="server"   style="margin-left: 2px" Width="45px" BackColor="Aqua"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxPhH" runat="server"   style="margin-left: 2px" Width="45px"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxPhHD" runat="server"    style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"></asp:TextBox></td>
                   <td></td><td class="auto-style95">[ppm]</td>
                 </tr></table>
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc" ><td class="auto-style89"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td class="auto-style92"></td></tr> 
         <tr>
             <td class="auto-style88">Depth:</td>
             <td class="auto-style22">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxDepthMin" runat="server" style="margin-left: 7px" Width="80px" ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxDepthMax" runat="server" style="margin-left: 35px" Width="80px" ></asp:TextBox></td>
                   <td></td><td>[m]</td>
                 </tr></table>
             </td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90"> Velocity:</td>
             <td class="auto-style93">
                 <table><tr>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxVeL" runat="server" style="margin-left: 7px" Width="80px"  ></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxVeH" runat="server" style="margin-left: 35px" Width="80px"  ></asp:TextBox></td>
                   <td class="auto-style24"></td><td class="auto-style24">[m/s]</td>
                 </tr></table>
             </td>

         </tr> 
         <tr>
             <td class="auto-style88">Salinity:</td>
             <td class="auto-style22">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxSoltMin" runat="server" style="margin-left: 7px" Width="80px" ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxSoltMax" runat="server" style="margin-left: 35px" Width="80px" ></asp:TextBox></td>
                   <td></td><td>[pps]</td>
                 </tr></table>
             </td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90">  </td>
             <td class="auto-style93">
                 <table><tr>
                   <td class="auto-style24"> </td>
                   <td class="auto-style24"> </td>
                   <td class="auto-style24"></td><td class="auto-style24"> </td>
                 </tr></table>
             </td>

         </tr> 
         <tr>
             <td class="auto-style88">Nitrate:</td>
             <td class="auto-style22">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxNitrateL" runat="server" style="margin-left: 7px" Width="80px"  ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxNitrateH" runat="server" style="margin-left: 35px" Width="80px" ></asp:TextBox></td>
                   <td></td><td>[umol/L]</td>
                 </tr></table>
             </td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90"> Phosphate:</td>
             <td class="auto-style93">
                 <table><tr>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxPhosphateL" runat="server" style="margin-left: 7px" Width="80px"  ></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxPhosphateH" runat="server" style="margin-left: 35px" Width="80px" ></asp:TextBox></td>
                   <td class="auto-style24"></td><td class="auto-style24">[umol/L]</td>
                 </tr></table>
             </td>

         </tr> 
        <tr style="background-color: #b6b7bc" ><td class="auto-style89"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td class="auto-style92"></td></tr> 
         <tr>
             <td class="auto-style88">Home Range:</td>
             <td class="auto-style22">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxHomeRange" runat="server" style="margin-left: 7px" Width="80px" TextMode="Number"></asp:TextBox></td>
                   <td></td><td>[km]</td>
                 </tr></table>
             </td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style90"> </td>
             <td class="auto-style93">
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc" ><td class="auto-style89"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td class="auto-style92"></td></tr> 
         <tr>
             <td class="auto-style88"> Fish Type:</td>
             <td class="auto-style43">
                 <asp:CheckBoxList ID="ddListType" runat="server" RepeatColumns="3"  Height="36px" Width="289px">
                    <asp:ListItem Value="1">Sport</asp:ListItem>
                    <asp:ListItem Value="2">Commercial</asp:ListItem>
                    <asp:ListItem Value="4">Invading</asp:ListItem>
                     <asp:ListItem Value="8">Aquarium</asp:ListItem>
                 </asp:CheckBoxList>
             </td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style88"> Fish Ability:</td>
             <td class="auto-style94">
                 <asp:CheckBoxList ID="cblFishWay" runat="server" RepeatColumns="3"  Height="36px" Width="289px">
                    <asp:ListItem Value="1">Moon Sensitive</asp:ListItem>
                    <asp:ListItem Value="2">Migration Pattern</asp:ListItem>
                 </asp:CheckBoxList>
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc"><td class="auto-style89"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td class="auto-style92"></td></tr> 
        <tr><td class="auto-style88"><asp:Button ID="ButtonFirst" runat="server" Text="First" Width="108px" OnClick="ButtonFirst_Click" /></td>
            <td class="auto-style40">
                <asp:Button ID="ButtonA" runat="server" OnClick="ButtonA_Click" Text="A" Width="30px" />
                <asp:Button ID="ButtonB" runat="server" OnClick="ButtonA_Click" Text="B" Width="30px" />
                <asp:Button ID="ButtonC" runat="server" OnClick="ButtonA_Click" Text="C" Width="30px" />
                <asp:Button ID="ButtonD" runat="server" OnClick="ButtonA_Click" Text="D" Width="30px" />
                <asp:Button ID="ButtonE" runat="server" OnClick="ButtonA_Click" Text="E" Width="30px" />
                <asp:Button ID="ButtonF" runat="server" OnClick="ButtonA_Click" Text="F" Width="30px" />
                <asp:Button ID="ButtonG" runat="server" OnClick="ButtonA_Click" Text="G" Width="30px" />
                <asp:Button ID="ButtonH" runat="server" OnClick="ButtonA_Click" Text="H" Width="30px" />
            </td>
            <td></td><td class="auto-style90"><asp:Button ID="ButtonNext" runat="server" Text="Next" Width="108px" OnClick="ButtonNext_Click" /></td><td class="auto-style92">
                <asp:Button ID="ButtonK" runat="server" OnClick="ButtonA_Click" Text="K" Width="30px" />
                <asp:Button ID="ButtonL" runat="server" OnClick="ButtonA_Click" Text="L" Width="30px" />
                <asp:Button ID="ButtonM" runat="server" OnClick="ButtonA_Click" Text="M" Width="30px" />
                <asp:Button ID="ButtonN" runat="server" OnClick="ButtonA_Click" Text="N" Width="30px" />
                <asp:Button ID="ButtonP" runat="server" OnClick="ButtonA_Click" Text="P" Width="30px" />
                <asp:Button ID="ButtonR" runat="server" OnClick="ButtonA_Click" Text="R" Width="30px" />
                <asp:Button ID="ButtonS" runat="server" OnClick="ButtonA_Click" Text="S" Width="30px" />
                <asp:Button ID="ButtonT" runat="server" OnClick="ButtonA_Click" Text="T" Width="30px" />
                <asp:Button ID="ButtonW" runat="server" OnClick="ButtonA_Click" Text="W" Width="30px" />                  
                <asp:Button ID="ButtonZ" runat="server" OnClick="ButtonA_Click" Text="Z" Width="30px" Visible="False" />
            </td></tr> 
        <tr><td class="auto-style88">
            <asp:CheckBox ID="cbxLock" runat="server" Text="Locked" />
            </td>
            <td class="auto-style40">
            </td>
            <td></td><td class="auto-style90">
                  <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" Width="108px" OnClick="ButtonSubmit_Click" />
                </td><td class="auto-style92">
                    <table><tr><td class="auto-style83"></td><td class="auto-style82">Edited by: </td><td class="auto-style85"><asp:Label ID="LabelEditedBy" runat="server" Text=""></asp:Label>
                        </td><td class="auto-style84"><asp:Label ID="LabelStamp" runat="server" Text="Label"></asp:Label></td>
                    </tr></table>
            </td></tr> 
       </table>

</asp:Content>

