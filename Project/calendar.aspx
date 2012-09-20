<%@ Page language="c#" Codebehind="calendar.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Core._calendar" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Calendar</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="Style.css" type="text/css" rel="stylesheet">
		<script language="javascript">
    function CloseWindow()
            {
                self.close();
            }
		</script>
	</HEAD>
	<body bgColor="#ffffff" leftMargin="5" topMargin="5" onload="self.focus();">
		<form id="Calendar" method="post" runat="server">
			<table cellSpacing="0" cellPadding="0" width="100%" height="1">
				<tr bgColor="white">
					<td colSpan="2"><IMG height="10" src="images/spacer.gif" width="1"></td>
				</tr>
				<tr bgColor="white">
					<td align="center" colSpan="2">
						<asp:DropDownList id="MonthSelect" runat="server" AutoPostBack="True" Width="90px" Height="22px"></asp:DropDownList>&nbsp;
						<asp:DropDownList id="YearSelect" runat="server" AutoPostBack="True" Width="60px" Height="22px"></asp:DropDownList>
						<asp:Calendar id="Cal" runat="server" FirstDayOfWeek="Monday" ForeColor="#C0C0FF" DayNameFormat="FirstTwoLetters"
							BorderColor="White" Font-Names="Arial" Font-Size="XX-Small" BorderStyle="Solid" ShowNextPrevMonth="False"
							ShowTitle="False" BorderWidth="5px">
							<TodayDayStyle Font-Bold="True" ForeColor="Black" BackColor="#FFFFCC"></TodayDayStyle>
							<DayStyle BorderWidth="2px" ForeColor="#666666" BorderStyle="Solid" BorderColor="White" BackColor="#EAEAEA"></DayStyle>
							<DayHeaderStyle ForeColor="#000000"></DayHeaderStyle>
							<SelectedDayStyle Font-Bold="True" ForeColor="#333333" BackColor="#FAAD50"></SelectedDayStyle>
							<WeekendDayStyle ForeColor="White" BackColor="#BBBBBB"></WeekendDayStyle>
							<OtherMonthDayStyle ForeColor="#666666" BackColor="White"></OtherMonthDayStyle>
						</asp:Calendar>
					</td>
				</tr>
				<tr>
					<td align="center" colSpan="2">Date Selected:<br>
						<asp:label id="lblDate" runat="server" Font-Bold="True"></asp:label><input id="datechosen" type="hidden" name="datechosen" runat="server">
					</td>
				</tr>
				<tr>
					<td colSpan="2"><IMG height="10" src="images/spacer.gif" width="1"></td>
				</tr>
				<tr>
					<td align="center"><asp:button id="OKButton" runat="server" Width="60px" Height="21px" Text="Select"></asp:button></td>
					<td align="center"><asp:button id="CancelButton" runat="server" Width="60px" Height="21px" Text="Cancel"></asp:button></td>
					</TD>
				</tr>
			</table>
		</form>
	</body>
</HTML>
