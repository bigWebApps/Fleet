<%@ Page language="c#" Codebehind="main.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web._main" %>
<form id="Form1" method="post" runat="server">
	<table width="100%" border="0" id="Table1">
		<TBODY>
			<tr valign="top">
				<td align="center">
					<table cellpadding="3" cellspacing="1" border="0" align="center" id="Table2">
						<tr>
							<td colspan="3" align="left">
								<b>Work Orders </b>
							</td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td colspan="2" align="left">
								<asp:HyperLink id="hlCreateWO" runat="server" NavigateUrl="wo_default.aspx?select=AddOrder">Create New Work Order</asp:HyperLink>
							</td>
						</tr>
						<TR>
							<TD></TD>
							<TD align="left" colSpan="2">
								<asp:HyperLink id="hlCreateRR" runat="server" NavigateUrl="wo_default.aspx?select=AddRoadside">Roadside Repair</asp:HyperLink></TD>
						</TR>
						<TR>
							<TD></TD>
							<TD align="left" colSpan="2">
								<asp:HyperLink id="hlCreateWOInspection" runat="server" NavigateUrl="wo_showEquipsForInspect.aspx">Create Future Inspections</asp:HyperLink></TD>
						</TR>
						<TR>
							<TD></TD>
							<TD align="left" colSpan="2">
								<asp:HyperLink id="hlCreatePastWO" runat="server" NavigateUrl="wo_default.aspx?select=AddPastOrder">Create Past Work Order</asp:HyperLink>
							</TD>
						</TR>
						<tr>
							<td></td>
							<td colspan="2" align="left">
								View Work Orders:
							</td>
						</tr>
						<tr>
							<td></td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td align="left">
								<asp:HyperLink id="hlToday" runat="server" NavigateUrl="wo_showOrdersForToday.aspx">Next 7 Days + Overdue</asp:HyperLink>
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td align="left">
								<asp:HyperLink id="hlWODaily" runat="server" NavigateUrl="wo_showOrdersForDaily.aspx">Daily</asp:HyperLink>
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td align="left">
								<asp:HyperLink id="hlWOWeekly" runat="server" NavigateUrl="wo_showOrdersForWeekly.aspx">Weekly</asp:HyperLink>
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td align="left">
								<asp:HyperLink id="hlWOMonthly" runat="server" NavigateUrl="wo_showOrdersForMonthly.aspx">Monthly</asp:HyperLink>
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td align="left">
								<asp:HyperLink id="hlWOCompleted" runat="server" NavigateUrl="wo_showCompletedOrders.aspx" ToolTip="The completed and unclosed orders">Service Completed</asp:HyperLink>
							</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td align="left">
								<asp:HyperLink id="hlWOUnassigned" runat="server" NavigateUrl="wo_showUnassignedOrders.aspx" ToolTip="The orders without the assigned technician">Scheduled</asp:HyperLink>
							</td>
						</tr>
						<tr>
							<td colspan="3" align="left">
								<b>Equipments</b>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2">
								<asp:HyperLink id="hlViewList" runat="server" NavigateUrl="e_list.aspx">View Equipment List</asp:HyperLink></td>
						</tr>
						<tr>
							<td></td>
							<td colSpan="2">
								<asp:HyperLink id="hlAddEquipment" runat="server" NavigateUrl="e_addEquip.aspx">Add New</asp:HyperLink>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2" align="left">
								<asp:HyperLink id="hlManageRI" runat="server" NavigateUrl="wo_default.aspx?select=AddIssue">Manage Reported Issues</asp:HyperLink>
							</td>
						</tr>
						<TR>
							<TD></TD>
							<TD align="left" colSpan="2">
								<asp:HyperLink id="hlChangeTempOper" runat="server" NavigateUrl="wo_default.aspx?select=ChangeTempOper">Change Temporary Operator</asp:HyperLink></TD>
						</TR>
						<tr>
							<td colspan="3" align="left">
								<b>Reports</b>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2">
								<asp:HyperLink id="hlTempOperatorReport" runat="server" NavigateUrl="e_viewTempOperatorReport.aspx">Temporary
Operator Assigment Report</asp:HyperLink></td>
						</tr>
						<TR>
							<TD></TD>
							<TD colSpan="2">
								<asp:HyperLink id="hlEquipWorkOrderReport" runat="server" NavigateUrl="wo_viewEquipWorkOrderReport.aspx">Equipment Work Order Report</asp:HyperLink></TD>
						</TR>
						<TR>
							<TD colSpan="3"><b>Training</b>&nbsp;</TD>
						</TR>
						<TR>
							<TD></TD>
							<TD colSpan="2">
								<asp:HyperLink id="hlTrainingOpen" runat="server" NavigateUrl="t_OpenWorkOrder.htm" Target="_blank">Adding PM and Inspections to a Work Order</asp:HyperLink></TD>
						</TR>
						<TR>
							<TD colSpan="3"><b>Logoff</b></TD>
						</TR>
						<TR>
							<TD></TD>
							<TD colSpan="2">
								<asp:HyperLink id="hlDeactivate" runat="server" NavigateUrl="selectMode.aspx">Deactivate Technician Terminal</asp:HyperLink>
							</TD>
						</TR>
					</table>
				</td>
				<td align="center">
					<asp:repeater id="repOrders" runat="server">
						<ItemTemplate>
							<tr valign="middle" bgcolor="#FFFFCC" style="cursor:pointer;" onclick='<%# "javascript:document.location=\"wo_viewWorkOrder.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) + "\"" %>'>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
									</asp:Label>
								</td>
								<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.StatusColor")) %>'>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
									</asp:Label>
								</td>
								<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
									</asp:Label>
								</td>
							</tr>
						</ItemTemplate>
						<AlternatingItemTemplate>
							<tr valign="middle" style="cursor:pointer;" bgcolor="#FFF7BE" onclick='<%# "javascript:document.location=\"wo_viewWorkOrder.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) + "\"" %>'>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
									</asp:Label>
								</td>
								<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.StatusColor")) %>'>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
									</asp:Label>
								</td>
								<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
									</asp:Label>
								</td>
							</tr>
						</AlternatingItemTemplate>
						<HeaderTemplate>
							<table class="tblStandard" borderColor="#9e755f" cellSpacing="0" cellPadding="5" border="2">
								<tr>
									<td class="tblSubHead1" align="left" colspan="5">Current Activity</td>
								</tr>
								<tr valign="middle" class="ag01">
									<td>Equipment</td>
									<td>Operator</td>
									<td>Technician</td>
									<td>Status</td>
									<td>Operator Status</td>
								</tr>
						</HeaderTemplate>
						<FooterTemplate>
	</table>
	</FooterTemplate> </asp:repeater></TD></TR></TBODY></TABLE>
</form>
