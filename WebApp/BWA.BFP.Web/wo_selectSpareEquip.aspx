<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Page language="c#" Codebehind="wo_selectSpareEquip.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_slectSpareEquip" %>
<form id="Form1" method="post" runat="server">
	<table id="tblMain" runat="server">
		<tr>
			<td colSpan="6">
				<asp:LinkButton id="lbCheckInSpare" runat="server">Check in the Spare Equipment</asp:LinkButton>
			</td>
		</tr>
		<tr>
			<td colSpan="6">&nbsp;-&nbsp;or&nbsp;-&nbsp;</td>
		</tr>
		<tr>
			<td colSpan="6">Select Spare Equipment from Unassigned Equipments list:</td>
		</tr>
		<tr>
			<td vAlign="top" rowSpan="2"><b>Filter:</b></td>
			<td>Equip Id</td>
			<td>Type</td>
			<td>Department</td>
			<td>Location</td>
			<td vAlign="bottom" rowSpan="2"><asp:button id="btnFiltration" runat="server" Text="Search"></asp:button></td>
		</tr>
		<tr>
			<TD><asp:textbox id="tbEquipId" runat="server" MaxLength="255"></asp:textbox></TD>
			<td><asp:dropdownlist id="ddlEquipTypes" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
			<td><asp:dropdownlist id="ddlDepartments" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
			<td><asp:dropdownlist id="ddlLocations" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td colSpan="6"><mits:datagrid_a id="dgMainList" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="#">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<asp:LinkButton runat="server" Text='<%# "[" + Convert.ToString(DataBinder.Eval(Container, "DataItem.EquipId")) + "]" %>' CommandName="Select" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.VisibleLink")) %>'>
								</asp:LinkButton>
								<asp:Label id=lblName runat="server" Text='<%# "[" + Convert.ToString(DataBinder.Eval(Container, "DataItem.EquipId")) + "]" %>' Visible='<%# !Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.VisibleLink")) %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Available"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Type">
							<ItemTemplate>
								<asp:Label id=Label1 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Available"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Department">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DeptName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Available"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Location">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LocName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Available"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Make">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MakeName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Available"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Model">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ModelName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Available"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EquipOperatorName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Available"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Temp Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TempOperatorName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Available"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
		<TR>
			<TD colSpan="6">Equipment listed as red are unavailable and are currently 
				checked-out
				<br>
				<br>
			</TD>
		</TR>
		<tr>
			<td colSpan="6">
				<uc1:nextback id="NextBackControl" runat="server"></uc1:nextback>
			</td>
		</tr>
	</table>
</form>
