<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="admin_inspection_category_edit.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_inspection_category_edit" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TR>
			<TD colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead1">Inspection Category Info</td>
					</tr>
				</table>
			</TD>
		</TR>
		<tr vAlign="middle">
			<td class="RowCap">Inspection Name</td>
			<td class="RowElem" width="66%" colSpan="2"><asp:label id="lblInspectionName" runat="server"></asp:label></td>
		</tr>
		<tr vAlign="middle">
			<td class="RowCap">Category Name</td>
			<td class="RowElem" width="66%" colSpan="2"><asp:textbox id="tbCategory" runat="server"></asp:textbox>&nbsp;
				<asp:requiredfieldvalidator id="rfvCategory" runat="server" ControlToValidate="tbCategory" ErrorMessage="Category is required"></asp:requiredfieldvalidator></td>
		</tr>
		<TR vAlign="middle">
			<TD class="RowCap">Position from Top</TD>
			<TD class="RowElem" width="66%" colSpan="2"><asp:dropdownlist id="ddlOrder" runat="server"></asp:dropdownlist></TD>
		</TR>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<tr>
			<TD colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead2">Inspection Items of Category</td>
					</tr>
				</table>
			</TD>
		</tr>
		<TR>
			<TD colSpan="3"><mits:datagrid_a id="dgInspectItems" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Position">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label Id="lblCatId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Position") %>'>
								</asp:Label>
								<span id="NewPosition" name="NewPosition" runat="server">
									<SELECT id='<%# "FormPosition" + Convert.ToString(Convert.ToInt32(DataBinder.Eval(Container, "DataItem.Position")) - 1) %>' name='<%# "FormPosition" + Convert.ToString(Convert.ToInt32(DataBinder.Eval(Container, "DataItem.Position")) - 1) %>' onchange='<%# DataBinder.Eval(Container, "DataItem.CallProcedure") %>'>
										<%# DataBinder.Eval(Container, "DataItem.Options") %>
									</SELECT>
								</span>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Inspection Item">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ItemName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:HyperLink runat="server" id="LinkToEdit" NavigateUrl='<%# DataBinder.Eval(Container, "DataItem.Link") %>'>Edit
								</asp:HyperLink>
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
			<TD colSpan="3"><asp:label id="lblError" runat="server" ForeColor="Red"></asp:label></TD>
		</TR>
		<TR>
			<td colSpan="3"><br>
			</td>
		</TR>
		<TR>
			<TD colSpan="3"><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:button id="btnDelete" runat="server" Text="Delete" CausesValidation="False"></asp:button></TD>
		</TR>
	</table>
</form>
