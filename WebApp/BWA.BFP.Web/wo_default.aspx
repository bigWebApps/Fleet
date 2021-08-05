<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="wo_default.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_default" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td></td>
			<td>Equipment Id</td>
			<td>Type</td>
			<TD>Spare</TD>
			<td>Department</td>
			<td>Location</td>
			<TD>Equip Operator</TD>
			<td vAlign="bottom" rowSpan="2"><asp:button id="btnFiltration" runat="server" Text="Search"></asp:button></td>
		</tr>
		<tr vAlign="bottom">
			<td vAlign="top"><b>Filter:</b></td>
			<TD><asp:textbox id="tbEquipId" runat="server" MaxLength="50" onkeypress="return(clickButton(document.Form1.btnFiltration));"></asp:textbox></TD>
			<td><asp:dropdownlist id="ddlEquipTypes" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
			<TD>
				<asp:DropDownList id="ddlSpare" runat="server">
					<asp:ListItem Value="-1">All</asp:ListItem>
					<asp:ListItem Value="0">Yes</asp:ListItem>
					<asp:ListItem Value="1">No</asp:ListItem>
				</asp:DropDownList></TD>
			<td><asp:dropdownlist id="ddlDepartments" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
			<td><asp:dropdownlist id="ddlLocations" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
			<td><asp:dropdownlist id="ddlDrivers" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td colSpan="8"><b>Select Vehicle:</b></td>
		</tr>
		<tr>
			<td colSpan="8"><mits:datagrid_a id="dgMainList" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow" CellPadding="2">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="#">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# "[" + Convert.ToString(DataBinder.Eval(Container, "DataItem.EquipId")) + "]" %>' NavigateUrl='<%# DataBinder.Eval(Container, "DataItem.Navigation") %>'>
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
						<asp:TemplateColumn HeaderText="Department">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DeptName") %>' >
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Location">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LocName") %>' >
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip Operator">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.AssignedTo") %>' >
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Temp Operator">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TempOperator") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
		<tr>
			<td colSpan="8">
				<br>
				<asp:Label id="lblError" runat="server" Visible="False">
					<ul type="disc">
						<li style="color:red">
							The specified equipment could not be located;</li>
						<li style="color:blue">
							Please change search settings or <a href="e_addEquip.aspx">Add New</a> Equipment;
						</li>
						<li style="color:blue">
							If equipment has not assigned operator then this equipment cannot be available;</li>
						<li style="color:blue">
							If the system is unable to locate the equipment after all please contact <a href="mailto:project.bfs@micajah.com">
								System Administrator</a> for assistance.</li>
					</ul>
				</asp:Label>
			</td>
		</tr>
	</table>
</form>
