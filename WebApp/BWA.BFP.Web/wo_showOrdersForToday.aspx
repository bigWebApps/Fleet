<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="wo_showOrdersForToday.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_showOrdersForToday" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td><FONT color="red" size="3">Past - (Not Closed)</FONT></td>
		</tr>
		<tr>
			<td>
				<mits:datagrid_a id="dgWorkOrders_Past" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + DataBinder.Eval(Container, "DataItem.Id") %>' ID="Hyperlink1">
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip Id">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' ID="Label1">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label2">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>' ID="Label3">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
											</asp:Label>&nbsp;
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
		<tr>
			<td bgcolor="#000000"></td>
		</tr>
		<tr>
			<td><br>
				<FONT color="green" size="3">Today</FONT></td>
		</tr>
		<tr>
			<td>
				<mits:datagrid_a id="dgWorkOrders_Today" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + DataBinder.Eval(Container, "DataItem.Id") %>' ID="Hyperlink2">
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip Id">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' ID="Label5">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label6">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>' ID="Label7">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
											</asp:Label>&nbsp;
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
		<tr>
			<td bgcolor="#000000"></td>
		</tr>
		<tr>
			<td><br>
				<FONT color="blue" size="3">Tomorrow</FONT></td>
		</tr>
		<tr>
			<td>
				<mits:datagrid_a id="dgWorkOrders_Tomorrow" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + DataBinder.Eval(Container, "DataItem.Id") %>' ID="Hyperlink3">
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip Id">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' ID="Label9">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label10">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>' ID="Label11">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
											</asp:Label>&nbsp;
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
		<tr>
			<td bgcolor="#000000"></td>
		</tr>
		<tr>
			<td><br>
				<FONT color="purple" size="3">Next 7 days</FONT></td>
		</tr>
		<tr>
			<td>
				<mits:datagrid_a id="dgWorkOrders_Future" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + DataBinder.Eval(Container, "DataItem.Id") %>' ID="Hyperlink4">
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip Id">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' ID="Label13">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label14">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>' ID="Label15">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
											</asp:Label>&nbsp;
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
		<tr>
			<td bgcolor="#000000"></td>
		</tr>
	</table>
</form>
