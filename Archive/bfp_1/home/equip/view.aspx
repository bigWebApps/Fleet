<%@ Register TagPrefix="BFPCntrls" TagName="Header" Src="../../controls/Header.ascx" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Footer" Src="../../controls/Footer.ascx" %>
<%@ Page language="c#" Codebehind="view.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.home.equip._view" %>
<BFPCNTRLS:HEADER id="Header" runat="server" RightMenuSelected="0" LeftMenuSelected="0" SubTopMenuSelected="0"
	TopMenuSelected="1"></BFPCNTRLS:HEADER>
<FORM runat="server">
	<TABLE>
		<tr>
			<td class="bg03" colSpan="2">Main</td>
			<td><asp:LinkButton id="lnkEditMain" runat="server" OnClick="OnEditMainClick" CausesValidation="False">[edit]</asp:LinkButton></td>
		</tr>
		<tr>
			<td class="bg01">Equip Id</td>
			<td class="bg02"><asp:Label id="lbStrEquipId" runat="server">Label</asp:Label></td>
		</tr>
		<tr>
			<td class="bg01">Year</td>
			<td class="bg02"><asp:Label id="lbYear" runat="server">Label</asp:Label></td>
		</tr>
		<TR>
			<td class="bg01">Type</td>
			<td class="bg02"><asp:Label id="lbType" runat="server">Label</asp:Label></td>
		</TR>
		<tr>
			<td class="bg01">Make/Model</td>
			<td class="bg02"><asp:Label id="lbMake" runat="server">Label</asp:Label>
				/
				<asp:Label id="lbModel" runat="server">Label</asp:Label></td>
		</tr>
		<tr>
			<td class="bg01">Department</td>
			<td class="bg02"><asp:Label id="lbDept" runat="server">Label</asp:Label></td>
		</tr>
		<tr>
			<td class="bg01">Location</td>
			<td class="bg02"><asp:Label id="lbLoc" runat="server">Label</asp:Label></td>
		</tr>
		<TR>
			<td class="bg01">VIN/Serial #</td>
			<td class="bg02"><asp:Label id="lbVinSerial" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<TD class="bg01">Fuel Code</TD>
			<TD class="bg02">
				<asp:Label id="lbFuelCode" runat="server">Label</asp:Label></TD>
		</TR>
		<tr>
			<td class="bg01">Assigned To</td>
			<td class="bg02"><asp:Label id="lbAssignedTo" runat="server">Label</asp:Label></td>
		</tr>
		<TR>
			<TD></TD>
			<TD></TD>
		</TR>
		<tr>
			<td class="tblSubHead2" colSpan="2">Current Settings</td>
			<td><asp:LinkButton id="lnkEditMainAlt" runat="server" OnClick="OnEditMainAltClick" CausesValidation="False">[edit]</asp:LinkButton></td>
		</tr>
		<TR>
			<td class="bg01">Status</td>
			<td class="bg02"><asp:Label id="lbStatus" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">PM Schedule</td>
			<td class="bg02"><asp:Label id="lbPMSched" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Inspection</td>
			<td class="bg02"><asp:Label id="lbInspection" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Units (Mileage)</td>
			<td class="bg02"><asp:Label id="lbUnits" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<TD></TD>
			<TD></TD>
		</TR>
		<tr>
			<td class="tblSubHead2" colSpan="2">Aquisition Information</td>
			<td><asp:LinkButton id="lnkEditAquis" runat="server" OnClick="OnEditAquisClick" CausesValidation="False">[edit]</asp:LinkButton></td>
		</tr>
		<tr>
			<td class="bg01">Date In Service</td>
			<td class="bg02"><asp:Label id="lbDtInService" runat="server">Label</asp:Label></td>
		</tr>
		<tr>
			<td class="bg01">Date Aquired</td>
			<td class="bg02"><asp:Label id="lbDtAquired" runat="server">Label</asp:Label></td>
		</tr>
		<TR>
			<td class="bg01">Org/Contact</td>
			<td class="bg02"><asp:Label id="lbVchPurOrgContact" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Amount</td>
			<td class="bg02"><asp:Label id="lbSmPurAmount" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Units</td>
			<td class="bg02"><asp:Label id="lbIntPurUnits" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Notes</td>
			<td class="bg02"><asp:Label id="lbVchPurNotes" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<TD></TD>
			<TD></TD>
		</TR>
		<TR>
			<TD class="tblSubHead2" colSpan="2">Disposal Information</TD>
			<td><asp:LinkButton id="lnkEditDisp" runat="server" OnClick="OnEditDispClick" CausesValidation="False">[edit]</asp:LinkButton></td>
		</TR>
		<TR>
			<td class="bg01">dtOutService</td>
			<td class="bg02"><asp:Label id="lbDtOutOfService" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">dtDisposed</td>
			<td class="bg02"><asp:Label id="lbDtDisposed" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Disposed Via</td>
			<td class="bg02"><asp:Label id="lbVchDispMethod" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Org/Contact</td>
			<td class="bg02"><asp:Label id="lbVchDispOrgContact" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Amount</td>
			<td class="bg02"><asp:Label id="lbSmDispAmount" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Units</td>
			<td class="bg02"><asp:Label id="lbIntDispUnits" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Notes</td>
			<td class="bg02"><asp:Label id="lbVchDispNotes" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<TD></TD>
			<TD></TD>
		</TR>
		<TR>
			<TD class="tblSubHead2" colSpan="2">Transmission</TD>
			<td><asp:LinkButton id="Linkbutton4" runat="server" OnClick="OnEditTransClick">[edit]</asp:LinkButton></td>
		</TR>
		<TR>
			<td class="bg01">Make</td>
			<td class="bg02"><asp:Label id="lbTranMake" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Model</td>
			<td class="bg02"><asp:Label id="tbTransModel" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Part#</td>
			<td class="bg02"><asp:Label id="lbTranPart" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Serial #</td>
			<td class="bg02"><asp:Label id="lbTranSerial" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<TD></TD>
			<TD></TD>
		</TR>
		<TR>
			<TD class="tblSubHead2" colSpan="2">Engine</TD>
			<td><asp:LinkButton id="Linkbutton6" runat="server" OnClick="OnEditEngineClick">[edit]</asp:LinkButton></td>
		</TR>
		<TR>
			<td class="bg01">Make</td>
			<td class="bg02"><asp:Label id="lbEngineMake" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Model</td>
			<td class="bg02"><asp:Label id="lbEngineModel" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Part #</td>
			<td class="bg02"><asp:Label id="lbEnginePart" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<td class="bg01">Serial #</td>
			<td class="bg02"><asp:Label id="lbEngineSerial" runat="server">Label</asp:Label></td>
		</TR>
		<TR>
			<TD></TD>
			<TD></TD>
		</TR>
		<TR>
			<TD class="tblSubHead2" colSpan="2">Chasis</TD>
			<TD>
				<asp:LinkButton id="lbEditChasis" onclick="OnEditChasisClick" runat="server">[edit]</asp:LinkButton></TD>
		</TR>
		<TR>
			<TD class="bg01">Make</TD>
			<TD class="bg02">
				<asp:Label id="lblChasisMake" runat="server"></asp:Label></TD>
		</TR>
		<TR>
			<TD class="bg01">Chasis #</TD>
			<TD class="bg02">
				<asp:Label id="lblChasisNumber" runat="server"></asp:Label></TD>
		</TR>
		<TR>
			<TD></TD>
			<TD></TD>
		</TR>
		<TR>
			<TD class="tblSubHead2" colspan="2">Bus Type Only Custom</TD>
			<td><asp:LinkButton id="Linkbutton5" runat="server" OnClick="OnEditMainClick">[edit]</asp:LinkButton></td>
		</TR>
		<TR>
			<TD class="bg01">License Plate</TD>
			<TD class="bg02"></TD>
		</TR>
		<TR>
			<TD class="bg01">Passengers</TD>
			<TD class="bg02"></TD>
		</TR>
		<TR>
			<TD class="bg01">Bus Type</TD>
			<TD class="bg02">Conventional/Special Need/Transit</TD>
		</TR>
		<TR>
			<TD class="bg01">Bus Use (select)</TD>
			<TD class="bg02">Route Bus (checkbox) Route or Spare</TD>
		</TR>
		<TR>
			<TD class="bg01">Body #</TD>
			<TD class="bg02"></TD>
		</TR>
	</TABLE>
</FORM>
<BFPCNTRLS:FOOTER id="Footer" runat="server"></BFPCNTRLS:FOOTER>
