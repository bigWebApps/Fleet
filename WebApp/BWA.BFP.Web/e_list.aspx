<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="e_list.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._e_list" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td width="45"></td>
			<td>Equipment Id</td>
			<td>Type</td>
			<TD>Spare</TD>
			<td>Department</td>
			<td>Location</td>
			<TD>Equip Operator</TD>
			<td nowrap><asp:hyperlink id="hlAdd" runat="server" NavigateUrl="e_addEquip.aspx">[Add a New Equipment]</asp:hyperlink>
			</td>
		</tr>
		<tr valign="bottom">
			<td valign="top" width="45"><b>Filter:</b></td>
			<TD><asp:TextBox id="tbEquipId" runat="server" MaxLength="50"></asp:TextBox></TD>
			<td><asp:dropdownlist id="ddlEquipTypes" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist></td>
			<TD>
				<asp:DropDownList id="ddlSpare" runat="server">
					<asp:ListItem Value="-1">All</asp:ListItem>
					<asp:ListItem Value="0">Yes</asp:ListItem>
					<asp:ListItem Value="1">No</asp:ListItem>
				</asp:DropDownList></TD>
			<td><asp:dropdownlist id="ddlDepartments" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist></td>
			<td><asp:dropdownlist id="ddlLocations" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist></td>
			<td><asp:dropdownlist id="ddlDrivers" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist></td>
			<td><asp:button id="btnFiltration" runat="server" Text="Search"></asp:button></td>
		</tr>
		<tr>
			<td colSpan="8"><mits:datagrid_a id="dgMainList" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow" CellPadding="2">
					<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"></HeaderStyle>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text="[detail]" NavigateUrl='<%# "e_view.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equipment Id">
							<ItemTemplate>
								<asp:Label id=Label1 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EquipId") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Type">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Make">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MakeName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Model">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ModelName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Year">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Year") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="VIN/Serial #">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.VinSerial") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Fuel Code">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.FuelCode") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Department">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DeptName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Location">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LocName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.AssignedTo") %>' >
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Temp Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TempOperator") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
	</table>
</form>
