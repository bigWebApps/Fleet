<%@ Page language="c#" Codebehind="admin_inspectschedule_detail.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_inspectschedule_detail" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TBODY>
			<TR>
				<TD colSpan="3">
					<table cellSpacing="0" cellPadding="0" width="100%" border="0">
						<tr>
							<td class="tblSubHead1">Inspection Schedule&nbsp;Information</td>
						</tr>
					</table>
				</TD>
			</TR>
			<tr vAlign="top">
				<td class="bg01">Schedule Name</td>
				<td class="bg02" width="66%" colSpan="2"><asp:label id="lblScheduleName" runat="server"></asp:label></td>
			</tr>
			<tr>
				<td colSpan="3"><br>
				</td>
			</tr>
			<tr>
				<TD colSpan="3">
					<table cellSpacing="0" cellPadding="0" width="100%" border="0">
						<tr>
							<td class="tblSubHead2">Detail Inspections List of Schedule</td>
						</tr>
					</table>
				</TD>
			</tr>
			<TR>
				<TD colSpan="3"><mits:datagrid_a id="dgInspectSchedDetails" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
						Width="100%" DataKeyField="Id">
						<Columns>
							<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
							<asp:TemplateColumn HeaderText="Inspection Name">
								<ItemTemplate>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InspectionName") %>'>
									</asp:Label>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:TemplateColumn HeaderText="Minimum Days Out">
								<ItemStyle HorizontalAlign="Center"></ItemStyle>
								<ItemTemplate>
									<asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.MinimumDaysOut")) + " days" %>'>
									</asp:Label>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:TemplateColumn HeaderText="Target Days Out">
								<ItemStyle HorizontalAlign="Center"></ItemStyle>
								<ItemTemplate>
									<asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.TargetDaysOut")) + " days" %>'>
									</asp:Label>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:TemplateColumn HeaderText="Maximum Days Out">
								<ItemStyle HorizontalAlign="Center"></ItemStyle>
								<ItemTemplate>
									<asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.MaximumDaysOut")) + " days" %>'>
									</asp:Label>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:TemplateColumn>
								<ItemStyle HorizontalAlign="Center"></ItemStyle>
								<ItemTemplate>
								&nbsp;
								<asp:HyperLink runat="server" Text="Edit" NavigateUrl='<%# "admin_inspectschedule_detail_edit.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.InspectSchedId")) + "&detailid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) %>'>
									</asp:HyperLink>
								&nbsp;
								</ItemTemplate>
							</asp:TemplateColumn>
						</Columns>
					</mits:datagrid_a></TD>
			</TR>
			<tr>
				<td colSpan="3"><br>
				</td>
			</tr>
			<TR>
				<TD colSpan="3"><asp:hyperlink id="hlAddInspection" runat="server" NavigateUrl="admin_inspection_category_edit.aspx">Add New Inspection to Schedule</asp:hyperlink></TD>
			</TR>
			<tr>
				<td colSpan="3"><br>
				</td>
			</tr>
			<TR>
				<TD colSpan="3"><asp:label id="lblBack" runat="server"></asp:label></TD>
			</TR>
		</TBODY></table>
</form>
