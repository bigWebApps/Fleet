<%@ Page language="c#" Codebehind="e_viewEquipAssignmentReport.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._e_viewEquipAssignmentReport" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR vAlign="top">
			<TD class="tblSubHead1" colSpan="3">
				Select date range to view report</TD>
		</TR>
		<tr>
			<td class="RowCap">Equipment ID:
			</td>
			<td class="RowElem">
				<asp:Label id="lblEquipId" runat="server" Font-Bold="True"></asp:Label></td>
			<TD vAlign="middle" align="center" rowSpan="4">&nbsp;&nbsp;&nbsp;&nbsp;<asp:button id="btnReport" runat="server" Text="  View Report  "></asp:button>&nbsp;&nbsp;&nbsp;&nbsp;</TD>
		</tr>
		<TR vAlign="top">
			<TD class="RowCap">Date Range
			</TD>
			<td class="RowElem">
				<SELECT name="ddlDateRange" id="ddlDateRange" runat="server" onchange="javascript:SetDateRange('ddlDateRange', 'adtStartDate', 'adtEndDate');">
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
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Start Date
			</TD>
			<td class="RowElem"><cc1:activedatetime id="adtStartDate" runat="server" AlertEnabled="True" AllowNull="False" Format="MONTH;/;DAY;/;YEAR"
					MaxYear="2030" MinYear="2000"></cc1:activedatetime>&nbsp; <A id="A1" style="CURSOR: pointer" onclick="javascript:OpenCalendar('adtStartDate', false, event.screenX, event.screenY)"
					runat="server"><IMG id="imgCalBegin1" src="images/calendar-16x16.gif" border="0"></A>
			</td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">End Date
			</TD>
			<td class="RowElem"><cc1:activedatetime id="adtEndDate" runat="server" AlertEnabled="True" AllowNull="False" Format="MONTH;/;DAY;/;YEAR"
					MaxYear="2030" MinYear="2000"></cc1:activedatetime>&nbsp; <A id="A2" style="CURSOR: pointer" onclick="javascript:OpenCalendar('adtEndDate', false, event.screenX, event.screenY)"
					runat="server"><IMG id="imgCalBegin2" src="images/calendar-16x16.gif" border="0"></A>
			</td>
		</TR>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
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
						<asp:TemplateColumn HeaderText="Change Type">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ChangeType") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Old">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.AssignedFrom") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="New">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.AssignedTo") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Changed By">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Note">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchNote") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
	</table>
</form>
