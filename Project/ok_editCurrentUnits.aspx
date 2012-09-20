<%@ Page language="c#" Codebehind="ok_editCurrentUnits.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_editCurrentUnits" %>
<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TBODY>
			<TR>
				<TD width="50%"><BR>
					<BR>
				</TD>
				<td width="50%"></td>
			</TR>
			<TR>
				<TD align="center" colSpan="2">
					<H1>
						The equipment’s current&nbsp;<asp:label id="lblMeasure" runat="server"></asp:label>&nbsp;is
						<asp:label id="lblCurrentUnits" runat="server"></asp:label>.
					</H1>
					<BR>
				</TD>
			</TR>
			<tr>
				<td class="ok_maintext" align="center" colSpan="2">
					Please enter the current&nbsp;<asp:label id="lblMeasure2" runat="server"></asp:label>&nbsp;for&nbsp;<asp:Label id="lblEquipType" runat="server"></asp:Label>&nbsp;#<asp:label id="lblEquipId" runat="server"></asp:label></td>
			</tr>
			<tr>
				<td class="ok_maintext" align="center" colSpan="2"><br>
					Current
					<asp:label id="lblMeasure3" runat="server"></asp:label>
					: &nbsp;<asp:textbox id="tbUnits" runat="server" CssClass="ok_input_text" onkeypress="return(clickButton(document.Form1.NextBackControl_btNext));"
						AutoPostBack="True" Width="200px" MaxLength="10"></asp:textbox>&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td align="center" colSpan="2"><asp:requiredfieldvalidator id="rfvUnis" runat="server" ErrorMessage="Mileage is required" ControlToValidate="tbUnits"
						Font-Size="14pt"></asp:requiredfieldvalidator><br>
					<asp:regularexpressionvalidator id="revUnits" runat="server" ControlToValidate="tbUnits" ValidationExpression="^\d{0,10}(?:\.\d{0,8})?$"
						Font-Size="14pt">This value must be decimal numeric</asp:regularexpressionvalidator><br>
					<asp:rangevalidator id="rvUnits" runat="server" ErrorMessage="Value must be greater than was 0" ControlToValidate="tbUnits"
						MaximumValue="999999999" MinimumValue="0" Type="Double" Font-Size="14pt"></asp:rangevalidator></td>
			</tr>
			<tr>
				<td align="center" colSpan="2"><br>
					<br>
					<br>
					<uc1:nextback id="NextBackControl" runat="server"></uc1:nextback></td>
			</tr>
		</TBODY></TABLE>
</form>
