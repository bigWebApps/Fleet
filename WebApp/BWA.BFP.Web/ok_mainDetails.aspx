<%@ Page language="c#" Codebehind="ok_mainDetails.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_mainDetails" %>
<form id="Form1" method="post" runat="server">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tblMain" name="tblMain"
		runat="server">
		<tr>
			<td align="center">
				<h1>Operator Kiosk Work Order Detail</h1>
			</td>
		</tr>
		<tr align="center">
			<td>
				<table>
					<tr valign="top">
						<td class="bg01">Work Order #</td>
						<td class="bg02" width="50%"><asp:label id="lblWorkOrderN" runat="server"></asp:label></td>
					</tr>
					<tr vAlign="top">
						<td class="bg01">Equipment #</td>
						<td class="bg02"><asp:label id="lblEquipId" runat="server"></asp:label></td>
					</tr>
					<TR>
						<TD class="bg01">Type</TD>
						<TD class="bg02"><asp:label id="lblType" runat="server"></asp:label></TD>
					</TR>
					<tr vAlign="top">
						<td class="bg01">Equipment Operator</td>
						<td class="bg02"><asp:label id="lblOperator" runat="server"></asp:label></td>
					</tr>
					<tr vAlign="top">
						<td class="bg01">Work Order Status</td>
						<td class="bg02"><asp:label id="lblStatus" runat="server"></asp:label></td>
					</tr>
					<TR>
						<TD class="bg01">Work Order Operator Status&nbsp;</TD>
						<TD class="bg02">
							<asp:label id="lblOperatorStatus" runat="server"></asp:label></TD>
					</TR>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<br>
			</td>
		</tr>
		<tr>
			<td align="center">
				<br>
				<br>
				<INPUT id="btnCheckIn" runat="server" class="ok_input_button" type="button" value=" Arrival Check-In "
					style="WIDTH: 400px">
				<br>
			</td>
		</tr>
		<tr>
			<td align="center">
				<br>
				<br>
				<INPUT id="btnCheckOut" runat="server" class="ok_input_button" type="button" value=" Departure Check-Out "
					style="WIDTH: 400px">
				<br>
			</td>
		</tr>
		<TR>
			<TD align="center">
				<br>
				<br>
				<INPUT id="btnReOpen" runat="server" class="ok_input_button" type="button" value=" ReOpen Work Order "
					style="WIDTH: 400px" NAME="btnReOpen">
				<br>
			</TD>
		</TR>
		<tr>
			<td align="center">
				<br>
				<br>
				<INPUT id="btnCheckOutSpare" runat="server" class="ok_input_button" type="button" value=" Check-Out Spare "
					style="WIDTH: 400px">
				<br>
			</td>
		</tr>
		<tr>
			<td align="center">
				<br>
				<br>
				<INPUT id="btnAddIssue" runat="server" class="ok_input_button" type="button" value=" Add Reported Issue "
					style="WIDTH: 400px">
				<br>
			</td>
		</tr>
		<TR>
			<TD align="center">
				<br>
				<br>
				<INPUT id="btnBack" runat="server" class="ok_input_button" type="button" value="<< Back"
					style="WIDTH: 400px">
				<br>
			</TD>
		</TR>
	</table>
</form>
