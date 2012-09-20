<%@ Register TagPrefix="BFPCntrls" TagName="SCC" Src="../../controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="../../controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="../../controls/Footer.ascx" %>
<%@ Page language="c#" Codebehind="reassign.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._reassign" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<FORM runat="server" ID="Form1">
	<table>
		<tr>
			<td class="RowCap">Equipment Id</td>
			<td class="RowElem">
				<asp:Label id="lbEquipId" runat="server"></asp:Label></td>
			<TD class="RowHelp"></TD>
		</tr>
		<tr>
			<td class="RowCap">Type/Make/Model</td>
			<td class="RowElem">
				<asp:Label id="lbTypeMakeModel" runat="server"></asp:Label></td>
			<TD class="RowHelp"></TD>
		</tr>
		<TR>
			<TD class="RowCap">Year</TD>
			<TD class="RowElem">
				<asp:Label id="lbYear" runat="server"></asp:Label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Assign From</TD>
			<TD class="RowElem">
				<asp:Label id="lbAssignFrom" runat="server"></asp:Label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Assign To*</TD>
			<TD class="RowElem">
				<asp:DropDownList id="ddAssignTo" runat="server"></asp:DropDownList></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Note*</TD>
			<TD class="RowElem">
				<asp:TextBox id="tbNote" runat="server" CssClass="input6"></asp:TextBox></TD>
			<TD class="RowHelp">
				<asp:RequiredFieldValidator id="rfvNote" runat="server" ErrorMessage="Note is required" Display="Dynamic" ControlToValidate="tbNote"></asp:RequiredFieldValidator></TD>
		</TR>
		<TR class="RowHelp">
			<TD></TD>
			<TD><BFPCntrls:SCC id="SaveCancelControl" runat="server" />
			</TD>
			<TD></TD>
		</TR>
	</table>
</FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
