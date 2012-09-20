<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Page language="c#" Codebehind="edit2.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._edit2" errorPage="error.aspx"%>
<BFPCNTRLS:HEADER id="Header" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0"
	runat="server"></BFPCNTRLS:HEADER>
<FORM id="Form1" runat="server">
	<TABLE>
		<TR>
			<TD class="RowCap" width="144" height="28">PM Schedule</TD>
			<TD class="RowElem" height="28"><asp:dropdownlist id="ddPMScheduleId" runat="server"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvPMShed" runat="server" ErrorMessage="PM Schedule is required" Display="Dynamic"
					ControlToValidate="ddPMScheduleId"></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp" height="28"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Inspection</TD>
			<TD class="RowElem"><asp:dropdownlist id="ddInspectionId" runat="server"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvInspection" runat="server" ErrorMessage="Inspection is required" Display="Dynamic"
					ControlToValidate="ddInspectionId"></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Units (Mileage)</TD>
			<TD class="RowElem"><asp:textbox id="tbCurrentUnits" runat="server"></asp:textbox>
				<asp:RequiredFieldValidator id="rfvUnits" runat="server" ErrorMessage="Units is required" Display="Dynamic"
					ControlToValidate="tbCurrentUnits"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator id="revUnits" runat="server" ErrorMessage="Units must be numeric" Display="Dynamic"
					ControlToValidate="tbCurrentUnits" ValidationExpression="^\d{0,10}?$"></asp:RegularExpressionValidator>
			</TD>
			<TD class="RowHelp">
			</TD>
		</TR>
		<TR class="RowHelp">
			<TD width="144"></TD>
			<TD><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
			<TD></TD>
		</TR>
	</TABLE>
</FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
