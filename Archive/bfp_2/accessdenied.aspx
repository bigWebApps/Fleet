<%@ Page language="c#" Codebehind="accessdenied.aspx.cs" AutoEventWireup="false" Inherits="bfp.AccessDenied" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<BFPCntrls:Header id="Header" TopMenuSelected="0" SubTopMenuSelected="0" LeftMenuSelected="0" RightMenuSelected="0"
	FocusOnLoad="tbLoginEmail" runat="server" />
<form id="Form1" method="post" runat="server">
	<center>
	<h1>Access Denied
	</h1>
	<br>
	<br>
		<INPUT type="button" value="Back" onclick="javascript:history.go(-1);">
	</center>
</form>
<BFPCntrls:Footer id="Footer" runat="server" />
