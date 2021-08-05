<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Page language="c#" Codebehind="wo_editNotes.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_editNotes" %>
<BFPCNTRLS:HEADER id="Header" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0"
	runat="server"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table width="100%" cellpadding="5">
		<TR vAlign="top">
			<TD class="tblSubHead1" colSpan="3" align="center">Work Order Notes</TD>
		</TR>
		<tr>
			<td>
				<table id="tblNotes" runat="server" width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td class="tblSubHead2">Operator's Notes
						</td>
					</tr>
					<tr>
						<td>
							<asp:DataGrid id="dgOperatorNotes" runat="server" Width="100%" AutoGenerateColumns="False" BorderColor="#CCCCCC">
								<HeaderStyle BackColor="#CCCCCC"></HeaderStyle>
								<Columns>
									<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
									<asp:TemplateColumn HeaderText="Note">
										<ItemTemplate>
											<asp:Label id="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Note") %>'>
											</asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:TextBox id="Textbox1" runat="server" TextMode="MultiLine" Rows="3" Width="100%" Text='<%# DataBinder.Eval(Container, "DataItem.Note") %>' MaxLength="8000">
											</asp:TextBox>
										</EditItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="Author">
										<ItemTemplate>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserName") %>' ID="Label2" NAME="Label2">
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="Date">
										<ItemTemplate>
											<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.CreatedDate")).ToString("yyyy-MM-dd hh:mm tt") %>' ID="Label3" NAME="Label3">
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<ItemTemplate>
											<asp:LinkButton runat="server" Text="Edit" CommandName="Edit" CausesValidation="false" ID="Linkbutton1"
												NAME="Linkbutton1"></asp:LinkButton>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:LinkButton runat="server" Text="Update" CommandName="Update" ID="Linkbutton2" NAME="Linkbutton2"></asp:LinkButton>&nbsp;
											<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" ID="Linkbutton3"
												NAME="Linkbutton3"></asp:LinkButton>
										
</EditItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<ItemTemplate>
											<asp:LinkButton runat="server" Text="Delete" CommandName="Delete" CausesValidation="false" ID="Linkbutton4"
												NAME="Linkbutton4"></asp:LinkButton>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:DataGrid></td>
					</tr>
					<tr>
						<td class="tblSubHead2">Creation Notes
						</td>
					</tr>
					<tr>
						<td>
							<asp:DataGrid id="dgCreationNotes" runat="server" Width="100%" AutoGenerateColumns="False" BorderColor="#CCCCCC">
								<HeaderStyle BackColor="#CCCCCC"></HeaderStyle>
								<Columns>
									<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
									<asp:TemplateColumn HeaderText="Note">
										<ItemTemplate>
											<asp:Label id=lblNote runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Note") %>'>
											</asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:TextBox id=tbNote runat="server" TextMode="MultiLine" Rows="3" Width="100%" Text='<%# DataBinder.Eval(Container, "DataItem.Note") %>' MaxLength="8000">
											</asp:TextBox>
										</EditItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="Author">
										<ItemTemplate>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserName") %>'>
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="Date">
										<ItemTemplate>
											<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.CreatedDate")).ToString("yyyy-MM-dd hh:mm tt") %>'>
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<ItemTemplate>
											<asp:LinkButton runat="server" Text="Edit" CommandName="Edit" CausesValidation="false"></asp:LinkButton>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:LinkButton runat="server" Text="Update" CommandName="Update"></asp:LinkButton>&nbsp;
											<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false"></asp:LinkButton>
										
</EditItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<ItemTemplate>
											<asp:LinkButton runat="server" Text="Delete" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:DataGrid>
						</td>
					</tr>
					<tr>
						<td align="left"><asp:linkbutton id="lbSaveNotes" runat="server" Font-Bold="True">[Add Creation Note]</asp:linkbutton></td>
					</tr>
					<TR>
						<td><asp:textbox id="tbNotes" runat="server" Width="100%" Rows="4" TextMode="MultiLine" Columns="65"></asp:textbox></td>
					</TR>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center">
				<uc1:NextBack id="NextBackControl" runat="server"></uc1:NextBack>
			</td>
		</tr>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
