<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="wo_addPreventiveMaintenance.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_addPreventiveMaintenance" %>
<form id="formAddPMItems" method="post" runat="server">
	<table id="tblMain" width="100%" runat="server">
		<TR>
			<TD>Select upcoming or due Preventive Maintenance items for&nbsp;the current Work 
				Order:</TD>
		</TR>
		<tr>
			<td><mits:datagrid_a id="dgPMServices" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:BoundColumn Visible="False" DataField="ServiceId" ReadOnly="True"></asp:BoundColumn>
						<asp:BoundColumn Visible="False" DataField="ItemId" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Add">
							<ItemTemplate>
								<asp:CheckBox id="chAdd" runat="server" Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.IsChecked")) %>'>
								</asp:CheckBox>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Category">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Item">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Status">
							<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Units Left">
							<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.UnitsVisibleLast")) %>' Text='<%# DataBinder.Eval(Container, "DataItem.UnitsDue") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Date Due">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.DaysVisibleLast")) %>' Text='<%# DataBinder.Eval(Container, "DataItem.DateDue") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Units Inteval">
							<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.UnitsVisible")) %>' Text='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.UnitsInteval"))%>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Time Interval">
							<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.DaysVisible")) %>' Text='<%# DataBinder.Eval(Container, "DataItem.TimeInterval") %>' ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Units last serviced">
							<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>' Text='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.UnitsLastServiced")) + " " + Convert.ToString(DataBinder.Eval(Container, "DataItem.MeasureName"))%>' Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.UnitsVisibleLast")) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Date last serviced">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" ForeColor='<%# System.Drawing.Color.FromName(Convert.ToString(DataBinder.Eval(Container, "DataItem.Color"))) %>' Text='<%# DataBinder.Eval(Container, "DataItem.DateLastServiced") %>' Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.DaysVisibleLast")) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="History">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink id=HyperLink2 style="CURSOR: hand" onclick='<%# "javascript:return AddLS(" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) + ", " + Convert.ToString(DataBinder.Eval(Container, "DataItem.WorkOrderId")) + ", " + Convert.ToString(DataBinder.Eval(Container, "DataItem.HistoryId")) + ");" %>' runat="server" Visible='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.VisibleLastLink")) %>' ToolTip="Add Units and Date Last Serviced">Add</asp:HyperLink>
								<asp:HyperLink id=HyperLink1 style="CURSOR: hand" onclick='<%# "javascript:return AddLS(" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) + ", " + Convert.ToString(DataBinder.Eval(Container, "DataItem.WorkOrderId")) + ", " + Convert.ToString(DataBinder.Eval(Container, "DataItem.HistoryId")) + ");" %>' runat="server" Visible='<%# !Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.VisibleLastLink")) %>' ToolTip="Edit Units and Date Last Serviced">Edit</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a><br>
				<asp:Label id="lblCurrentUnits" runat="server"></asp:Label>
				<br>
				<br>
			</td>
		</tr>
		<TR>
			<TD>The Preventive Maintenance items of the future work orders</TD>
		</TR>
		<TR>
			<TD>
				<mits:datagrid_a id="dgFuturePMItems" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:LinkButton runat="server" Text="[assign to WO]" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.VisibleAssign")) %>' CommandName="Assign" CausesValidation="false"></asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Work Order #">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Category">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Item">
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
					</Columns>
				</mits:datagrid_a>
				<br>
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
