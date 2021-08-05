<%@ Page language="c#" Codebehind="wo_showOrdersForMonthly.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_showOrdersForMonthly" %>
<%@ Register TagPrefix="acme" Namespace="Acme" Assembly="TemplatedCalendar" %>
<form id="Form1" method="post" runat="server">
	<table align="center">
		<tr>
			<td vAlign="middle" align="center" colSpan="2" height="16"><font color="green" size="3"><asp:linkbutton id="lbPreviousYear" runat="server" Font-Size="Larger" ToolTip="Previous Year">&lt;&lt;</asp:linkbutton>&nbsp;
					<asp:linkbutton id="lbPreviousMonth" runat="server" Font-Size="Larger" ToolTip="Previous Month">&lt;</asp:linkbutton>&nbsp;
					<asp:label id="lblCurrentDate" runat="server" Font-Bold="True"></asp:label>&nbsp;
					<asp:linkbutton id="lbNextMonth" runat="server" Font-Size="Larger" ToolTip="Next Month">&gt;</asp:linkbutton>&nbsp;
					<asp:linkbutton id="lbNextYear" runat="server" Font-Size="Larger" ToolTip="Next Year">&gt;&gt;</asp:linkbutton></font></td>
		</tr>
		<tr>
			<td bgColor="#000000" colSpan="2"></td>
		</tr>
		<tr>
			<td colSpan="2"><acme:templatedcalendar id="t_calOrders" runat="server" ShowDayHeader="True" ShowNextPrevMonth="False" ShowTitle="False"
					Width="560px" DayStyle-Width="80px" DayStyle-VerticalAlign="Top" DayHeaderStyle-Font-Bold="True" DayStyle-Height="80px">
					<DayTemplate>
						<asp:LinkButton id="lbDay" runat="server" Font-Size="Larger" CommandName="Reserve" CommandArgument='<%# Container.Date %>' ToolTip="Daily View">
							<%# Container.DayText %>
						</asp:LinkButton>
						<br>
						<br>
						<table border="0" cellpadding="-1" cellspacing="-1">
							<asp:repeater id="repOrders" runat="server">
								<ItemTemplate>
									<TR style="cursor:pointer;" onclick='<%# "javascript:document.location=\"wo_viewWorkOrder.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) + "\"" %>'>
										<TD style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Color")) %>' nowrap>
											<asp:Label id="lblEquipId" runat="server">
												<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>
											</asp:Label>-
											<asp:Label id="lblOperator" runat="server">
												<%# DataBinder.Eval(Container, "DataItem.OperatorLastName") %>
											</asp:Label>
										</TD>
										<TD>
										</TD>
									</TR>
								</ItemTemplate>
							</asp:repeater>
						</table>
					</DayTemplate>
				</acme:templatedcalendar></td>
		</tr>
	</table>
</form>
