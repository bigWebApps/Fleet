<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Page language="c#" Codebehind="list.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._list" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
<BFPCNTRLS:HEADER id="Header" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0"
	runat="server"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table width="85%">
		<tr>
			<td>Equipment Type:
				<asp:DropDownList id="ddlEquipType" runat="server" DataTextField="vchName" DataValueField="Id" AutoPostBack="True"></asp:DropDownList></td>
			<td align="right" height="11" style="HEIGHT: 11px">
				<asp:HyperLink id="hlAdd" runat="server" NavigateUrl="addEquip.aspx" CssClass="LargeLink">Add New Equipment</asp:HyperLink></td>
		</tr>
		<tr>
			<td colspan="2">
				<mits:datagrid_a id="dgMainList" runat="server" ColorScheme="Yellow" OnItemCommand="OnItemEditClick"
					AutoGenerateColumns="False" Width="100%" DataKeyField="id">
					<Columns>
						<asp:ButtonColumn Text="Detail" HeaderText=" View">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
						</asp:ButtonColumn>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
