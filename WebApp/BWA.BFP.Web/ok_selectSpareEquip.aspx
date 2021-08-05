<%@ Page language="c#" Codebehind="ok_selectSpareEquip.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_selectSpareEquip" %>
<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" id="Table1">
		<TBODY>
			<tr>
				<TD width="50%"><BR>
				</TD>
				<td width="50%"></td>
			</tr>
			<asp:panel id="pnlViewQuestion" runat="server" Visible="False">
				<TR>
					<TD align="center" colSpan="2"><BR>
						<BR>
						<H1>
							<asp:Label id="lblFirstName" runat="server"></asp:Label>, Will you be checking 
							out a spare
							<asp:Label id="lblEquipType" runat="server"></asp:Label>&nbsp;today?
						</H1>
						<BR>
						<BR>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:Button id="btnNO" runat="server" CssClass="ok_input_button" Text="   NO   "></asp:Button></TD>
					<TD align="center">
						<asp:Button id="btnYES" runat="server" CssClass="ok_input_button" Text="  YES  "></asp:Button></TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2"><BR>
						<BR>
						<BR>
						<BR>
						<BR>
						<BR>
						<asp:Button id="btnBack" runat="server" CssClass="ok_input_button" Text="<< Back"></asp:Button></TD>
					</TD></TR>
			</asp:panel>
			<asp:panel id="pnlSelectSpare" runat="server" Visible="False">
				<TR>
					<TD align="center" colSpan="2">
						<H1>Please select the spare equipment from the list below
						</H1>
					</TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2">
						<asp:Repeater id="repSpareEquip" runat="server">
							<HeaderTemplate>
								<table class="tblStandard" borderColor="#9e755f" cellSpacing="0" cellPadding="10" border="2">
									<tr valign="middle" class="ag01">
										<td class="ok_size" align="center">Equipment Id</td>
										<td class="ok_size">Department</td>
										<td class="ok_size">Location</td>
										<td class="ok_size">Make</td>
										<td class="ok_size">ModelName</td>
									</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr valign="middle" bgcolor="#FFFFCC">
									<td class="ok_size" align="center">
										<asp:LinkButton runat="server" Font-Bold="True" Font-Size="16pt" id="lbEquipId" CommandName="Select" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' Text='<%# DataBinder.Eval(Container, "DataItem.EquipId") %>'>
										</asp:LinkButton>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DeptName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LocName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MakeName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ModelName") %>'>
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="middle" bgcolor="#FFF7BE">
									<td class="ok_size" align="center">
										<asp:LinkButton runat="server" Font-Bold="True" Font-Size="16pt" id="lblEquipId" CommandName="Select" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' Text='<%# DataBinder.Eval(Container, "DataItem.EquipId") %>'>
										</asp:LinkButton>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DeptName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LocName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MakeName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ModelName") %>'>
										</asp:Label>
									</td>
								</tr>
							</AlternatingItemTemplate>
							<FooterTemplate>
	</TABLE>
	</FooterTemplate> </asp:Repeater><br>
	<br>
	<br>
	<asp:Button id="btnBackInt" runat="server" Text="<< Back" CssClass="ok_input_button"></asp:Button></TD></TR></asp:panel>
	<asp:panel id="pnlNoSpare" runat="server" Visible="False">
		<TR>
			<TD align="center" colSpan="2">
				<H1>No spare equipment is available for check-out, please continue the check-in 
					process. You may contact an adminstrator for further assistance after you 
					complete the check-in process.
				</H1>
			</TD>
		</TR>
		<TR>
			<TD align="center" colSpan="2"><BR>
				<BR>
				<BR>
				<uc1:nextback id="NextBackControl" runat="server"></uc1:nextback></TD>
		</TR>
	</asp:panel>
	<TR>
		<TD align="center" colSpan="2">
		</TD>
	</TR>
	</TBODY></TABLE>
</form>