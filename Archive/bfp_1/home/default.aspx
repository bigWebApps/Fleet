<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="../controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="../controls/Footer.ascx" %>
<%@ Page language="c#" Codebehind="default.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home._default" %>
<BFPCntrls:Header id="Header" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0" runat="server" />
<table width='100%'><tr><td align=center>
<table>
	<tr>
		<td colspan="2">Create New Work Order</td>
	</tr>
	<tr>
		<td width=30px><br>
			<br>
		</td>
	</tr>
	<tr>
		<td colspan="2">Show Work Orders</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>Today</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>Weekly</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>Monthly</td>
	</tr>
	<tr>
		<td><br>
			<br>
		</td>
	</tr>
	<tr>
		<td colspan="2"><a class=LargeLink href='equip/list.aspx'>View Equipment List</a></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><a href='equip/edit.aspx?id=0'>Add New</a></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>State Report</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>Past Work Orders</td>
	</tr>
	<tr>
		<td><br>
			<br>
		</td>
	</tr>
	<tr>
		<td colspan="2">Print Parts Used</td>
	</tr>
</table>
</td></tr></table>
<BFPCntrls:Footer id="Footer" runat="server" />
