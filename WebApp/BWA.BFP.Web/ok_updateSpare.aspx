<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Page language="c#" Codebehind="ok_updateSpare.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_updateSpare" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TBODY>
			<tr>
				<TD width="50%"><BR>
					<br>
					<br>
				</TD>
				<td width="50%"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<H1>
						<asp:Label id="lblFirstName1" runat="server"></asp:Label>,&nbsp;Are you 
						returning&nbsp;
						<asp:Label id="lblEquipType" runat="server"></asp:Label>&nbsp;#
						<asp:Label id="lblEquipId" runat="server"></asp:Label>?
					</H1>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br>
					<br>
					<br>
				</td>
			</tr>
			<tr>
				<TD colspan="2" align="center">
					<uc1:nextback id="NextBackControl" runat="server"></uc1:nextback>
				</TD>
			</tr>
		</TBODY>
	</TABLE>
</form>
