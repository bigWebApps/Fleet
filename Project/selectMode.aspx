<%@ Page language="c#" Codebehind="selectMode.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web._selectMode" %>
<form id="Form1" method="post" runat="server">
	<table width="100%" border="0">
		<tr>
			<td><br>
				<br>
			</td>
		</tr>
		<tr>
			<td align="center">
				<table cellspacing="1" cellpadding="4" border="0">
					<tr>
						<td align="left">
							<asp:HyperLink id="hlAdmin" runat="server" NavigateUrl="admin.aspx">Administration</asp:HyperLink>
						</td>
					</tr>
					<tr>
						<td align="left">
							<asp:HyperLink id="hlErrors" runat="server" NavigateUrl="error_report.aspx">Error Reports</asp:HyperLink>
						</td>
					</tr>
					<tr>
						<td align="left">
							<asp:HyperLink id="hlTM" runat="server" NavigateUrl="main.aspx">Activate Technician Terminal</asp:HyperLink>
						</td>
					</tr>
					<tr>
						<td align="left">
							<asp:HyperLink id="hlOK" runat="server" NavigateUrl="ok_mainMenu.aspx">Activate Operator Kiosk Terminal</asp:HyperLink>
						</td>
					</tr>
					<tr>
						<td align="left">
							<asp:HyperLink id="hlLogoff" runat="server" NavigateUrl="default.aspx">Logoff</asp:HyperLink>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
