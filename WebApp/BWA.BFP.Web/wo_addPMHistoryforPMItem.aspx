<%@ Page language="c#" Codebehind="wo_addPMHistoryforPMItem.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_addPMHistoryforPMItem" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<HTML>
	<HEAD>
		<title>Adding History for PM Item</title>
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
					<td colSpan="2"><b><i>Add Units and Date of Last Service</i></b>
						<br>
						<asp:Label id="lblError" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="Smaller"></asp:Label>
					</td>
				</tr>
				<TR>
					<TD>Category:</TD>
					<TD><asp:label id="lblCategory" runat="server" Font-Bold="True"></asp:label></TD>
				</TR>
				<tr>
					<td>Service Name:
					</td>
					<td><asp:label id="lblServiceName" runat="server" Font-Bold="True"></asp:label></td>
				</tr>
				<tr>
					<td>Equipment Id:
					</td>
					<td><asp:label id="lblEquipName" runat="server" Font-Bold="True"></asp:label></td>
				</tr>
				<tr valign="middle">
					<td nowrap>
						Last Service Date:</td>
					<td nowrap><cc1:activedatetime id="adtLastTime" runat="server" AllowNull="False" AlertEnabled="True" MinYear="2000"
							MaxYear="2030" Format="MONTH;/;DAY;/;YEAR"></cc1:activedatetime>
						&nbsp; <A onclick="javascript:OpenCalendar('adtLastTime', false, event.screenX, event.screenY)"
							style="CURSOR:pointer"><IMG id="imgCalBegin2" src="images/calendar-16x16.gif" border="0"></A>
					</td>
				</tr>
				<tr>
					<td valign="baseline">
						Last Service Units:</td>
					<td><asp:textbox id="tbUnits" runat="server"></asp:textbox><br>
						<asp:RequiredFieldValidator id="rfvUnits" runat="server" ErrorMessage="Units is required" ControlToValidate="tbUnits"></asp:RequiredFieldValidator>
						<br>
						<asp:rangevalidator id="valRangeUnits" runat="server" ErrorMessage="Value must be greater than 0." ControlToValidate="tbUnits"
							MaximumValue="999999999" MinimumValue="0" Display="Dynamic"></asp:rangevalidator>
						<br>
						<asp:RegularExpressionValidator id="revUnits" runat="server" ErrorMessage="Unit must be decimal numeric" ControlToValidate="tbUnits"
							ValidationExpression="^\d{0,10}(?:\.\d{0,8})?$"></asp:RegularExpressionValidator></td>
				</tr>
				<tr>
					<td align="center"><asp:button id="btnSave" runat="server" Text=" Save "></asp:button></td>
					<td align="center"><INPUT onclick="javascript:window.close();" type="button" value="Cancel"></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
