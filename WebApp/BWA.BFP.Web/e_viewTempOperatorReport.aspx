<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="e_viewTempOperatorReport.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._e_viewTempOperatorReport" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colSpan="3"><mits:datagrid_a id="dgAssignments" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"></HeaderStyle>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Date &amp; Time">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtUpdated") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equipment Id">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' NavigateUrl='<%# "e_selectTempOperator.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.[Id]")) %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Temporary Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TempOperator") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Note">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchNote") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Changed By">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
	</table>
</form>
