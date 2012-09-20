<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="wo_addInspections.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_addInspections" %>
<form id="formSelectInspect" method="post" runat="server">
	<table id="tblMain" width="100%" runat="server">
		<TR>
			<TD>Select upcoming or due Inspections for the current Work Order</TD>
		</TR>
		<tr>
			<td><mits:datagrid_a id="dgInspections" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:BoundColumn Visible="False" DataField="ItemId" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Add">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:CheckBox id="chAdd" runat="server" Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.IsChecked")) %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.IsCompeted")) %>'>
								</asp:CheckBox>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Inspection">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Date Due">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DateDue") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Last Inspection Date">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>' Text='<%# DataBinder.Eval(Container, "DataItem.DateLastInspected") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Target Days Out">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TargetDaysOut") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Min Days">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MinimumDaysOut") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Max Days">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MaximumDaysOut") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="History">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink style="CURSOR: hand" onclick='<%# "javascript:return AddLI(" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) + ", " + Convert.ToString(DataBinder.Eval(Container, "DataItem.WorkOrderId")) + ", " + Convert.ToString(DataBinder.Eval(Container, "DataItem.HistoryId")) + ");" %>' runat="server" ToolTip="Add Date of Last Inspection" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.VisibleLink")) %>'>Add</asp:HyperLink>
								<asp:HyperLink style="CURSOR: hand" onclick='<%# "javascript:return AddLI(" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) + ", " + Convert.ToString(DataBinder.Eval(Container, "DataItem.WorkOrderId")) + ", " + Convert.ToString(DataBinder.Eval(Container, "DataItem.HistoryId")) + ");" %>' runat="server" ToolTip="Edit Date of Last Inspection" Visible='<%# !Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.VisibleLink")) %>'>Edit</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a><br>
				<br>
			</td>
		</tr>
		<TR>
			<TD>The Inspection of the future work orders</TD>
		</TR>
		<TR>
			<TD>
				<mits:datagrid_a id="dgFutureInspections" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:LinkButton runat="server" Text="[assign to WO]" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.VisibleAssign")) %>' CommandName="Assign" CausesValidation="false">
								</asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Inspection">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Scheduled Date">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.ScheduledDate")).ToString("yyyy-MM-dd") %>'>
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
					</Columns>
				</mits:datagrid_a><br>
				<br>
			</TD>
		</TR>
		<tr>
			<td><uc1:NextBack id="NextBackControl" runat="server"></uc1:NextBack></td>
		</tr>
		<tr>
			<td>
				<uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel>
			</td>
		</tr>
	</table>
</form>
