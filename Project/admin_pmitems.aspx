<%@ Register TagPrefix="mits" Namespace="Micajah.Common" Assembly="Micajah.Common" %>
<%@ Page language="c#" Codebehind="admin_pmitems.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin.admin_pmitems" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colSpan="3">
				<mits:datagridex id="dgPMItems" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Category">
							<ItemTemplate>
								<asp:Label id="lblCatName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:DropDownList id="dg_ddlCategories" runat="server" DataTextField="vchName" DataValueField="Id" SelectedValueEx='<%# DataBinder.Eval(Container, "DataItem.RepairCatId") %>'>
								</asp:DropDownList>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Service Name">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceName") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:TextBox id="tbPMServiceName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceName") %>' MaxLength="50" Width="100%">
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
								<asp:LinkButton runat="server" Text="Update" CommandName="Update" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:LinkButton>&nbsp;
								<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false"></asp:LinkButton>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								&nbsp;
								<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Schedule?')">
									<asp:LinkButton runat="server" Text="Delete" CommandName="Delete" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
									</asp:LinkButton>
								</SPAN>
								&nbsp;
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagridex>
			</td>
		</tr>
		<TR>
			<TD colSpan="3"><br>
			</TD>
		</TR>
		<TR>
			<TD colSpan="3">
				<b>Add New Preventive Maintenance Item</b>
			</TD>
		</TR>
		<TR>
			<TD noWrap>Category</TD>
			<TD><asp:dropdownlist id="ddlCategory" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></TD>
			<TD></TD>
		</TR>
		<tr>
			<td>PM Item Name</td>
			<td>
				<asp:TextBox id="tbItemName" runat="server" Width="200px" MaxLength="50"></asp:TextBox></td>
			<td>
				<asp:RequiredFieldValidator id="rfvItemName" runat="server" ErrorMessage="The Item Name is required" ControlToValidate="tbItemName"></asp:RequiredFieldValidator></td>
		</tr>
		<TR>
			<TD colSpan="3"><br>
			</TD>
		</TR>
		<TR>
			<TD colSpan="3">
				<asp:Button id="btnAddPMItem" runat="server" Text="Add PM Item"></asp:Button></TD>
		</TR>
	</table>
	<br>
</form>
