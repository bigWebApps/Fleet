<%@ Page language="c#" Codebehind="ok_mainMenu.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_mainMenu" %>
<form id="Form1" method="post" runat="server">
	<table cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TBODY>
			<tr>
				<td align="center" colSpan="2">
					<h1><asp:label id="lblWelcome" runat="server"></asp:label></h1>
				</td>
			</tr>
			<tr>
				<td colSpan="2">
					<table cellSpacing="0" cellPadding="3" width="100%" border="0">
						<tr vAlign="middle">
							<td class="ok_maintext" align="center">Last Name</td>
							<td class="ok_maintext" align="center">PIN Code</td>
							<td align="center"></td>
						</tr>
						<TR>
							<TD align="center" width="33%"><asp:textbox id="tbLastName" runat="server" Width="200px" MaxLength="50" CssClass="ok_input_text"></asp:textbox></TD>
							<TD align="center" width="33%"><asp:textbox id="tbPIN" runat="server" Width="200px" MaxLength="10" CssClass="ok_input_text"
									TextMode="Password"></asp:textbox></TD>
							<TD align="center" width="34%"><asp:button id="btnLogin" runat="server" CssClass="ok_input_button" Text="Next >>"></asp:button></TD>
						</TR>
						<tr vAlign="middle">
							<td align="center"><asp:requiredfieldvalidator id="rfvLastName" runat="server" Display="Dynamic" Font-Size="14pt" ControlToValidate="tbLastName"
									ErrorMessage="Last Name is required"></asp:requiredfieldvalidator></td>
							<td align="center"><asp:requiredfieldvalidator id="rfvPIN" runat="server" Display="Dynamic" Font-Size="14pt" ControlToValidate="tbPIN"
									ErrorMessage="PIN is required"></asp:requiredfieldvalidator><br>
								<asp:regularexpressionvalidator id="revPIN" runat="server" Display="Dynamic" Font-Size="14pt" ControlToValidate="tbPIN"
									ErrorMessage="PIN must be from 4 digits and more" ValidationExpression="\d{4,}"></asp:regularexpressionvalidator></td>
							<td align="center"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colSpan="2"><asp:repeater id="repOrders" runat="server">
						<HeaderTemplate>
							<table class="tblStandard" borderColor="#9e755f" cellSpacing="0" cellPadding="5" border="2">
								<tr>
									<td class="tblSubHead1" class="ok_size" align="left" colspan="5" height="22">Current 
										Activity</td>
								</tr>
								<tr valign="middle" class="ag01">
									<td class="ok_size">Equipment</td>
									<td class="ok_size">Operator</td>
									<td class="ok_size">Technician</td>
									<td class="ok_size">Status</td>
									<td class="ok_size">Operator Status</td>
								</tr>
						</HeaderTemplate>
						<FooterTemplate>
	</table>
	</FooterTemplate>
	<ItemTemplate>
		<tr valign="middle" bgcolor="#FFFFCC" style="cursor:pointer;" onclick='<%# "javascript:document.location=\"ok_authCredentials.aspx?orderid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) + "\"" %>'>
			<td class="ok_size" align="center">
				<asp:Label runat="server" Font-Bold="True" Font-Size="16pt" Font-Underline="True" ForeColor="Blue" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>'>
				</asp:Label>
			</td>
			<td class="ok_size">
				<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
				</asp:Label>
			</td>
			<td class="ok_size">
				<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
				</asp:Label>
			</td>
			<td class="ok_size" bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.StatusColor")) %>'>
				<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
				</asp:Label>
			</td>
			<td class="ok_size" bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
				<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
				</asp:Label>
			</td>
		</tr>
	</ItemTemplate>
	<AlternatingItemTemplate>
		<tr valign="middle" style="cursor:pointer;" bgcolor="#FFF7BE" onclick='<%# "javascript:document.location=\"ok_authCredentials.aspx?orderid=" + Convert.ToString(DataBinder.Eval(Container, "DataItem.Id")) + "\"" %>'>
			<td class="ok_size" align="center">
				<asp:Label runat="server" Font-Bold="True" Font-Size="16pt" Font-Underline="True" ForeColor="Blue" Text='<%# DataBinder.Eval(Container, "DataItem.vchEquipId") %>'>
				</asp:Label>
			</td>
			<td class="ok_size">
				<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
				</asp:Label>
			</td>
			<td class="ok_size">
				<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TechName") %>'>
				</asp:Label>
			</td>
			<td class="ok_size" bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.StatusColor")) %>'>
				<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
				</asp:Label>
			</td>
			<td class="ok_size" bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
				<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
				</asp:Label>
			</td>
		</tr>
	</AlternatingItemTemplate>
	</asp:repeater></TD></TR>
	<tr>
		<td colSpan="2">
			<br>
			<br>
			<asp:HyperLink id="hlDeactivate" runat="server" NavigateUrl="selectMode.aspx" Font-Size="12pt">Deactivate Operator Kiosk Terminal</asp:HyperLink>
		</td>
	</tr>
	</TBODY></TABLE>
</form>
