<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Signature.ascx.cs" Inherits="BWA.BFP.Web.Controls.User.Signature" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<table id="htmlTabel" width="100%" runat="server">
	<TR>
		<TD class="tblSubHead2" width="100%" colSpan="3">Signature</TD>
	</TR>
	<tr vAlign="top">
		<td class="RowCap">Initials</td>
		<td class="RowElem"><asp:textbox id="tbInitial" runat="server" MaxLength="3" Width="50px"></asp:textbox><asp:requiredfieldvalidator id="rfvInitials" runat="server" ControlToValidate="tbInitial" ErrorMessage="Initials is required"></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="revInitials" runat="server" ControlToValidate="tbInitial" ErrorMessage="Initials must be 2 or 3 symbols"
				ValidationExpression="\w{2,3}"></asp:regularexpressionvalidator></td>
	</tr>
	<tr vAlign="top">
		<td class="RowCap">
			PIN Code</td>
		<td class="RowElem" width="66%"><asp:textbox id="tbPIN" runat="server" MaxLength="10" TextMode="Password" Width="50px"></asp:textbox><asp:requiredfieldvalidator id="rfvPIN" runat="server" ControlToValidate="tbPIN" ErrorMessage="PIN is required"></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="revPIN" runat="server" ControlToValidate="tbPIN" ErrorMessage="PIN must be 4 digits or more"
				ValidationExpression="\d{4,}"></asp:regularexpressionvalidator></td>
	</tr>
	<tr>
		<TD colSpan="2">
			<asp:label id="lblError" runat="server" ForeColor="Red"></asp:label></TD>
	</tr>
</table>
