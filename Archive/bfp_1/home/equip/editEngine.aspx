<%@ Page language="c#" Codebehind="editEngine.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip.editEngine" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="../../controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="../../controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="../../controls/Header.ascx" %>
<%@ Register tagprefix="mbll" namespace="MetaBuilders.WebControls" Assembly="MetaBuilders.WebControls.ListLink" %>
<BFPCNTRLS:HEADER id="Header" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0"
	runat="server"></BFPCNTRLS:HEADER>
<FORM runat="server" ID="Form1">
	<TABLE>
		<TR>
			<TD class="RowCap" width="144" height="18">Make</TD>
			<TD class="RowElem" height="18"><asp:DropDownList id="ddMake" runat="server"></asp:DropDownList></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="18">Model</TD>
			<TD class="RowElem" height="18"><asp:DropDownList id="ddModel" runat="server"></asp:DropDownList></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="18">Part #</TD>
			<TD class="RowElem" height="18"><asp:TextBox id="tbPartNum" runat="server" Columns="25" MaxLength="25"></asp:TextBox></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="18">Serial #</TD>
			<TD class="RowElem" height="18"><asp:TextBox id="tbSerialNum" runat="server" Columns="25" MaxLength="25"></asp:TextBox></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="18">Last Update</TD>
			<TD class="RowElem" height="18">
				<asp:Label id="lbLastUpdate" runat="server">Label</asp:Label></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
		<TR>
			<TD class="RowCap" width="144" height="18"></TD>
			<TD class="RowElem" height="18">
				<uc1:SaveCancel id="SaveCancelControl" runat="server"></uc1:SaveCancel></TD>
			<TD class="RowHelp" height="18"></TD>
		</TR>
	</TABLE>

<mbll:listlink id="ListLink1" runat="server" EnableViewState="True" DataRelation="Makes_Models" 
	ChildList="ddModel" ParentList="ddMake" LockFirstItem="True"></mbll:listlink>
	
</FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
