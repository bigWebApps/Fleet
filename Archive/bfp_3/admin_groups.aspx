<%@ Page language="c#" Codebehind="admin_groups.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_groups" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colSpan="3"><mits:datagrid_a id="dgGroups" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn>
							<ItemTemplate>
								&nbsp;
								<asp:HyperLink runat="server" Text="Users" NavigateUrl='<%# "admin_groups_users.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) %>'>
								</asp:HyperLink>
								&nbsp;
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemTemplate>
								&nbsp;
								<asp:HyperLink runat="server" Text="Permissions" NavigateUrl='<%# "admin_groups_permissions.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) %>'>
								</asp:HyperLink>
								&nbsp;
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Group Name">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:Label id="lblEditId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:Label>
								<asp:TextBox id="tbNameEdit" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
								</asp:TextBox>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
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
							<ItemTemplate>
								&nbsp;
								<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Group?')">
								<asp:LinkButton runat="server" Text="Remove" CommandName="Delete" CausesValidation="false" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.CanDelete")) %>'>
								</asp:LinkButton>
								</span>
								&nbsp;
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
		<TR>
			<TD colSpan="3"></TD>
		</TR>
		<TR>
			<TD colSpan="3">
				<b>Add New Group</b>
			</TD>
		</TR>
		<tr>
			<td>Group&nbsp;Name</td>
			<td>
				<asp:TextBox id="tbGroupName" runat="server"></asp:TextBox></td>
			<td>
				<asp:RequiredFieldValidator id="rfvGroupName" runat="server" ErrorMessage="The Group Name is required" ControlToValidate="tbGroupName"></asp:RequiredFieldValidator></td>
		</tr>
		<TR>
			<TD colSpan="3">
				<asp:Button id="btnAddGroup" runat="server" Text="Add Group"></asp:Button></TD>
		</TR>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
