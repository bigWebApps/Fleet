<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="manageIssues.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._manageIssues" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colSpan="2">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead1">The Equipment Information
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr vAlign="top">
			<td class="bg01" width="33%">Equipment #</td>
			<td class="bg02"><asp:label id="lblEquipId" runat="server"></asp:label></td>
		</tr>
		<TR>
			<TD class="bg01" width="33%">Type</TD>
			<TD class="bg02"><asp:label id="lblType" runat="server"></asp:label></TD>
		</TR>
		<TR>
			<TD class="bg01" width="33%">Make/Model</TD>
			<TD class="bg02"><asp:label id="lblMakeModel" runat="server"></asp:label></TD>
		</TR>
		<TR>
			<TD class="bg01" width="33%">Year</TD>
			<TD class="bg02"><asp:label id="lblYear" runat="server"></asp:label></TD>
		</TR>
		<TR>
			<td class="bg01" width="33%">Units (Mileage)</td>
			<td class="bg02"><asp:label id="lblUnits" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01" width="33%">Equipment Operator</td>
			<td class="bg02"><asp:label id="lblOperator" runat="server"></asp:label></td>
		</TR>
		<tr>
			<td colSpan="2"><br>
			</td>
		</tr>
		<tr>
			<td colSpan="2">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead2">The Assigned Reported Issues</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colSpan="2"><mits:datagrid_a id="dgAssignedIssues" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Category">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Caterogy") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Issue">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Name") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Date Report">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.ReportDate")).ToString("yyyy-MM-dd") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Order Status">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td align="center" bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.StatusColor")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Status") %>'>
											</asp:Label>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Operator Status">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemTemplate>
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
											</asp:Label>&nbsp;
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.WorkOrderNumber") %>' NavigateUrl='<%# "wo_viewWorkOrder.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OrderId")) %>'>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
		<tr>
			<td colSpan="2"><br>
			</td>
		<tr>
			<td bgColor="#000000" colSpan="2"></td>
		</tr>
		<tr>
			<td colSpan="2"><br>
			</td>
		<tr>
		<tr>
			<td colSpan="2">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead2" align="left">The Unassigned Reported Issues
						</td>
						<td class="tblSubHead2" align="right">
							<asp:HyperLink id="hlCreateOrder" runat="server" Text="[create order]" NavigateUrl="wo_existingWorkOrders.aspx"
								ForeColor="Azure">[create order]</asp:HyperLink>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colSpan="2"><mits:datagrid_a id="dgUnAssignedIssues" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Category">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Caterogy") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Issue">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Name") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:Label id="lblReportIssueId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:Label>
								<asp:TextBox id="tbIssueName" Width="100%" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Name")%>'>
								</asp:TextBox>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Date Report">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.ReportDate")).ToString("yyyy-MM-dd") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:LinkButton runat="server" Text="[edit]" CommandName="Edit" CausesValidation="false"></asp:LinkButton>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:LinkButton runat="server" Text="[update]" CommandName="Update" CausesValidation="false"></asp:LinkButton>&nbsp;
								<asp:LinkButton runat="server" Text="[cancel]" CommandName="Cancel" CausesValidation="false"></asp:LinkButton>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Issue?')">
									<asp:LinkButton runat="server" Text="[remove]" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
								</SPAN>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></td>
		</tr>
		<tr>
			<td colSpan="2"><br>
			</td>
		</tr>
		<tr>
			<td colSpan="2">
				Add New Issue Report:
			</td>
		</tr>
		<tr>
			<td colSpan="2">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td>Category*</td>
						<td><asp:dropdownlist id="ddlCategory" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvCategory" runat="server" ControlToValidate="ddlCategory" ErrorMessage="Category is required"></asp:requiredfieldvalidator></td>
					</tr>
					<tr>
						<td>Issue*</td>
						<td vAlign="top"><asp:textbox id="tbDesc" runat="server" Width="350px" Height="100px" TextMode="MultiLine"></asp:textbox><asp:requiredfieldvalidator id="rfvDesc" runat="server" ControlToValidate="tbDesc" ErrorMessage="Description is required"></asp:requiredfieldvalidator></td>
					</tr>
					<tr>
						<td></td>
						<td><asp:button id="btnAddRepair" runat="server" Text="Add to Work Order"></asp:button></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
