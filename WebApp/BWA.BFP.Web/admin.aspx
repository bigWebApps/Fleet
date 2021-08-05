<%@ Page language="c#" Codebehind="admin.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin" %>
<form id="Form1" method="post" runat="server">
	<table cellpadding="4" cellspacing="1" border="0" align="center">
		<tr>
			<td colspan="3" align="left">
				<b>Inspections</b>
			</td>
		</tr>
		<TR>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td colspan="2" align="left">
				<asp:HyperLink id="hlInspections" runat="server" NavigateUrl="admin_inspections.aspx">Inspections Manager</asp:HyperLink></td>
		</TR>
		<TR>
			<TD></TD>
			<TD align="left" colSpan="2">
				<asp:HyperLink id="hlInspectSchedules" runat="server" NavigateUrl="admin_inspectschedules.aspx">Inspections Schedules Manager</asp:HyperLink></TD>
		</TR>
		<TR>
			<TD align="left" colSpan="3"><b>Preventive Maintenances</b></TD>
		</TR>
		<tr>
			<td></td>
			<td align="left" colspan="2">
				<asp:HyperLink id="hlPMItems" runat="server" NavigateUrl="admin_pmitems.aspx">PM Services Manager</asp:HyperLink>
			</td>
		</tr>
		<TR>
			<TD></TD>
			<TD align="left" colSpan="2">
				<asp:HyperLink id="hlPMSchedules" runat="server" NavigateUrl="admin_pmschedules.aspx">PM Schedules Manager</asp:HyperLink></TD>
		</TR>
		<tr>
			<td colspan="3" align="left">
				<b>Security</b>
			</td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td colspan="2" align="left">
				<asp:HyperLink id="hlPermission" runat="server" NavigateUrl="admin_permissions.aspx">Permissions Manager</asp:HyperLink>
			</td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td colspan="2" align="left">
				<asp:HyperLink id="hlGroups" runat="server" NavigateUrl="admin_groups.aspx">Groups Manager</asp:HyperLink></td>
		</tr>
		<TR>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td colspan="2" align="left">
				<asp:HyperLink id="hlUsers" runat="server" NavigateUrl="admin_users.aspx">Users Manager</asp:HyperLink></td>
		</TR>
		<tr>
			<td colspan="3" align="left">
				<b>Others</b>
			</td>
		</tr>
		<TR>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td colspan="2" align="left">
				<asp:HyperLink id="hlHolidays" runat="server" NavigateUrl="admin_holidays.aspx">Holidays Date Manager</asp:HyperLink></td>
		</TR>
		<TR>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td colspan="2" align="left">
				<asp:HyperLink id="hlKioskInstructionTexts" runat="server" NavigateUrl="admin_kiosk_customtext.aspx">Kiosk Instruction Texts Manager</asp:HyperLink></td>
		</TR>
		<TR>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td colspan="2" align="left">
				<asp:HyperLink id="hlWarehouseIntegration" runat="server" NavigateUrl="admin_integration.aspx">Setup Warehouse Integration</asp:HyperLink></td>
		</TR>
	</table>
</form>
1