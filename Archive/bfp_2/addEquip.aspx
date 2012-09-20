<%@ Page language="c#" Codebehind="addEquip.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._addEquip" errorPage="error.aspx"%>
<%@ Register TagPrefix="MM" TagName="MakesModels" Src="controls/MakesModels.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<BFPCNTRLS:HEADER id="Header" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0"
	runat="server"></BFPCNTRLS:HEADER>
<form id="frmAddEquip" method="post" runat="server">
	<TABLE id="tblEquipment">
		<TBODY>
			<TR>
				<TD colSpan="3">Equipment Type:
					<asp:dropdownlist id="ddlEquipType" runat="server" DataValueField="Id" DataTextField="vchName" AutoPostBack="True"></asp:dropdownlist></TD>
			</TR>
			<asp:repeater id="repCustomFields" runat="server" EnableViewState="False">
				<ItemTemplate>
					<INPUT id=inputTypeName type=hidden value='<%# DataBinder.Eval(Container.DataItem, "TypeName", "{0}") %>' name=inputTypeName runat="server">
					<TR>
						<TD class="RowCap">
							<asp:Label id="lblValueName" runat="server">
								<%# DataBinder.Eval(Container, "DataItem.ValueName") %>
							</asp:Label></TD>
						<TD class="RowElem">
							<asp:TextBox id=tbValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TB_Visible", "{0}")) %>'>
							</asp:TextBox>
							<asp:RequiredFieldValidator id="rfvTextBox" runat="server" ErrorMessage='<%# Convert.ToString(DataBinder.Eval(Container.DataItem, "ValueName", "{0}")) + " is required" %>' ControlToValidate="tbValue" 
 Display="Dynamic" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "TB_Visible", "{0}")) %>'>
							</asp:RequiredFieldValidator>
							<asp:regularexpressionvalidator id="valValue" runat="server" ErrorMessage='<%# DataBinder.Eval(Container.DataItem, "ErrorMessage") %>' ControlToValidate="tbValue" ValidationExpression='<%# DataBinder.Eval(Container.DataItem, "Exp") %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "Val_Visible", "{0}")) %>'>
							</asp:regularexpressionvalidator>
							<asp:DropDownList id=ddlValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "DDL_Visible", "{0}")) %>'>
							</asp:DropDownList>
							<asp:CheckBox id=chValue runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "CB_Visible", "{0}")) %>'>
							</asp:CheckBox>
							<MM:MAKESMODELS id="mmValue" runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "MM_Visible", "{0}")) %>'>
							</MM:MAKESMODELS>
							<cc1:activedatetime id="adtValue" runat="server" Format="MONTH;/;DAY;/;YEAR" MaxYear="2010" MinYear="1970" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "DT_Visible", "{0}")) %>' AlertEnabled="True" AllowNull="False">
							</cc1:activedatetime>
						</TD>
						<TD class="RowHelp">
							<%# DataBinder.Eval(Container.DataItem, "Help") %>
						</TD>
					</TR>
				</ItemTemplate>
			</asp:repeater>
			<TR>
				<TD></TD>
				<TD><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
				<TD></TD>
			</TR>
		</TBODY></TABLE>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER></TR></TBODY></TABLE>
