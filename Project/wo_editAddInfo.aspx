<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Page language="c#" Codebehind="wo_editAddInfo.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_editAddInfo" %>
<form id="Form1" method="post" runat="server">
	<table width="100%">
		<TR vAlign="top">
			<TD class="tblSubHead1" colSpan="3">Work Order Information</TD>
		</TR>
		<tr vAlign="top">
			<td class="RowCap" width="30%">Equipment #</td>
			<td class="RowElem" width="340"><asp:label id="lblEquipId" runat="server" Font-Bold="True"></asp:label></td>
			<td class="RowHelp"></td>
		</tr>
		<TR vAlign="top">
			<TD class="RowCap">Work Order Type
			</TD>
			<TD class="RowElem" width="340"><asp:radiobuttonlist id="rblWOTypes" runat="server" DataTextField="vchName" DataValueField="Id" RepeatLayout="Flow"></asp:radiobuttonlist>&nbsp;
				<asp:requiredfieldvalidator id="rfvTypes" runat="server" ControlToValidate="rblWOTypes" ErrorMessage="Work Order Type is required"></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" align="left" height="28">Scheduled Date and Time
			</TD>
			<TD class="RowElem" valign="middle" height="28">
				<cc1:activedatetime id="adtScheduled" runat="server" Format="MONTH;/;DAY;/;YEAR;&nbsp;:&nbsp;;HOUR;/;MINUTE;/;MERIDIEM"
					MaxYear="2020" MinYear="1970" AlertEnabled="True" AllowNull="False"></cc1:activedatetime>
				<A id="html_ScheduledDate" style="CURSOR: pointer" onclick="javascript:OpenPopUpScheduleDate('adtScheduled', false)"
					runat="server"><IMG id="imgCalBegin3" src="images/calendar-16x16.gif" border="0">
				</A>
			</TD>
			<TD class="RowHelp" height="28"></TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Work Order Creation Note</TD>
			<td class="RowElem" noWrap><asp:textbox id="tbNotes" runat="server" TextMode="MultiLine" Width="100%" Height="100px"></asp:textbox></td>
			<td class="RowHelp"></td>
		</TR>
		<asp:repeater id="repCustomFields" runat="server" EnableViewState="False">
			<HeaderTemplate>
				<TR vAlign="top">
					<TD class="tblSubHead2" colSpan="3">Custom Fields</TD>
				</TR>
			</HeaderTemplate>
			<ItemTemplate>
				<INPUT id=inputTypeName type=hidden value='<%# DataBinder.Eval(Container.DataItem, "TypeName", "{0}") %>' runat="server" NAME="inputTypeName">
				<TR vAlign="top">
					<TD class="RowCap">
						<asp:Label id="lblValueName" runat="server">
							<%# DataBinder.Eval(Container, "DataItem.ValueName") %>
						</asp:Label>:</TD>
					<TD class="RowElem">
						<asp:TextBox id="tbValue" runat="server" MaxLength="255" Text='<%# DataBinder.Eval(Container.DataItem, "Value_String") %>' Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TB_Visible", "{0}")) %>'>
						</asp:TextBox>
						<asp:RequiredFieldValidator id="rfvValue" runat="server" ErrorMessage='<%# Convert.ToString(DataBinder.Eval(Container.DataItem, "ValueName", "{0}")) + " is required" %>' ControlToValidate="tbValue" Display="Dynamic" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "RFV_Visible", "{0}")) %>'>
						</asp:RequiredFieldValidator>
						<asp:regularexpressionvalidator id="valValue" runat="server" ErrorMessage='<%# DataBinder.Eval(Container.DataItem, "ErrorMessage") %>' ControlToValidate="tbValue" ValidationExpression='<%# DataBinder.Eval(Container.DataItem, "Exp") %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Val_Visible", "{0}")) %>'>
						</asp:regularexpressionvalidator>
						<asp:DropDownList id=ddlValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "DDL_Visible", "{0}")) %>'>
						</asp:DropDownList>
						<asp:CheckBox id=chValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "CB_Visible", "{0}")) %>' Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Value_Boolean", "{0}")) %>'>
						</asp:CheckBox>
						<cc1:activedatetime id=adtValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "DT_Visible", "{0}")) %>' Date='<%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "Value_DateTime", "{0}")) %>' MinYear="1970" MaxYear="2020" Format="MONTH;/;DAY;/;YEAR" AlertEnabled="True" AllowNull="False">
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
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR vAlign="top">
			<TD colSpan="3"><uc1:nextback id="NextBackControl" runat="server"></uc1:nextback></TD>
		</TR>
	</table>
</form>
