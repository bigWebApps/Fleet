<%@ Register TagPrefix="BFPCntrls" TagName="Signature" Src="controls/Signature.ascx" %>
<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="wo_preview.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_preview" %>
<form id="Form1" method="post" runat="server">
	<table cellSpacing="5" cellPadding="5" width="100%" align="center">
		<tr>
			<td>
				<table class="tblArea" cellSpacing="0" cellPadding="5" width="100%" border="1">
					<tr>
						<td class="tblSubHead1" align="center">General Information
						</td>
					</tr>
					<tr>
						<td>
							<table cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="top">
									<td width="50%"> <!-- left column -->
										<table width="100%">
											<tr>
												<TD colSpan="2">
													<table cellSpacing="0" cellPadding="0" width="100%" border="0">
														<tr>
															<td class="tblSubHead2" align="left">Work Order Info&nbsp;&nbsp;&nbsp;
															</td>
														</tr>
													</table>
												</TD>
											</tr>
											<TR vAlign="top">
												<td class="bg01">Work Order #</td>
												<td class="bg02" width="66%"><asp:label id="lblWorkOrderN" runat="server" Font-Underline="True"></asp:label></td>
											</TR>
											<TR>
												<TD class="bg01">Type</TD>
												<TD class="bg02">
													<asp:label id="lblWOType" runat="server"></asp:label></TD>
											</TR>
											<tr vAlign="top">
												<td class="bg01">Status</td>
												<td class="bg02"><asp:label id="lblStatus" runat="server"></asp:label></td>
											</tr>
											<TR>
												<TD class="bg01">Operator Status</TD>
												<TD class="bg02"><asp:label id="lblOperatorStatus" runat="server"></asp:label></TD>
											</TR>
											<tr vAlign="top">
												<td class="bg01">Operator</td>
												<td class="bg02"><asp:label id="lblOperator" runat="server"></asp:label></td>
											</tr>
											<tr vAlign="top">
												<td class="bg01">Is the Operator Staying?</td>
												<td class="bg02"><asp:label id="lblStaying" runat="server"></asp:label></td>
											</tr>
											<tr vAlign="top">
												<td class="bg01">Spare equipment</td>
												<td class="bg02"><asp:label id="lblSpare" runat="server"></asp:label></td>
											</tr>
											<tr vAlign="top">
												<td class="bg01">Assign technician</td>
												<td class="bg02"><asp:label id="lblTech" runat="server"></asp:label></td>
											</tr>
											<tr vAlign="top">
												<td class="bg01">Dropped Off By</td>
												<td class="bg02"><asp:label id="lblDroppedOffBy" runat="server"></asp:label></td>
											</tr>
											<TR>
												<TD class="bg01">Scheduled Date</TD>
												<TD class="bg02"><asp:label id="lblScheduledDate" runat="server"></asp:label></TD>
											</TR>
											<tr vAlign="top">
												<td class="bg01">Check-In Date</td>
												<td class="bg02"><asp:label id="lblArrivalDate" runat="server"></asp:label></td>
											</tr>
										</table>
									</td>
									<td width="50%"> <!-- right column -->
										<table width="100%">
											<tr>
												<td colSpan="2">
													<table cellSpacing="0" cellPadding="0" width="100%" border="0">
														<tr>
															<td class="tblSubHead2">Equipment Info</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr vAlign="top">
												<td class="bg01">Equipment #</td>
												<td class="bg02"><asp:hyperlink id="hlEquipId" runat="server" Target="_blank"></asp:hyperlink></td>
											</tr>
											<TR>
												<TD class="bg01">Type</TD>
												<TD class="bg02"><asp:label id="lblType" runat="server"></asp:label></TD>
											</TR>
											<TR>
												<TD class="bg01">Make/Model</TD>
												<TD class="bg02"><asp:label id="lblMakeModel" runat="server"></asp:label></TD>
											</TR>
											<TR>
												<TD class="bg01">Year</TD>
												<TD class="bg02"><asp:label id="lblYear" runat="server"></asp:label></TD>
											</TR>
											<TR>
												<td class="bg01">Units (Mileage)</td>
												<td class="bg02"><asp:label id="lblUnits" runat="server"></asp:label></td>
											</TR>
											<!-- here variable fileds --><asp:repeater id="repCustomFields" runat="server">
												<HeaderTemplate>
													<tr>
														<td colSpan="2">
															<table cellSpacing="0" cellPadding="0" width="100%" border="0">
																<tr>
																	<td class="tblSubHead2">Custom Fields</td>
																</tr>
															</table>
														</td>
													</tr>
												</HeaderTemplate>
												<ItemTemplate>
													<TR>
														<TD class="bg01">
															<asp:Label id="lblValueName" runat="server">
																<%# DataBinder.Eval(Container, "DataItem.ValueName") %>
															</asp:Label>
														</TD>
														<TD class="bg02">
															<asp:Label id="lblValue" runat="server">
																<%# DataBinder.Eval(Container, "DataItem.Value") %>
															</asp:Label></TD>
													</TR>
												</ItemTemplate>
											</asp:repeater></table>
									</td>
								</TR>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table class="tblArea" cellSpacing="0" cellPadding="5" width="100%" border="1">
					<tr>
						<td class="tblSubHead1" align="center">
							Operations
						</td>
					</tr>
					<tr>
						<td>
							<table cellSpacing="0" cellPadding="2" width="100%" border="0">
								<tr vAlign="middle">
									<td><asp:hyperlink id="hlStart" runat="server" Font-Bold="True">[Back to the Open Work Order screen]</asp:hyperlink></td>
									<td><asp:hyperlink id="hlPMItems" runat="server" NavigateUrl="wo_addPreventiveMaintenance.aspx" Font-Bold="True">[Back to the PM Items screen]</asp:hyperlink></td>
								</tr>
								<tr vAlign="middle">
									<td><asp:hyperlink id="hlIssues" runat="server" NavigateUrl="wo_addRepairs.aspx" Font-Bold="True">[Back to the Reported Issues screen]</asp:hyperlink></td>
									<td><asp:hyperlink id="hlInspections" runat="server" NavigateUrl="wo_addInspections.aspx" Font-Bold="True">[Back to the Inspections screen]</asp:hyperlink></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table class="tblArea" cellSpacing="0" cellPadding="5" width="100%" border="1">
					<tr>
						<td class="tblSubHead1" align="center">
							Service Issues
						</td>
					</tr>
					<tr>
						<td colSpan="2">
							<table class="tblMicajah" borderColor="#9e755f" cellSpacing="0" cellPadding="1" width="100%"
								border="1">
								<tr>
									<td class="tblSubHead2" align="left" colSpan="5" height="24">Reported Issues
									</td>
								</tr>
								<asp:repeater id="repIssues" runat="server">
									<HeaderTemplate>
										<tr valign="middle" class="ag01">
											<td align="left">Category</td>
											<td align="left">Issue</td>
											<td align="center" colspan="3">Date Report</td>
										</tr>
									</HeaderTemplate>
									<ItemTemplate>
										<tr valign="middle" bgcolor="#FFFFCC">
											<td align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
												</asp:Label>
											</td>
											<td align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
												</asp:Label>
											</td>
											<td align="center" colspan="3">
												<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.ReportDate")).ToString("yyyy-MM-dd") %>'>
												</asp:Label>
											</td>
										</tr>
									</ItemTemplate>
									<AlternatingItemTemplate>
										<tr valign="middle" bgcolor="#FFF7BE">
											<td align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
												</asp:Label>
											</td>
											<td align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
												</asp:Label>
											</td>
											<td align="center" colspan="3">
												<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.ReportDate")).ToString("yyyy-MM-dd") %>'>
												</asp:Label>
											</td>
										</tr>
									</AlternatingItemTemplate>
								</asp:repeater>
								<tr>
									<td colSpan="5">
										<table id="html_tblNoneIssues" cellSpacing="0" cellPadding="0" width="100%" border="0"
											runat="server">
											<tr>
												<td align="center">None</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td colSpan="5"><br>
									</td>
								</tr>
								<tr>
									<td class="tblSubHead2" align="left" colSpan="5">Preventive Maintenance 
										Items&nbsp;&nbsp;&nbsp;
									</td>
								</tr>
								<asp:repeater id="repPMItems" runat="server">
									<HeaderTemplate>
										<tr valign="middle" class="ag01">
											<td align="left">Category</td>
											<td align="left">Issue</td>
											<td align="center">Status</td>
											<td align="center">Units Left</td>
											<td align="center">Date Due</td>
										</tr>
									</HeaderTemplate>
									<ItemTemplate>
										<tr valign="middle" bgcolor="#FFFFCC">
											<td align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
											<td align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
											<td align="center">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
											<td align="center">
												<asp:Label runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.UnitsVisibleLast")) %>' Text='<%# DataBinder.Eval(Container, "DataItem.UnitsDue") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
											<td align="center">
												<asp:Label runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.DaysVisibleLast")) %>' Text='<%# DataBinder.Eval(Container, "DataItem.DateDue") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
										</tr>
									</ItemTemplate>
									<AlternatingItemTemplate>
										<tr valign="middle" bgcolor="#FFF7BE">
											<td align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
											<td align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
											<td align="center">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
											<td align="center">
												<asp:Label runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.UnitsVisibleLast")) %>' Text='<%# DataBinder.Eval(Container, "DataItem.UnitsDue") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
											<td align="center">
												<asp:Label runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.DaysVisibleLast")) %>' Text='<%# DataBinder.Eval(Container, "DataItem.DateDue") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
										</tr>
									</AlternatingItemTemplate>
								</asp:repeater>
								<TR>
									<TD colSpan="5">
										<TABLE id="html_tblNonePMItems" cellSpacing="0" cellPadding="0" width="100%" border="0"
											runat="server">
											<TR>
												<TD align="center">None</TD>
											</TR>
										</TABLE>
									</TD>
								</TR>
								<TR>
									<TD colSpan="5"><BR>
									</TD>
								</TR>
								<tr>
								<tr>
									<td class="tblSubHead2" align="left" colSpan="5">Inspections&nbsp;&nbsp;&nbsp;
									</td>
								</tr>
								<asp:repeater id="repInspections" runat="server">
									<HeaderTemplate>
										<tr valign="middle" class="ag01">
											<td colspan="2" align="left">Name</td>
											<td align="center">Status</td>
											<td align="center" colspan="2">Date Due</td>
										</tr>
									</HeaderTemplate>
									<ItemTemplate>
										<tr valign="middle" bgcolor="#FFFFCC">
											<td colspan="2" align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
											<td align="center">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
											<td align="center" colspan="2">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DateDue") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
												</asp:Label>
											</td>
										</tr>
									</ItemTemplate>
									<AlternatingItemTemplate>
										<tr valign="middle" bgcolor="#FFF7BE">
											<td colspan="2" align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>' ID="Label1" NAME="Label1">
												</asp:Label>
											</td>
											<td align="center">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>' ID="Label2" NAME="Label2">
												</asp:Label>
											</td>
											<td align="center" colspan="2">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DateDue") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>' ID="Label3" NAME="Label3">
												</asp:Label>
											</td>
										</tr>
									</AlternatingItemTemplate>
								</asp:repeater>
								<tr>
									<td colSpan="5">
										<table id="html_tblNoneInspections" cellSpacing="0" cellPadding="0" width="100%" border="0"
											runat="server">
											<tr>
												<td align="center">None</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table class="tblArea" cellSpacing="0" cellPadding="5" width="100%" border="1">
					<tr>
						<td class="tblSubHead1" align="center">
							Notes
						</td>
					</tr>
					<tr>
						<td>
							<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<asp:repeater id="repCreationNotes" runat="server">
									<HeaderTemplate>
										<tr>
											<td colspan="2" class="tblSubHead2">Creation Notes
											</td>
										</tr>
									</HeaderTemplate>
									<ItemTemplate>
										<tr bgcolor="#CCCCCC">
											<td align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserName") %>'>
												</asp:Label>
											</td>
											<td align="right">
												<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.CreatedDate")).ToString("yyyy-MM-dd hh:mm tt") %>'>
												</asp:Label>
											</td>
										</tr>
										<tr>
											<td align="left" colspan="2">
												<asp:label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Note") %>'>
												</asp:label>
											</td>
										</tr>
										<tr>
											<td colspan="2"><br>
											</td>
										</tr>
									</ItemTemplate>
								</asp:repeater>
								<tr>
									<td colspan="2"><br>
									</td>
								</tr>
								<asp:repeater id="repOperatorNotes" runat="server">
									<HeaderTemplate>
										<tr>
											<td colspan="2" class="tblSubHead2">Operator's Notes
											</td>
										</tr>
									</HeaderTemplate>
									<ItemTemplate>
										<tr bgcolor="#CCCCCC">
											<td align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserName") %>'>
												</asp:Label>
											</td>
											<td align="right">
												<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.CreatedDate")).ToString("yyyy-MM-dd hh:mm tt") %>'>
												</asp:Label>
											</td>
										</tr>
										<tr>
											<td align="left" colspan="2">
												<asp:label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Note") %>'>
												</asp:label>
											</td>
										</tr>
										<tr>
											<td colspan="2"><br>
											</td>
										</tr>
									</ItemTemplate>
								</asp:repeater>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table class="tblArea" cellSpacing="0" cellPadding="5" width="100%" border="1">
					<tr>
						<td class="tblSubHead1" align="center">
							Signatures
						</td>
					</tr>
					<tr>
						<td>
							<BFPCNTRLS:Signature id="Signature" runat="server"></BFPCNTRLS:Signature>
						</td>
					</tr>
				</table>
		<tr>
			<td align="center"><uc1:nextback id="NextBackControl" runat="server"></uc1:nextback></td>
		</tr>
	</table>
</form>
