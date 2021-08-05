<%@ Page language="c#" Codebehind="admin_inspections_items.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_inspections_items" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TBODY>
			<TR>
				<TD colSpan="3">
					<table cellSpacing="0" cellPadding="0" width="100%" border="0">
						<tr>
							<td class="tblSubHead1">Inspection Information</td>
						</tr>
					</table>
				</TD>
			</TR>
			<tr vAlign="top">
				<td class="bg01">Inspection Name</td>
				<td class="bg02" width="66%" colSpan="2"><asp:label id="lblInspectionName" runat="server"></asp:label></td>
			</tr>
			<tr>
				<td colspan="3"><br>
				</td>
			</tr>
			<tr>
				<TD colSpan="3">
					<table cellSpacing="0" cellPadding="0" width="100%" border="0">
						<tr>
							<td class="tblSubHead2">Inspection Items List</td>
						</tr>
					</table>
				</TD>
			</tr>
			<TR>
				<TD colSpan="3"><asp:repeater id="repInspections" runat="server">
						<HeaderTemplate>
							<table style="border-color:#9E755F;border-width:1px;border-style:solid;width:100%;border-collapse:collapse;"
								cellSpacing="0" cellPadding="3" border="1" borderColor="#9E755F">
						</HeaderTemplate>
						<ItemTemplate>
							<tr bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.CellColor")) %>' style="border-color:#FFFFCC;">
								<td style='<%# "BORDER-COLOR: #9E755F;BORDER-RIGHT-STYLE: " + Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderStyle")) %>'>
									&nbsp;<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OrderText") %>'>
									</asp:Label>&nbsp;
								</td>
								<td style='<%# "BORDER-COLOR: #9E755F;BORDER-LEFT-STYLE: " + Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderStyle")) %>'>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ItemName") %>'>
									</asp:Label>
								</td>
								<td style="BORDER-COLOR: #9E755F;" align="center">
									<asp:HyperLink runat="server" NavigateUrl='<%# DataBinder.Eval(Container, "DataItem.Link") %>' Text='<%# DataBinder.Eval(Container, "DataItem.Text") %>'>
									</asp:HyperLink>
								</td>
							</tr>
						</ItemTemplate>
						<FooterTemplate>
	</table>
	</FooterTemplate> </asp:repeater></TD></TR>
	<tr>
		<td colSpan="3"><br>
		</td>
	</tr>
	<TR>
		<TD colSpan="3"><asp:hyperlink id="hlAddCategory" runat="server" NavigateUrl="admin_inspection_category_edit.aspx">Add New Inspection Category</asp:hyperlink></TD>
	</TR>
	<tr>
		<td colSpan="3"><br>
		</td>
	</tr>
	<TR>
		<TD colSpan="3"><asp:hyperlink id="hlAddInspectionItem" runat="server" NavigateUrl="admin_inspection_item_edit.aspx">Add New Inspection Item</asp:hyperlink></TD>
	</TR>
	<TR>
		<TD colSpan="3"><br>
		</TD>
	</TR>
	<TR>
		<TD colSpan="3"><asp:label id="lblBack" runat="server"></asp:label></TD>
	</TR>
	</TBODY></TABLE></form>
