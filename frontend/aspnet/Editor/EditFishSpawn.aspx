<%@ Page Title="Fish Editor Spawn" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="EditFishSpawn.aspx.cs" Inherits="FishTracker.Editor.EditFishSpawn" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-style1 {
            width: 373px;
        }
        .auto-style8 {
            height: 76px;
        }
        .auto-style9 {
            width: 99px;
        }
        .auto-style10 {
            height: 76px;
            width: 99px;
        }
        .auto-style11 {
            width: 68px;
        }
        .auto-style12 {
            height: 76px;
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

        .auto-style83 {
            width: 16px;
        }

        .auto-style84 {
            width: 156px;
        }

        .auto-style85 {
            width: 91px;
        }
        .auto-style86 {
            width: 121px;
        }
        </style>
    <script type="text/javascript">            function initialize() { } </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <input  type="hidden" runat='server' id="hiddenFishGuid" />
       <table><tr>
           <td></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonEditor" runat="server" EnableViewState="False" OnClick="LinkButtonEditor_Click" >Habitat</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonZoo" runat="server" EnableViewState="False" OnClick="LinkButtonZoo_Click" >Zoology</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD33">Reproduction</td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonFood" runat="server" EnableViewState="False" OnClick="LinkButtonFood_Click" >Diet</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
           <td class="auto-styleHD31"><asp:LinkButton ID="LinkButtonGeneral" runat="server" EnableViewState="False" OnClick="LinkButtonGeneral_Click" >General</asp:LinkButton></td>
           <td class="auto-styleHD33">&deg;</td>
       </tr></table>

       <table style="width: 889px">
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
        <tr style="background-color: #b6b7bc"><td class="auto-style9"></td><td class="auto-style40"></td><td></td><td class="auto-style11"></td><td></td></tr> 
        <tr>
             <td class="auto-style10">Spawn Period:</td>
             <td class="auto-style8">
                 <asp:CheckBoxList ID="cbSpawnList" runat="server" Height="69px" RepeatColumns="6" Width="290px">
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
                 </asp:CheckBoxList>
             </td>
             <td style="background-color: #b6b7bc"></td>
             <td class="auto-style12">
                 <table style="width: 104px; height: 63px">
                     <tr><td class="auto-style86">Male Age:&nbsp</td></tr>
                     <tr><td class="auto-style86">Female Age:&nbsp</td></tr>
                 </table></td>
             <td class="auto-style8">
                 <table style="width: 309px">
                     <tr><td><asp:TextBox ID="TextBoxMaleAge" runat="server" style="margin-left: 35px" Width="127px" ForeColor="#CCCCCC" TextMode="Number"></asp:TextBox></td><td>[Years]</td></tr>
                     <tr><td><asp:TextBox ID="TextBoxFemaleAge" runat="server" style="margin-left: 35px" Width="128px" ForeColor="#CCCCCC" TextMode="Number"></asp:TextBox></td><td>[Years]</td></tr>
                 </table>
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc"><td class="auto-style9"></td><td class="auto-style40"></td><td></td><td class="auto-style11"></td><td></td></tr> 
         <tr>
             <td class="auto-style39">Spawn Over:</td>
             <td class="auto-style22"> 
                 <asp:CheckBoxList ID="cbxSpawnOver" runat="server" RepeatColumns="3"  Height="36px" Width="289px">
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
             <td class="auto-style39">Spawn at:</td>
             <td class="auto-style22"> 
                 <asp:CheckBoxList ID="cbxSpawnAt" runat="server" RepeatColumns="4" Height="36px" Width="366px" style="margin-left: 0px">
                     <asp:ListItem Value="1">Lake</asp:ListItem>
                     <asp:ListItem Value="2">River</asp:ListItem>
                     <asp:ListItem Value="4">Stream</asp:ListItem>
                     <asp:ListItem Value="8">Pond</asp:ListItem>
                     <asp:ListItem Value="16">Marsh</asp:ListItem>
                     <asp:ListItem Value="32">Backwater</asp:ListItem>
                     <asp:ListItem Value="64">Creek</asp:ListItem>
                     <asp:ListItem Value="128">Canal</asp:ListItem>
                     <asp:ListItem Value="256">Estuary</asp:ListItem>
                     <asp:ListItem Value="512">Shore</asp:ListItem>
                     <asp:ListItem Value="2048">Ocean</asp:ListItem>
                     <asp:ListItem Value="8192">Reservoir</asp:ListItem>
                 </asp:CheckBoxList>
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc" height="1"><td class="auto-style38"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td></td></tr> 
         <tr>
             <td class="auto-style39">Turbidity:</td>
             <td class="auto-style40">
                 <table><tr>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxTuLD" runat="server" style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxTuL" runat="server" style="margin-left: 2px" Width="45px"  ></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxTuC" runat="server" style="margin-left: 2px" Width="45px" BackColor="Aqua"  ></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxTuH" runat="server" style="margin-left: 2px" Width="45px"  ></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxTuHD" runat="server" style="margin-left: 2px" Width="45px" BackColor="#FFCCFF" ></asp:TextBox></td>
                   <td class="auto-style24"></td><td class="auto-style24">[FBU]</td>
                 </tr></table>
             </td>
             <td style="background-color: #b6b7bc"></td>
             <td class="auto-style39">Temperature:</td>
             <td class="auto-style22">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxTmLD" runat="server" style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"  ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxTmL" runat="server" style="margin-left: 2px" Width="45px"  ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxTmC" runat="server" style="margin-left: 2px" Width="45px" BackColor="Aqua" ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxTmH" runat="server" style="margin-left: 2px" Width="45px"  ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxTmHD" runat="server" style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"  ></asp:TextBox></td>
                   <td></td><td>[C]</td>
                 </tr></table>
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc" height="1"><td class="auto-style38"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td></td></tr> 
         <tr>
             <td class="auto-style39">Oxigen:</td>
             <td class="auto-style22">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxOxLD" runat="server" style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxOxL" runat="server" style="margin-left: 2px" Width="45px"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxOxC" runat="server" style="margin-left: 2px" Width="45px" BackColor="Aqua" ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxOxH" runat="server" style="margin-left: 2px" Width="45px" T></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxOxHD" runat="server" style="margin-left: 2px" Width="45px" BackColor="#FFCCFF" ></asp:TextBox></td>
                   <td></td><td>[mg/l]</td>
                 </tr></table>
             </td>
             <td style="background-color: #b6b7bc" class="auto-style26"></td>
             <td class="auto-style39">PH:</td>
             <td class="auto-style22">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxPhLD" runat="server" style="margin-left: 2px" Width="45px" BackColor="#FFCCFF" T ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxPhL" runat="server" style="margin-left: 2px" Width="45px" ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxPhC" runat="server" style="margin-left: 2px" Width="45px" BackColor="Aqua"  ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxPhH" runat="server" style="margin-left: 2px" Width="45px"  ></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxPhHD" runat="server" style="margin-left: 2px" Width="45px" BackColor="#FFCCFF"   ></asp:TextBox></td>
                   <td></td><td>[ppm]</td>
                 </tr></table>
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc" ><td class="auto-style38"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td></td></tr> 
         <tr>
             <td class="auto-style39">Depth:</td>
             <td class="auto-style22">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxDepthMin" runat="server" style="margin-left: 7px" Width="80px"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxDepthMax" runat="server" style="margin-left: 35px" Width="80px"></asp:TextBox></td>
                   <td></td><td>[m]</td>
                 </tr></table>
             </td>
             <td style="background-color: #b6b7bc" class="auto-style29"></td>
             <td class="auto-style39"> Velocity:</td>
             <td class="auto-style22">
                 <table><tr>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxVeL" runat="server" style="margin-left: 7px" Width="80px"></asp:TextBox></td>
                   <td class="auto-style24"><asp:TextBox ID="TextBoxVeH" runat="server" style="margin-left: 35px" Width="80px"></asp:TextBox></td>
                   <td class="auto-style24"></td><td class="auto-style24">[m/s]</td>
                 </tr></table>
             </td>
         </tr> 
        <tr style="background-color: #b6b7bc"><td class="auto-style38"></td><td class="auto-style40"></td><td></td><td class="auto-style38"></td><td></td></tr> 
         <tr>
             <td class="auto-style39">Description:</td>
             <td class="auto-style22"><asp:TextBox ID="TextBoxDescription" runat="server" style="margin-left: 7px" Width="250px" Height="45px" TextMode="MultiLine"></asp:TextBox></td>
             <td style="background-color: #b6b7bc"  class="auto-style29"></td>
             <td class="auto-style39">Location:</td>
             <td class="auto-style22"><asp:TextBox ID="TextBoxLocation" runat="server" style="margin-left: 7px" Width="250px" Height="45px" TextMode="MultiLine"></asp:TextBox></td>
         </tr> 
       <tr style="background-color: #b6b7bc"><td class="auto-style9"></td><td class="auto-style40"></td><td></td><td class="auto-style11"></td><td></td></tr> 
        <tr><td class="auto-style39">
            Spawn Eggs:
            </td>
            <td class="auto-style40">
                 <table><tr>
                   <td><asp:TextBox ID="TextBoxEggMin" runat="server" style="margin-left: 7px" Width="80px" TextMode="Number"></asp:TextBox></td>
                   <td><asp:TextBox ID="TextBoxEggMax" runat="server" style="margin-left: 35px" Width="80px" TextMode="Number"></asp:TextBox></td>
                 </tr></table>
            </td>
            <td></td><td class="auto-style39">
                <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" Width="108px" OnClick="ButtonSubmit_Click" />
                </td><td>
                    <table>
                        <tr><td class="auto-style83"></td><td class="auto-style82">Edited by: </td><td class="auto-style85"><asp:Label ID="LabelEditedBy" runat="server" Text=""></asp:Label>
                            </td><td class="auto-style84"><asp:Label ID="LabelStamp" runat="server" Text="Label"></asp:Label></td><td><asp:CheckBox ID="cbxLock" runat="server" Text="Locked" /></td>
                        </tr></table>
            </td></tr> 
       </table>

</asp:Content>
