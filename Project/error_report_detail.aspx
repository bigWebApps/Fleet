<%@ Page language="c#" Codebehind="error_report_detail.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.error._error_report_detail" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td class="tblSubHead2" colSpan="2">
				Error&nbsp;Info</td>
		</tr>
		<tr>
			<td class="bg01" nowrap>Error Message</td>
			<td class="bg02"><asp:label id="lblErrorMessage" runat="server"></asp:label></td>
		</tr>
		<tr>
			<td class="bg01" nowrap>Page Name</td>
			<td class="bg02"><asp:label id="lblPageName" runat="server"></asp:label></td>
		</tr>
		<tr>
			<td class="bg01" nowrap>User</td>
			<td class="bg02"><asp:label id="lblUserName" runat="server"></asp:label></td>
		</tr>
		<tr>
			<td class="bg01" nowrap>Organization</td>
			<td class="bg02"><asp:label id="lblOrg" runat="server"></asp:label></td>
		</tr>
		<tr>
			<td class="bg01" nowrap>Date of Creating</td>
			<td class="bg02"><asp:label id="lblCreated" runat="server"></asp:label></td>
		</tr>
		<tr>
			<td class="bg01" nowrap>Error Description</td>
			<td class="bg02"><asp:label id="lblDesc" runat="server"></asp:label></td>
		</tr>
		<tr>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td colspan="2">
				<asp:Label id="lblBack" runat="server"></asp:Label></td>
		</tr>
	</table>
</form>
