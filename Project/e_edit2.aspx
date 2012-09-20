<%@ Page language="c#" Codebehind="e_edit2.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._e_edit2" errorPage="error.aspx"%>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<FORM id="Form1" runat="server">
	<TABLE>
		<TR>
			<TD class="RowCap">Preventive Maintenances Schedule</TD>
			<TD class="RowElem"><asp:dropdownlist id="ddPMScheduleId" runat="server"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvPMShed" runat="server" ErrorMessage="PM Schedule is required" Display="Dynamic"
					ControlToValidate="ddPMScheduleId"></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Inspections Schedule</TD>
			<TD class="RowElem"><asp:dropdownlist id="ddInspectionId" runat="server"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvInspection" runat="server" ErrorMessage="Inspections Schedule is required"
					Display="Dynamic" ControlToValidate="ddInspectionId"></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Units (Mileage)</TD>
			<TD class="RowElem"><asp:textbox id="tbCurrentUnits" runat="server"></asp:textbox>
				<asp:RequiredFieldValidator id="rfvUnits" runat="server" ErrorMessage="Units is required" Display="Dynamic"
					ControlToValidate="tbCurrentUnits"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator id="revUnits" runat="server" ErrorMessage="Unit must be decimal numeric" Display="Dynamic"
					ControlToValidate="tbCurrentUnits" ValidationExpression="^\d{0,10}(?:\.\d{0,8})?$"></asp:RegularExpressionValidator>
			</TD>
			<TD class="RowHelp">
			</TD>
		</TR>
		<TR class="RowHelp">
			<TD></TD>
			<TD><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
			<TD></TD>
		</TR>
	</TABLE>
</FORM>
