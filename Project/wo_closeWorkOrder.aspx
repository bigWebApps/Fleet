<%@ Page language="c#" Codebehind="wo_closeWorkOrder.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_closeWorkOrder" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Signature" Src="controls/Signature.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR>
			<TD class="tblSubHead1" colSpan="3">Main Information</TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Work Order #</TD>
			<td class="RowElem"><asp:label id="lblWorkOrderId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Equipment #</TD>
			<td class="RowElem"><asp:label id="lblEquipId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Spare Equipment</TD>
			<td class="RowElem"><asp:label id="lblSpareEquipId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Assigned Technician</TD>
			<td class="RowElem"><asp:label id="lblTech" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<tr vAlign="top">
			<TD class="RowCap">Equipment Operator</TD>
			<TD class="RowElem"><asp:label id="lblOperator" runat="server"></asp:label></TD>
			<td class="RowHelp"></td>
		</tr>
		<tr vAlign="top">
			<TD class="RowCap">Equipment Cleanliness</TD>
			<TD class="RowElem"><asp:textbox id="tbCleanliness" runat="server" Rows="4" TextMode="MultiLine" MaxLength="1000"
					Columns="40"></asp:textbox></TD>
			<TD class="RowHelp">Please indicate the condition of this equipment pertaining to 
				cleanliness
			</TD>
		</tr>
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
						<cc1:activedatetime id=adtValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "DT_Visible", "{0}")) %>' Date='<%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "Value_DateTime", "{0}")) %>' MinYear="1970" MaxYear="2020" Format="MONTH;/;DAY;/;YEAR" AlertEnabled="True" AllowNull="False" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Enabled", "{0}")) %>'>
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
			<TD class="RowCap">Close Date</TD>
			<TD class="RowElem">
				<cc1:activedatetime id="adtClosed" runat="server" AllowNull="False" AlertEnabled="True" MinYear="1970"
					MaxYear="2020" Format=";MONTH;/;DAY;/;YEAR;"></cc1:activedatetime></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="tblSubHead2" vAlign="top" colSpan="3">Technician's Notes</TD>
		</TR>
		<tr>
			<td colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%">
					<asp:repeater id="repTechNotes" runat="server">
						<ItemTemplate>
							<tr bgcolor="#CCCCCC">
								<td align="left">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserName") %>'>
									</asp:Label>
								</td>
								<td align="right">
									<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.CreatedDate")).ToString("yyyy-MM-dd hh:mm tt") %>'>
									</asp:Label>
								</td>
							</tr>
							<tr>
								<td align="left" colspan="2">
									<asp:label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Note") %>'>
									</asp:label>
								</td>
							</tr>
						</ItemTemplate>
					</asp:repeater>
					<tr>
						<td colSpan="3"><br>
						</td>
					</tr>
					<tr>
						<td align="left" colSpan="3">Please enter the note to add to technician's notes
						</td>
					</tr>
					<tr>
						<td colSpan="3"><asp:textbox id="tbTechNote" runat="server" Width="100%" Rows="4" TextMode="MultiLine" MaxLength="8000"></asp:textbox></td>
					</tr>
					<tr>
						<td colSpan="3"><br>
						</td>
					</tr>
					<tr>
						<td align="left" colSpan="3">Please enter the check-out note to will be read and 
							signed by the equipment operator during the check-out process
						</td>
					</tr>
					<tr>
						<td colSpan="3"><asp:textbox id="tbCheckOutNote" runat="server" Width="100%" Rows="4" TextMode="MultiLine" MaxLength="8000"></asp:textbox><br>
							<asp:requiredfieldvalidator id="rfvNotes" runat="server" Enabled="False" ErrorMessage="Note is required" ControlToValidate="tbCheckOutNote"></asp:requiredfieldvalidator></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR>
			<TD class="tblSubHead1" width="100%" colSpan="3">Technician Signature for close of 
				the work order</TD>
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
