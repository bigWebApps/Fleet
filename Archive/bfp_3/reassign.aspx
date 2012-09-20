<%@ Page language="c#" Codebehind="reassign.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._reassign" %>
<%@ Register TagPrefix="BFPCntrls" TagName="SCC" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<BFPCNTRLS:HEADER id="Header" runat="server" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0"
	RightMenuSelected="0"></BFPCNTRLS:HEADER>
<FORM id="Form1" runat="server">
	<table>
		<TR>
			<TD class="RowCap">Equipment Id</TD>
			<td class="RowElem">
				<asp:Label id="lblEquipment" runat="server"></asp:Label></td>
			<td class="RowHelp">User assigned internal id/character. At Walker Count they are 
				Bus 101,102,102B, 102C, 103, ...</td>
		</TR>
		<TR>
			<TD class="RowCap">Type</TD>
			<TD class="RowElem">
				<asp:Label id="lblType" runat="server"></asp:Label></TD>
			<TD class="RowHelp">Equipment Type</TD>
		</TR>
		<TR>
			<TD class="RowCap">Make/Model</TD>
			<TD class="RowElem">
				<asp:Label id="lblMakeModel" runat="server"></asp:Label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Year</TD>
			<TD class="RowElem">
				<asp:Label id="lblYear" runat="server"></asp:Label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">VIN/Serial #</TD>
			<TD class="RowElem">
				<asp:Label id="lblSerial" runat="server"></asp:Label></TD>
			<TD class="RowHelp">Vin or Serial number of equipment</TD>
		</TR>
		<TR>
			<TD class="RowCap">Fuel Code</TD>
			<TD class="RowElem">
				<asp:Label id="lblFuelCode" runat="server"></asp:Label></TD>
			<TD class="RowHelp">Code to identify this equipment in the fuel monitoring systems.</TD>
		</TR>
		<TR>
			<TD class="RowCap">Department</TD>
			<TD class="RowElem">
				<asp:Label id="lblDepartment" runat="server"></asp:Label></TD>
			<TD class="RowHelp">Internal Departments</TD>
		</TR>
		<TR>
			<TD class="RowCap">Location</TD>
			<TD class="RowElem">
				<asp:Label id="lblLocation" runat="server"></asp:Label></TD>
			<TD class="RowHelp">Internal Location</TD>
		</TR>
		<TR>
			<TD class="RowCap">Share</TD>
			<TD class="RowElem">
				<asp:Label id="lblShare" runat="server"></asp:Label></TD>
			<TD class="RowHelp">Equipment is available as a spare True/False</TD>
		</TR>
		<TR>
			<TD class="RowCap">Assign From</TD>
			<TD class="RowElem"><asp:label id="lbAssignFrom" runat="server"></asp:label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Assign To*</TD>
			<TD class="RowElem"><asp:dropdownlist id="ddAssignTo" runat="server"></asp:dropdownlist>
				<asp:requiredfieldvalidator id="rfvAssign" runat="server" ErrorMessage="Assign is required" Display="Dynamic"
					ControlToValidate="ddAssignTo"></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Note*</TD>
			<TD class="RowElem"><asp:textbox id="tbNote" runat="server" CssClass="input6"></asp:textbox><asp:requiredfieldvalidator id="rfvNote" runat="server" ControlToValidate="tbNote" Display="Dynamic" ErrorMessage="Note is required"></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR class="RowHelp">
			<TD></TD>
			<TD><BFPCNTRLS:SCC id="SaveCancelControl" runat="server"></BFPCNTRLS:SCC></TD>
			<TD></TD>
		</TR>
	</table>
</FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
