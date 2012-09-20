<%@ Page language="c#" Codebehind="e_editAquis.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._e_editAquis" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<FORM runat="server" ID="Form1">
	<TABLE>
		<TR>
			<TD class="RowCap" width="144">Date In-Service</TD>
			<TD class="RowElem" valign="middle"><cc1:activedatetime id="adtInService" runat="server" Format="MONTH;/;DAY;/;YEAR" MaxYear="2020" MinYear="1970"
					AlertEnabled="True" AllowNull="False"></cc1:activedatetime>
				&nbsp; <A id="A1" onclick="javascript:OpenCalendar('adtInService', false, event.screenX, event.screenY)"
					style="CURSOR:pointer" runat="server"><IMG id="imgCalBegin1" src="images/calendar-16x16.gif" border="0"></A>
			</TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Date Aquired</TD>
			<TD class="RowElem" valign="middle"><cc1:activedatetime id="adtAquired" runat="server" Format="MONTH;/;DAY;/;YEAR" MaxYear="2020" MinYear="1970"
					AlertEnabled="True" AllowNull="False" AutoAdjust="False"></cc1:activedatetime>
				&nbsp; <A id="A2" onclick="javascript:OpenCalendar('adtAquired', false, event.screenX, event.screenY)"
					style="CURSOR:pointer" runat="server"><IMG id="imgCalBegin2" src="images/calendar-16x16.gif" border="0"></A>
			</TD>
			<TD class="RowHelp" height="28"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">
				Org/Contact</TD>
			<TD class="RowElem"><asp:textbox id="tbOrgContact" runat="server" MaxLength="50" Columns="45"></asp:textbox>
				<asp:RequiredFieldValidator id="rfvContact" runat="server" ControlToValidate="tbOrgContact" ErrorMessage="Org/Contact is required"></asp:RequiredFieldValidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Amount</TD>
			<TD class="RowElem"><asp:textbox id="tbAmount" runat="server"></asp:textbox>
				<asp:RequiredFieldValidator id="rfvAmount" runat="server" ControlToValidate="tbAmount" ErrorMessage="Amount is required"></asp:RequiredFieldValidator><asp:regularexpressionvalidator id="valAmount" runat="server" ErrorMessage="Amount must be numeric." ControlToValidate="tbAmount"
					ValidationExpression="^\d{0,6}(?:\.\d{0,2})?$"></asp:regularexpressionvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144">Units (Mileage)</TD>
			<TD class="RowElem"><asp:textbox id="tbUnits" runat="server"></asp:textbox>
				<asp:RequiredFieldValidator id="rfvUnits" runat="server" ControlToValidate="tbUnits" ErrorMessage="Units is required"
					EnableClientScript="False">Units is required</asp:RequiredFieldValidator>
				<asp:RangeValidator id="valRangeUnits" runat="server" ErrorMessage="Value must be greater than 0." ControlToValidate="tbUnits"
					MaximumValue="999999999" MinimumValue="0" Type="Double"></asp:RangeValidator>
				<asp:RegularExpressionValidator id="valRegExpUnits" runat="server" ErrorMessage="Unit must be decimal numeric" ControlToValidate="tbUnits"
					ValidationExpression="^\d{0,10}(?:\.\d{0,8})?$"></asp:RegularExpressionValidator></TD>
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
	<asp:Label id="lblError" runat="server" ForeColor="Red"></asp:Label>
</FORM>
