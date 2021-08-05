<%@ Page language="c#" Codebehind="wo_deleteWorkOrder.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_deleteWorkOrder" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR>
			<TD class="tblSubHead1" colSpan="2">Information</TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Work Order #</TD>
			<td class="RowElem"><asp:label id="lblWorkOrderId" runat="server"></asp:label></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" noWrap>Equipment #</TD>
			<td class="RowElem"><asp:label id="lblEquipId" runat="server"></asp:label></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Assigned Technician</TD>
			<td class="RowElem"><asp:label id="lblTech" runat="server"></asp:label></td>
		</TR>
		<tr vAlign="top">
			<TD class="RowCap">Equipment Operator</TD>
			<TD class="RowElem"><asp:label id="lblOperator" runat="server"></asp:label></TD>
		</tr>
		<tr>
			<td colspan="2"><br>
				<br>
				<br>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center"><font style="FONT-WEIGHT: bold; FONT-SIZE: 16pt">Are you 
					sure you want to delete this work order?</font></td>
		</tr>
		<tr>
			<td colspan="2"><br>
			</td>
		</tr>
		<tr>
			<td align="center" width="50%"><INPUT type="button" runat="server" value="   No   " name="html_btnNo" id="html_btnNo"></td>
			<td align="center" width="50%">
				<asp:Button id="btnYes" runat="server" Text="   Yes   "></asp:Button></td>
		</tr>
	</table>
</form>
