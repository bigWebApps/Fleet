<%@ Page language="c#" Codebehind="error_report.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.error._error_report" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<BFPCNTRLS:HEADER id="Header" runat="server" TopMenuSelected="1" SubTopMenuSelected="0" LeftMenuSelected="0"
	RightMenuSelected="0"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<table cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr>
			<td colSpan="5">Choose the period of error report</td>
		</tr>
		<tr>
			<td nowrap>From:&nbsp;</td>
			<td nowrap><cc1:activedatetime id="adtReportFrom" runat="server" Format="MONTH;/;DAY;/;YEAR" MaxYear="2010" MinYear="1970"
					AlertEnabled="True" AllowNull="False" Enabled="True"></cc1:activedatetime></td>
			<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;To:&nbsp;</td>
			<TD nowrap><cc1:activedatetime id="adtReportTo" runat="server" Format="MONTH;/;DAY;/;YEAR" MaxYear="2010" MinYear="1970"
					AlertEnabled="True" AllowNull="False" Enabled="True"></cc1:activedatetime></TD>
			<td width="100%">&nbsp;
				<asp:Button id="btnShow" runat="server" Text="Report"></asp:Button></td>
		</tr>
		<tr>
			<td colspan="5">
				&nbsp;</td>
		</tr>
		<tr>
			<td colSpan="5"><mits:datagrid_a id="dgErrorsList" runat="server" ColorScheme="Yellow" AutoGenerateColumns="False"
					Width="100%" DataKeyField="Id">
<Columns>
<asp:TemplateColumn HeaderText="View">
<HeaderStyle HorizontalAlign="Center">
</HeaderStyle>

<ItemStyle HorizontalAlign="Center">
</ItemStyle>

<ItemTemplate>
								<asp:HyperLink id="hlDetail" runat="server" NavigateURL='<%# "error_report_detail.aspx?id=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) %>'>Detail</asp:HyperLink>
							
</ItemTemplate>
</asp:TemplateColumn>
<asp:TemplateColumn HeaderText="Error #">
<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
								</asp:Label>
							
</ItemTemplate>
</asp:TemplateColumn>
<asp:TemplateColumn HeaderText="User">
<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserName") %>'>
								</asp:Label>
							
</ItemTemplate>
</asp:TemplateColumn>
<asp:TemplateColumn HeaderText="Organization">
<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OrgName") %>'>
								</asp:Label>
							
</ItemTemplate>
</asp:TemplateColumn>
<asp:TemplateColumn HeaderText="Page Name">
<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchPageName") %>'>
								</asp:Label>
							
</ItemTemplate>
</asp:TemplateColumn>
<asp:TemplateColumn HeaderText="Date">
<ItemTemplate>
								<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.dtCreated")).ToString("g") %>'>
								</asp:Label>
							
</ItemTemplate>
</asp:TemplateColumn>
</Columns>

<PagerStyle Mode="NumericPages">
</PagerStyle>
				</mits:datagrid_a>
			</td>
		</tr>
	</table>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
