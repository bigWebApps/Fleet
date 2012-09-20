<%@ Register TagPrefix="BFPCntrls" TagName="Signature" Src="controls/Signature.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Page language="c#" Codebehind="wo_viewCheckIn.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_viewCheckIn" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR>
			<TD class="tblSubHead1" colSpan="3">Main Information</TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Work Order #</TD>
			<td class="RowElem" width="40%"><asp:label id="lblWorkOrderId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Equipment #</TD>
			<td class="RowElem">
				<asp:hyperlink id="hlEquipId" runat="server" Target="_blank"></asp:hyperlink></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Equipment Operator</TD>
			<TD class="RowElem"><asp:label id="lblOperator" runat="server"></asp:label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Spare Equipment #</TD>
			<td class="RowElem" noWrap><asp:hyperlink id="hlSpareEquipId" runat="server" Target="_blank"></asp:hyperlink>&nbsp;
				<asp:hyperlink id="hlChangeSpare" runat="server" Font-Bold="True">[change]</asp:hyperlink></td>
			<td class="RowHelp"></td>
		</TR>
		<tr vAlign="middle">
			<td class="RowCap">Equipment Units</td>
			<td class="RowElem" noWrap><asp:textbox id="tbMileage" runat="server" MaxLength="10"></asp:textbox><asp:label id="lblMeasure" runat="server"></asp:label></td>
			<td class="RowHelp"><asp:requiredfieldvalidator id="rfvMileage" runat="server" ControlToValidate="tbMileage" ErrorMessage="Units is required<br>"></asp:requiredfieldvalidator><asp:rangevalidator id="valRangeUnits" runat="server" ControlToValidate="tbMileage" ErrorMessage="Value must be greater than was 0<br>"
					Type="Double" Display="Dynamic" MinimumValue="0" MaximumValue="999999999"></asp:rangevalidator><asp:regularexpressionvalidator id="revMiles" runat="server" ControlToValidate="tbMileage" ValidationExpression="^\d{0,10}(?:\.\d{0,8})?$">This value must be decimal numeric</asp:regularexpressionvalidator></td>
		</tr>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Is the Operator Staying?</TD>
			<td class="RowElem"><asp:radiobuttonlist id="rblStaying" runat="server" RepeatDirection="Horizontal">
					<asp:ListItem Value="True">Yes</asp:ListItem>
					<asp:ListItem Value="False">No</asp:ListItem>
				</asp:radiobuttonlist></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Dropped Off By</TD>
			<td class="RowElem"><asp:textbox id="tbDroppedOffBy" runat="server" MaxLength="50"></asp:textbox></td>
			<td class="RowHelp">(Optional) Name of person dropping off equipment if different 
				than equipment operator</td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Additional Check-In Note</TD>
			<td class="RowElem" noWrap><asp:textbox id="tbNotes" runat="server" Height="100px" Width="100%" TextMode="MultiLine"></asp:textbox></td>
			<td class="RowHelp"></td>
		</TR>
		<TR>
			<TD class="RowCap" noWrap>Check-In Date</TD>
			<TD class="RowElem" noWrap><cc1:activedatetime id="adtCheckIn" runat="server" AllowNull="False" AlertEnabled="True" MinYear="1970"
					MaxYear="2020" Format=";MONTH;/;DAY;/;YEAR;"></cc1:activedatetime></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR>
			<TD class="tblSubHead1" width="100%" colSpan="3">Technician Signature for Check-In 
				of the Equipment
			</TD>
		</TR>
		<tr>
			<td colspan="3">
				<BFPCNTRLS:Signature id="Signature" runat="server"></BFPCNTRLS:Signature>
			</td>
		</tr>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></td>
			<td></td>
		</tr>
	</table>
</form>
