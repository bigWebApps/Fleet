<%@ Register tagprefix="mbll" namespace="MetaBuilders.WebControls" Assembly="MetaBuilders.WebControls.ListLink" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="MakesModels.ascx.cs" Inherits="BWA.BFP.Web.Controls.User.MakesModels" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<asp:DropDownList id="ddlMakes" runat="server"></asp:DropDownList>
<asp:Literal id="Literal" runat="server" Text="/"></asp:Literal>
<asp:DropDownList id="ddlModels" runat="server"></asp:DropDownList>
<mbll:listlink id="ListLink" runat="server"></mbll:listlink>
&nbsp;
<asp:RequiredFieldValidator ID="rfvMakes" Runat="server" ErrorMessage="Makes is required" ControlToValidate="ddlMakes"
	Display="Dynamic"></asp:RequiredFieldValidator>
&nbsp;
<asp:RequiredFieldValidator ID="rfvModels" Runat="server" ErrorMessage="Models is required" ControlToValidate="ddlModels"
	Display="Dynamic"></asp:RequiredFieldValidator>
