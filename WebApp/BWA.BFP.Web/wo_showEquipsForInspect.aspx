<%@ Page language="c#" Codebehind="wo_showEquipsForInspect.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_showEquipsForInspect" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<form id="Form1" method="post" runat="server">
	<table id="tableMain">
		<tr>
			<td></td>
			<td>Equip #</td>
			<td>Type</td>
			<TD>Spare</TD>
			<td>Department</td>
			<td>Location</td>
			<TD>Equip Operator</TD>
			<td vAlign="bottom" rowSpan="2"><asp:button id="btnFiltration" runat="server" Text="Search"></asp:button></td>
		</tr>
		<tr vAlign="bottom">
			<td vAlign="top"><b>Filter:</b></td>
			<TD><asp:textbox onkeypress="return(clickButton(document.Form1.btnFiltration));" id="tbEquipId" runat="server"
					MaxLength="50" AutoPostBack="True"></asp:textbox></TD>
			<td><asp:dropdownlist id="ddlEquipTypes" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
			<TD><asp:dropdownlist id="ddlSpare" runat="server">
					<asp:ListItem Value="-1">All</asp:ListItem>
					<asp:ListItem Value="0">Yes</asp:ListItem>
					<asp:ListItem Value="1">No</asp:ListItem>
				</asp:dropdownlist></TD>
			<td><asp:dropdownlist id="ddlDepartments" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
			<td><asp:dropdownlist id="ddlLocations" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
			<td><asp:dropdownlist id="ddlDrivers" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td colSpan="8"></td>
		</tr>
		<tr>
			<td colSpan="8"><b>Select the equipment number&nbsp;to create an inspection work order</b></td>
		</tr>
		<tr>
			<td colSpan="8"><mits:datagrid_a id="dgInspections" runat="server" DataKeyField="EquipId" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow" CellPadding="2">
					<HeaderStyle Font-Bold="True"></HeaderStyle>
					<Columns>
						<asp:TemplateColumn HeaderText="Equip #">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# "[" + Convert.ToString(DataBinder.Eval(Container, "DataItem.vchEquipId")) + "]" %>' NavigateUrl='<%# "wo_addInspectForecast.aspx?equipid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.EquipId")) + "&sid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.ItemId")) %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Inspection">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Last Inspection">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>' Text='<%# DataBinder.Eval(Container, "DataItem.DateLastInspected") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Scheduled Dates Range">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DatesRange") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Future Work Order [Scheduled Date]">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.WorkOrder") %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.WorkOrderId")) %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
	</table>
</form>
