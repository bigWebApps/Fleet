<%@ Page language="c#" Codebehind="wo_editInspectHistory.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_editInspectHistory" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<HTML>
	<HEAD>
		<title>Edit History for the Inspections</title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<script language="javascript"><!--
			<% Response.Write(sOnLoad); %>
			//-->
		</script>
		<script language="javascript" src="OpenWindows.js"></script>
	</HEAD>
	<body id="htmlMainBody" runat="server" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table id="tblMain" runat="server">
				<tr>
					<td colSpan="2">
						<asp:Label id="lblHeader" runat="server" Font-Bold="True" Font-Italic="True"></asp:Label>
						<br>
						<asp:Label id="lblError" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="Smaller"></asp:Label>
					</td>
				</tr>
				<TR>
					<TD>Inspection Schedule:</TD>
					<TD>
						<asp:label id="lblInspectSchedule" runat="server" Font-Bold="True"></asp:label></TD>
				</TR>
				<tr>
					<td>Inspection Name:
					</td>
					<td><asp:label id="lblInspectionName" runat="server" Font-Bold="True"></asp:label></td>
				</tr>
				<tr>
					<td>Equipment Id:
					</td>
					<td><asp:label id="lblEquipName" runat="server" Font-Bold="True"></asp:label></td>
				</tr>
				<tr valign="middle">
					<td nowrap>Date of Last Inspection:</td>
					<td nowrap><cc1:activedatetime id="adtLastTime" runat="server" AllowNull="False" AlertEnabled="True" MinYear="2000"
							MaxYear="2030" Format="MONTH;/;DAY;/;YEAR"></cc1:activedatetime>
						&nbsp; <A onclick="javascript:OpenCalendar('adtLastTime', false, event.screenX, event.screenY)"
							style="CURSOR:pointer"><IMG id="imgCalBegin2" src="images/calendar-16x16.gif" border="0"></A>
					</td>
				</tr>
				<tr>
					<td align="center"><asp:button id="btnSave" runat="server" Text=" Save "></asp:button></td>
					<td align="center"><INPUT onclick="javascript:window.close();" type="button" value="Cancel"></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
