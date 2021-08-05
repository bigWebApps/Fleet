<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="admin_permission_detail.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_permission_detail" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR>
			<TD class="RowCap">Permission Name:</TD>
			<td colSpan="2" class="RowElem"><asp:label id="lblPermName" runat="server" Font-Bold="True"></asp:label></td>
		</TR>
		<TR>
			<TD class="RowCap">Permission Code:</TD>
			<TD colSpan="2" class="RowElem"><asp:label id="lblPermCode" runat="server" Font-Bold="True"></asp:label></TD>
		</TR>
		<tr>
			<td colspan="3"><br>
			</td>
		</tr>
		<tr>
			<td colSpan="3"><mits:datagrid_a id="dgPages" runat="server" Width="100%" DataKeyField="Id" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="File Name">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchPageName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Pages from Permission?')">
									<asp:LinkButton runat="server" Text="Remove" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
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
			<td><b>Add Page</b></td>
			<td><asp:dropdownlist id="ddlNewPages" runat="server"></asp:dropdownlist></td>
			<td><asp:button id="btnAddPage" runat="server" Text="Add Page"></asp:button></td>
		</tr>
		<TR>
			<TD colSpan="3"><asp:label id="lblBack" runat="server"></asp:label></TD>
		</TR>
	</table>
</form>
