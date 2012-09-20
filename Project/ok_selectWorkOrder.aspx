<%@ Page language="c#" Codebehind="ok_selectWorkOrder.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_selectWorkOrder" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TBODY>
			<TR>
				<TD width="50%"><BR>
					<BR>
				</TD>
				<td width="50%"></td>
			</TR>
			<asp:panel id="pnlOneEquipment" runat="server" Visible="False">
				<TR>
					<TD align="center" colSpan="2">
						<H1>
							<asp:Label id="lblFirstName1" runat="server"></asp:Label>, are you checking-out
							<BR>
							<asp:Label id="lblEquipType" runat="server"></asp:Label>&nbsp;#
							<asp:Label id="lblEquipId" runat="server"></asp:Label>&nbsp;now?
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
			</asp:panel>
			<asp:panel id="pnlManyEquipment" runat="server" Visible="False"> <!-- more than one equipment-->
				<TR>
					<TD align="center" colSpan="2">
						<H1><asp:label id="lblFirstName2" runat="server"></asp:label>, which equipment are 
							you checking-out now?
							<br>
							Please select&nbsp;available equipments for check-out
						</H1>
						<br>
						<br>
					</TD>
				</TR>
				<tr>
					<td colSpan="2"><asp:repeater id="repEquipments" runat="server">
							<HeaderTemplate>
								<table class="tblStandard" borderColor="#9e755f" cellSpacing="0" cellPadding="10" border="2">
									<tr valign="middle" class="ag01">
										<td class="ok_size" align="center">Equipment Id</td>
										<td class="ok_size">Type</td>
										<td class="ok_size">Make</td>
										<td class="ok_size">Model</td>
										<td class="ok_size">Year</td>
										<td class="ok_size">Operator</td>
									</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr valign="middle" bgcolor="#FFFFCC">
									<td class="ok_size" align="center">
										<asp:LinkButton runat="server" Font-Bold="True" Font-Size="16pt" id="lbEquipId" CommandName="Select" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' Text='<%# DataBinder.Eval(Container, "DataItem.EquipId") %>'>
										</asp:LinkButton>
									</td>
									<td class="ok_size">
										<asp:Label id="lbEquipType" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
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
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Year") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
										</asp:Label>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr valign="middle" bgcolor="#FFF7BE">
									<td class="ok_size" align="center">
										<asp:LinkButton id="lbEquipId" Font-Bold="True" Font-Size="16pt" runat="server" CommandName="Select" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' Text='<%# DataBinder.Eval(Container, "DataItem.EquipId") %>'>
										</asp:LinkButton>
									</td>
									<td class="ok_size">
										<asp:Label id="lbEquipType" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
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
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Year") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
										</asp:Label>
									</td>
								</tr>
							</AlternatingItemTemplate>
							<FooterTemplate>
	</TABLE>
	</FooterTemplate> </asp:repeater><br>
	<br>
	</TD></TR></asp:panel>
	<asp:panel id="pnlNoneEquipment" runat="server" Visible="False"> <!-- no equipment -->
		<TR>
			<TD align="center" colSpan="2">
				<H1>
					<asp:Label id="lblFirstName3" runat="server"></asp:Label>,&nbsp;the system 
					hasn't any equipments available for check-out, please go back and wait till the 
					service will be completed
					<BR>
				</H1>
				<BR>
				<BR>
			</TD>
		</TR>
	</asp:panel>
	<tr>
		<td align="center" colSpan="2"><br>
			<br>
			<br>
			<br>
			<INPUT class="ok_input_button" onclick="javascript:document.location='ok_mainMenu.aspx'"
				type="button" value="<< Back">
		</td>
	</tr>
	</TBODY></TABLE></form>
