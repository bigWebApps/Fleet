<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="list.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._list" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table width="85%">
		<tr>
			<td>Equipment Type:
				<asp:dropdownlist id="ddlEquipType" runat="server" AutoPostBack="True" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
			<td style="HEIGHT: 11px" align="right" height="11"><asp:hyperlink id="hlAdd" runat="server" NavigateUrl="addEquip.aspx">Add New Equipment</asp:hyperlink></td>
		</tr>
		<tr>
			<td colSpan="2"><mits:datagrid_a id="dgMainList" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn>
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text="Detail" NavigateUrl='<%# "view.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equipment ID">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EquipId") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Type">
							<HeaderStyle Font-Bold="True"  HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Make">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MakeName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Model">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ModelName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Year">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Year") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="VIN/Serial #">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.VinSerial") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Fuel Code">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.FuelCode") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Department">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DeptName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Location">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LocName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
