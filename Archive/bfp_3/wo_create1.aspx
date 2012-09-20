<%@ Page language="c#" Codebehind="wo_create1.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_create1" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td rowspan="2" valign="top"><b>Filter:</b></td>
			<td>Type</td>
			<td>Department</td>
			<td>Location</td>
			<td>Driver</td>
			<td rowspan="2" valign="bottom">
				<asp:Button id="btnFiltration" runat="server" Text="To Filter"></asp:Button></td>
		</tr>
		<tr>
			<td>
				<asp:DropDownList id="ddlEquipTypes" runat="server"></asp:DropDownList>
			</td>
			<td>
				<asp:DropDownList id="ddlDepartments" runat="server"></asp:DropDownList></td>
			<td>
				<asp:DropDownList id="ddlLocations" runat="server"></asp:DropDownList></td>
			<td>
				<asp:DropDownList id="ddlDrivers" runat="server"></asp:DropDownList></td>
		</tr>
		<tr>
			<td colspan="6"><b>Select Vehicle:</b></td>
		</tr>
		<tr>
			<td colspan="6">
				<mits:datagrid_a id="dgMainList" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="#">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text="EquipId" NavigateUrl='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Type">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Make">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MakeName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Model">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ModelName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="User">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.AssignedTo") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
