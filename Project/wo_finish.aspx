<%@ Page language="c#" Codebehind="wo_finish.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_finish" %>
<form id="Form1" method="post" runat="server">
	<br>
	<br>
	<table id="tblMain" runat="server" border="0" cellspacing="1" cellpadding="5" align="center">
		<tr>
			<td align="center"><p><asp:Label id="lblMainText" runat="server" Font-Bold="True"></asp:Label></p>
			</td>
		</tr>
		<tr>
			<td align="center">
				<asp:HyperLink id="hlHome" runat="server" NavigateUrl="main.aspx">[Return to Main Menu]</asp:HyperLink></td>
		</tr>
		<TR>
			<td align="center">
				<asp:HyperLink id="hlContinue" runat="server"></asp:HyperLink>
			</td>
		</TR>
		<TR>
			<td align="center">
				<asp:HyperLink id="hlView" runat="server"></asp:HyperLink>
			</td>
		</TR>
		<TR>
			<TD align="center">
				<asp:HyperLink id="hlAdditional" runat="server"></asp:HyperLink>
			</TD>
		</TR>
		<tr>
			<td align="center">
				<asp:HyperLink id="hlPrint" runat="server" Target="_blank"></asp:HyperLink>
			</td>
		</tr>
	</table>
</form>
