<%@ Page language="c#" Codebehind="admin_groups_permissions.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_groups_permissions_aspx" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR>
			<TD class="RowCap">Group Name:</TD>
			<td colSpan="2" class="RowElem">
				<asp:Label id="lblGroupName" runat="server" Font-Bold="True"></asp:Label></td>
		</TR>
		<tr>
			<td colspan="3"><br>
			</td>
		</tr>
		<tr>
			<td colSpan="3"><mits:datagrid_a id="dgPermissions" runat="server" AutoGenerateColumns="False" DataKeyField="Id"
					ColorScheme="Yellow" Width="100%">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Permission Name">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<SPAN onclick="javascript:return confirm('Are you sure that you want to remove this Permission from Group?')">
									<asp:LinkButton runat="server" Text="Remove" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
								</SPAN>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
		<tr>
			<td colSpan="3"></td>
		</tr>
		<tr>
			<td><b>Add Permission</b></td>
			<td><asp:dropdownlist id="ddlNewPerm" runat="server"></asp:dropdownlist></td>
			<td><asp:button id="btnAddPerm" runat="server" Text="Add Permission"></asp:button>
			</td>
		</tr>
		<TR>
			<TD colSpan="3">
				<asp:Label id="lblBack" runat="server"></asp:Label></TD>
		</TR>
	</table>
</form>
