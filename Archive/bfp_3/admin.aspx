<%@ Page language="c#" Codebehind="admin.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table width='100%'>
		<tr>
			<td align="center">
				<table>
					<tr>
						<td colspan="2">
							<asp:HyperLink id="hlPermission" runat="server" NavigateUrl="admin_permissions.aspx">Permissions Manager</asp:HyperLink>
						</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="2">
							<asp:HyperLink id="hlGroups" runat="server" NavigateUrl="admin_groups.aspx">Groups Manager</asp:HyperLink></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
