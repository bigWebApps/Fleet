<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Page language="c#" Codebehind="ok_reopenWorkOrder.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_reopenWorkOrder" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="3" width="100%" border="0">
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
							<td class="tblSubHead1" align="left" colspan="4">
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
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>' ID="Label1">
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>' ID="Label2">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.IssuesName") %>' ID="Label3">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>' ID="Label4">
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="top" bgcolor="#FFF7BE">
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>' ID="Label5">
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>' ID="Label6">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.IssuesName") %>' ID="Label7">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>' ID="Label8">
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
							<TD class="tblSubHead1" align="left" colSpan="4">Preventive Maintenance Items that 
								were serviced on the work order
							</TD>
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
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>' ID="Label9">
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>' ID="Label10">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceName") %>' ID="Label11">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>' ID="Label12">
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="top" bgcolor="#FFF7BE">
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>' ID="Label13">
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>' ID="Label14">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceName") %>' ID="Label15">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>' ID="Label16">
										</asp:Label>
									</td>
								</tr>
							</AlternatingItemTemplate>
						</asp:repeater>
						<TR>
							<td colSpan="4">
								<table id="html_tblNonePMItems" cellSpacing="0" cellPadding="0" width="100%" border="0"
									runat="server">
									<tr>
										<td align="center" class="ok_size2">None</td>
									</tr>
								</table>
							</td>
						</TR>
						<tr>
							<td colSpan="4"><br>
							</td>
						</tr>
						<tr>
							<td class="tblSubHead1" align="left" colSpan="4">
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
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>' ID="Label17">
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>' ID="Label18">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionItemName") %>' ID="Label19">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>' ID="Label20">
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="top" bgcolor="#FFF7BE">
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>' ID="Label21">
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" nowrap>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>' ID="Label22">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionItemName") %>' ID="Label23">
										</asp:Label>
									</td>
									<td class="ok_size2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairNotes") %>' ID="Label24">
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
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionName") %>' ID="Label25">
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" colspan="2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ID="Label26">
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="middle" bgcolor="#FFF7BE">
									<td class="ok_size2" align="center" colspan="2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionName") %>' ID="Label27">
										</asp:Label>
									</td>
									<td class="ok_size2" align="center" colspan="2">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ID="Label28">
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
				</td>
			</tr>
			<tr>
				<td colspan="2" vAlign="middle" align="center">
					<INPUT id="btnAddIssue" runat="server" class="ok_input_button" type="button" value=" Add New Reported Issue "
						NAME="btnAddIssue" style="width:60%">
				</td>
			</tr>
			<tr>
				<td colspan="2" class="ok_size" align="center">
					And \ Or
				</td>
			</tr>
			<tr>
				<td colspan="2" vAlign="middle" align="center">
					<INPUT id="btnAddComment" runat="server" class="ok_input_button" type="button" value="Add General Comment"
						NAME="btnAddComment" style="width:60%">
				</td>
			</tr>
			<tr>
				<td colspan="2" vAlign="middle" align="center"><BR>
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
