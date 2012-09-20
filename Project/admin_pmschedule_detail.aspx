<%@ Page language="c#" Codebehind="admin_pmschedule_detail.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_pmschedule_detail" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.Common" Assembly="Micajah.Common" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead1">Preventive Maintenance Schedule Information</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr vAlign="top">
			<td class="bg01">PM Schedule Name</td>
			<td class="bg02" width="66%" colSpan="2"><asp:label id="lblPMScheduleName" runat="server"></asp:label></td>
		</tr>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<tr>
			<TD colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead2">Preventive Maintenance Services for the Schedule</td>
					</tr>
				</table>
			</TD>
		</tr>
		<tr>
			<td colSpan="3"><mits:datagridex id="dgPMSchedDetails" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id" BorderColor="#9E755F">
					<AlternatingItemStyle BackColor="#FFF7BE"></AlternatingItemStyle>
					<CustomPager Mode="DropDownList"></CustomPager>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Service Name">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Days">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Days") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Units">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Units") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Measure">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UnitMeasureName") %>' ID="Label1">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
							&nbsp;
							<asp:HyperLink runat="server" Text="Edit" NavigateUrl='<%# "admin_pmschedule_detail_edit.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.PMSchedId")) + "&detailid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) %>'>
								</asp:HyperLink>
							&nbsp;
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagridex></td>
		</tr>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR>
			<TD colSpan="3"><asp:hyperlink id="hlAddPMService" runat="server" NavigateUrl="admin_pmschedule_detail_edit.aspx">Add New PM Service to Schedule</asp:hyperlink></TD>
		</TR>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR>
			<TD colSpan="3"><asp:label id="lblBack" runat="server"></asp:label></TD>
		</TR>
	</table>
</form>
