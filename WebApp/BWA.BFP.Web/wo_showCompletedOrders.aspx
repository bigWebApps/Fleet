<%@ Page language="c#" Codebehind="wo_showCompletedOrders.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_showCompletedOrders" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<form id="Form1" method="post" runat="server">
	<table id="tableMain" runat="server">
		<tr>
			<td vAlign="top" rowSpan="2"><b>Filter:</b></td>
			<td>Equip Id</td>
			<TD>The User has signed the order request</TD>
			<td vAlign="bottom" rowSpan="2"><asp:button id="btnFiltration" runat="server" Text="To Filter"></asp:button></td>
		</tr>
		<tr>
			<TD><asp:textbox id="tbEquipId" runat="server" MaxLength="50"></asp:textbox></TD>
			<td><asp:dropdownlist id="ddlDrivers" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td colSpan="4"><b>Select the Work Order:</b></td>
		</tr>
		<tr>
			<td colSpan="4"><mits:datagrid_a id="dgCompletedWorkOrders" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip #">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Completed Date">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CompletedDate") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
	</table>
</form>
