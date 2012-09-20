<%@ Page language="c#" Codebehind="editChasis.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip.editChasis" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="../../controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="../../controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="../../controls/Header.ascx" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<FORM id="Form1" runat="server">
	<TABLE>
		<TR>
			<TD class="RowCap" width="144" height="18">Chasis Make</TD>
			<TD class="RowElem" height="18"><asp:dropdownlist id="ddChasisMake" runat="server"></asp:dropdownlist></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="18">Chasis&nbsp;#</TD>
			<TD class="RowElem" height="18"><asp:textbox id="tbChasisNum" runat="server" MaxLength="25" Columns="25"></asp:textbox></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="18">Last Update</TD>
			<TD class="RowElem" height="18"><asp:label id="lbLastUpdate" runat="server">Label</asp:label></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="18"></TD>
			<TD class="RowElem" height="18"><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
	</TABLE>
</FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
