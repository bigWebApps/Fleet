<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Page language="c#" Codebehind="editDisp.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._editDisp" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<FORM id="Form1" runat="server">
	<TABLE>
		<TR>
			<TD class="RowCap" width="144" height="18">Date Out-Of-Service</TD>
			<TD class="RowElem" height="18"><cc1:activedatetime id="adtOutOfService" runat="server" MinYear="1970" MaxYear="2010" Format="MONTH;/;DAY;/;YEAR"
					AllowNull="False" AlertEnabled="True"></cc1:activedatetime></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="28">Date Disposed</TD>
			<TD class="RowElem" height="28"><cc1:activedatetime id="adtDisposed" runat="server" MinYear="1970" MaxYear="2010" Format="MONTH;/;DAY;/;YEAR"
					AllowNull="False" AlertEnabled="True"></cc1:activedatetime></TD>
			<TD class="RowHelp" height="28"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Org/Contact</TD>
			<TD class="RowElem"><asp:textbox id="tbOrgContact" runat="server" Columns="45" MaxLength="50"></asp:textbox>
				<asp:RequiredFieldValidator id="rfvOrgContact" runat="server" ErrorMessage="Org/Contact is required" ControlToValidate="tbOrgContact"
					Display="Dynamic"></asp:RequiredFieldValidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Amount</TD>
			<TD class="RowElem"><asp:textbox id="tbAmount" runat="server"></asp:textbox>
				<asp:RequiredFieldValidator id="rfvAmount" runat="server" ErrorMessage="Amount is required" ControlToValidate="tbAmount"
					Display="Dynamic"></asp:RequiredFieldValidator><asp:regularexpressionvalidator id="valAmount" runat="server" ValidationExpression="^\d{0,6}(?:\.\d{0,2})?$" ControlToValidate="tbAmount"
					ErrorMessage="Amount must be numeric."></asp:regularexpressionvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="24">Units (Mileage)</TD>
			<TD class="RowElem" height="24">
				<asp:textbox id="tbUnits" runat="server"></asp:textbox>
				<asp:RequiredFieldValidator id="rfvUnits" runat="server" Display="Dynamic" ControlToValidate="tbUnits" ErrorMessage="Units is required"></asp:RequiredFieldValidator>
				<asp:rangevalidator id="valRangeUnits" runat="server" ErrorMessage="Value must be greater than 0." ControlToValidate="tbUnits"
					MaximumValue="999999999" MinimumValue="0" Display="Dynamic"></asp:rangevalidator>
				<asp:regularexpressionvalidator id="valRegExpUnits" runat="server" ErrorMessage="Input must be an integer (1,2,3,4..)"
					ControlToValidate="tbUnits" ValidationExpression="^\d{0,10}$" Display="Dynamic"></asp:regularexpressionvalidator></TD>
			<TD class="RowHelp" height="24"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Method</TD>
			<TD class="RowElem">
				<asp:dropdownlist id="ddMethod" runat="server"></asp:dropdownlist></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Notes</TD>
			<TD class="RowElem">
				<asp:textbox id="tbNotes" runat="server" MaxLength="250" Columns="40" TextMode="MultiLine" Rows="5"></asp:textbox></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR class="RowHelp">
			<TD width="144"></TD>
			<TD>
				<uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
			<TD></TD>
		</TR>
	</TABLE>
</FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
