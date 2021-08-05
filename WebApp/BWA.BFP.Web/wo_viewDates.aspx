<%@ Page language="c#" Codebehind="wo_viewDates.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_viewDates" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>View the Service Dates</title>
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="style_global.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onload="javascript:setTimeout('window.close()',30000);" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table height="200" width="350">
				<tr>
					<td class="tblSubHead2" colspan="2">Work Order Service Dates
					</td>
				</tr>
				<TR>
					<TD class="bg01">Created Date</TD>
					<TD class="bg02"><asp:label id="lblDateCreated" runat="server"></asp:label></TD>
				</TR>
				<tr vAlign="top">
					<td class="bg01">Check-In Date</td>
					<td class="bg02"><asp:label id="lblArrivalDate" runat="server"></asp:label></td>
				</tr>
				<tr vAlign="top">
					<td class="bg01">Scheduled Date</td>
					<td class="bg02"><asp:label id="lblDateScheduled" runat="server"></asp:label></td>
				</tr>
				<TR>
					<TD class="bg01">Opened Date</TD>
					<TD class="bg02"><asp:label id="lblDateOpened" runat="server"></asp:label></TD>
				</TR>
				<TR>
					<TD class="bg01">Closed Date</TD>
					<TD class="bg02"><asp:label id="lblDateClosed" runat="server"></asp:label></TD>
				</TR>
				<TR>
					<TD class="bg01">Check-Out Date</TD>
					<TD class="bg02"><asp:label id="lblDepartureDate" runat="server"></asp:label></TD>
				</TR>
				<tr>
					<td colspan="2"><br>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<INPUT type="button" value="  Close  " onclick="javascript:window.close();">
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
