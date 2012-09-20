<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="../../controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="../../controls/Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="../../controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Page language="c#" Codebehind="editAquis.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._editAquis" %>
<BFPCNTRLS:HEADER id="Header" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0"
	runat="server"></BFPCNTRLS:HEADER>
<FORM runat="server">
	<TABLE>
		<TR>
			<TD class="RowCap" width="144">Date In-Service</TD>
			<TD class="RowElem"><cc1:activedatetime id="adtInService" runat="server" Format="MONTH;/;DAY;/;YEAR" MaxYear="2010" MinYear="1970"></cc1:activedatetime></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="28">Date Aquired</TD>
			<TD class="RowElem" height="28"><cc1:activedatetime id="adtAquired" runat="server" Format="MONTH;/;DAY;/;YEAR" MaxYear="2010" MinYear="1970"></cc1:activedatetime></TD>
			<TD class="RowHelp" height="28"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">
				Org/Contact</TD>
			<TD class="RowElem"><asp:textbox id="tbOrgContact" runat="server" MaxLength="50" Columns="45"></asp:textbox></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Amount</TD>
			<TD class="RowElem"><asp:textbox id="tbAmount" runat="server"></asp:textbox><asp:regularexpressionvalidator id="valAmount" runat="server" ErrorMessage="Amount must be numeric." ControlToValidate="tbAmount"
					ValidationExpression="^\d+(?:\.\d{0,2})?$"></asp:regularexpressionvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Units (Mileage)</TD>
			<TD class="RowElem"><asp:textbox id="tbUnits" runat="server"></asp:textbox>
				<asp:RangeValidator id="valRangeUnits" runat="server" ErrorMessage="Value must be greater than 0." ControlToValidate="tbUnits"
					MaximumValue="999999999" MinimumValue="0" Display="Dynamic"></asp:RangeValidator>
				<asp:RegularExpressionValidator id="valRegExpUnits" runat="server" ErrorMessage="Input must be an integer (1,2,3,4..)"
					ControlToValidate="tbUnits" ValidationExpression="^\d+$" Display="Dynamic"></asp:RegularExpressionValidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Notes</TD>
			<TD class="RowElem"><asp:textbox id="tbNotes" runat="server" MaxLength="250" TextMode="MultiLine" Columns="40" Rows="5"></asp:textbox></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR class="RowHelp">
			<TD width="144"></TD>
			<TD><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
			<TD></TD>
		</TR>
	</TABLE>
</FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
