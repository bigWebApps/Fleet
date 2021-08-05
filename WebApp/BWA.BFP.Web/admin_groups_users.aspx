<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="admin_groups_users.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_groups_users" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR>
			<TD class="RowCap">Group Name:</TD>
			<td colSpan="2" class="RowElem"><asp:label id="lblGroupName" runat="server" Font-Bold="True"></asp:label></td>
		</TR>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<tr>
			<td colSpan="3"><mits:datagrid_a id="dgUsers" runat="server" AutoGenerateColumns="False" ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="UserId" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Info">
							<ItemTemplate>
&nbsp; 
<asp:HyperLink id=HyperLink1 runat="server" Text="Detail" NavigateUrl='<%# "admin_user_detail.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.UserId"))%>' Target="_blank">Detail</asp:HyperLink>&nbsp; 
</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="First Name">
							<ItemTemplate>
								&nbsp;
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.FirstName") %>'>
								</asp:Label>
								&nbsp;
							
</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Last Name">
							<ItemTemplate>
								&nbsp;
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LastName") %>'>
								</asp:Label>
								&nbsp;
							
</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Initials">
							<ItemTemplate>
								&nbsp;
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Initials") %>'>
								</asp:Label>
								&nbsp;
							
</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="User Type">
							<ItemTemplate>
								&nbsp;
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserType") %>'>
								</asp:Label>
								&nbsp;
							
</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemTemplate>
								<SPAN onclick="javascript:return confirm('Are you sure that you want to remove this User from Group?')">
									<asp:LinkButton runat="server" Text="Delete" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
								</SPAN>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
		<tr>
			<td colSpan="3"></td>
		</tr>
		<tr>
			<td><b>Add Users</b></td>
			<td><asp:dropdownlist id="ddlUsers" runat="server" DataValueField="UserId" DataTextField="UserName"></asp:dropdownlist></td>
			<td><asp:button id="btnAddUser" runat="server" Text="Add User"></asp:button></td>
		</tr>
		<TR>
			<TD colSpan="3"><asp:label id="lblBack" runat="server"></asp:label></TD>
		</TR>
	</table>
</form>
