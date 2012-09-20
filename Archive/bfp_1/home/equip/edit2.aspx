<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="../../controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="../../controls/Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="../../controls/SaveCancel.ascx" %>
<%@ Page language="c#" Codebehind="edit2.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._edit2" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<FORM runat="server">
	<TABLE>
		<TR>
			<TD class="RowCap" width="144">
				Status</TD>
			<TD class="RowElem">
				<asp:DropDownList id="ddStatusId" runat="server"></asp:DropDownList></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" height="28" width="144">PM Schedule</TD>
			<TD class="RowElem" height="28"><asp:dropdownlist id="ddPMScheduleId" runat="server"></asp:dropdownlist></TD>
			<TD class="RowHelp" height="28"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Inspection</TD>
			<TD class="RowElem"><asp:dropdownlist id="ddInspectionId" runat="server"></asp:dropdownlist></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Units (Mileage)</TD>
			<TD class="RowElem">
				<asp:TextBox id="tbCurrentUnits" runat="server"></asp:TextBox></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR class="RowHelp">
			<TD width="144"></TD>
			<TD>
				<uc1:SaveCancel id="SaveCancelControl" runat="server"></uc1:SaveCancel></TD>
			<TD></TD>
		</TR>
	</TABLE>
</FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
