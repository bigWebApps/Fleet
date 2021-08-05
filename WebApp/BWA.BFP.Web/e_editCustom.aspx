<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Page language="c#" Codebehind="e_editCustom.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._e_editCustom" errorPage="error.aspx"%>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="MM" TagName="MakesModels" Src="controls/MakesModels.ascx" %>
<form id="Form1" method="post" runat="server">
	<TABLE id="tblEquipment">
		<asp:Repeater id="repCustomFields" runat="server" EnableViewState="False">
			<ItemTemplate>
				<INPUT id=inputTypeName type=hidden value='<%# DataBinder.Eval(Container.DataItem, "TypeName", "{0}") %>' runat="server" NAME="inputTypeName">
				<TR>
					<TD class="RowCap">
						<asp:Label id="lblValueName" runat="server">
							<%# DataBinder.Eval(Container, "DataItem.ValueName") %>
						</asp:Label></TD>
					<TD class="RowElem" width="35%">
						<asp:TextBox id=tbValue runat="server" MaxLength="255" Text='<%# DataBinder.Eval(Container.DataItem, "Value_String") %>' Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TB_Visible", "{0}")) %>'>
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
					<TD class="RowHelp" width="40%">
						<asp:Label id="lblHelp" runat="server">
							<%# DataBinder.Eval(Container.DataItem, "Help") %>
						</asp:Label>
					</TD>
				</TR>
			</ItemTemplate>
		</asp:Repeater></TD></TR>
		<TR>
			<TD></TD>
			<TD><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
			<TD></TD>
		</TR>
	</TABLE>
</form>
