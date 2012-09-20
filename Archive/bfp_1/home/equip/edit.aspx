<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="../../controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="../../controls/Footer.ascx" %>
<%@ Register tagprefix="mbll" namespace="MetaBuilders.WebControls" Assembly="MetaBuilders.WebControls.ListLink" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="../../controls/SaveCancel.ascx" %>
<%@ Page language="c#" Codebehind="edit.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._edit" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<FORM runat="server">
	<TABLE>
		<TR>
			<TD class="RowCap">Equipment Id</TD>
			<TD class="RowElem">
				<asp:TextBox id="tbEquipId" runat="server" MaxLength="4" Columns="8"></asp:TextBox>
				<asp:RequiredFieldValidator id="rfvEquipId" runat="server" ErrorMessage="Equipment id is required." ControlToValidate="tbEquipId"
					Display="Dynamic"></asp:RequiredFieldValidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" height="28">Type</TD>
			<TD class="RowElem" height="28"><asp:dropdownlist id="ddTypeId" runat="server"></asp:dropdownlist>
				<asp:RequiredFieldValidator id="rfvTypeId" runat="server" ErrorMessage="Type is required." ControlToValidate="ddTypeId"></asp:RequiredFieldValidator></TD>
			<TD class="RowHelp" height="28"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Make</TD>
			<TD class="RowElem"><asp:dropdownlist id="ddMakeId" runat="server"></asp:dropdownlist>
				<asp:RequiredFieldValidator id="rfvMakeId" runat="server" ErrorMessage="Make is required." ControlToValidate="ddMakeId"></asp:RequiredFieldValidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Model</TD>
			<TD class="RowElem"><asp:dropdownlist id="ddModelId" runat="server"></asp:dropdownlist>
				<asp:RequiredFieldValidator id="rfvModelId" runat="server" ErrorMessage="Model is required." ControlToValidate="ddModelId"></asp:RequiredFieldValidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Year</TD>
			<TD class="RowElem">
				<asp:TextBox id="tbYear" runat="server" MaxLength="4" Columns="8"></asp:TextBox>
				<asp:RequiredFieldValidator id="rfvYear" runat="server" ErrorMessage="Year is required." ControlToValidate="tbYear"></asp:RequiredFieldValidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Department</TD>
			<TD class="RowElem">
				<asp:DropDownList id="ddDeptId" runat="server"></asp:DropDownList>
				<asp:RequiredFieldValidator id="rfvDepartment" runat="server" ErrorMessage="Department is required." ControlToValidate="ddDeptId"></asp:RequiredFieldValidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Default Location</TD>
			<TD class="RowElem">
				<asp:DropDownList id="ddLocationId" runat="server"></asp:DropDownList>
				<asp:RequiredFieldValidator id="rfvLocation" runat="server" ErrorMessage="Location is required." ControlToValidate="ddLocationId"></asp:RequiredFieldValidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">VIN/Serial #</TD>
			<TD class="RowElem">
				<asp:TextBox id="tbVinSerial" runat="server" Columns="25" MaxLength="50"></asp:TextBox></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Fuel Code</TD>
			<TD class="RowElem">
				<asp:TextBox id="tbFuelCode" runat="server" MaxLength="25"></asp:TextBox></TD>
			<TD class="RowHelp">Code to identify this equipment in the fuel monitoring systems.</TD>
		</TR>
		<TR>
			<TD class="RowCap">
				<asp:Label id="lbAssignedToCap" runat="server">Assigned To</asp:Label></TD>
			<TD class="RowElem">
				<asp:Label id="lbAssignedTo" runat="server"></asp:Label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">
				<asp:Label id="lbReassignCap" runat="server">Reassign</asp:Label></TD>
			<TD class="RowElem">
				<asp:CheckBox id="ckReassign" runat="server"></asp:CheckBox></TD>
			<TD class="RowHelp">
				<asp:Label id="lbReassignHelp" runat="server">Check this box to assign this equipment to someone else.</asp:Label></TD>
		</TR>
		<TR class="RowHelp">
			<TD></TD>
			<TD>
				<uc1:SaveCancel id="SaveCancelControl" runat="server"></uc1:SaveCancel></TD>
			<TD></TD>
		</TR>
	</TABLE>
	<mbll:listlink id="ListLink1" runat="server" EnableViewState="True" DataRelation="Types_Makes"
		ChildList="ddMakeId" ParentList="ddTypeId" LockFirstItem="True"></mbll:listlink>
	<mbll:listlink id="ListLink2" runat="server" EnableViewState="True" DataRelation="Makes_Models"
		ChildList="ddModelId" ParentList="ddMakeId" LockFirstItem="True"></mbll:listlink></FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
