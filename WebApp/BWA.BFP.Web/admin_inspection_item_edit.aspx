<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register tagprefix="mbll" namespace="MetaBuilders.WebControls" Assembly="MetaBuilders.WebControls.ListLink" %>
<%@ Page language="c#" Codebehind="admin_inspection_item_edit.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_inspection_item_edit" %>
<form id="Form1" method="post" runat="server">
	<table id="tblMain" runat="server">
		<TR>
			<TD colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead1">Inspection Item Info</td>
					</tr>
				</table>
			</TD>
		</TR>
		<tr vAlign="middle">
			<td class="RowCap">Inspection Name</td>
			<td class="RowElem" width="66%" colSpan="2"><asp:label id="lblInspectionName" runat="server"></asp:label></td>
		</tr>
		<tr vAlign="middle">
			<td class="RowCap">Item Category</td>
			<td class="RowElem" width="66%" colSpan="2"><asp:dropdownlist id="ddlCategories" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist>&nbsp;
			</td>
		</tr>
		<TR vAlign="middle">
			<TD class="RowCap">Item Name</TD>
			<TD class="RowElem" width="66%" colSpan="2"><asp:textbox id="tbItemName" runat="server"></asp:textbox><asp:requiredfieldvalidator id="rfvItemName" runat="server" ErrorMessage="Name is required" ControlToValidate="tbItemName"></asp:requiredfieldvalidator></TD>
		</TR>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<tr>
			<td colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead2">Relating with Preventive Maintenances</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr vAlign="top">
			<TD class="RowCap">Linked PM Items</TD>
			<TD class="RowElem" colSpan="2" vAlign="top" align="left"><asp:datagrid id="dgPMItems" runat="server" Width="100%" AutoGenerateColumns="False">
					<HeaderStyle Font-Bold="True"></HeaderStyle>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Schedule">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ScheduleName") %>' ID="Label1" NAME="Label1">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Service">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceName") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:LinkButton runat="server" Text="[remove]" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:datagrid></TD>
		</tr>
		<TR>
			<TD class="RowCap">PM Schedules</TD>
			<TD class="RowElem" colSpan="2"><asp:dropdownlist id="ddlPMSchedules" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></TD>
		</TR>
		<TR>
			<TD class="RowCap">PM Services</TD>
			<TD class="RowElem" colSpan="2"><asp:dropdownlist id="ddlPMServices" runat="server" DataValueField="Id" DataTextField="vchDesc"></asp:dropdownlist><mbll:listlink id="ListLink" runat="server" ParentList="ddlPMSchedules" EnableViewState="False"
					ChildList="ddlPMServices" DataRelation="Schedules_Services" Enabled="False"></mbll:listlink></TD>
		</TR>
		<TR>
			<TD class="RowCap"></TD>
			<TD class="RowElem" colSpan="2"><asp:button id="btnLink" runat="server" CausesValidation="False" Text="Link PM Item to Inspection Item"></asp:button></TD>
		</TR>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR>
			<TD colSpan="3"><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Inspection Item?')">
					<asp:button id="btnDelete" runat="server" Text="Delete"></asp:button>
				</SPAN></TD>
		</TR>
	</table>
</form>
