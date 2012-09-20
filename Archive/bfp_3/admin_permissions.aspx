<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="admin_permissions.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_permissions" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table>
		<TR>
			<TD colSpan="3">
				<P>Attention! The Permissions is the common data for all organizations and if you 
					changes something in this screen then the changes will be for all organizations</P>
			</TD>
		</TR>
		<tr>
			<td colSpan="3"><mits:datagrid_a id="dgPermissions" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:ButtonColumn Text="Pages" CommandName="Select">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
						</asp:ButtonColumn>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Name">
							<ItemTemplate>
								<asp:Label id=Label1 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:TextBox id=tbNameEdit runat="server" Width="100%" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>'>
								</asp:TextBox>
								<asp:Label id="lblEditId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:Label>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Code">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.chCode") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel" EditText="Edit">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
						</asp:EditCommandColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Permission?')">
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
			<td colSpan="3"><b>Add New Permission</b>
			</td>
		</tr>
		<tr>
			<td>Permission Name
			</td>
			<td><asp:textbox id="tbAddPermName" runat="server"></asp:textbox></td>
			<td><asp:requiredfieldvalidator id="rfvAddNewPermName" runat="server" ErrorMessage="The Permission Name is required"
					ControlToValidate="tbAddPermName"></asp:requiredfieldvalidator></td>
		</tr>
		<tr>
			<td>Permission Code
			</td>
			<td><asp:textbox id="tbAddPermCode" runat="server"></asp:textbox></td>
			<td><asp:requiredfieldvalidator id="rfvAddNewPermCode" runat="server" ErrorMessage="The Permission Code is required"
					ControlToValidate="tbAddPermCode"></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="revAddNewPermCode" runat="server" ErrorMessage="Must be a three upper symbols"
					ControlToValidate="tbAddPermCode" ValidationExpression="[A-Z]{3}"></asp:regularexpressionvalidator></td>
		</tr>
		<tr>
			<td colSpan="3"><asp:button id="btnAddPerm" runat="server" Text="Add Permission"></asp:button></td>
		</tr>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
