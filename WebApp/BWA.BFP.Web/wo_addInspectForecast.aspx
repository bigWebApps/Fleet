<%@ Page language="c#" Codebehind="wo_addInspectForecast.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_addInspectForecast" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR vAlign="top">
			<TD class="tblSubHead1" colSpan="3">Work Order Information</TD>
		</TR>
		<tr vAlign="top">
			<td class="RowCap" width="30%">Equipment #</td>
			<td class="RowElem"><asp:label id="lblEquipId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</tr>
		<TR vAlign="top">
			<TD class="RowCap">Work Order Type
			</TD>
			<TD class="RowElem"><asp:label id="lblWOType" runat="server"></asp:label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<tr vAlign="top">
			<td class="RowCap">Optimal Date for Work Order</td>
			<td class="RowElem"><asp:label id="lblScheduledDate" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</tr>
		<TR vAlign="top">
			<TD class="RowCap" align="left">Scheduled Date and Time
			</TD>
			<TD class="RowElem" vAlign="middle"><cc1:activedatetime id="adtScheduled" runat="server" AllowNull="False" AlertEnabled="True" MinYear="2000"
					MaxYear="2030" Format="MONTH;/;DAY;/;YEAR;&nbsp;:&nbsp;;HOUR;/;MINUTE;/;MERIDIEM"></cc1:activedatetime><A id="html_ScheduledDate" style="CURSOR: pointer" onclick="javascript:OpenPopUpScheduleDate('adtScheduled', false)"
					runat="server"><IMG id="imgCalBegin3" src="images/calendar-16x16.gif" border="0"></A>
				&nbsp;<asp:Label id="lblErrorScheduled" runat="server" ForeColor="Red"></asp:Label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Work Order Creation Note</TD>
			<td class="RowElem" noWrap><asp:textbox id="tbNotes" runat="server" Height="100px" Width="100%" TextMode="MultiLine"></asp:textbox></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="tblSubHead1" colSpan="3">Inspection Information</TD>
		</TR>
		<tr vAlign="top">
			<td class="RowCap">Inspection Schedule</td>
			<td class="RowElem"><asp:label id="lblInspectSchedule" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</tr>
		<tr vAlign="top">
			<td class="RowCap">Inspection Name</td>
			<td class="RowElem"><asp:label id="lblInspectName" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</tr>
		<tr vAlign="top">
			<td class="RowCap">Inspection Status</td>
			<td class="RowElem"><asp:label id="lblStatus" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</tr>
		<tr vAlign="top">
			<td class="RowCap">Date of Last Inspection
			</td>
			<td class="RowElem"><asp:label id="lblLastInspectDate" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</tr>
		<tr vAlign="top">
			<td class="RowCap">Scheduled Dates Range</td>
			<td class="RowElem"><asp:label id="lblDateRange" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</tr>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR vAlign="top">
			<TD colSpan="3"><uc1:nextback id="NextBackControl" runat="server"></uc1:nextback></TD>
		</TR>
	</table>
</form>
