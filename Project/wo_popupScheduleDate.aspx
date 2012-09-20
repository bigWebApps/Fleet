<%@ Page language="c#" Codebehind="wo_popupScheduleDate.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_popupScheduleDate" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>Calendar for the Schedule Date</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="style_global.css" type="text/css" rel="stylesheet">
		<script language="javascript">
    function CloseWindow()
            {
                self.close();
            }
		</script>
</HEAD>
	<body bgColor="#ffffff" leftMargin="5" topMargin="5" onload="self.focus();">
		<form id="Calendar" method="post" runat="server">
			<table height="1" cellSpacing="0" cellPadding="0" width="100%">
				<tr bgColor="white">
					<td colSpan="2"><IMG height="10" src="images/spacer.gif" width="1"></td>
				</tr>
				<tr bgColor="white">
					<td align="center" colSpan="2"><asp:dropdownlist id="MonthSelect" runat="server" AutoPostBack="True" Width="90px" Height="22px"></asp:dropdownlist>&nbsp;
						<asp:dropdownlist id="YearSelect" runat="server" AutoPostBack="True" Width="60px" Height="22px"></asp:dropdownlist>
						<asp:calendar id="Cal" runat="server" CellSpacing="1" NextPrevFormat="ShortMonth" BackColor="White"
							FirstDayOfWeek="Monday" ForeColor="Black" BorderColor="Black" Font-Names="Times New Roman" Font-Size="9pt" BorderStyle="Solid" ShowNextPrevMonth="False" ShowTitle="False">
							<TodayDayStyle ForeColor="White" BackColor="#999999"></TodayDayStyle>
							<DayStyle BackColor="#CCCCCC"></DayStyle>
							<NextPrevStyle Font-Size="8pt" Font-Bold="True" ForeColor="White"></NextPrevStyle>
							<DayHeaderStyle Font-Size="8pt" Font-Bold="True" Height="8pt" ForeColor="#333333"></DayHeaderStyle>
							<SelectedDayStyle ForeColor="White" BackColor="#333399"></SelectedDayStyle>
							<TitleStyle Font-Size="12pt" Font-Bold="True" Height="12pt" ForeColor="White" BackColor="#333399"></TitleStyle>
							<OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>
						</asp:calendar></td>
				</tr>
				<tr>
					<td align="center" colSpan="2"><br>
					</td>
				</tr>
				<TR>
					<TD align="center" colSpan="2"><asp:xml id="xmlTimeSheet" runat="server"></asp:xml></TD>
				</TR>
				<tr>
					<td colSpan="2"><br>
					</td>
				</tr>
				<tr>
					<td align="center" colSpan="2">Date Selected:<br>
						<asp:label id="lblDate" runat="server" Font-Bold="True"></asp:label>
						<input id="datechosen" type="hidden" name="datechosen" runat="server">
					</td>
				</tr>
				<tr>
					<td colSpan="2"><IMG height="10" src="images/spacer.gif" width="1"></td>
				</tr>
				<tr>
					<td align="center"><asp:button id="OKButton" runat="server" Width="60px" Height="21px" Text="Select"></asp:button></td>
					<td align="center"><asp:button id="CancelButton" runat="server" Width="60px" Height="21px" Text="Cancel"></asp:button></td></TD></tr>
			</table>
		</form>
	</body>
</HTML>
