<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Page language="c#" Codebehind="main.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home._main" %>
<BFPCntrls:Header id="Header" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0"
	runat="server" />
	<form id="Form1" method="post" runat="server">
<table width='100%'>
	<tr>
		<td align="center">
			<table>
				<tr>
					<td colspan="2">Create New Work Order</td>
				</tr>
				<tr>
					<td width="30"><br>
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
					<td colspan="2">
						<asp:HyperLink cssclass="LargeLink" id="hlViewList" runat="server" NavigateUrl="list.aspx">View Equipment List</asp:HyperLink></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<asp:HyperLink id="hlAdd" runat="server" NavigateUrl="addEquip.aspx" CssClass="LargeLink">Add New</asp:HyperLink></td>
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
				<TR>
					<TD colspan="2"><asp:HyperLink id="hlLogoff" runat="server" NavigateUrl="default.aspx?logoff" CssClass="LargeLink">Log off</asp:HyperLink></TD>
				</TR>
			</table>
		</td>
	</tr>
</table>
</form>
<BFPCntrls:Footer id="Footer" runat="server" />
