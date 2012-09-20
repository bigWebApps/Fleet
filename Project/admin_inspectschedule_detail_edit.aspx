<%@ Page language="c#" Codebehind="admin_inspectschedule_detail_edit.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_inspectschedule_detail_edit" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR>
			<TD colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead1">Inspection Information of Schedule</td>
					</tr>
				</table>
			</TD>
		</TR>
		<TR>
			<TD class="RowCap">Schedule Name</TD>
			<TD class="RowElem" width="66%" colSpan="2">
				<asp:Label id="lblScheduleName" runat="server"></asp:Label></TD>
		</TR>
		<tr vAlign="middle">
			<td class="RowCap">Inspection Name</td>
			<td class="RowElem" width="66%" colSpan="2">
				<asp:DropDownList id="ddlInspections" runat="server" DataTextField="vchName" DataValueField="Id"></asp:DropDownList></td>
		</tr>
		<tr vAlign="middle">
			<td class="RowCap">Minimum Days Out</td>
			<td class="RowElem" width="66%" colSpan="2">
				<asp:TextBox id="tbMinDays" runat="server" MaxLength="10"></asp:TextBox>
				<asp:RequiredFieldValidator id="rfvMinDays" runat="server" ErrorMessage="Min Days is required" ControlToValidate="tbMinDays"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator id="revMinDays" runat="server" ErrorMessage="Min Days must be numeric" ControlToValidate="tbMinDays"
					ValidationExpression="\d{1,10}"></asp:RegularExpressionValidator></td>
		</tr>
		<TR vAlign="middle">
			<TD class="RowCap">Target Days Out</TD>
			<TD class="RowElem" width="66%" colSpan="2">
				<asp:TextBox id="tbTagetDays" runat="server" MaxLength="10"></asp:TextBox>
				<asp:RequiredFieldValidator id="rfvTargetDays" runat="server" ErrorMessage="Target Days is required" ControlToValidate="tbTagetDays"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator id="revTargetDays" runat="server" ErrorMessage="Target Days must be numeric" ControlToValidate="tbTagetDays"
					ValidationExpression="\d{1,10}"></asp:RegularExpressionValidator></TD>
		</TR>
		<TR vAlign="middle">
			<TD class="RowCap">Maximum Days Out</TD>
			<TD class="RowElem" width="66%" colSpan="2">
				<asp:TextBox id="tbMaxDays" runat="server" MaxLength="10"></asp:TextBox>
				<asp:RequiredFieldValidator id="rfvMaxDays" runat="server" ErrorMessage="Max Days is required" ControlToValidate="tbMaxDays"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator id="revMaxDays" runat="server" ErrorMessage="Max Days must be numeric" ControlToValidate="tbMaxDays"
					ValidationExpression="\d{1,10}"></asp:RegularExpressionValidator></TD>
		</TR>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR>
			<TD colSpan="3"><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Inspection Schedule Detail?')">
					<asp:button id="btnDelete" runat="server" Text="Delete" CausesValidation="False"></asp:button>
				</SPAN></TD>
		</TR>
	</table>
</form>
