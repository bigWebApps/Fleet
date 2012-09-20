<%@ Page language="c#" Codebehind="ok_authCredentials.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_authCredentials" %>
<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<form id="Form1" method="post" runat="server">
	<table cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td width="15%"></td>
			<td></td>
			<td width="200"></td>
			<td width="25%"></td>
		</tr>
		<tr>
			<td></td>
			<td colSpan="2">
				<h1>Please enter PIN code for the processing of
					<asp:label id="lblType" runat="server"></asp:label>
					#<asp:label id="lblEquipId" runat="server"></asp:label>
				</h1>
			</td>
			<td></td>
		</tr>
		<tr>
			<td colspan="4">
				<br>
				<br>
			</td>
		</tr>
		<tr>
			<td height="24"></td>
			<td class="ok_maintext" height="24">Last Name</td>
			<td height="24"><asp:textbox id="tbLastName" runat="server" MaxLength="50" CssClass="ok_input_text"></asp:textbox></td>
			<td height="24">
				<asp:RequiredFieldValidator id="rfvLastName" runat="server" Font-Size="14pt" ControlToValidate="tbLastName"
					ErrorMessage="Last Name is required" Display="Dynamic"></asp:RequiredFieldValidator></td>
		</tr>
		<tr>
			<td></td>
			<td class="ok_maintext">PIN Code</td>
			<td>
				<asp:TextBox id="tbPIN" runat="server" TextMode="Password" MaxLength="10" CssClass="ok_input_text"></asp:TextBox></td>
			<td>
				<asp:RequiredFieldValidator id="rfvPIN" runat="server" ErrorMessage="PIN is required" ControlToValidate="tbPIN"
					Font-Size="14pt" Display="Dynamic"></asp:RequiredFieldValidator><br>
				<asp:regularexpressionvalidator id="revPIN" runat="server" ErrorMessage="must be from 4 digits and more" ControlToValidate="tbPIN"
					ValidationExpression="\d{4,}" Font-Size="14pt" Display="Dynamic"></asp:regularexpressionvalidator></td>
		</tr>
		<tr>
			<td colspan="4">
				<br>
				<br>
				<asp:Label id="lblError" runat="server" Font-Size="14pt" ForeColor="Red"></asp:Label>
				<br>
				<br>
			</td>
		</tr>
		<tr>
			<td></td>
			<td align="center" colspan="2">
				<uc1:NextBack id="NextBackControl" runat="server"></uc1:NextBack>
			</td>
			<td></td>
		</tr>
	</table>
</form>
