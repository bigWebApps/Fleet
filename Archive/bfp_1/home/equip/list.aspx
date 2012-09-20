<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="../../controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="../../controls/Footer.ascx" %>
<%@ Page language="c#" Codebehind="list.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._list" %>
<BFPCNTRLS:HEADER id="Header" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0"
	runat="server"></BFPCNTRLS:HEADER>
<form runat="server">
<table width="85%"><tr><td align="right"><a href='edit.aspx?id=0'>Add New Item</a></td></tr>
<tr><td>
	<mits:datagrid_a id="DataGrid1" runat="server" ColorScheme="Yellow" OnItemCommand="OnItemEditClick"
		AutoGenerateColumns="False" Width="100%">
		<Columns>
			<asp:ButtonColumn Text="Edit" HeaderText=" ">
				<ItemStyle HorizontalAlign="Center"></ItemStyle>
			</asp:ButtonColumn>
			<asp:BoundColumn Visible="False" DataField="id"></asp:BoundColumn>
			<asp:BoundColumn DataField="vchEquipId" HeaderText="Equip Id"></asp:BoundColumn>
			<asp:BoundColumn DataField="vchTypeName" HeaderText="Type"></asp:BoundColumn>
			<asp:BoundColumn DataField="intYear" HeaderText="intYear"></asp:BoundColumn>
			<asp:BoundColumn DataField="vchMakeName" HeaderText="Make"></asp:BoundColumn>
			<asp:BoundColumn DataField="vchModelName" HeaderText="Model"></asp:BoundColumn>
			<asp:BoundColumn DataField="DeptName" HeaderText="Dept">
				<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
				<ItemStyle HorizontalAlign="Center"></ItemStyle>
			</asp:BoundColumn>
			<asp:BoundColumn DataField="LocName" HeaderText="Location">
				<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
				<ItemStyle HorizontalAlign="Center"></ItemStyle>
			</asp:BoundColumn>
		</Columns>
	</mits:datagrid_a>
</td></tr></table>
	
	
	</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
