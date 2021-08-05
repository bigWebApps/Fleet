<%@ Page Language="c#" CodeBehind="ok_addIssues.aspx.cs" AutoEventWireup="false"
    Inherits="BWA.BFP.Web.operatorkiosk._ok_addIssues" %>

<form id="Form1" method="post" runat="server">
<table cellspacing="0" cellpadding="0" width="100%" border="0">
    <tbody>
        <tr>
            <td width="50%">
                <br>
            </td>
            <td width="50%">
            </td>
        </tr>
        <asp:panel id="pnlViewIssues" runat="server" visible="False">
				<TR>
					<TD colSpan="2">
						<TABLE class="tblStandard" borderColor="#9e755f" cellSpacing="0" cellPadding="10" border="2">
							<TR>
								<TD class="tblSubHead1" align="left" colSpan="4" height="22"><FONT class="ok_size3">Current 
										list of reported issues for&nbsp;
										<asp:Label id="lblEquipType" runat="server"></asp:Label>&nbsp;#
										<asp:label id="lblEquipId" runat="server"></asp:label></FONT></TD>
							</TR>
							<TR class="ag01" vAlign="middle">
								<TD class="ok_size">Repair Category</TD>
								<TD class="ok_size" align="center">Status</TD>
								<TD class="ok_size">Issue</TD>
								<TD class="ok_size" align="center">Date Report</TD>
							</TR>
							<asp:Repeater id="repIssues" runat="server">
								<ItemTemplate>
									<tr valign="middle" bgcolor="#FFFFCC">
										<td class="ok_size">
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
											</asp:Label>
										</td>
										<td class="ok_size" align="center">
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
											</asp:Label>
										</td>
										<td class="ok_size">
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
											</asp:Label>
										</td>
										<td class="ok_size" align="center">
											<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.ReportDate")).ToString("yyyy-MM-dd") %>'>
											</asp:Label>
										</td>
									</tr>
								</ItemTemplate>
								<AlternatingItemTemplate>
									<tr valign="middle" bgcolor="#FFF7BE">
										<td class="ok_size">
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CategoryName") %>'>
											</asp:Label>
										</td>
										<td class="ok_size" align="center">
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
											</asp:Label>
										</td>
										<td class="ok_size">
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
											</asp:Label>
										</td>
										<td class="ok_size" align="center">
											<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.ReportDate")).ToString("yyyy-MM-dd") %>'>
											</asp:Label>
										</td>
									</tr>
								</AlternatingItemTemplate>
							</asp:Repeater>
							<TR>
								<TD colSpan="4">
									<TABLE id="html_tblNoneIssues" cellSpacing="0" cellPadding="0" width="100%" border="0"
										runat="server">
										<TR>
											<TD class="ok_size" align="center"><FONT color="red">No reported issues currently found 
													for this equipment.</FONT></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2"><BR>
						<H1>
							<asp:Label id="lblFirstName" runat="server"></asp:Label>, do you have any 
							additional reported issues to report?
						</H1>
						<BR>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:Button id="btnNO" runat="server" Text="   NO   " CssClass="ok_input_button"></asp:Button></TD>
					<TD align="center">
						<asp:Button id="btnYES" runat="server" Text="  YES  " CssClass="ok_input_button"></asp:Button></TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2"><BR>
						<BR>
						<BR>
						<asp:Button id="btnBack" runat="server" Text="<< Back" CssClass="ok_input_button" CausesValidation="False"></asp:Button></TD>
				</TR>
			</asp:panel>
        <asp:panel id="pnlSelectCategory" runat="server" visible="False">
				<TR>
					<TD align="center" colSpan="2">
						<H1>Please select the repair category of additional issue
						</H1>
					</TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2">
					    <asp:DataList id="repCategories" runat="server">
							<ItemTemplate>
										<asp:LinkButton id="lbSelectCategory" runat="server" Font-Size="24pt" Text='<%# DataBinder.Eval(Container, "DataItem.vchName") %>' CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' CommandName="Select">
										</asp:LinkButton>
							</ItemTemplate>
					    </asp:DataList></TD></TR>
	<TR>
		<TD align="center" colSpan="2"><BR>
			<BR>
			<BR>
			<asp:Button id="btnBack1" runat="server" Text="<< Back" CssClass="ok_input_button" CausesValidation="False"></asp:Button></TD>
	</TR>
	</asp:panel>
        <asp:panel id="pnlEnterIssue" runat="server" visible="False">
		<TR>
			<TD align="center" colSpan="2"><BR>
				<H1>Please enter a brief description
					<BR>
					for this&nbsp;reported issue
				</H1>
				<BR>
				<BR>
			</TD>
		</TR>
		<TR>
			<TD align="center" colSpan="2">
				<asp:TextBox id="tbNotes" runat="server" Font-Size="14pt" TextMode="MultiLine" Width="500px"
					Height="100px"></asp:TextBox><BR>
				<asp:RequiredFieldValidator id="rfvNotes" runat="server" Font-Size="14pt" ErrorMessage="Comments is required"
					ControlToValidate="tbNotes"></asp:RequiredFieldValidator></TD>
		</TR>
		<TR>
			<TD align="center" colSpan="2"><BR>
				<asp:Button id="btnSaveNote" runat="server" Text="  Save  " CssClass="ok_input_button"></asp:Button></TD>
		</TR>
		<TR>
			<TD align="center" colSpan="2"><BR>
				<BR>
				<BR>
				<asp:Button id="btnBack2" runat="server" Text="<< Back" CssClass="ok_input_button" CausesValidation="False"></asp:Button></TD>
		</TR>
	</asp:panel>
        <tr>
            <td align="center" colspan="2">
            </td>
        </tr>
    </tbody>
</table>
</form>
