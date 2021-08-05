<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="admin_users.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_users" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td>First Name</td>
			<td>Last Name</td>
			<td>E-mail</td>
			<td>User Type</td>
			<TD nowrap>User Active Status</TD>
			<td>Groups</td>
			<TD nowrap>
				<asp:hyperlink id="hlAdd" runat="server" NavigateUrl="admin_user_detail_edit.aspx?id=0">[Add a New User]</asp:hyperlink>
			</TD>
		</tr>
		<TR>
			<TD>
				<asp:TextBox id="tbFirstName" runat="server" MaxLength="50"></asp:TextBox></TD>
			<TD>
				<asp:TextBox id="tbLastName" runat="server" MaxLength="50"></asp:TextBox></TD>
			<TD>
				<asp:TextBox id="tbEmail" runat="server" MaxLength="50"></asp:TextBox></TD>
			<TD>
				<asp:DropDownList id="ddlUserTypes" runat="server">
					<asp:ListItem Value="0" Selected="True">All</asp:ListItem>
					<asp:ListItem Value="2">Technician</asp:ListItem>
					<asp:ListItem Value="1">Operator</asp:ListItem>
				</asp:DropDownList></TD>
			<TD>
				<asp:DropDownList id="ddlActiveStatus" runat="server">
					<asp:ListItem Value="0" Selected="True">Active</asp:ListItem>
					<asp:ListItem Value="1">InActive</asp:ListItem>
					<asp:ListItem Value="-1">-- No Filter --</asp:ListItem>
				</asp:DropDownList></TD>
			<td>
				<asp:DropDownList id="ddlGroups" runat="server" DataTextField="vchDesc" DataValueField="Id"></asp:DropDownList></td>
			<td align="center"><asp:Button id="btnFilter" runat="server" Text="Search"></asp:Button></td>
		</TR>
		<tr>
			<td colspan="7">
				<br>
			</td>
		</tr>
		<tr>
			<td colspan="7">
				<mits:datagrid_a id="dgUserList" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn>
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text="Detail" NavigateUrl='<%# "admin_user_detail.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="First Name">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.FirstName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Last Name">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LastName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="E-mail">
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Email") %>' NavigateUrl='<%# "mailto:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Email")) %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Type">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserType") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
	</table>
</form>
