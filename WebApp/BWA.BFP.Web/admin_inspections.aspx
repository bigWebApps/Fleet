<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="admin_inspections.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_inspections" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colSpan="3">
				<mits:datagrid_a id="dgInspections" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								&nbsp;
								<asp:HyperLink runat="server" Text="Items" NavigateUrl='<%# "admin_inspections_items.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) %>'>
								</asp:HyperLink>
								&nbsp;
							
</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Inspection Name">
							<ItemTemplate>
								<asp:Label id=Label1 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:TextBox id=tbNameEdit runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>' MaxLength="50" Width="100%">
								</asp:TextBox>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								&nbsp;
								<asp:LinkButton runat="server" Text="Edit" CommandName="Edit" CausesValidation="false"></asp:LinkButton>
								&nbsp;
							
</ItemTemplate>
							<EditItemTemplate>
								<asp:LinkButton runat="server" Text="Update" CommandName="Update" CausesValidation="false"></asp:LinkButton>&nbsp;
								<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false"></asp:LinkButton>
							
</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								&nbsp;
								<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Inspection?')">
									<asp:LinkButton runat="server" Text="Remove" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
								</SPAN>
								&nbsp;
							
</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
		<TR>
			<TD colSpan="3"><br>
			</TD>
		</TR>
		<TR>
			<TD colSpan="3">
				<b>Add New Inspection</b>
			</TD>
		</TR>
		<tr>
			<td>Inspection Name</td>
			<td>
				<asp:TextBox id="tbInspectionName" runat="server" Width="200px" MaxLength="50"></asp:TextBox></td>
			<td>
				<asp:RequiredFieldValidator id="rfvInspectionName" runat="server" ErrorMessage="The Inspection Name is required"
					ControlToValidate="tbInspectionName"></asp:RequiredFieldValidator></td>
		</tr>
		<TR>
			<TD colSpan="3"><br>
			</TD>
		</TR>
		<TR>
			<TD colSpan="3">
				<asp:Button id="btnAddInspection" runat="server" Text="Add Inspection"></asp:Button></TD>
		</TR>
	</table>
	<br>
</form>
