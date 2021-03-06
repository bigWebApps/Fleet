<%@ Page language="c#" Codebehind="admin_inspectschedules.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_inspectschedules" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colSpan="3">
				<mits:datagrid_a id="dgInspectSchedules" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								&nbsp;
								<asp:HyperLink runat="server" Text="Detail" NavigateUrl='<%# "admin_inspectschedule_detail.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) %>'>
								</asp:HyperLink>
								&nbsp;
							
</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Schedule Name">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:TextBox id=tbNameEdit runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>' MaxLength="50" Width="100%">
								</asp:TextBox>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								&nbsp;
								<asp:LinkButton runat="server" Text="Edit" CommandName="Edit" CausesValidation="false"></asp:LinkButton>
								&nbsp;
							
</ItemTemplate>
							<EditItemTemplate>
								<asp:LinkButton runat="server" Text="Update" CommandName="Update" CausesValidation="false"></asp:LinkButton>&nbsp;
								<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false"></asp:LinkButton>
							
</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								&nbsp;
								<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Schedule?')">
									<asp:LinkButton runat="server" Text="Remove" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
								</SPAN>
								&nbsp;
							
</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
		<TR>
			<TD colSpan="3"><br>
			</TD>
		</TR>
		<TR>
			<TD colSpan="3">
				<b>Add New Inspection Schedule</b>
			</TD>
		</TR>
		<tr>
			<td>Schedule Name</td>
			<td>
				<asp:TextBox id="tbScheduleName" runat="server" Width="200px" MaxLength="50"></asp:TextBox></td>
			<td>
				<asp:RequiredFieldValidator id="rfvScheduleName" runat="server" ErrorMessage="The Schedule Name is required"
					ControlToValidate="tbScheduleName"></asp:RequiredFieldValidator></td>
		</tr>
		<TR>
			<TD colSpan="3"><br>
			</TD>
		</TR>
		<TR>
			<TD colSpan="3">
				<asp:Button id="btnAddSchedule" runat="server" Text="Add Schedule"></asp:Button></TD>
		</TR>
	</table>
	<br>
</form>
