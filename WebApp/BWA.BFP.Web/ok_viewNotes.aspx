<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Page language="c#" Codebehind="ok_viewNotes.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_viewNotes" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TBODY>
			<tr>
				<TD width="50%"><BR>
					<br>
					<br>
				</TD>
				<td width="50%"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<table class="tblStandard" borderColor="#9e755f" cellSpacing="0" cellPadding="5" border="2">
						<tr>
							<td class="tblSubHead1" style="FONT-SIZE: 12pt" align="left" colspan="2" height="22">
								The Check-Out Notes from Technician
							</td>
						</tr>
						<asp:repeater id="repTechNotes" runat="server">
							<ItemTemplate>
								<tr valign="middle" class="ag01">
									<td class="ok_size" align="left">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size" align="right">
										<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.CreatedDate")).ToString("yyyy-MM-dd hh:mm tt") %>'>
										</asp:Label>
									</td>
								</tr>
								<tr valign="middle">
									<td class="ok_size" align="left" colspan="2">
										<asp:label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Note") %>'>
										</asp:label>
									</td>
								</tr>
							</ItemTemplate>
						</asp:repeater>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br>
					<br>
					<br>
				</td>
			</tr>
			<tr>
				<TD colspan="2" align="center">
					<uc1:nextback id="NextBackControl" runat="server"></uc1:nextback>
				</TD>
			</tr>
		</TBODY>
	</TABLE>
</form>
