<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="wo_viewEquipWorkOrderReport.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_viewEquipWorkOrderReport" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TBODY>
			<TR vAlign="top">
				<TD class="tblSubHead1" colSpan="3">Select filter options to view report</TD>
			</TR>
			<tr>
				<td class="RowCap">Equipment ID:
				</td>
				<td class="RowElem" colSpan="2"><asp:textbox onkeypress="return(clickButton(document.Form1.btnReport));" id="tbEquipId" runat="server"
						MaxLength="50"></asp:textbox><asp:requiredfieldvalidator id="rfvEquipId" runat="server" ControlToValidate="tbEquipId" ErrorMessage="Equipment ID is required"></asp:requiredfieldvalidator></td>
			</tr>
			<TR vAlign="top">
				<TD class="RowCap">Date Range
				</TD>
				<td class="RowElem"><SELECT id="ddlDateRange" onchange="javascript:SetDateRange('ddlDateRange', 'adtStartDate', 'adtEndDate');"
						name="ddlDateRange" runat="server">
						<OPTION value="-1">Today</OPTION>
						<OPTION value="1">This Week</OPTION>
						<OPTION value="2">This Month</OPTION>
						<OPTION value="3">This Year</OPTION>
						<OPTION value="3">This Fiscal Year</OPTION>
						<OPTION value="11">Last Week</OPTION>
						<OPTION value="12">Last Month</OPTION>
						<OPTION value="13">Last Year</OPTION>
						<OPTION value="13">Last Fiscal Year</OPTION>
						<OPTION value="-30">Rolling Last 30 days</OPTION>
						<OPTION value="-90">Rolling Last 90 days</OPTION>
						<OPTION value="-365" selected>Rolling Last 365 days</OPTION>
					</SELECT></td>
				<TD class="RowElem" vAlign="middle" align="center" rowSpan="3">&nbsp;&nbsp;&nbsp;&nbsp;<asp:button id="btnReport" runat="server" Text="  View Report  "></asp:button>&nbsp;&nbsp;&nbsp;&nbsp;</TD>
			</TR>
			<TR vAlign="top">
				<TD class="RowCap">Start Date
				</TD>
				<td class="RowElem"><cc1:activedatetime id="adtStartDate" runat="server" MinYear="2000" MaxYear="2030" Format="MONTH;/;DAY;/;YEAR"
						AllowNull="False" AlertEnabled="True"></cc1:activedatetime>&nbsp; <A id="A1" style="CURSOR: pointer" onclick="javascript:OpenCalendar('adtStartDate', false, event.screenX, event.screenY)"
						runat="server"><IMG id="imgCalBegin1" src="images/calendar-16x16.gif" border="0"></A>
				</td>
			</TR>
			<TR vAlign="top">
				<TD class="RowCap">End Date
				</TD>
				<td class="RowElem"><cc1:activedatetime id="adtEndDate" runat="server" MinYear="2000" MaxYear="2030" Format="MONTH;/;DAY;/;YEAR"
						AllowNull="False" AlertEnabled="True"></cc1:activedatetime>&nbsp; <A id="A2" style="CURSOR: pointer" onclick="javascript:OpenCalendar('adtEndDate', false, event.screenX, event.screenY)"
						runat="server"><IMG id="imgCalBegin2" src="images/calendar-16x16.gif" border="0"></A>
				</td>
			</TR>
			<tr>
				<td class="RowCap" noWrap>Repair Category
				</td>
				<td class="RowElem" colSpan="2"><asp:dropdownlist id="ddlRepairCats" runat="server" DataMember="Table" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist></td>
			</tr>
			<TR>
				<TD class="RowCap" noWrap>Work Order Type</TD>
				<TD class="RowElem" colSpan="2"><asp:dropdownlist id="ddlWOTypes" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist></TD>
			</TR>
			<TR>
				<TD class="RowCap" noWrap>Technician</TD>
				<TD class="RowElem" colSpan="2"><asp:dropdownlist id="ddlTech" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist></TD>
			</TR>
			<TR>
				<TD class="RowCap" noWrap>Equipment Operator</TD>
				<TD class="RowElem" colSpan="2"><asp:dropdownlist id="ddlOperators" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist></TD>
			</TR>
			<tr>
				<td colSpan="3"><br>
				</td>
			</tr>
			<tr>
				<td colSpan="3"><asp:repeater id="repWorkOrders" runat="server">
						<HeaderTemplate>
							<table style="border-color:#CCCCCC;border-width:1px;border-style:solid;width:100%;border-collapse:collapse;"
								cellSpacing="0" cellPadding="1" border="1" rules="all" borderColor="#CCCCCC">
								<tr valign="middle" class="ag03">
									<td align="center">#</td>
									<td align="center" nowrap>Work Order #</td>
									<td nowrap>Work Order Type</td>
									<td nowrap>Technician Name</td>
									<td nowrap>Operator Name</td>
									<td align="center">Status</td>
									<td align="center" nowrap>Operator Status</td>
									<td nowrap>Scheduled Date</td>
									<td nowrap>Completed Date</td>
									<td nowrap>Total Cost</td>
								</tr>
						</HeaderTemplate>
						<ItemTemplate>
							<tr valign="middle" bgcolor="#FFFFCC">
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
									</asp:Label>
								</td>
								<td align="center" nowrap>
									<asp:HyperLink runat="server" Text='<%# "[" + Convert.ToString(DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber")) + "]" %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OrderId")) %>'>
									</asp:HyperLink>
								</td>
								<td nowrap>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
									</asp:Label>
								</td>
								<td nowrap>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
									</asp:Label>
								</td>
								<td nowrap>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
										<tr>
											<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.StatusColor")) %>'>
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
												</asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td align="center" nowrap>
									<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
										<tr>
											<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
												</asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td nowrap>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ScheduledDate") %>'>
									</asp:Label>
								</td>
								<td nowrap>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CompletedDate") %>'>
									</asp:Label>
								</td>
								<td nowrap>
									<asp:Label runat="server" Font-Bold="True" Text='<%# "$" + Convert.ToString(DataBinder.Eval(Container, "DataItem.TotalCost")) %>'>
									</asp:Label>
								</td>
							</tr>
							<tr>
								<td colspan="10">
									<%# DataBinder.Eval(Container, "DataItem.Repairs") %>
									<%# DataBinder.Eval(Container, "DataItem.Notes") %>
								</td>
							</tr>
						</ItemTemplate>
						<AlternatingItemTemplate>
							<tr valign="middle" bgcolor="#FFF7BE">
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
									</asp:Label>
								</td>
								<td align="center" nowrap>
									<asp:HyperLink runat="server" Text='<%# "[" + Convert.ToString(DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber")) + "]" %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OrderId")) %>'>
									</asp:HyperLink>
								</td>
								<td nowrap>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
									</asp:Label>
								</td>
								<td nowrap>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
									</asp:Label>
								</td>
								<td nowrap>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
										<tr>
											<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.StatusColor")) %>'>
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
												</asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td align="center" nowrap>
									<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
										<tr>
											<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
												</asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td nowrap>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ScheduledDate") %>'>
									</asp:Label>
								</td>
								<td nowrap>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CompletedDate") %>'>
									</asp:Label>
								</td>
								<td nowrap>
									<asp:Label runat="server" Font-Bold="True" Text='<%# "$" + Convert.ToString(DataBinder.Eval(Container, "DataItem.TotalCost")) %>'>
									</asp:Label>
								</td>
							</tr>
							<tr>
								<td colspan="10">
									<%# DataBinder.Eval(Container, "DataItem.Repairs") %>
									<%# DataBinder.Eval(Container, "DataItem.Notes") %>
								</td>
							</tr>
						</AlternatingItemTemplate>
						<FooterTemplate>
	</table>
	</FooterTemplate> </asp:Repeater></TD></TR>
	<tr>
		<td colSpan="3"><br>
		</td>
	</tr>
	<TR>
		<TD noWrap colSpan="3" align="right">
			Total Orders Costs:&nbsp;
			<asp:Label id="lblTotalCost" runat="server" Font-Bold="True"></asp:Label>
		</TD>
	</TR>
	</TBODY></TABLE></form>
