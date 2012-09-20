<%@ Page language="c#" Codebehind="ok_mainMenu2.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.operatorkiosk._ok_mainMenu2" %>
<form id="Form1" method="post" runat="server">
	<table cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TBODY>
			<tr>
				<td align="center" colSpan="2">
					<h1><asp:label id="lblFirstName" runat="server"></asp:label>, Select equipment or 
						enter the equipment number to continue.
					</h1>
				</td>
			</tr>
			<tr>
				<td class="ok_maintext" align="center" colSpan="2">Enter Equipment #
					<asp:textbox id="tbEquipmentId" runat="server" CssClass="ok_input_text" onkeypress="return(clickButton(document.Form1.btnFind));"
						AutoPostBack="True" Width="300px" MaxLength="50"></asp:textbox>&nbsp;
					<asp:Button id="btnFind" runat="server" CssClass="ok_input_button" Text="  Find  "></asp:Button><br>
					<br>
				</td>
			</tr>
			<tr>
				<td colSpan="2"><asp:repeater id="repEquipments" runat="server">
						<ItemTemplate>
							<tr valign="middle" bgcolor="#FFFFCC" style="cursor:pointer;" onclick='<%# "javascript:document.location=\"" + Convert.ToString(DataBinder.Eval(Container, "DataItem.vchLink")) + "&back=mainmenu2\"" %>'>
								<td class="ok_size" align="center">
									<asp:Label id="lbEquipId" runat="server" Font-Bold="True" Font-Size="16pt" Font-Underline="True" ForeColor="Blue" Text='<%# DataBinder.Eval(Container, "DataItem.EquipId") %>'>
									</asp:Label>
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
									<asp:Label id="lbOperator" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
									</asp:Label>
								</td>
							</tr>
						</ItemTemplate>
						<AlternatingItemTemplate>
							<tr valign="middle" bgcolor="#FFF7BE" style="cursor:pointer;" onclick='<%# "javascript:document.location=\"" + Convert.ToString(DataBinder.Eval(Container, "DataItem.vchLink")) + "&back=mainmenu2\"" %>'>
								<td class="ok_size" align="center">
									<asp:Label id="lbEquipId" runat="server" Font-Bold="True" Font-Size="16pt" Font-Underline="True" ForeColor="Blue" Text='<%# DataBinder.Eval(Container, "DataItem.EquipId") %>'>
									</asp:Label>
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
									<asp:Label id="lbOperator" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
									</asp:Label>
								</td>
							</tr>
						</AlternatingItemTemplate>
						<HeaderTemplate>
							<table class="tblStandard" borderColor="#9e755f" cellSpacing="0" cellPadding="10" border="2">
								<tr valign="middle" class="ag01">
									<td class="ok_size" align="center">Equipment Id</td>
									<td class="ok_size">Type</td>
									<td class="ok_size">Make</td>
									<td class="ok_size">Model</td>
									<td class="ok_size">Operator</td>
								</tr>
						</HeaderTemplate>
						<FooterTemplate>
	</table>
	</FooterTemplate> </asp:repeater></TD></TR>
	<tr>
		<td align="center"><br>
			<br>
			<INPUT class="ok_input_button" onclick="javascript:document.location='ok_mainMenu.aspx'"
				type="button" value="<< Back">
		</td>
	</tr>
	</TBODY></TABLE></form>
