<%@ Page language="c#" Codebehind="default.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web._default" %>
<form id="Form1" method="post" runat="server">
	<table height="100%" width="100%">
		<tr>
			<td align="center">&nbsp;
				<table id="tblLogin" runat="server">
					<tr>
						<td>&nbsp;</td>
						<td><asp:label id="lbErr" runat="server" Visible="False" CssClass="errTxt">
							Username and password are not valid. Please try again.
							</asp:label></td>
					</tr>
					<TR>
						<TD>Choose organization:</TD>
						<TD><asp:datagrid id="dgOrgs" runat="server" ShowHeader="False" AutoGenerateColumns="False" DataKeyField="Id"
								CellSpacing="2" CellPadding="2" BorderWidth="0px">
								<Columns>
									<asp:TemplateColumn>
										<ItemTemplate>
											<asp:LinkButton id=lbSelect runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>' CommandArgument='<%# DataBinder.Eval(Container, "DataItem.vchLogo") %>' CommandName="Select" CausesValidation="false">
											</asp:LinkButton>
											<asp:Label id=lblOrgId runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></TD>
					</TR>
					<tr>
						<td>Login/Email:*</td>
						<td><asp:textbox id="tbEmail" runat="server" MaxLength="50" Columns="30"></asp:textbox><asp:requiredfieldvalidator id="LoginEmailValidator" runat="server" Display="Dynamic" ControlToValidate="tbEmail"
								ErrorMessage="Login/email is required."></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="LoginEmailRegExp" runat="server" Display="Dynamic" ControlToValidate="tbEmail"
								ErrorMessage="Login/email contains invalid characters." ValidationExpression="[a-z|A-Z|0-9|'@.]*"></asp:regularexpressionvalidator></td>
					</tr>
					<tr>
						<td>Password:*</td>
						<td><asp:textbox id="tbPassword" runat="server" MaxLength="50" TextMode="Password"></asp:textbox><asp:requiredfieldvalidator id="PasswordValidator" runat="server" Display="Dynamic" ControlToValidate="tbPassword"
								ErrorMessage="Password is required."></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="PasswordRegExp" runat="server" Display="Dynamic" ControlToValidate="tbPassword"
								ErrorMessage="Password contains invalid characters." ValidationExpression="[a-z|A-Z|0-9|!$%&amp;amp;*@?]*"></asp:regularexpressionvalidator></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><asp:button id="btLogin" runat="server" Text="Submit" Width="75px"></asp:button></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
