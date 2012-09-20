<%@ Page language="c#" Codebehind="error.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.error._error" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colspan="2">
				<b>The BFP site has encountered a problem. We are sorry for the inconvenience.</b>
			</td>
		</tr>
		<tr>
			<td colspan="2" bgcolor="black">
			</td>
		</tr>
		<tr>
			<td>Error Description:</td>
			<td>
				<asp:Label id="lblError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
		</tr>
		<tr>
			<td colspan="2" bgcolor="black">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<b>If the system error has been in the site then you can send the report having 
					full error description to help us improve this site.</b></td>
		</tr>
		<tr>
			<td colspan="2" bgcolor="black">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<asp:Button id="btnSendReport" runat="server" Text="Send Error Report"></asp:Button>&nbsp;
				<asp:Label id="lblBack" runat="server"></asp:Label>
			</td>
		</tr>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
