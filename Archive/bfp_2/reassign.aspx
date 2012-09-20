<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="SCC" Src="controls/SaveCancel.ascx" %>
<%@ Page language="c#" Codebehind="reassign.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._reassign" %>
<BFPCNTRLS:HEADER id="Header" runat="server" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0"
	RightMenuSelected="0"></BFPCNTRLS:HEADER>
<FORM id="Form1" runat="server">
	<table>
		<!-- here variable fileds -->
		<asp:Repeater id="repCustomFields" runat="server">
			<ItemTemplate>
				<TR>
					<TD class="RowCap">
						<asp:Label id="lblValueName" runat="server">
							<%# DataBinder.Eval(Container, "DataItem.ValueName") %>
						</asp:Label></TD>
					<TD class="RowElem">
						<asp:Label id="lblValue" runat="server">
							<%# DataBinder.Eval(Container, "DataItem.Value") %>
						</asp:Label></TD>
					<td class="RowHelp"></td>
				</TR>
			</ItemTemplate>
		</asp:Repeater>
		<TR>
			<TD class="RowCap">Assign From</TD>
			<TD class="RowElem"><asp:label id="lbAssignFrom" runat="server"></asp:label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Assign To*</TD>
			<TD class="RowElem"><asp:dropdownlist id="ddAssignTo" runat="server"></asp:dropdownlist>
				<asp:requiredfieldvalidator id="rfvAssign" runat="server" ErrorMessage="Assign is required" Display="Dynamic"
					ControlToValidate="ddAssignTo"></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Note*</TD>
			<TD class="RowElem"><asp:textbox id="tbNote" runat="server" CssClass="input6"></asp:textbox><asp:requiredfieldvalidator id="rfvNote" runat="server" ControlToValidate="tbNote" Display="Dynamic" ErrorMessage="Note is required"></asp:requiredfieldvalidator></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR class="RowHelp">
			<TD></TD>
			<TD><BFPCNTRLS:SCC id="SaveCancelControl" runat="server"></BFPCNTRLS:SCC></TD>
			<TD></TD>
		</TR>
	</table>
</FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
