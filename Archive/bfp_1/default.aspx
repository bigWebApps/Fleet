<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Page Language="c#" codebehind="default.aspx.cs" autoeventwireup="false" Inherits="BWA.BFP.Web._Login" %>
<BFPCntrls:Header id="Header" TopMenuSelected="0" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0"
	FocusOnLoad="tbLoginEmail" runat="server" />
<form id="login" method="post" runat="server">
	<table width="100%" height="100%">
		<tr>
			<td align="center">
				<table>
					<tr>
						<td>&nbsp;</td>
						<td><asp:Label id="lbErr" runat="server" Visible="False" CssClass="errTxt">
							Username and password are not valid. Please try again.
							</asp:Label></td>
					</tr>
					<tr>
						<td>Login/Email:*</td>
						<td>
							<asp:TextBox id="tbLoginEmail" runat="server" MaxLength="50" Columns="30" />
							<asp:RequiredFieldValidator id="LoginEmailValidator" runat="server" ErrorMessage="Login/email is required."
								ControlToValidate="tbLoginEmail" Display="Dynamic" />
							<asp:RegularExpressionValidator id="LoginEmailRegExp" runat="server" ErrorMessage="Login/email contains invalid characters."
								ControlToValidate="tbLoginEmail" ValidationExpression="[a-z|A-Z|0-9|'@.]*" Display="Dynamic" />
						</td>
					</tr>
					<tr>
						<td>Password:*</td>
						<td>
							<asp:TextBox id="tbPassword" runat="server" MaxLength="50" TextMode="Password" />
							<asp:RequiredFieldValidator id="PasswordValidator" runat="server" ErrorMessage="Password is required." ControlToValidate="tbPassword"
								Display="Dynamic" />
							<asp:RegularExpressionValidator id="PasswordRegExp" runat="server" ErrorMessage="Password contains invalid characters."
								ControlToValidate="tbPassword" ValidationExpression="[a-z|A-Z|0-9|!$%&amp;amp;*@?]*" Display="Dynamic" />
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><asp:Button id="btLogin" runat="server" Text="Submit" Width="75px" onclick="btLogin_Click"></asp:Button></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
<BFPCntrls:Footer id="Footer" runat="server" />
