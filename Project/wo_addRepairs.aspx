<%@ Page language="c#" Codebehind="wo_addRepairs.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_addRepairs" %>
<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<form id="Form1" method="post" runat="server">
	<table id="tblMain" runat="server">
		<TR>
			<TD class="wo_size">Reported Issues for this work order:</TD>
		</TR>
		<tr>
			<td><mits:datagrid_a id="dgRepairs" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Report #">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ReportNumber") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Repair Category">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Issue">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:Label id="lblReportIssueId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:Label>
								<asp:TextBox id="tbDescMain" Width="100%" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc")%>'>
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
								<asp:LinkButton runat="server" Text="[unassign from WO]" CommandName="Unassign" CausesValidation="false"></asp:LinkButton>
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
									<asp:LinkButton runat="server" Text="[delete]" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
								</SPAN>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
				<br>
			</td>
		</tr>
		<TR>
			<TD class="wo_size">Existing unassigned Reported Issues for Equipment is #<asp:Label id="lblEquipId" runat="server"></asp:Label>:</TD>
		</TR>
		<TR>
			<TD>
				<mits:datagrid_a id="dgPreviousRepairs" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
					<Columns>
						<asp:ButtonColumn Text="[assign to WO]" CommandName="Assign">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
						</asp:ButtonColumn>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Last Work Order #">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Repair Category">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Issue">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:Label id="lblReportIssueId2" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:Label>
								<asp:TextBox id="tbDescPrevious" Width="100%" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc")%>'>
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
					</Columns>
				</mits:datagrid_a>
				<br>
			</TD>
		</TR>
		<TR>
			<TD class="wo_size">Reported Issues on future work orders</TD>
		</TR>
		<TR>
			<TD>
				<mits:datagrid_a id="dgFutureIssues" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:LinkButton runat="server" Text="[assign to WO]" CommandName="Assign" CausesValidation="false"></asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Repair Category">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Issue">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
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
						<asp:TemplateColumn HeaderText="Date of Work Order">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.ScheduledDate")).ToString("yyyy-MM-dd") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a></TD>
		</TR>
		<tr>
			<td><br><br>Add Reported Issue:
			</td>
		</tr>
		<tr>
			<td>
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td>Category*</td>
						<td><asp:dropdownlist id="ddlCategory" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist>
							<asp:RequiredFieldValidator id="rfvCategory" runat="server" ErrorMessage="Category is required" ControlToValidate="ddlCategory"></asp:RequiredFieldValidator></td>
					</tr>
					<tr>
						<td>Issue*</td>
						<td vAlign="top"><asp:textbox id="tbDesc" runat="server" TextMode="MultiLine" Width="350px" Height="100px"></asp:textbox><asp:requiredfieldvalidator id="rfvDesc" runat="server" ErrorMessage="Description is required" ControlToValidate="tbDesc"></asp:requiredfieldvalidator></td>
					</tr>
					<tr>
						<td></td>
						<td><asp:button id="btnAddRepair" runat="server" Text="Add Reported Issue"></asp:button></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<br>
			</td>
		</tr>
		<tr>
			<td>
				<uc1:NextBack id="NextBackControl" runat="server"></uc1:NextBack>
			</td>
		</tr>
		<tr>
			<td>
				<uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel>
			</td>
		</tr>
	</table>
</form>
