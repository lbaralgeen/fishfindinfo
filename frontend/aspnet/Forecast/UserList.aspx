<%@ Page Title="Fish Tracker" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="UserList.aspx.cs" Inherits="FishTracker.TUserList" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

<script type="text/javascript">
    function initialize() 
    {
        return;
    }
</script>

    <style type="text/css">
        .auto-style1 {
            height: 378px;
        }
        .auto-style7 {
            height: 378px;
        }
        .auto-style8 {
            width: 340px;
        }
    </style>

</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
   <input  type="hidden" runat='server' id="hiddenSessionId"  />
   <input  type="hidden" runat='server' id="hiddenPostal" />
   <input  type="hidden" runat='server' id="hiddenPlot" value="plot.aspx" />
   <input  type="hidden" runat='server' id="hiddenTrial"  value="1"/>
   <table style="vertical-align: top; height: 1071px; margin: -20px;" >     <!-- ======== with 2 columns single row ======== -->
      <tr style="vertical-align: top">
          <td class="auto-style7">
             <iframe height: 370px; width=950px scrolling="no" seamless="yes" src="MapFrame.aspx?Postal=<%=hiddenPostal.Value%>&trial=<%=hiddenTrial.Value%>&sessionId=<%=hiddenTrial.Value%>" id="MapFrameId" name="MapFrameName" style="border-style: hidden; border-width: 1px; height: 377px;"></iframe>
         </td></tr>
      <tr style="vertical-align: top; margin: -10px;">
          <td style="border-style: hidden; border-top-width: 1px">
              <table style="vertical-align: top; height: 610px; margin: -10px;">
                  <tr>
                  <td><iframe  height: 429px; width: 720px;  scrolling="no" seamless="yes" src="<%=hiddenPlot.Value%>" id="ForecastFrameId" name="ForecastFrameName" style="border-style: hidden; border-width: 1px; width: 938px; height: 620px;"></iframe>
                  </td></tr> 
              </table>
         </td></tr>
    </table>
</asp:Content>
