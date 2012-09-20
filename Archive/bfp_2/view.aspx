<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Page language="c#" Codebehind="view.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._view" %>
<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<form id="Form1" method="post" runat="server">
	<TABLE>
		<tr>
			<td class="tblSubHead1" colSpan="2">Main</td>
			<td><asp:linkbutton id="lnkEditMain" onclick="OnEditMainClick" runat="server" CausesValidation="False">[edit]</asp:linkbutton></td>
		</tr>
		<!-- here variable fileds -->
		<asp:Repeater id="repCustomFields" runat="server">
			<ItemTemplate>
				<TR>
					<TD class="bg01">
						<asp:Label id="lblValueName" runat="server">
							<%# DataBinder.Eval(Container, "DataItem.ValueName") %>
						</asp:Label>
					</TD>
					<TD class="bg02" width="66%">
						<asp:Label id="lblValue" runat="server">
							<%# DataBinder.Eval(Container, "DataItem.Value") %>
						</asp:Label></TD>
				</TR>
			</ItemTemplate>
		</asp:Repeater>
		<tr>
			<td class="tblSubHead2" colSpan="2">Current Settings</td>
			<td><asp:linkbutton id="lnkEditMainAlt" onclick="OnEditMainAltClick" runat="server" CausesValidation="False">[edit]</asp:linkbutton></td>
		</tr>
		<TR>
			<td class="bg01">Status</td>
			<td class="bg02"><asp:label id="lbStatus" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">PM Schedule</td>
			<td class="bg02"><asp:label id="lbPMSched" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">Inspection</td>
			<td class="bg02"><asp:label id="lbInspection" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">Units (Mileage)</td>
			<td class="bg02"><asp:label id="lbUnits" runat="server"></asp:label></td>
		</TR>
		<TR>
			<TD></TD>
			<TD></TD>
		</TR>
		<tr>
			<td class="tblSubHead2" colSpan="2">Aquisition Information</td>
			<td><asp:linkbutton id="lnkEditAquis" onclick="OnEditAquisClick" runat="server" CausesValidation="False">[edit]</asp:linkbutton></td>
		</tr>
		<tr>
			<td class="bg01">Date In Service</td>
			<td class="bg02"><asp:label id="lbDtInService" runat="server"></asp:label></td>
		</tr>
		<tr>
			<td class="bg01">Date Aquired</td>
			<td class="bg02"><asp:label id="lbDtAquired" runat="server"></asp:label></td>
		</tr>
		<TR>
			<td class="bg01">Org/Contact</td>
			<td class="bg02"><asp:label id="lbVchPurOrgContact" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">Amount</td>
			<td class="bg02"><asp:label id="lbSmPurAmount" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">Units</td>
			<td class="bg02"><asp:label id="lbIntPurUnits" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">Notes</td>
			<td class="bg02"><asp:label id="lbVchPurNotes" runat="server"></asp:label></td>
		</TR>
		<TR>
			<TD></TD>
			<TD></TD>
		</TR>
		<TR>
			<TD class="tblSubHead2" colSpan="2">Disposal Information</TD>
			<td><asp:linkbutton id="lnkEditDisp" onclick="OnEditDispClick" runat="server" CausesValidation="False">[edit]</asp:linkbutton></td>
		</TR>
		<TR>
			<td class="bg01">dtOutService</td>
			<td class="bg02"><asp:label id="lbDtOutOfService" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">dtDisposed</td>
			<td class="bg02"><asp:label id="lbDtDisposed" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">Disposed Via</td>
			<td class="bg02"><asp:label id="lbVchDispMethod" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">Org/Contact</td>
			<td class="bg02"><asp:label id="lbVchDispOrgContact" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">Amount</td>
			<td class="bg02"><asp:label id="lbSmDispAmount" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">Units</td>
			<td class="bg02"><asp:label id="lbIntDispUnits" runat="server"></asp:label></td>
		</TR>
		<TR>
			<td class="bg01">Notes</td>
			<td class="bg02"><asp:label id="lbVchDispNotes" runat="server"></asp:label></td>
		</TR>
		<TR>
			<TD></TD>
			<TD></TD>
		</TR>
		<asp:Repeater id="repComponents" runat="server">
			<ItemTemplate>
				<tr>
					<td class="tblSubHead2" colSpan="2">
						<asp:label id="lblComponentName" runat="server">
							<%# DataBinder.Eval(Container.DataItem, "ComponentName") %>
						</asp:label>
					</td>
					<td>
						<asp:HyperLink id="hlLinkToEdit" runat="server" NavigateUrl='<%# "editComponent.aspx?id=" + DataBinder.Eval(Container.DataItem, "ComponentId") %>'>[edit]</asp:HyperLink>
					</td>
				</tr>
				<asp:Repeater id="repComponentItem" runat="server">
					<ItemTemplate>
						<tr>
							<td class="bg01">
								<asp:Label id="lblValueName_Comp" runat="server">
									<%# Convert.ToString(DataBinder.Eval(Container.DataItem, "ValueName_Comp")) %>
								</asp:Label>
							</td>
							<td class="bg02">
								<asp:Label id="lblValue_Comp" runat="server">
									<%# Convert.ToString(DataBinder.Eval(Container.DataItem, "Value_Comp")) %>
								</asp:Label>
							</td>
							<td>&nbsp;</td>
						</tr>
					</ItemTemplate>
				</asp:Repeater>
				<tr>
					<td class="bg01">
						Component Status
					</td>
					<td class="bg02">
						<asp:Label id="lblActive" runat="server">
							<%# DataBinder.Eval(Container.DataItem, "Active") %>
						</asp:Label>
					</td>
				</tr>
			</ItemTemplate>
		</asp:Repeater>
		<tr>
			<td class="tblSubHead2" colspan="2">Choose the Component's type:
				<asp:DropDownList id="ddlComponentTypes" runat="server"></asp:DropDownList>
			</td>
			<td>
				<asp:LinkButton id="lbAddComponent" runat="server">[add]</asp:LinkButton></td>
		</tr>
	</TABLE>
</form>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
