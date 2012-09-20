<%@ Page language="c#" Codebehind="default.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web._default" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="0"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table height="100%" width="100%">
		<tr>
			<td align="center">&nbsp;
				<table id="tblLogin" runat="server">
					<tr>
						<td>&nbsp;</td>
						<td><asp:label id="lbErr" runat="server" CssClass="errTxt" Visible="False">
							Username and password are not valid. Please try again.
							</asp:label></td>
					</tr>
					<TR>
						<TD>Organization</TD>
						<TD><asp:dropdownlist id="ddlOrg" runat="server"></asp:dropdownlist><asp:requiredfieldvalidator id="rfvOrgs" runat="server" ErrorMessage="Organization is required." ControlToValidate="ddlOrg"
								Display="Dynamic"></asp:requiredfieldvalidator></TD>
					</TR>
					<tr>
						<td>Login/Email:*</td>
						<td><asp:textbox id="tbEmail" runat="server" Columns="30" MaxLength="50"></asp:textbox><asp:requiredfieldvalidator id="LoginEmailValidator" runat="server" ErrorMessage="Login/email is required."
								ControlToValidate="tbEmail" Display="Dynamic"></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="LoginEmailRegExp" runat="server" ErrorMessage="Login/email contains invalid characters."
								ControlToValidate="tbEmail" Display="Dynamic" ValidationExpression="[a-z|A-Z|0-9|'@.]*"></asp:regularexpressionvalidator></td>
					</tr>
					<tr>
						<td>Password:*</td>
						<td><asp:textbox id="tbPassword" runat="server" MaxLength="50" TextMode="Password"></asp:textbox><asp:requiredfieldvalidator id="PasswordValidator" runat="server" ErrorMessage="Password is required." ControlToValidate="tbPassword"
								Display="Dynamic"></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="PasswordRegExp" runat="server" ErrorMessage="Password contains invalid characters."
								ControlToValidate="tbPassword" Display="Dynamic" ValidationExpression="[a-z|A-Z|0-9|!$%&amp;amp;*@?]*"></asp:regularexpressionvalidator></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><asp:button id="btLogin" runat="server" Width="75px" Text="Submit"></asp:button></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
