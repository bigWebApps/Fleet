<%@ Page language="c#" Codebehind="ok_editStaying.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_editStaying" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TBODY>
			<tr>
				<TD width="50%"><BR>
				</TD>
				<td width="50%"></td>
			</tr>
			<TR>
				<TD align="center" colSpan="2"><BR>
					<br>
					<H1>
						<asp:Label id="lblFirstName" runat="server"></asp:Label>, Will you be staying 
						while your equipment is serviced?
					</H1>
					<BR>
					<br>
					<br>
				</TD>
			</TR>
			<TR>
				<TD align="center" height="23">
					<asp:Button id="btnNO" runat="server" Text="   NO   " CssClass="ok_input_button"></asp:Button></TD>
				<TD align="center" height="23">
					<asp:Button id="btnYES" runat="server" CssClass="ok_input_button" Text="  YES  "></asp:Button></TD>
			</TR>
			<tr>
				<td align="center" colSpan="2">
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<asp:Button id="btnBack" runat="server" CssClass="ok_input_button" Text="<< Back"></asp:Button></td>
				</TD>
			</tr>
			<TR>
				<TD align="center" colSpan="2">
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>
