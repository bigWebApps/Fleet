<%@ Page language="c#" Codebehind="wo_openWorkOrder.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_openWorkOrder" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<form id="Form1" method="post" runat="server">
	<table id="tableMain">
		<TR>
			<TD class="tblSubHead1" colSpan="3">Main Information</TD>
		</TR>
		<TR vAlign="middle">
			<TD class="RowCap">Work Order #</TD>
			<td class="RowElem" width="50%"><asp:label id="lblWorkOrderId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="middle">
			<TD class="RowCap">Equipment #</TD>
			<td class="RowElem">
				<asp:hyperlink id="hlEquipId" runat="server" Target="_blank"></asp:hyperlink></td>
			<td class="RowHelp"></td>
		</TR>
		<tr valign="middle">
			<TD class="RowCap" nowrap>Equipment Operator</TD>
			<TD class="RowElem"><asp:label id="lblOperator" runat="server"></asp:label></TD>
			<td class="RowHelp"></td>
		</tr>
		<TR vAlign="middle">
			<TD class="RowCap" nowrap>Is the operator staying?</TD>
			<td class="RowElem">
				<asp:label id="lblStaying" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="middle">
			<TD class="RowCap" noWrap>Spare Equipment</TD>
			<td class="RowElem">
				<asp:hyperlink id="hlSpareEquipId" runat="server" Target="_blank"></asp:hyperlink>&nbsp;</td>
			<td class="RowHelp"></td>
		</TR>
		<TR>
			<TD class="RowCap">Check-In Date</TD>
			<TD class="RowElem">
				<asp:Label id="lblArrivalDate" runat="server"></asp:Label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR vAlign="middle">
			<TD class="RowCap">Scheduled Date</TD>
			<td class="RowElem">
				<asp:Label id="lblScheduledDate" runat="server"></asp:Label></td>
			<td class="RowHelp"></td>
		</TR>
		<tr vAlign="middle">
			<td class="RowCap">Equipment Units</td>
			<td class="RowElem" noWrap>
				<asp:textbox id="tbMileage" runat="server" MaxLength="10"></asp:textbox>
				<asp:label id="lblMeasure" runat="server"></asp:label>
			</td>
			<td class="RowHelp">
				<asp:requiredfieldvalidator id="rfvMileage" runat="server" ErrorMessage="Units is required<br>" ControlToValidate="tbMileage"></asp:requiredfieldvalidator>
				<asp:rangevalidator id="valRangeUnits" runat="server" ErrorMessage="Value must be greater than was 0<br>"
					ControlToValidate="tbMileage" MaximumValue="999999999" MinimumValue="0" Display="Dynamic" Type="Double"></asp:rangevalidator>
				<asp:regularexpressionvalidator id="revMiles" runat="server" ControlToValidate="tbMileage" ValidationExpression="^\d{0,10}(?:\.\d{0,8})?$">This value must be decimal numeric</asp:regularexpressionvalidator></td>
		</tr>
		<TR vAlign="middle">
			<TD class="RowCap" nowrap>Assigned Technician</TD>
			<td class="RowElem" nowrap><asp:dropdownlist id="ddlTech" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist>
			</td>
			<td class="RowHelp">
				<asp:RequiredFieldValidator id="rfvAssignTech" runat="server" ControlToValidate="ddlTech" ErrorMessage="The assigned technician is required"
					InitialValue="0"></asp:RequiredFieldValidator></td>
		</TR>
		<TR vAlign="middle">
			<TD class="RowCap">Dropped Off By</TD>
			<td class="RowElem"><asp:textbox id="tbDroppedOffBy" runat="server" MaxLength="50"></asp:textbox></td>
			<td class="RowHelp">
				(Optional) Name of person dropping off equipment if different than equipment 
				operator</td>
		</TR>
		<asp:repeater id="repCustomFields" runat="server" EnableViewState="False">
			<HeaderTemplate>
				<TR>
					<TD class="tblSubHead2" vAlign="middle" colSpan="3">Custom Fields
					</TD>
				</TR>
			</HeaderTemplate>
			<ItemTemplate>
				<INPUT id=inputTypeName type=hidden value='<%# DataBinder.Eval(Container.DataItem, "TypeName", "{0}") %>' runat="server" NAME="inputTypeName">
				<TR>
					<TD class="RowCap">
						<asp:Label id="lblValueName" runat="server">
							<%# DataBinder.Eval(Container, "DataItem.ValueName") %>
						</asp:Label></TD>
					<TD class="RowElem">
						<asp:TextBox id="tbValue" runat="server" MaxLength="255" Text='<%# DataBinder.Eval(Container.DataItem, "Value_String") %>' Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TB_Visible", "{0}")) %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Enabled", "{0}")) %>'>
						</asp:TextBox>
						<asp:RequiredFieldValidator id="rfvValue" runat="server" ErrorMessage='<%# Convert.ToString(DataBinder.Eval(Container.DataItem, "ValueName", "{0}")) + " is required" %>' ControlToValidate="tbValue" Display="Dynamic" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "RFV_Visible", "{0}")) %>'>
						</asp:RequiredFieldValidator>
						<asp:regularexpressionvalidator id="valValue" runat="server" ErrorMessage='<%# DataBinder.Eval(Container.DataItem, "ErrorMessage") %>' ControlToValidate="tbValue" ValidationExpression='<%# DataBinder.Eval(Container.DataItem, "Exp") %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Val_Visible", "{0}")) %>'>
						</asp:regularexpressionvalidator>
						<asp:DropDownList id=ddlValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "DDL_Visible", "{0}")) %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Enabled", "{0}")) %>'>
						</asp:DropDownList>
						<asp:CheckBox id=chValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "CB_Visible", "{0}")) %>' Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Value_Boolean", "{0}")) %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Enabled", "{0}")) %>'>
						</asp:CheckBox>
						<cc1:activedatetime id=adtValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "DT_Visible", "{0}")) %>' Date='<%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "Value_DateTime", "{0}")) %>' MinYear="2000" MaxYear="2030" Format="MONTH;/;DAY;/;YEAR" AlertEnabled="True" AllowNull="False" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Enabled", "{0}")) %>'>
						</cc1:activedatetime>
					</TD>
					<TD class="RowHelp">
						<asp:Label id="lblHelp" runat="server">
							<%# DataBinder.Eval(Container.DataItem, "Help") %>
						</asp:Label>
					</TD>
				</TR>
			</ItemTemplate>
		</asp:repeater>
		<TR>
			<TD class="tblSubHead2" vAlign="top" colSpan="3">Creation Notes</TD>
		</TR>
		<TR>
			<TD class="RowCap" noWrap>Clerk's Creation Note</TD>
			<TD class="RowElem">
				<asp:Label id="lblClerkNote" runat="server"></asp:Label></TD>
			<TD class="RowHelp">The Clerk's Creation Note entered during creating Work Order</TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" nowrap>
				Additional Creation Note&nbsp;</TD>
			<td class="RowElem" noWrap><asp:textbox id="tbNotes" runat="server" TextMode="MultiLine" Width="100%" Height="100px"></asp:textbox></td>
			<td class="RowHelp"></td>
		</TR>
		<TR>
			<TD class="RowCap" noWrap>Open Date</TD>
			<TD class="RowElem" noWrap>
				<cc1:activedatetime id="adtOpened" runat="server" AllowNull="False" AlertEnabled="True" MinYear="2000"
					MaxYear="2030" Format=";MONTH;/;DAY;/;YEAR;"></cc1:activedatetime></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD colSpan="3"><br>
			</TD>
		</TR>
		<TR vAlign="top">
			<TD></TD>
			<TD><uc1:NextBack id="NextBackControl" runat="server"></uc1:NextBack></TD>
			<TD></TD>
		</TR>
	</table>
</form>
