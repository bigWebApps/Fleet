<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="wo_showUnsignedOrders.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_showUnsignedOrders" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td><mits:datagrid_a id="dgUnsignedWorkOrders" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>' NavigateUrl='<%# "wo_preview.aspx?id=" + DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip Id">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' ID="Label1">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label2">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>' ID="Label3">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Created by User">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserCreated") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:BoundColumn DataField="CreatedDate" ReadOnly="True" HeaderText="Created Date"></asp:BoundColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
	</table>
</form>
