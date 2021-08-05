<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="wo_showOrdersForWeekly.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_showOrdersForWeekly" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colspan="2" height="16" valign="middle" align="center">
				<font size="3" color="green">
					<asp:LinkButton id="lbPreviousMonth" runat="server" Font-Size="Larger" ToolTip="Previous Month">&lt;&lt;</asp:LinkButton>
					&nbsp;
					<asp:LinkButton id="lbPreviousWeek" runat="server" Font-Size="Larger" ToolTip="Previous Week">&lt;</asp:LinkButton>
					&nbsp;
					<asp:Label id="lblCurrentDate" runat="server" Font-Bold="True"></asp:Label>
					&nbsp;
					<asp:LinkButton id="lbNextWeek" runat="server" Font-Size="Larger" ToolTip="Next Week">&gt;</asp:LinkButton>
					&nbsp;
					<asp:LinkButton id="lbNextMonth" runat="server" Font-Size="Larger" ToolTip="Next Month">&gt;&gt;</asp:LinkButton>
				</font>
			</td>
		</tr>
		<tr>
			<td colspan="2" bgcolor="#000000"></td>
		</tr>
		<tr valign="top">
			<td>
				<font size="2">
					<asp:Label id="lblMondayDate" runat="server" Font-Bold="True"></asp:Label>
				</font>
			</td>
			<td>
				<font size="2">
					<asp:Label id="lblThursdayDate" runat="server" Font-Bold="True"></asp:Label>
				</font>
			</td>
		</tr>
		<tr valign="top">
			<td>
				<mits:datagrid_a id="dgWorkOrdersMonday" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip Id">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
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
						<asp:TemplateColumn HeaderText="Op. Status">
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
				<br>
			</td>
			<td>
				<mits:datagrid_a id="dgWorkOrdersThursday" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
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
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' ID="Label12">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label13">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>' ID="Label14">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ID="Label15">
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Op. Status">
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
				<br>
			</td>
		</tr>
		<tr valign="top">
			<td>
				<font size="2">
					<asp:Label id="lblTuesdayDate" runat="server" Font-Bold="True"></asp:Label>
				</font>
			</td>
			<td>
				<font size="2">
					<asp:Label id="lblFridayDate" runat="server" Font-Bold="True"></asp:Label>
				</font>
			</td>
		</tr>
		<tr valign="top">
			<td>
				<mits:datagrid_a id="dgWorkOrdersTuesday" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
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
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' ID="Label2">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label3">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>' ID="Label4">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ID="Label5">
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Op. Status">
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
				<br>
			</td>
			<td>
				<mits:datagrid_a id="dgWorkOrdersFriday" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
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
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' ID="Label17">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label18">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>' ID="Label19">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ID="Label20">
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Op. Status">
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
				<br>
			</td>
		</tr>
		<tr valign="top">
			<td>
				<font size="2">
					<asp:Label id="lblWednesdayDate" runat="server" Font-Bold="True"></asp:Label>
				</font>
			</td>
			<td>
				<font size="2">
					<asp:Label id="lblWeekendDate" runat="server" Font-Bold="True"></asp:Label>
				</font>
			</td>
		</tr>
		<tr valign="top">
			<td>
				<mits:datagrid_a id="dgWorkOrdersWednesday" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
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
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' ID="Label7">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label8">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>' ID="Label9">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ID="Label10">
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Op. Status">
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
				<br>
			</td>
			<td>
				<mits:datagrid_a id="dgWorkOrdersWeekend" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + DataBinder.Eval(Container, "DataItem.Id") %>' ID="Hyperlink5">
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Equip Id">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>' ID="Label22">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label23">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Technician">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>' ID="Label24">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<ItemTemplate>
								<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
									<tr>
										<td style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ID="Label25">
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Op. Status">
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
				<br>
			</td>
		</tr>
	</table>
</form>
