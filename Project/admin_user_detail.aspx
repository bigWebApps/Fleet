<%@ Page language="c#" Codebehind="admin_user_detail.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_user_detail" %>
<form id="Form1" method="post" runat="server">
	<table id="Table1">
		<TR>
			<TD colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="Table2">
					<tr>
						<td class="tblSubHead1" align="left">User Info</td>
						<td class="tblSubHead1" align="right"><asp:hyperlink id="hlUserEdit" runat="server" NavigateUrl="admin_user_detail_edit.aspx" ForeColor="Azure"
								ToolTip="editing of user info">[Edit]</asp:hyperlink></td>
					</tr>
				</table>
			</TD>
		</TR>
		<tr vAlign="top">
			<td class="bg01">First Name</td>
			<td class="bg02" width="66%" colSpan="2"><asp:label id="lblFirstName" runat="server"></asp:label></td>
		</tr>
		<tr vAlign="top">
			<td class="bg01">Last Name</td>
			<td class="bg02" colSpan="2"><asp:label id="lblLastName" runat="server"></asp:label></td>
		</tr>
		<tr vAlign="top">
			<td class="bg01">Email</td>
			<td class="bg02" colSpan="2"><asp:label id="lblEmail" runat="server"></asp:label></td>
		</tr>
		<tr vAlign="top">
			<td class="bg01">Type</td>
			<td class="bg02" colSpan="2"><asp:label id="lblType" runat="server"></asp:label></td>
		</tr>
		<TR>
			<TD class="bg01">Hourly Rate</TD>
			<TD class="bg02" colSpan="2">
				<asp:label id="lblHourlyRate" runat="server"></asp:label></TD>
		</TR>
		<TR vAlign="top">
			<TD class="bg01">Created Date</TD>
			<TD class="bg02" colSpan="2"><asp:label id="lblCreatedDate" runat="server"></asp:label></TD>
		</TR>
		<TR vAlign="top">
			<TD class="bg01">Current Status</TD>
			<TD class="bg02" colspan="2">
				<asp:label id="lblUserActivateStatus" runat="server"></asp:label></TD>
		</TR>
		<TR>
			<TD></TD>
			<TD></TD>
			<td></td>
		</TR>
		<tr>
			<td colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="Table3">
					<tr>
						<td class="tblSubHead2">User's Groups</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr vAlign="top">
			<TD class="bg01">Groups</TD>
			<TD class="bg02" colSpan="2"><asp:datagrid id="dgGroups" runat="server" Width="100%" ShowHeader="False" AutoGenerateColumns="False">
					<Columns>
						<asp:TemplateColumn>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:datagrid></TD>
		</tr>
		<TR>
			<TD></TD>
			<TD></TD>
			<td></td>
		</TR>
		<tr>
			<td colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="Table4">
					<tr>
						<td class="tblSubHead2">User's Equipments</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr vAlign="top">
			<TD class="bg01">Equipments</TD>
			<TD class="bg02" colSpan="2"><asp:datagrid id="dgEquipments" runat="server" Width="100%" ShowHeader="False" AutoGenerateColumns="False">
					<Columns>
						<asp:TemplateColumn>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.TypeName")) + " #" + Convert.ToString(DataBinder.Eval(Container, "DataItem.EquipId")) %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:datagrid></TD>
		</tr>
		<TR>
			<TD colSpan="3"><asp:label id="lblBack" runat="server"></asp:label></TD>
		</TR>
	</table>
</form>
