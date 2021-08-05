<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="MM" TagName="MakesModels" Src="controls/MakesModels.ascx" %>
<%@ Page language="c#" Codebehind="e_edit.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._e_edit" %>
<form id="Form1" method="post" runat="server">
	<TABLE>
		<TR>
			<TD class="RowCap">Equipment Id</TD>
			<td class="RowElem"><asp:textbox id="tbEquipId" runat="server" Columns="8" MaxLength="50"></asp:textbox><asp:requiredfieldvalidator id="rfvEquipId" runat="server" Display="Dynamic" ControlToValidate="tbEquipId" ErrorMessage="Equipment id is required."></asp:requiredfieldvalidator></td>
			<td class="RowHelp">User assigned internal id/character. At Walker Count they are 
				Bus 101,102,102B, 102C, 103, ...</td>
		</TR>
		<TR>
			<TD class="RowCap">Make/Model</TD>
			<TD class="RowElem" align="left"><MM:MAKESMODELS id="mmValue" runat="server" EnableViewState="False"></MM:MAKESMODELS></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Year</TD>
			<TD class="RowElem"><asp:textbox id="tbYear" runat="server" Columns="8" MaxLength="4"></asp:textbox><asp:requiredfieldvalidator id="rfvYear" runat="server" ControlToValidate="tbYear" ErrorMessage="Year is required."></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="revYear" runat="server" ControlToValidate="tbYear" ErrorMessage="Year must be number"
					ValidationExpression="\d{4}"></asp:regularexpressionvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">VIN/Serial #</TD>
			<TD class="RowElem"><asp:textbox id="tbVinSerial" runat="server" Columns="25" MaxLength="50"></asp:textbox></TD>
			<TD class="RowHelp">Vin or Serial number of equipment</TD>
		</TR>
		<TR>
			<TD class="RowCap">Fuel Code</TD>
			<TD class="RowElem"><asp:textbox id="tbFuelCode" runat="server" MaxLength="25"></asp:textbox></TD>
			<TD class="RowHelp">Code to identify this equipment in the fuel monitoring systems.</TD>
		</TR>
		<TR>
			<TD class="RowCap" nowrap>Plate Number</TD>
			<TD class="RowElem"><asp:textbox id="tbPlateNumber" runat="server" MaxLength="50"></asp:textbox></TD>
			<TD class="RowHelp">License plate number for equipment</TD>
		</TR>
		<TR>
			<TD class="RowCap">Department</TD>
			<TD class="RowElem"><asp:dropdownlist id="ddlDepts" runat="server">
					<asp:ListItem Selected="True"></asp:ListItem>
				</asp:dropdownlist><asp:requiredfieldvalidator id="rfvDepartment" runat="server" ControlToValidate="ddlDepts" ErrorMessage="Department is required."></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp">Internal Departments</TD>
		</TR>
		<TR>
			<TD class="RowCap">Location</TD>
			<TD class="RowElem"><asp:dropdownlist id="ddlLocs" runat="server">
					<asp:ListItem Selected="True"></asp:ListItem>
				</asp:dropdownlist><asp:requiredfieldvalidator id="rfvLocation" runat="server" ControlToValidate="ddlLocs" ErrorMessage="Location is required."></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp">Internal Location</TD>
		</TR>
		<TR>
			<TD class="RowCap">Spare</TD>
			<TD class="RowElem"><asp:checkbox id="chSpare" runat="server"></asp:checkbox></TD>
			<TD class="RowHelp">Equipment is available as a spare True/False</TD>
		</TR>
		<TR>
			<TD class="RowCap" nowrap>Equipment Operator</TD>
			<TD class="RowElem"><asp:label id="lblEquipOperator" runat="server"></asp:label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" noWrap>Temporary Operator</TD>
			<TD class="RowElem">
				<asp:label id="lblTempOperator" runat="server"></asp:label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Reassign Operator</TD>
			<TD class="RowElem"><asp:checkbox id="cbReassign" runat="server"></asp:checkbox></TD>
			<TD class="RowHelp">Reassign Equipment Operator</TD>
		</TR>
		<TR>
			<TD></TD>
			<TD><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
			<TD></TD>
		</TR>
	</TABLE>
</form>
