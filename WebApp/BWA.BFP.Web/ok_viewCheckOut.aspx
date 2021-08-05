<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Page language="c#" Codebehind="ok_viewCheckOut.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_viewCheckOut" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td align="center" colSpan="2"><br>
				<h1><asp:Label id="lblFirstName" runat="server"></asp:Label>,&nbsp;
					<asp:Label id="lblEquipType" runat="server"></asp:Label>&nbsp;#<asp:label id="lblEquipId" runat="server"></asp:label>
					has been checked-out successfully!
				</h1>
				<br>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="FONT-SIZE: 18pt;">
				Please read the following instructions:<br>
				<asp:Repeater id="repInstructions" runat="server">
					<HeaderTemplate>
						<ul type="disc">
					</HeaderTemplate>
					<ItemTemplate>
						<li>
							<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchNote") %>' ID="Label1">
							</asp:Label>
						</li><table border="0" height="15"><tr><td></td></tr></table>
					</ItemTemplate>
					<FooterTemplate>
						</ul>
					</FooterTemplate>
				</asp:Repeater>
			</td>
		</tr>
		<tr>
			<td colspan="2"><br>
				<br>
				<br>
			</td>
		</tr>
		<tr>
			<td align="center" colSpan="2">
				<uc1:nextback id="NextBackControl" runat="server"></uc1:nextback>
			</td>
		</tr>
	</TABLE>
</form>
