<%@ Page Title="Fish Tracker" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Planning.aspx.cs" Inherits="FishTracker.TUserList" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

<script type="text/javascript">
    function initialize() 
    {
        return;
    }
</script>

    <style type="text/css">
        .frame-container 
        {
          position: relative;
          overflow: hidden;
          width: 100%;
          padding-top: 56.25%; /* 16:9 Aspect Ratio (divide 9 by 16 = 0.5625) */
        }

        /* Then style the iframe to fit in the container div with full height and width */
        .common-iframe 
        {
          border-style:hidden;
          border-width:1px;
          background-color: transparent;
          border: 0px none transparent;
          padding: 0px;
         
          position: absolute;
          top: 0;
          left: 0;
          bottom: 0;
          right: 0;
          width: 100%;
          height: 100%;

        }
    </style>

</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
   <input  type="hidden" runat='server' id="hiddenSessionId"  />
   <input  type="hidden" runat='server' id="hiddenPostal" />
   <input  type="hidden" runat='server' id="hiddenPlot" value="plot.aspx" />
   <input  type="hidden" runat='server' id="hiddenTrial"  value="1"/>

    <div class="frame-container">
        <iframe class="common-iframe" scrolling="no" id="MapFrameId" name="MapFrameName"
            src="MapFrame.aspx?Postal=<%=hiddenPostal.Value%>&trial=<%=hiddenTrial.Value%>&sessionId=<%=hiddenTrial.Value%>">
        </iframe>
    </div>
    <div class="frame-container">
         <iframe class="common-iframe" scrolling="no" src="<%=hiddenPlot.Value%>" id="ForecastFrameId" name="ForecastFrameName"></iframe>
    </div>

</asp:Content>
