<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Page language="c#" Codebehind="admin_pmschedule_detail_edit.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_pmschedule_detail_edit" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR>
			<TD colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead1">Preventive Maintenance Service of Schedule</td>
					</tr>
				</table>
			</TD>
		</TR>
		<TR>
			<TD class="RowCap">Schedule Name</TD>
			<TD class="RowElem" width="66%" colSpan="2"><asp:label id="lblScheduleName" runat="server"></asp:label></TD>
		</TR>
		<tr vAlign="middle">
			<td class="RowCap">Service Name</td>
			<td class="RowElem" width="66%" colSpan="2"><asp:dropdownlist id="ddlPMServices" runat="server" DataValueField="Id" DataTextField="ServiceName"></asp:dropdownlist></td>
		</tr>
		<tr vAlign="middle">
			<td class="RowCap">Time Interval (days)</td>
			<td class="RowElem" width="66%" colSpan="2"><asp:textbox id="tbDays" runat="server" MaxLength="10"></asp:textbox><asp:regularexpressionvalidator id="revDays" runat="server" ControlToValidate="tbDays" ErrorMessage="Days must be numeric"
					ValidationExpression="\d{1,10}" Display="Dynamic"></asp:regularexpressionvalidator></td>
		</tr>
		<TR vAlign="middle">
			<TD class="RowCap">Units Interval</TD>
			<TD class="RowElem" width="66%" colSpan="2"><asp:textbox id="tbUnits" runat="server" MaxLength="10"></asp:textbox><asp:dropdownlist id="ddlMeasures" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist><asp:regularexpressionvalidator id="revUnits" runat="server" ControlToValidate="tbUnits" ErrorMessage="Units must be numeric or decimal"
					ValidationExpression="(\d+\.\d{0,2})|(\d+)"></asp:regularexpressionvalidator></TD>
		</TR>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR vAlign="top">
			<TD colSpan="3"><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this PM Service of Schedule?')">
					<asp:button id="btnDelete" runat="server" CausesValidation="False" Text="Delete"></asp:button></SPAN></TD>
		</TR>
	</table>
</form>
