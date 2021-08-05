<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Page language="c#" Codebehind="ok_viewServices.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_viewServices" %>
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
					<table class="tblStandard" borderColor="#9e755f" cellSpacing="0" cellPadding="3" border="2">
						<tr>
							<td class="tblSubHead1" align="left" colspan="4" height="22">
								Reported Issues List that were serviced on the work order
							</td>
						</tr>
						<asp:repeater id="repIssues" runat="server">
							<HeaderTemplate>
								<tr valign="middle" class="ag01">
									<td class="ok_size2">Category</td>
									<td class="ok_size2" align="center">Status</td>
									<td class="ok_size2">Issue</td>
									<td class="ok_size2">Repair Notes</td>
								</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr valign="top" bgcolor="#FFFFCC">
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.IssuesName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>'>
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="top" bgcolor="#FFF7BE">
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.IssuesName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>'>
										</asp:Label>
									</td>
								</tr>
							</AlternatingItemTemplate>
						</asp:repeater>
						<tr>
							<td colSpan="4">
								<table id="html_tblNoneIssues" cellSpacing="0" cellPadding="0" width="100%" border="0"
									runat="server">
									<tr>
										<td class="ok_size2" align="center">None</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td colSpan="4"><br>
							</td>
						</tr>
						<tr>
							<td class="tblSubHead1" align="left" colSpan="4" height="22">
								Preventive Maintenance Items that were serviced on the work order
							</td>
						</tr>
						<asp:repeater id="repPMItems" runat="server">
							<HeaderTemplate>
								<tr valign="middle" class="ag01">
									<td class="ok_size2">Category</td>
									<td class="ok_size2" align="center">Status</td>
									<td class="ok_size2">Service</td>
									<td class="ok_size2">Repair Notes</td>
								</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr valign="top" bgcolor="#FFFFCC">
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>'>
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="top" bgcolor="#FFF7BE">
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>'>
										</asp:Label>
									</td>
								</tr>
							</AlternatingItemTemplate>
						</asp:repeater>
						<TR>
							<TD colSpan="4" designtimesp="17163">
								<table id="html_tblNonePMItems" cellSpacing="0" cellPadding="0" width="100%" border="0"
									runat="server">
									<tr>
										<td align="center" class="ok_size2">None</td>
									</tr>
								</table>
							</TD>
						</TR>
						<tr>
							<td colSpan="4"><br>
							</td>
						</tr>
						<tr>
							<td class="tblSubHead1" align="left" colSpan="4" height="22">
								<asp:Label runat="server" id="lblInspectionTitle">Inspection Items that were serviced on the work order
								</asp:Label>
							</td>
						</tr>
						<asp:repeater id="repInspectItems" runat="server">
							<HeaderTemplate>
								<tr valign="middle" class="ag01">
									<td class="ok_size2">Category</td>
									<td class="ok_size2" align="center">Status</td>
									<td class="ok_size2">Inspection Item</td>
									<td class="ok_size2">Repair Notes</td>
								</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr valign="top" bgcolor="#FFFFCC">
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionItemName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>'>
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="top" bgcolor="#FFF7BE">
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionItemName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>'>
										</asp:Label>
									</td>
								</tr>
							</AlternatingItemTemplate>
						</asp:repeater>
						<asp:repeater id="repInspections" runat="server">
							<HeaderTemplate>
								<tr valign="top" class="ag01">
									<td class="ok_size2" colspan="2">Inspection Name</td>
									<td class="ok_size2" align="center" colspan="2">Status</td>
								</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr valign="top" bgcolor="#FFFFCC">
									<td class="ok_size2" align="center" colspan="2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" colspan="2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="middle" bgcolor="#FFF7BE">
									<td class="ok_size2" align="center" colspan="2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" colspan="2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
										</asp:Label>
									</td>
								</tr>
							</AlternatingItemTemplate>
						</asp:repeater>
						<tr>
							<td colSpan="4">
								<table id="html_tblNoneInspections" cellSpacing="0" cellPadding="0" width="100%" border="0"
									runat="server">
									<tr>
										<td class="ok_size2" align="center">None</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br>
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
