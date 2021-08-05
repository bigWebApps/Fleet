<%@ Page language="c#" Codebehind="ok_viewIssues.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_viewIssues" %>
<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TBODY>
			<tr>
				<TD width="50%"><BR>
				</TD>
				<td width="50%"></td>
			</tr>
			<tr>
				<td colspan="2">
					<asp:Repeater id="repIssues" runat="server">
							<HeaderTemplate>
								<table class="tblStandard" borderColor="#9e755f" cellSpacing="0" cellPadding="10" border="2">
									<tr>
										<td class="tblSubHead1" style="FONT-SIZE: 12pt;" align="left" colspan="3" height="22">
											The list of all repairs items that are associated to the current equipment that have not been serviced
											(i.e. attached to future work orders OR not attached to a work order)
										</td>
									</tr>
									<tr valign="middle" class="ag01">
										<td class="ok_size">Repair Category</td>
										<td class="ok_size">Issue</td>
										<td class="ok_size" align="center">Date Report</td>
									</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr valign="middle" bgcolor="#FFFFCC">
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
										</asp:Label>
									</td>
									<td class="ok_size" align="center">
										<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.ReportDate")).ToString("yyyy-MM-dd") %>'>
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="middle" bgcolor="#FFF7BE">
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
										</asp:Label>
									</td>
									<td class="ok_size" align="center">
										<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.ReportDate")).ToString("yyyy-MM-dd") %>'>
										</asp:Label>
									</td>
								</tr>
							</AlternatingItemTemplate>
							<FooterTemplate>
								</TABLE>
							</FooterTemplate> </asp:Repeater>
							</TD></TR>
			<tr>
				<td colspan="2"><br><br>
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
