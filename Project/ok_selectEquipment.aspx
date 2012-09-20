<%@ Page language="c#" Codebehind="ok_selectEquipment.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_selectEquipment" %>
<form id="Form1" method="post" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TBODY>
			<TR>
				<TD width="50%"><BR>
					<BR>
				</TD>
				<td width="50%"></td>
			</TR>
			<asp:panel id="pnlOneEquipment" runat="server" Visible="False"> <!-- one equipment -->
				<TR>
					<TD align="center" colSpan="2">
						<H1>
							<asp:Label id="lblFirstName1" runat="server"></asp:Label>, are you checking-in
							<BR>
							<asp:Label id="lblEquipType" runat="server"></asp:Label>&nbsp;#
							<asp:Label id="lblEquipId" runat="server"></asp:Label>&nbsp; (
							<asp:Label id="lblMakeModel" runat="server"></asp:Label>&nbsp;-&nbsp;
							<asp:Label id="lblYear" runat="server"></asp:Label>)&nbsp;today?
						</H1>
						<BR>
						<BR>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:Button id="btnNO1" runat="server" CssClass="ok_input_button" Text="   NO   "></asp:Button></TD>
					<TD align="center">
						<asp:Button id="btnYES1" runat="server" CssClass="ok_input_button" Text="  YES  "></asp:Button></TD>
				</TR>
			</asp:panel>
			<asp:panel id="pnlManyEquipment" runat="server" Visible="False"> <!-- more than one equipment-->
				<TR>
					<TD align="center" colSpan="2">
						<H1><asp:label id="lblFirstName2" runat="server"></asp:label>, which equipment are 
							you checking-in today?
							<br>
							Please select the assigned equipments
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
										<asp:Label id="lbMakeName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MakeName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label id="lbModelName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ModelName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label id="lbYear" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Year") %>'>
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
										<asp:Label id="lbMakeName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MakeName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label id="lbModelName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ModelName") %>'>
										</asp:Label>
									</td>
									<td class="ok_size">
										<asp:Label id="lbYear" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Year") %>'>
										</asp:Label>
									</td>
								</tr>
							</AlternatingItemTemplate>
							<FooterTemplate>
	</TABLE>
	</FooterTemplate> </asp:repeater><br>
	<br>
	</TD></TR>
	<tr>
		<td class="ok_maintext" align="center" colSpan="2">-- OR --
		</td>
	</tr>
	<tr>
		<td align="center" colSpan="2"><br>
			<asp:linkbutton id="lbFindEquipment" runat="server" Font-Size="18pt" Font-Bold="True">None of these</asp:linkbutton></td>
	</tr>
	</asp:panel>
	<asp:panel id="pnlFindEquipment" runat="server" Visible="False"> <!-- no equipment -->
		<TR>
			<TD align="center" colSpan="2">
				<H1>
					<asp:Label id="lblFirstName3" runat="server"></asp:Label>, please enter the 
					number of the equipment you wish to check-in
					<BR>
				</H1>
				<BR>
				<BR>
			</TD>
		</TR>
		<TR vAlign="middle">
			<TD class="ok_maintext" align="center" colSpan="2">Bus #:
				<asp:textbox onkeypress="return(clickButton(document.Form1.btnFind));" id="tbEquipId" runat="server"
					CssClass="ok_input_text" AutoPostBack="True" Width="300px" MaxLength="50"></asp:textbox></TD>
		</TR>
		<TR>
			<TD align="center" colSpan="2"><BR>
				<BR>
				<asp:Button id="btnFind" runat="server" CssClass="ok_input_button" Text="  Find  "></asp:Button></TD>
		</TR>
		<TR>
			<TD colSpan="2"><BR>
				<BR>
				<asp:Label id="lblError" runat="server" Visible="False" Font-Size="12pt">
					<ul type="disc">
						<li style="color:red">
							The specified equipment could not be located;</li>
						<li style="color:blue">
							If equipment already checked-in for service then this equipment cannot be 
							available too;
						</li>
						<li style="color:blue">
							If the system is unable to locate the equipment you are checking in please 
							contact <a style="font-size:12pt" href="mailto:project.bfp@micajah.com">System 
								Administrator</a> for assistance.</li>
					</ul>
				</asp:Label></TD>
		</TR>
	</asp:panel>
	<tr>
		<td align="center" colSpan="2"><br>
			<br>
			<br>
			<br>
			<INPUT id="btnBack" runat="server" class="ok_input_button" tabIndex="3" type="button" value="<< Back"
				size="20">
		</td>
	</tr>
	</TBODY></TABLE></form>
