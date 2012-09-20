<%@ Page language="c#" Codebehind="ok_editNote.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_editNote" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TBODY>
			<tr>
				<TD width="50%"><BR>
				</TD>
				<td width="50%"></td>
			</tr>
			<asp:panel id="pnlViewQuestion" runat="server" Visible="False">
				<TR>
					<TD align="center" colSpan="2"><BR>
						<BR>
						<H1>
							<asp:Label id="lblFirstName" runat="server"></asp:Label>, Do you have any 
							additional comments you would like to add to this work order?
						</H1>
						<BR>
						<BR>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:Button id="btnNO" runat="server" Text="   NO   " CssClass="ok_input_button"></asp:Button></TD>
					<TD align="center">
						<asp:Button id="btnYES" runat="server" Text="  YES  " CssClass="ok_input_button"></asp:Button></TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2"><BR>
						<BR>
						<BR>
						<BR>
						<asp:Button id="btnBack" runat="server" Text="<< Back" CssClass="ok_input_button"></asp:Button></TD>
					</TD></TR>
			</asp:panel>
			<asp:panel id="pnlEnterNote" runat="server" Visible="False">
				<TR>
					<TD align="center" colSpan="2"><BR>
						<H1>Please enter additional comments
						</H1>
						<BR>
						<BR>
					</TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2">
						<asp:TextBox id="tbNotes" runat="server" Height="200px" Width="500px" TextMode="MultiLine" Font-Size="14pt"></asp:TextBox><BR>
						<asp:RequiredFieldValidator id="rfvNotes" runat="server" Font-Size="14pt" ControlToValidate="tbNotes" ErrorMessage="Comments is required"></asp:RequiredFieldValidator></TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2"><BR>
						<asp:Button id="btnSaveNote" runat="server" Text="  Save  " CssClass="ok_input_button"></asp:Button></TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2"><BR>
						<BR>
						<BR>
						<BR>
						<asp:Button id="btnBack1" runat="server" Text="<< Back" CssClass="ok_input_button" CausesValidation="False"></asp:Button></TD>
					</TD></TR>
			</asp:panel>
		</TBODY>
	</TABLE>
</form>
