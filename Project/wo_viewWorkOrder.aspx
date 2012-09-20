<%@ Page Language="c#" CodeBehind="wo_viewWorkOrder.aspx.cs" AutoEventWireup="false"
    Inherits="BWA.BFP.Web.workorder._wo_viewWorkOrder" %>

<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<form id="formViewWorkOrder" method="post" runat="server">
<table cellspacing="5" cellpadding="5" width="100%" align="center">
    <tbody>
        <tr>
            <td>
                <a name="Main"></a>
                <table class="tblArea" cellspacing="0" cellpadding="5" width="100%" border="1">
                    <tr>
                        <td class="tblSubHead1" align="center">
                            General Information
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr valign="top">
                                    <td width="50%">
                                        <!-- left column -->
                                        <table width="100%">
                                            <tr>
                                                <td colspan="2">
                                                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                        <tr>
                                                            <td class="tblSubHead2" align="left">
                                                                Work Order Information
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td class="bg01">
                                                    Work Order #
                                                </td>
                                                <td class="bg02" width="66%">
                                                    <asp:label id="lblWorkOrderN" runat="server" font-underline="True"></asp:label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg01">
                                                    Type
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblWOType" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td class="bg01">
                                                    Status
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblStatus" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg01">
                                                    Operator Status
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblOperatorStatus" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td class="bg01">
                                                    Operator
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblOperator" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td class="bg01">
                                                    Is the Operator Staying?
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblStaying" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td class="bg01">
                                                    Spare equipment
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblSpare" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td class="bg01">
                                                    Assign technician
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblTech" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td class="bg01">
                                                    Dropped Off By
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblDroppedOffBy" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td class="bg01">
                                                    Released To
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblReleasedTo" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg01">
                                                    Equipment Cleanliness
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblCleanliness" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg01">
                                                    Service Dates
                                                </td>
                                                <td class="bg02">
                                                    <asp:hyperlink id="hlServiceDates" style="cursor: pointer" runat="server">[view dates]</asp:hyperlink>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td width="50%">
                                        <!-- right column -->
                                        <table width="100%">
                                            <tr>
                                                <td colspan="2">
                                                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                        <tr>
                                                            <td class="tblSubHead2">
                                                                Equipment Information
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td class="bg01">
                                                    Equipment #
                                                </td>
                                                <td class="bg02" width="66%">
                                                    <asp:hyperlink id="hlEquipId" runat="server" target="_blank"></asp:hyperlink>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg01">
                                                    Type
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblType" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg01">
                                                    Make/Model
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblMakeModel" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg01">
                                                    Year
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblYear" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg01">
                                                    VIN/Serial #
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblSerial" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg01">
                                                    Units (Mileage)
                                                </td>
                                                <td class="bg02">
                                                    <asp:label id="lblUnits" runat="server"></asp:label>
                                                </td>
                                            </tr>
                                            <!-- here variable fileds -->
                                            <asp:repeater id="repCustomFields" runat="server">
													<HeaderTemplate>
														<tr>
															<td colSpan="2">
																<table cellSpacing="0" cellPadding="0" width="100%" border="0">
																	<tr>
																		<td class="tblSubHead2">Custom Information</td>
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
																</asp:Label>
															</TD>
														</TR>
													</ItemTemplate>
												</asp:repeater>
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
                <a name="Operation"></a>
                <table class="tblArea" cellspacing="0" cellpadding="5" width="100%" border="1">
                    <tr>
                        <td class="tblSubHead1" align="center">
                            Operations
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellspacing="0" cellpadding="2" width="100%" border="0">
                                <tr>
                                    <td class="tblSubHead2">
                                        Work Order Operations
                                    </td>
                                </tr>
                                <tr valign="middle">
                                    <td>
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td align="left">
                                                    <asp:hyperlink id="hlMainEdit" runat="server" font-bold="True" navigateurl="wo_editWorkOrder.aspx"
                                                        enabled="False"> [Edit Work Order]</asp:hyperlink>
                                                </td>
                                                <td align="center">
                                                    <asp:hyperlink id="hlOpenOrder" runat="server" font-bold="True" navigateurl="wo_openWorkOrder.aspx"
                                                        enabled="False"> [Open Work Order]</asp:hyperlink>
                                                </td>
                                                <td align="center">
                                                    <asp:hyperlink id="hlCloseOrder" runat="server" font-bold="True" navigateurl="wo_completeWorkOrder.aspx"
                                                        enabled="False"> [Close Work Order]</asp:hyperlink>
                                                </td>
                                                <td align="right">
                                                    <asp:hyperlink id="hlDeleteOrder" runat="server" font-bold="True" navigateurl="wo_viewCheckOut.aspx"
                                                        enabled="False"> [Delete  Work Order]</asp:hyperlink>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tblSubHead2" colspan="4">
                                        Equipment Operations
                                    </td>
                                </tr>
                                <tr valign="middle">
                                    <td>
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td align="left" width="33%">
                                                    <asp:hyperlink id="hlCheckIn" runat="server" font-bold="True" navigateurl="wo_viewCheckIn.aspx"
                                                        enabled="False"> [Arrival Check-In]</asp:hyperlink>
                                                </td>
                                                <td align="center" width="34%">
                                                    <asp:hyperlink id="hlCheckOut" runat="server" font-bold="True" navigateurl="wo_viewCheckOut.aspx"
                                                        enabled="False"> [Departure Check-Out]</asp:hyperlink>
                                                </td>
                                                <td align="right" width="33%">
                                                    <asp:hyperlink id="hlTimeLog" runat="server" font-bold="True" navigateurl="wo_updateTimeLog.aspx"
                                                        enabled="False"> [Time Tracking Log]</asp:hyperlink>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tblSubHead2" colspan="3">
                                        Issues Operations
                                    </td>
                                </tr>
                                <tr valign="middle">
                                    <td>
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td align="left" width="33%">
                                                    <asp:hyperlink id="hlReportedIssues" runat="server" font-bold="True" navigateurl="wo_addRepairs.aspx"
                                                        enabled="False" tooltip="Issues adding/editing/removing"> [Add/Edit/Remove Reported Issues]</asp:hyperlink>
                                                </td>
                                                <td align="center" width="34%">
                                                    <asp:hyperlink id="hlPMItems" runat="server" font-bold="True" navigateurl="wo_addPreventiveMaintenance.aspx"
                                                        enabled="False" tooltip="PM Items adding/removing"> [Add/Remove Preventive Maintenances]</asp:hyperlink>
                                                </td>
                                                <td align="right" width="33%">
                                                    <asp:hyperlink id="hlInspections" runat="server" font-bold="True" navigateurl="wo_addInspections.aspx"
                                                        enabled="False" tooltip="Inspections adding/removing"> [Add/Remove Inspections]</asp:hyperlink>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tblSubHead2" colspan="3">
                                        Print Operations
                                    </td>
                                </tr>
                                <tr valign="middle">
                                    <td>
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td align="left" width="33%">
                                                    <asp:hyperlink id="hlPrintOrderRequest" runat="server" target="_blank" font-bold="True"
                                                        enabled="False"> [Print Work Order Request]</asp:hyperlink>
                                                </td>
                                                <td align="center" width="34%">
                                                    <asp:hyperlink id="hlPrintPartUsed" runat="server" target="_blank" font-bold="True"
                                                        enabled="False"> [Print Parts Used]</asp:hyperlink>
                                                </td>
                                                <td align="right" width="33%">
                                                    <asp:hyperlink id="hlPrintCompletedOrder" runat="server" target="_blank" font-bold="True"
                                                        enabled="False"> [Print Closed Work Order]</asp:hyperlink>
                                                </td>
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
                <a name="Issues"></a>
                <table class="tblArea" cellspacing="0" cellpadding="5" width="100%" border="1">
                    <tr>
                        <td class="tblSubHead1" align="center">
                            Service Issues
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table class="tblMicajah" bordercolor="#9e755f" cellspacing="0" cellpadding="1" width="100%"
                                border="1">
                                <tr>
                                    <td class="tblSubHead2" align="left" colspan="4">
                                        Reported Issues&nbsp;&nbsp;
                                    </td>
                                    <td class="tblSubHead2" nowrap align="center" colspan="3">
                                        Check Status
                                    </td>
                                    <td class="tblSubHead2" nowrap align="center" colspan="3">
                                        Repair Status
                                    </td>
                                    <td class="tblSubHead2" nowrap align="right">
                                    </td>
                                </tr>
                                <asp:repeater id="repIssues" runat="server">
										<HeaderTemplate>
											<tr valign="middle" class="ag01">
												<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
												<td align="left">Category</td>
												<td align="left">Issue</td>
												<td align="center">Summary</td>
												<td align="center">&nbsp;OK&nbsp;</td>
												<td align="center">&nbsp;FAIR&nbsp;</td>
												<td align="center">Repairs<br>
													Needed</td>
												<td align="center">No<br>
													Service</td>
												<td align="center">Repaired</td>
												<td align="center">Replaced</td>
												<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
											</tr>
										</HeaderTemplate>
										<ItemTemplate>
											<tr valign="middle" bgcolor="#FFFFCC">
												<td align="center">
													<asp:Image runat="server" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.IsProcessed") %>'>
													</asp:Image>
													<asp:Label id="IssueId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
													</asp:Label>
													<asp:Label id="ServiceCheckId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceCheckId") %>'>
													</asp:Label>
													<asp:Label id="ServiceResultId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceResultId") %>'>
													</asp:Label>
												</td>
												<td align="left">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
													</asp:Label>
												</td>
												<td align="left">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.IssuesName") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="OK" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.OkayStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="FAIR" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.FairStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="RepairNeeded" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.RNStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="NoService" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.NSStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<asp:ImageButton runat="server" CommandName="Repaired" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.RepairedStatus") %>' CausesValidation="False">
													</asp:ImageButton>
												</td>
												<td align="center">
													<asp:ImageButton runat="server" CommandName="Replaced" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.ReplacedStatus") %>' CausesValidation="False">
													</asp:ImageButton>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.RemoveConfirmation") %>'>
														<asp:LinkButton runat="server" Text="[remove]" CommandName="Delete" CausesValidation="false" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' ID="Linkbutton1" NAME="Linkbutton1">
														</asp:LinkButton>
													</span>
												</td>
											</tr>
										</ItemTemplate>
										<AlternatingItemTemplate>
											<tr valign="middle" bgcolor="#FFF7BE">
												<td align="center">
													<asp:Image runat="server" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.IsProcessed") %>'>
													</asp:Image>
													<asp:Label id="IssueId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
													</asp:Label>
													<asp:Label id="ServiceCheckId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceCheckId") %>'>
													</asp:Label>
													<asp:Label id="ServiceResultId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceResultId") %>'>
													</asp:Label>
												</td>
												<td align="left">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
													</asp:Label>
												</td>
												<td align="left">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.IssuesName") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="OK" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.OkayStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="FAIR" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.FairStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="RepairNeeded" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.RNStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="NoService" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.NSStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<asp:ImageButton runat="server" CommandName="Repaired" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.RepairedStatus") %>' CausesValidation="False">
													</asp:ImageButton>
												</td>
												<td align="center">
													<asp:ImageButton runat="server" CommandName="Replaced" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.ReplacedStatus") %>' CausesValidation="False">
													</asp:ImageButton>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.RemoveConfirmation") %>'>
														<asp:LinkButton runat="server" Text="[remove]" CommandName="Delete" CausesValidation="false" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
														</asp:LinkButton>
													</span>
												</td>
											</tr>
										</AlternatingItemTemplate>
									</asp:repeater>
                                <tr>
                                    <td colspan="11">
                                        <table id="html_tblNoneIssues" cellspacing="0" cellpadding="0" width="100%" border="0"
                                            runat="server">
                                            <tr>
                                                <td align="center">
                                                    None
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="11">
                                        <br>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tblSubHead2" align="left" colspan="4">
                                        Preventive Maintenance Items
                                    </td>
                                    <td class="tblSubHead2" nowrap align="center" colspan="3">
                                        Check Status
                                    </td>
                                    <td class="tblSubHead2" nowrap align="center" colspan="3">
                                        Repair Status
                                    </td>
                                    <td class="tblSubHead2" nowrap align="right">
                                    </td>
                                </tr>
                                <asp:repeater id="repPMItems" runat="server">
										<HeaderTemplate>
											<tr valign="middle" class="ag01">
												<td></td>
												<td align="left">Category</td>
												<td align="left">Issue</td>
												<td align="center">Summary</td>
												<td align="center">OK</td>
												<td align="center">FAIR</td>
												<td align="center">Repairs<br>
													Needed</td>
												<td align="center">No<br>
													Service</td>
												<td align="center">Repaired</td>
												<td align="center">Replaced</td>
												<td></td>
											</tr>
										</HeaderTemplate>
										<ItemTemplate>
											<tr valign="middle" bgcolor="#FFFFCC">
												<td align="center">
													<asp:Image runat="server" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.IsProcessed") %>'>
													</asp:Image>
													<asp:Label id="PMItemId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
													</asp:Label>
													<asp:Label id="ServiceCheckId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceCheckId") %>'>
													</asp:Label>
													<asp:Label id="ServiceResultId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceResultId") %>'>
													</asp:Label>
												</td>
												<td align="left">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
													</asp:Label>
												</td>
												<td align="left">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceName") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="OK" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.OkayStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="FAIR" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.FairStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="RepairNeeded" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.RNStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="NoService" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.NSStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<asp:ImageButton runat="server" CommandName="Repaired" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.RepairedStatus") %>' CausesValidation="False">
													</asp:ImageButton>
												</td>
												<td align="center">
													<asp:ImageButton runat="server" CommandName="Replaced" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.ReplacedStatus") %>' CausesValidation="False">
													</asp:ImageButton>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.RemoveConfirmation") %>'>
														<asp:LinkButton runat="server" Text="[remove]" CommandName="Delete" CausesValidation="false" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
														</asp:LinkButton>
													</span>
												</td>
											</tr>
										</ItemTemplate>
										<AlternatingItemTemplate>
											<tr valign="middle" bgcolor="#FFF7BE">
												<td align="center">
													<asp:Image runat="server" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.IsProcessed") %>'>
													</asp:Image>
													<asp:Label id="PMItemId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
													</asp:Label>
													<asp:Label id="ServiceCheckId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceCheckId") %>'>
													</asp:Label>
													<asp:Label id="ServiceResultId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceResultId") %>'>
													</asp:Label>
												</td>
												<td align="left">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
													</asp:Label>
												</td>
												<td align="left">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceName") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="OK" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.OkayStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="FAIR" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.FairStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="RepairNeeded" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.RNStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:ImageButton runat="server" CommandName="NoService" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.NSStatus") %>' CausesValidation="False">
														</asp:ImageButton>
													</span>
												</td>
												<td align="center">
													<asp:ImageButton runat="server" CommandName="Repaired" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.RepairedStatus") %>' CausesValidation="False">
													</asp:ImageButton>
												</td>
												<td align="center">
													<asp:ImageButton runat="server" CommandName="Replaced" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessResult")) %>' CssClass="CURSOR:pointer" ImageAlign="Middle" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.ReplacedStatus") %>' CausesValidation="False">
													</asp:ImageButton>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.RemoveConfirmation") %>'>
														<asp:LinkButton runat="server" Text="[remove]" CommandName="Delete" CausesValidation="false" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
														</asp:LinkButton>
													</span>
												</td>
											</tr>
										</AlternatingItemTemplate>
									</asp:repeater>
                                <tr>
                                    <td colspan="11">
                                        <table id="html_tblNonePMItems" cellspacing="0" cellpadding="0" width="100%" border="0"
                                            runat="server">
                                            <tr>
                                                <td align="center">
                                                    None
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="11">
                                        <br>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tblSubHead2" align="left" colspan="11">
                                        Inspections
                                    </td>
                                </tr>
                                <asp:repeater id="repInspections" runat="server">
										<HeaderTemplate>
											<tr valign="middle" class="ag01">
												<td></td>
												<td colspan="2" align="left">Name</td>
												<td align="center">Summary</td>
												<td colspan="6"></td>
												<td></td>
											</tr>
										</HeaderTemplate>
										<ItemTemplate>
											<tr valign="middle" bgcolor="#FFFFCC">
												<td align="center">
													<asp:Image runat="server" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.IsProcessed") %>'>
													</asp:Image>
												</td>
												<td colspan="2" align="left">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionName") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
													</asp:Label>
												</td>
												<td align="center" colspan="6">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.Confirmation") %>'>
														<asp:LinkButton runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LinkName") %>' CommandName="Complete" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' ToolTip="executing of inspection">
														</asp:LinkButton>
													</span>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.RemoveConfirmation") %>'>
														<asp:LinkButton runat="server" Text="[remove]" CommandName="Delete" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
														</asp:LinkButton>
													</span>
												</td>
											</tr>
										</ItemTemplate>
										<AlternatingItemTemplate>
											<tr valign="middle" bgcolor="#FFF7BE">
												<td align="center">
													<asp:Image runat="server" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.IsProcessed") %>'>
													</asp:Image>
												</td>
												<td colspan="2" align="left">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionName") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
													</asp:Label>
												</td>
												<td align="center" colspan="6">
													<asp:HyperLink runat="server" NavigateUrl='<%# "wo_viewCompleteInspection.aspx?id=" + DataBinder.Eval(Container, "DataItem.OrderId") + "&inspectid=" + DataBinder.Eval(Container, "DataItem.Id") %>' ToolTip="executing of inspection" Text='<%# DataBinder.Eval(Container, "DataItem.LinkName") %>'>
													</asp:HyperLink>
												</td>
												<td align="center">
													<span onclick='<%# DataBinder.Eval(Container, "DataItem.RemoveConfirmation") %>'>
														<asp:LinkButton runat="server" Text="[remove]" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' CommandName="Delete" CausesValidation="false" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
														</asp:LinkButton>
													</span>
												</td>
											</tr>
										</AlternatingItemTemplate>
									</asp:repeater>
                                <tr>
                                    <td colspan="11">
                                        <table id="html_tblNoneInspections" cellspacing="0" cellpadding="0" width="100%"
                                            border="0" runat="server">
                                            <tr>
                                                <td align="center">
                                                    None
                                                </td>
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
                <a name="Repairs"></a>
                <table class="tblArea" cellspacing="0" cellpadding="5" width="100%" border="1">
                    <tbody>
                        <tr>
                            <td class="tblSubHead1" align="center">
                                Serviced Repairs
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tbody>
                                        <tr>
                                            <td colspan="2">
                                                <table cellspacing="-1" cellpadding="-1" width="100%" border="0">
                                                    <tr>
                                                        <td class="tblSubHead2" align="left">
                                                            Repairs
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:repeater id="repRepairs" runat="server">
														<HeaderTemplate>
															<table class="tblMicajah" cellSpacing="0" cellPadding="1" border="1" width="100%">
																<tr valign="middle" class="ag01">
																	<td>Category</td>
																	<td>Repair Item</td>
																	<td>Description</td>
																	<td></td>
																	<td></td>
																</tr>
														</HeaderTemplate>
														<ItemTemplate>
															<tr valign="middle" bgcolor="#FFFFCC">
																<td>
																	<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
																	</asp:Label>
																</td>
																<td>
																	<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ItemName") %>'>
																	</asp:Label>
																</td>
																<td>
																	<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairDesc") %>'>
																	</asp:Label>
																</td>
																<td align="center">
																	<asp:HyperLink runat="server" Text="[edit]" NavigateUrl='<%# "wo_updateRepair.aspx?mode=Edit&inspectid=0&type=NULL&itemid=0&op=NULL&id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OrderId")) + "&repairid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id"))%>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
																	</asp:HyperLink>
																</td>
																<td align="center">
																	<span onclick='<%# DataBinder.Eval(Container, "DataItem.RemoveConfirmation") %>'>
																		<asp:LinkButton runat="server" Text="[remove]" CommandName="Delete" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.EnableRemoveButton")) %>'>
																		</asp:LinkButton>
																	</span>
																</td>
															</tr>
														</ItemTemplate>
														<AlternatingItemTemplate>
															<tr valign="middle" bgcolor="#FFF7BE">
																<td>
																	<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
																	</asp:Label>
																</td>
																<td>
																	<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ItemName") %>'>
																	</asp:Label>
																</td>
																<td>
																	<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairDesc") %>'>
																	</asp:Label>
																</td>
																<td align="center">
																	<asp:HyperLink runat="server" Text="[edit]" NavigateUrl='<%# "wo_updateRepair.aspx?mode=Edit&inspectid=0&type=NULL&itemid=0&op=NULL&id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OrderId")) + "&repairid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id"))%>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
																	</asp:HyperLink>
																</td>
																<td align="center">
																	<span onclick='<%# DataBinder.Eval(Container, "DataItem.RemoveConfirmation") %>'>
																		<asp:LinkButton runat="server" Text="[remove]" CommandName="Delete" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.EnableRemoveButton")) %>'>
																		</asp:LinkButton>
																	</span>
																</td>
															</tr>
														</AlternatingItemTemplate>
														<FooterTemplate>
                                </table>
                                </FooterTemplate> </asp:repeater>
                                <table id="html_tblNoneRepairs" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                                    border-left: #000000 1px solid; border-bottom: #000000 1px solid" width="100%"
                                    runat="server">
                                    <tr>
                                        <td align="center">
                                            None
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table cellspacing="-1" cellpadding="-1" width="100%" border="0">
                                    <tr>
                                        <td class="tblSubHead2" align="left">
                                            Parts Used
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:repeater id="repPartsUsed" runat="server">
										<HeaderTemplate>
											<table class="tblMicajah" cellSpacing="0" cellPadding="1" border="1" width="100%">
												<tr valign="middle" class="ag01">
													<td align="center">Qty</td>
													<td align="center">Mfg#</td>
													<td>Desc</td>
													<td align="center">Cost</td>
													<td></td>
												</tr>
										</HeaderTemplate>
										<ItemTemplate>
											<tr valign="middle" bgcolor="#FFFFCC">
												<td align="center">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Qty") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Stock") %>'>
													</asp:Label>
												</td>
												<td>
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Desc") %>'>
													</asp:Label>
												</td>
												<td align="center">
									                <asp:Label runat="server" Text='<%# "$" + Convert.ToString(Convert.ToDecimal(DataBinder.Eval(Container, "DataItem.Cost")) * Convert.ToInt32(DataBinder.Eval(Container, "DataItem.Qty"))) %>'>
									                </asp:Label>
												</td>
												<td align="center">
													<asp:HyperLink runat="server" Text="[edit]" NavigateUrl='<%# "wo_updateRepair.aspx?mode=Edit&inspectid=0&type=NULL&itemid=0&op=NULL&id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OrderId")) + "&repairid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.RepairId"))%>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
													</asp:HyperLink>
												</td>
											</tr>
										</ItemTemplate>
										<AlternatingItemTemplate>
											<tr valign="middle" bgcolor="#FFF7BE">
												<td align="center">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Qty") %>'>
													</asp:Label>
												</td>
												<td align="center">
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Stock") %>'>
													</asp:Label>
												</td>
												<td>
													<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Desc") %>'>
													</asp:Label>
												</td>
												<td align="center">
									                <asp:Label runat="server" Text='<%# "$" + Convert.ToString(Convert.ToDecimal(DataBinder.Eval(Container, "DataItem.Cost")) * Convert.ToInt32(DataBinder.Eval(Container, "DataItem.Qty"))) %>'>
									                </asp:Label>
												</td>
												<td align="center">
													<asp:HyperLink runat="server" Text="[edit]" NavigateUrl='<%# "wo_updateRepair.aspx?mode=Edit&inspectid=0&type=NULL&itemid=0&op=NULL&id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OrderId")) + "&repairid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.RepairId"))%>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
													</asp:HyperLink>
												</td>
											</tr>
										</AlternatingItemTemplate>
										<FooterTemplate>
                </table>
                </FooterTemplate> </asp:repeater>
                <table id="html_tblNoneParts" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                    border-left: #000000 1px solid; border-bottom: #000000 1px solid" width="100%"
                    runat="server">
                    <tr>
                        <td align="center">
                            None
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <br>
                <asp:hyperlink id="hlAddRepair" runat="server" font-bold="True" navigateurl="wo_updateRepair.aspx"
                    enabled="False">[Add a Repair]</asp:hyperlink>
            </td>
        </tr>
    </tbody>
