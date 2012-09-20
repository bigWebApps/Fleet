<%@ Page language="c#" Codebehind="wo_showOrdersForDaily.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_showOrdersForDaily" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colspan="2" height="16" align="center" valign="middle">
				<font size="3" color="green">
					<asp:LinkButton id="lbPreviousMonth" runat="server" Font-Size="Larger" ToolTip="Previous Month">&lt;&lt;</asp:LinkButton>
					&nbsp;
					<asp:LinkButton id="lbPreviousDay" runat="server" Font-Size="Larger" ToolTip="Previous Day">&lt;</asp:LinkButton>
					&nbsp;
					<asp:Label id="lblCurrentDate" runat="server" Font-Bold="True"></asp:Label>
					&nbsp;
					<asp:LinkButton id="lbNextDay" runat="server" Font-Size="Larger" ToolTip="Next Day">&gt;</asp:LinkButton>
					&nbsp;
					<asp:LinkButton id="lbNextMonth" runat="server" Font-Size="Larger" ToolTip="Next Month">&gt;&gt;</asp:LinkButton>
				</font>
			</td>
		</tr>
		<tr>
			<td colspan="2" bgcolor="#000000"></td>
		</tr>
		<tr>
			<td colspan="2">
				<mits:datagrid_a id="dgWorkOrders" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
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
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>' ID="Label2">
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
										<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>'>
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
										<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
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
		<tr>
			<td colspan="2">
				<asp:Button id="btnBack" runat="server" Text="<< Back"></asp:Button>
			</td>
		</tr>
	</table>
</form>
