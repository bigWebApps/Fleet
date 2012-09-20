<%@ Page language="c#" Codebehind="admin_permission_detail.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_permission_detail" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<BFPCNTRLS:HEADER id="Header" runat="server" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0"
	RightMenuSelected="0"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colSpan="2"><asp:datagrid id="dgPages" runat="server" AutoGenerateColumns="False" DataKeyField="Id" Width="100%">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="File Name">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
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
				</asp:datagrid></td>
			<td></td>
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
			<TD colSpan="3">
				<asp:Label id="lblBack" runat="server"></asp:Label></TD>
		</TR>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