</table>
</TD></TR></TBODY></TABLE></TD></TR>
<tr>
    <td>
        <a name="TimeLog"></a>
        <table class="tblArea" cellspacing="0" cellpadding="5" width="100%" border="1">
            <tr>
                <td class="tblSubHead1" align="center">
                    Technician's Time Tracking Log
                </td>
            </tr>
            <tr>
                <td>
                    <table class="tblStandard" bordercolor="#9e755f" cellspacing="0" cellpadding="1"
                        width="100%" border="1">
                        <tr class="ag01" valign="middle">
                            <td>
                                Date
                            </td>
                            <td>
                                Start/Stop Times
                            </td>
                            <td>
                                HH:MM
                            </td>
                            <td>
                                Technician
                            </td>
                            <td>
                                Serviced Repair
                            </td>
                            <td>
                                Note
                            </td>
                        </tr>
                        <asp:repeater id="repTimeLog" runat="server">
								<ItemTemplate>
									<tr valign="middle" bgcolor="#FFFFCC">
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtCreatedDate") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtStartTime") %>'>
											</asp:Label>&nbsp;
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtStopTime") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Hours") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairName") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchNote") %>'>
											</asp:Label>
										</td>
									</tr>
								</ItemTemplate>
								<AlternatingItemTemplate>
									<tr valign="middle" bgcolor="#FFF7BE">
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtCreatedDate") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtStartTime") %>'>
											</asp:Label>&nbsp;
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtStopTime") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Hours") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairName") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchNote") %>'>
											</asp:Label>
										</td>
									</tr>
								</AlternatingItemTemplate>
							</asp:repeater>
                        <tr id="html_trTotalHours" runat="server">
                            <td align="right" colspan="3">
                                Total Hours :
                            </td>
                            <td align="right">
                                <asp:label id="lblTotalHours" runat="server" font-bold="True"></asp:label>
                            </td>
                        </tr>
                        <tr id="html_trTotalCosts" runat="server">
                            <td align="right" colspan="3">
                                Total Labor Costs :
                            </td>
                            <td align="right">
                                <asp:label id="lblTotalCosts" runat="server" font-bold="True"></asp:label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <table id="html_tblNoneTimeLog" cellspacing="0" cellpadding="0" width="100%" border="0"
                                    runat="server">
                                    <tr>
                                        <td align="center">
                                            None
                                        </td>
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
        <a name="Notes"></a>
        <table class="tblArea" cellspacing="0" cellpadding="5" width="100%" border="1">
            <tr>
                <td class="tblSubHead1" align="center">
                    Notes
                </td>
            </tr>
            <tr>
                <td>
                    <table cellspacing="0" cellpadding="0" width="100%">
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
								</ItemTemplate>
							</asp:repeater>
                        <tr>
                            <td colspan="2">
                                <br>
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
								</ItemTemplate>
							</asp:repeater>
                        <tr>
                            <td colspan="2">
                                <br>
                            </td>
                        </tr>
                        <asp:repeater id="repTechNotes" runat="server">
								<HeaderTemplate>
									<tr>
										<td colspan="2" class="tblSubHead2" align="left">Technician's Notes
										</td>
									<tr>
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
								</ItemTemplate>
							</asp:repeater>
                        <tr>
                            <td colspan="2">
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:textbox id="tbNotes" runat="server" width="100%" rows="4" textmode="MultiLine"
                                    columns="65"></asp:textbox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="2">
                                <asp:requiredfieldvalidator id="rfvNote" runat="server" controltovalidate="tbNotes"
                                    errormessage="Note is required"></asp:requiredfieldvalidator>
                                <br>
                                <asp:linkbutton id="lbSaveNotes" runat="server" font-bold="True" enabled="False">[Save & Add Technician's Note]</asp:linkbutton>
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
        <table class="tblArea" cellspacing="0" cellpadding="5" width="100%" border="1">
            <tr>
                <td class="tblSubHead1" align="center">
                    Signatures
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table cellspacing="-1" cellpadding="-1" width="100%" border="0">
                        <tr>
                            <td nowrap>
                                Checked-In By
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignCheckInBy" runat="server" font-bold="True" font-italic="True"
                                    font-size="Small" font-names="Georgia"></asp:label>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignDateCheckInBy" runat="server" font-bold="True"></asp:label>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td bgcolor="#000000">
                            </td>
                            <td>
                            </td>
                            <td bgcolor="#000000">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignCheckInByUnder" runat="server"></asp:label>
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                Sign Date
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap>
                                Opened By
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignOpenedBy" runat="server" font-bold="True" font-italic="True"
                                    font-size="Small" font-names="Georgia"></asp:label>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignDateOpenedBy" runat="server" font-bold="True"></asp:label>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td bgcolor="#000000">
                            </td>
                            <td>
                            </td>
                            <td bgcolor="#000000">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignOpenedByUnder" runat="server"></asp:label>
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                Sign Date
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap>
                                Closed&nbsp;By
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignClosedBy" runat="server" font-bold="True" font-italic="True"
                                    font-size="Small" font-names="Georgia"></asp:label>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignDateClosedBy" runat="server" font-bold="True"></asp:label>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td bgcolor="#000000">
                            </td>
                            <td>
                            </td>
                            <td bgcolor="#000000">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignClosedByUnder" runat="server"></asp:label>
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                Sign Date
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap>
                                Checked-Out&nbsp;By
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignCheckOutBy" runat="server" font-bold="True" font-italic="True"
                                    font-size="Small" font-names="Georgia"></asp:label>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignDateCheckOutBy" runat="server" font-bold="True"></asp:label>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td bgcolor="#000000">
                            </td>
                            <td>
                            </td>
                            <td bgcolor="#000000">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                <asp:label id="lblSignCheckOutByUnder" runat="server"></asp:label>
                            </td>
                            <td>
                            </td>
                            <td nowrap align="center">
                                Sign Date
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </td>
</tr>
</TBODY></TABLE></form>
