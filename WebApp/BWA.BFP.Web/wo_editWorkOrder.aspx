<%@ Page language="c#" Codebehind="wo_editWorkOrder.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_editWorkOrder" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<form id="Form1" method="post" runat="server">
	<TABLE>
		<TR>
			<TD class="tblSubHead1" colSpan="3">Main Information</TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Work Order #</TD>
			<td class="RowElem"><asp:label id="lblWorkOrderId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR>
			<TD class="RowCap">Work Order Type</TD>
			<TD class="RowElem">
				<asp:radiobuttonlist id="rblWOTypes" runat="server" DataValueField="Id" DataTextField="vchName" RepeatLayout="Flow"></asp:radiobuttonlist></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Equipment #</TD>
			<td class="RowElem"><asp:hyperlink id="hlEquipId" runat="server" Target="_blank"></asp:hyperlink></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Spare Equipment #</TD>
			<td class="RowElem" noWrap><asp:hyperlink id="hlSpareEquipId" runat="server" Target="_blank"></asp:hyperlink>&nbsp;
				<asp:hyperlink id="hlChangeSpare" runat="server" Font-Bold="True">[change]</asp:hyperlink></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Assigned Technician</TD>
			<td class="RowElem"><asp:dropdownlist id="ddlTech" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist></td>
			<td class="RowHelp">for Open status and his sub-statuses the work order must be 
				assigned to technician</td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Equipment Operator</TD>
			<TD class="RowElem"><asp:label id="lblOperator" runat="server"></asp:label></TD>
			<TD class="RowHelp"></TD>
		</TR>
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
			<TD class="RowCap">Released To</TD>
			<td class="RowElem"><asp:textbox id="tbReleasedTo" runat="server" MaxLength="50"></asp:textbox></td>
			<td class="RowHelp">(Optional) Name of person picking up equipment if different 
				than equipment operator</td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Equipment Cleanliness</TD>
			<TD class="RowElem"><asp:textbox id="tbCleanliness" runat="server" MaxLength="1000" TextMode="MultiLine"></asp:textbox></TD>
			<TD class="RowHelp">Please indicate the condition of this equipment pertaining to 
				cleanliness</TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Created Date</TD>
			<td class="RowElem"><asp:label id="lblCreatedDate" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Scheduled Date</TD>
			<td class="RowElem" nowrap><cc1:activedatetime id="adtScheduled" runat="server" AllowNull="False" AlertEnabled="True" MinYear="2000"
					MaxYear="2030" Format=";MONTH;/;DAY;/;YEAR;<br>;HOUR; ;MINUTE; ;MERIDIEM"></cc1:activedatetime>
				&nbsp;&nbsp;&nbsp;&nbsp;<A id="html_ScheduledDate" onclick="javascript:OpenPopUpScheduleDate('adtScheduled', false)"
					style="CURSOR:pointer" runat="server"><IMG id="imgCalBegin3" src="images/calendar-16x16.gif" border="0">
				</A>
			</td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top" id="trCheckInDate" runat="server">
			<TD class="RowCap">Check-In Date</TD>
			<td class="RowElem"><cc1:activedatetime id="adtCheckIn" runat="server" AllowNull="False" AlertEnabled="True" MinYear="2000"
					MaxYear="2030" Format=";MONTH;/;DAY;/;YEAR;"></cc1:activedatetime></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top" id="trOpenedDate" runat="server">
			<TD class="RowCap">Opened Date</TD>
			<td class="RowElem"><cc1:activedatetime id="adtOpened" runat="server" AllowNull="False" AlertEnabled="True" MinYear="2000"
					MaxYear="2030" Format=";MONTH;/;DAY;/;YEAR;"></cc1:activedatetime></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top" id="trClosedDate" runat="server">
			<TD class="RowCap">Closed Date</TD>
			<td class="RowElem"><cc1:activedatetime id="adtClosed" runat="server" AllowNull="False" AlertEnabled="True" MinYear="2000"
					MaxYear="2030" Format=";MONTH;/;DAY;/;YEAR;"></cc1:activedatetime></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top" id="trCheckOutDate" runat="server">
			<TD class="RowCap">Check-Out Date</TD>
			<td class="RowElem"><cc1:activedatetime id="adtCheckOut" runat="server" AllowNull="False" AlertEnabled="True" MinYear="2000"
					MaxYear="2030" Format=";MONTH;/;DAY;/;YEAR;"></cc1:activedatetime></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap"></TD>
			<td class="RowElem"></td>
			<td class="RowHelp"></td>
		</TR>
		<asp:repeater id="repCustomFields" runat="server" EnableViewState="False">
			<HeaderTemplate>
				<TR>
					<TD class="tblSubHead2" vAlign="top" colSpan="3">Custom Fields
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
					<TD class="RowElem" width="35%">
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
					<TD class="RowHelp" width="40%">
						<asp:Label id="lblHelp" runat="server">
							<%# DataBinder.Eval(Container.DataItem, "Help") %>
						</asp:Label>
					</TD>
				</TR>
			</ItemTemplate>
		</asp:repeater>
		<TR vAlign="top">
			<TD></TD>
			<TD><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
			<TD></TD>
		</TR>
	</TABLE>
</form>
