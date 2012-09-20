<%@ Page language="c#" Codebehind="admin_kiosk_customtext.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_kiosk_customtext" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.Common" Assembly="Micajah.Common" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colSpan="3"><mits:datagridex id="dgInstructions" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
					<AlternatingItemStyle VerticalAlign="Top" BackColor="#FFF7BE"></AlternatingItemStyle>
					<EditItemStyle VerticalAlign="Top"></EditItemStyle>
					<CustomPager Mode="DropDownList"></CustomPager>
					<ItemStyle VerticalAlign="Top"></ItemStyle>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Instruction Type">
							<ItemTemplate>
								<asp:Label id="lblTypeName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchTypeName") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:DropDownList id="dg_ddlInstructionTypes" runat="server" DataTextField="vchName" DataValueField="Id" SelectedValueEx='<%# DataBinder.Eval(Container, "DataItem.TypeId") %>'>
								</asp:DropDownList>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Instruction Text">
							<ItemTemplate>
								<asp:Label id=lblInstructionText runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchInstructionText") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:TextBox id="dg_tbInstructionText" runat="server" Width="400px" Height="80px" Text='<%# DataBinder.Eval(Container, "DataItem.vchInstructionText") %>' TextMode="MultiLine">
								</asp:TextBox>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemTemplate>
								<center>&nbsp;
									<asp:LinkButton runat="server" Text="Edit" CausesValidation="false" CommandName="Edit"></asp:LinkButton>
									&nbsp;</center>
							</ItemTemplate>
							<EditItemTemplate>
								<center>
									<asp:LinkButton runat="server" Text="Update" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' CommandName="Update">
									</asp:LinkButton>&nbsp;
									<asp:LinkButton runat="server" Text="Cancel" CausesValidation="false" CommandName="Cancel"></asp:LinkButton>
								</center>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemTemplate>
								<center>&nbsp;
									<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Instruction?')">
										<asp:LinkButton runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' CausesValidation="false">
										</asp:LinkButton>
									</SPAN>
									&nbsp;</center>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagridex></td>
		</tr>
		<TR>
			<TD colSpan="3"></TD>
		</TR>
		<TR>
			<TD colSpan="3"><b>Add New Instruction</b>
			</TD>
		</TR>
		<TR>
			<TD noWrap>Instruction Type</TD>
			<TD><asp:dropdownlist id="ddlInstructionTypes" runat="server" DataValueField="Id" DataTextField="vchName"></asp:dropdownlist></TD>
			<TD></TD>
		</TR>
		<tr vAlign="top">
			<td noWrap>Instruction Text</td>
			<td><asp:textbox id="tbInstructionText" runat="server" Width="400px" TextMode="MultiLine" Height="80px"></asp:textbox></td>
			<td><asp:requiredfieldvalidator id="rfvInstructionName" runat="server" ControlToValidate="tbInstructionText" ErrorMessage="The Instruction Text is required"></asp:requiredfieldvalidator></td>
		</tr>
		<TR>
			<TD colSpan="3"><asp:button id="btnAddInstruction" runat="server" Text="Add Instruction"></asp:button></TD>
		</TR>
	</table>
</form>
