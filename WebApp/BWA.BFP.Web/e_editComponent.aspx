<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="MM" TagName="MakesModels" Src="controls/MakesModels.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Page language="c#" Codebehind="e_editComponent.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._e_editComponent" %>
<form id="Form1" method="post" runat="server">
	<TABLE id="tblComponent">
		<asp:repeater id="repCustomFields" runat="server" EnableViewState="False">
			<ItemTemplate>
				<INPUT id=inputTypeName type=hidden value='<%# DataBinder.Eval(Container.DataItem, "TypeName", "{0}") %>' runat="server" NAME="inputTypeName">
				<TR>
					<TD class="RowCap">
						<%# DataBinder.Eval(Container, "DataItem.ValueName") %>
					</TD>
					<TD class="RowElem">
						<asp:TextBox id=tbValue runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Value_String") %>' Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TB_Visible", "{0}")) %>'>
						</asp:TextBox>
						<asp:RequiredFieldValidator id="rfvValue" runat="server" ErrorMessage='<%# Convert.ToString(DataBinder.Eval(Container.DataItem, "ValueName", "{0}")) + " is required" %>' ControlToValidate="tbValue" Display="Dynamic" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "RFV_Visible", "{0}")) %>'>
						</asp:RequiredFieldValidator>
						<asp:regularexpressionvalidator id="valValue" runat="server" ErrorMessage='<%# DataBinder.Eval(Container.DataItem, "ErrorMessage") %>' ControlToValidate="tbValue" ValidationExpression='<%# DataBinder.Eval(Container.DataItem, "Exp") %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Val_Visible", "{0}")) %>'>
						</asp:regularexpressionvalidator>
						<asp:DropDownList id=ddlValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "DDL_Visible", "{0}")) %>'>
						</asp:DropDownList>
						<asp:CheckBox id=chValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "CB_Visible", "{0}")) %>' Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Value_Boolean", "{0}")) %>'>
						</asp:CheckBox>
						<MM:MAKESMODELS id=mmValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "MM_Visible", "{0}")) %>'>
						</MM:MAKESMODELS>
						<cc1:activedatetime id=adtValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "DT_Visible", "{0}")) %>' Date='<%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "Value_DateTime", "{0}")) %>' MinYear="2000" MaxYear="2030" Format="MONTH;/;DAY;/;YEAR" AlertEnabled="True" AllowNull="False">
						</cc1:activedatetime>
					</TD>
					<TD class="RowHelp">
						<%# DataBinder.Eval(Container.DataItem, "Help") %>
					</TD>
				</TR>
			</ItemTemplate>
		</asp:repeater>
		<tr>
			<td class="RowCap">Component Status</td>
			<td class="RowElem"><asp:dropdownlist id="ddlStatus" runat="server">
					<asp:ListItem Value="1">Active</asp:ListItem>
					<asp:ListItem Value="0">Inactive (under repair)</asp:ListItem>
				</asp:dropdownlist></td>
			<td class="RowHelp">Only one component of the same type may has Active status. If 
				you will change the status then the other components of the same type will has 
				inactive status.</td>
		</tr>
		<tr>
			<td class="RowCap">Last Update</td>
			<td class="RowElem"><asp:label id="lblLastUpdate" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</tr>
		<TR>
			<TD></TD>
			<TD colspan="2" nowrap="true" valign="bottom"><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN onclick="javascript:return confirm('Are you sure that you want to remove this Component from Equipment?')">
					<asp:Button id="btnRemove" runat="server" Text="Remove Component" CausesValidation="False"></asp:Button>
				</SPAN></TD>
		</TR>
		<TR>
			<TD></TD>
			<TD>
				
			</TD>
			<TD></TD>
		</TR>
	</TABLE>
</form>
