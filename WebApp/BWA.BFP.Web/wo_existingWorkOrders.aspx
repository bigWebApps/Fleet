<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="wo_existingWorkOrders.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_existingWorkOrders" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td>Work Order for this vehicle have been located.<br>
				Click an existing work order to edit or click "Create New" to start another 
				work order.</td>
		</tr>
		<tr>
			<td>
				<br>
			</td>
		</tr>
		<tr>
			<td>
				<asp:HyperLink id="hlNewOrder" runat="server" NavigateUrl="wo_editAddInfo.aspx">[Create New Work Order]</asp:HyperLink>
			</td>
		</tr>
		<tr>
			<td>
				<br>
			</td>
		</tr>
		<tr>
			<td>&nbsp;-&nbsp;or&nbsp;-&nbsp;</td>
		</tr>
		<tr>
			<td>
				<br>
			</td>
		</tr>
		<TR>
			<TD>
				<!-- <asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>' NavigateUrl='<%# "wo_editAddInfo.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) + "&equipid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.EquipId")) %>'>
								</asp:HyperLink>
								-->
				<mits:datagrid_a id="dgMainList" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:TemplateColumn HeaderText="Work Order #">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td align="center" bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.StatusColor")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator Status">
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
											</asp:Label>&nbsp;
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:BoundColumn DataField="BeginWork" ReadOnly="True" HeaderText="Scheduled Date">
							<HeaderStyle Font-Bold="True"></HeaderStyle>
						</asp:BoundColumn>
					</Columns>
				</mits:datagrid_a>
			</TD>
		</TR>
	</table>
</form>
