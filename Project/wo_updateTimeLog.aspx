<%@ Page language="c#" Codebehind="wo_updateTimeLog.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_updateTimeLog" %>
<%@ Register TagPrefix="radi" Namespace="Telerik.WebControls" Assembly="RadInput" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.Common" Assembly="Micajah.Common" %>
<form id="Form1" method="post" runat="server">
	<table id="html_tblMain" name="html_tblMain" runat="server">
		<TR>
			<TD class="tblSubHead1" colSpan="3">Main Information</TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Work Order #</TD>
			<td class="RowElem"><asp:label id="lblWorkOrderId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Equipment #</TD>
			<td class="RowElem"><asp:label id="lblEquipId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Assigned Technician</TD>
			<td class="RowElem"><asp:label id="lblTech" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<tr vAlign="top">
			<TD class="RowCap">Equipment Operator</TD>
			<TD class="RowElem"><asp:label id="lblOperator" runat="server"></asp:label></TD>
			<td class="RowHelp"></td>
		</tr>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR>
			<TD class="tblSubHead2" vAlign="top" colSpan="3">Enter Technician's Time Log</TD>
		</TR>
		<tr vAlign="top">
			<td class="RowCap">Technician</td>
			<td class="RowElem"><asp:dropdownlist id="ddlTechnicians" runat="server" DataTextField="vchName" DataValueField="Id" AutoPostBack="True"></asp:dropdownlist>
				<asp:RequiredFieldValidator id="rfvTechnicians" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="ddlTechnicians"></asp:RequiredFieldValidator></td>
			<td class="RowHelp"></td>
		</tr>
		<tr vAlign="top">
			<td class="RowCap">Serviced Repair</td>
			<td class="RowElem"><asp:dropdownlist id="ddlRepairs" runat="server" DataTextField="RepairDesc" DataValueField="Id"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvRepairs" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="ddlRepairs"></asp:requiredfieldvalidator></td>
			<td class="RowHelp"></td>
		</tr>
		<tr vAlign="top">
			<td class="RowCap" height="16">Start Time</td>
			<td class="RowElem" height="16">
				<radi:RadDateInput id="rdiStartTime" Runat="server" DateFormat="g" MinDate="2000-01-01" SelectedDate="2000-01-01"
					PromptChar="_"></radi:RadDateInput></td>
			<td class="RowHelp" height="16"></td>
		</tr>
		<tr vAlign="top">
			<td class="RowCap">Stop Time</td>
			<td class="RowElem">
				<radi:RadDateInput id="rdiStopTime" Runat="server" DateFormat="g" MinDate="2000-01-01" SelectedDate="2000-01-01"></radi:RadDateInput></td>
			<td class="RowHelp"></td>
		</tr>
		<tr vAlign="top">
			<td class="RowCap">Hours<b>:</b>Minutes</td>
			<td class="RowElem"><asp:textbox id="tbHours" runat="server" MaxLength="10" Width="50px"></asp:textbox><b>:</b><asp:textbox id="tbMinutes" runat="server" MaxLength="50" Width="50px"></asp:textbox>&nbsp;
				<asp:regularexpressionvalidator id="revHours" runat="server" ErrorMessage="incorrect hours&nbsp;" Display="Dynamic"
					ControlToValidate="tbHours" ValidationExpression="\d+"></asp:regularexpressionvalidator><asp:regularexpressionvalidator id="revMinutes" runat="server" ErrorMessage="incorrect minutes" Display="Dynamic"
					ControlToValidate="tbMinutes" ValidationExpression="(0[0-9]|[1-5][0-9])"></asp:regularexpressionvalidator></td>
			<td class="RowHelp"></td>
		</tr>
		<tr vAlign="top">
			<td class="RowCap">Hourly Rate</td>
			<td class="RowElem"><asp:textbox id="tbHourlyRate" runat="server" MaxLength="50" Width="50px"></asp:textbox><asp:requiredfieldvalidator id="rfvHourlyRate" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="tbHourlyRate"></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="revHourlyRate" runat="server" ErrorMessage="enter numeric or decimal" Display="Dynamic"
					ControlToValidate="tbHourlyRate" ValidationExpression="(\d+\.\d{0,2})|(\d+)"></asp:regularexpressionvalidator></td>
			<td class="RowHelp"></td>
		</tr>
		<TR vAlign="top">
			<TD class="RowCap">Note:</TD>
			<TD class="RowElem"><asp:textbox id="tbNote" runat="server" MaxLength="6000" Width="300px" TextMode="MultiLine" Height="60px"></asp:textbox></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<tr>
			<td></td>
			<td colSpan="2"><asp:button id="btnAddTimeLog" runat="server" Text="Add Time Log"></asp:button></td>
		</tr>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR>
			<TD class="tblSubHead2" vAlign="top" colSpan="3">Technician's Time Tracking Log</TD>
		</TR>
		<tr>
			<td vAlign="top" colSpan="3">
				<table class="tblStandard" borderColor="#9e755f" cellSpacing="0" cellPadding="1" width="100%"
					border="1">
					<tr valign="middle" class="ag01">
						<td>Date</td>
						<td>Start/Stop Times</td>
						<td>HH:MM</td>
						<td>Technician</td>
						<td>Serviced Repair</td>
						<td>Note</td>
						<td></td>
					</tr>
					<asp:repeater id="repTimeLog" runat="server">
						<ItemTemplate>
							<tr valign="middle" bgcolor="#FFFFCC">
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtCreatedDate") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtStartTime") %>'>
									</asp:Label>&nbsp;
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtStopTime") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Hours") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairName") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchNote") %>'>
									</asp:Label>
								</td>
								<td>
									&nbsp;
									<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Time Log?')">
										<asp:LinkButton runat="server" Text="[delete]" CommandName="Delete" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
										</asp:LinkButton>
									</SPAN>&nbsp;
								</td>
							</tr>
						</ItemTemplate>
						<AlternatingItemTemplate>
							<tr valign="middle" bgcolor="#FFF7BE">
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtCreatedDate") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtStartTime") %>'>
									</asp:Label>&nbsp;
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtStopTime") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Hours") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairName") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchNote") %>'>
									</asp:Label>
								</td>
								<td>
									&nbsp;
									<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Time Log?')">
										<asp:LinkButton runat="server" Text="[delete]" CommandName="Delete" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
										</asp:LinkButton>
									</SPAN>&nbsp;
								</td>
							</tr>
						</AlternatingItemTemplate>
					</asp:repeater>
					<tr id="html_trTotalHours" runat="server">
						<td colspan="3" align="right">
							Total Hours :
						</td>
						<td align="right">
							<asp:Label id="lblTotalHours" runat="server" Font-Bold="True"></asp:Label></td>
					</tr>
					<tr id="html_trTotalCosts" runat="server">
						<td colspan="3" align="right">
							Total Labor Costs :
						</td>
						<td align="right">
							<asp:Label id="lblTotalCosts" runat="server" Font-Bold="True"></asp:Label></td>
					</tr>
					<tr>
						<td colSpan="7">
							<table id="html_tblNoneTimeLog" cellSpacing="0" cellPadding="0" width="100%" border="0"
								runat="server">
								<tr>
									<td align="center">None</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colSpan="3"><br>
				<SPAN style="COLOR: red">Tip #1:</SPAN>
				If you enter valid values to the Start and Stop time fields AND ALSO enter the 
				hours and/or minutes, the system will use entered hours and minutes and will 
				ignore the difference between the Start and Stop time entries.
				<br>
				<br>
				<SPAN style="COLOR: red">Tip #2:</SPAN>
				If you enter valid Start and Stop time fields BUT enter NEITHER the hours NOR 
				minutes, the system will use the difference betweent the Stop and Start time 
				entries.<br>
				<br>
			</td>
		</tr>
		<tr>
			<td></td>
			<td align="left" colSpan="2"><INPUT id="html_btnBack" type="button" value="  << Back  " runat="server"></td>
		</tr>
	</table>
</form>
