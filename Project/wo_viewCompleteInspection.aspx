<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Page language="c#" Codebehind="wo_viewCompleteInspection.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_viewCompleteInspection" %>
<META http-equiv="Content-Type" content="text/html; charset=windows-1251">
<form id="formCompleteInspection" method="post" runat="server">
	<table id="tableMain" runat="server">
		<TBODY>
			<tr>
				<td class="tblSubHead1" align="left" colSpan="2">
					Inspection info</td>
			</tr>
			<tr vAlign="top">
				<td class="bg01">Inspection Name</td>
				<td class="bg02"><asp:label id="lblInspectName" runat="server"></asp:label></td>
			</tr>
			<TR>
				<TD class="bg01">Inspection Schedule</TD>
				<TD class="bg02">
					<asp:label id="lblInspectSchedule" runat="server"></asp:label></TD>
			</TR>
			<tr vAlign="top">
				<td class="bg01">Traget Days Out</td>
				<td class="bg02"><asp:label id="lblTargetDaysOut" runat="server"></asp:label></td>
			</tr>
			<tr>
				<td class="tblSubHead2" align="left" colSpan="2">
					Equipment info</td>
			</tr>
			<tr vAlign="top">
				<td class="bg01">Equipment #</td>
				<td class="bg02" colSpan="2"><asp:label id="lblEquipId" runat="server"></asp:label></td>
			</tr>
			<tr vAlign="top">
				<td class="bg01">Make</td>
				<td class="bg02"><asp:label id="lblEquipMake" runat="server"></asp:label></td>
			</tr>
			<tr vAlign="top">
				<td class="bg01">Model</td>
				<td class="bg02"><asp:label id="lblEquipModel" runat="server"></asp:label></td>
			</tr>
			<tr>
				<td class="tblSubHead2" width="100%" colSpan="2">Documents Print
				</td>
			</tr>
			<tr>
				<td class="bg01">Print Inspection Request</td>
				<TD class="bg02"><asp:hyperlink id="hlPrintInspectRequest" runat="server" Target="_blank">[Inspection Request]</asp:hyperlink></TD>
			</tr>
			<tr>
				<td class="bg01">Print Completed Inspection</td>
				<TD class="bg02" colSpan="2"><asp:hyperlink id="hlPrintCompletedInstect" runat="server" Target="_blank">[Completed Inspection]</asp:hyperlink></TD>
			</tr>
			<TR>
				<TD colSpan="2"><br>
				</TD>
			</TR>
			<tr>
				<td bgColor="#000000" colSpan="2"></td>
			</tr>
			<TR>
				<TD colSpan="2"><br>
				</TD>
			</TR>
			<tr>
				<td class="tblSubHead2" align="left" colSpan="2">The inspection items list
				</td>
			</tr>
			<tr vAlign="top">
				<td colSpan="2">
					<asp:repeater id="repInspectItems" runat="server">
						<HeaderTemplate>
							<table style="border-color:#CCCCCC;border-width:1px;border-style:solid;width:100%;border-collapse:collapse;"
								cellSpacing="0" cellPadding="1" border="1" rules="cols" borderColor="#CCCCCC">
						</HeaderTemplate>
						<ItemTemplate>
							<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.Header")) %>
							<tr valign="middle" bgcolor="#FFFFCC" style="border-color:#FFFFCC;">
								<td bgcolor="#CCCCCC" style="border-color:#9E755F;">
									<table width="100%" cellspacing="0">
										<tr>
											<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>' colspan="2">
											</td>
										</tr>
										<tr>
											<td height="25px" valign="middle" nowrap align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
												</asp:Label>
											</td>
											<td height="25px" valign="middle" nowrap align="right">
												<a style='<%# "CURSOR:pointer;" + Convert.ToString(DataBinder.Eval(Container, "DataItem.VisibleSelectButtonOkay")) %>' onclick='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.OkayScript")) %>'>
													[all Ok] </a><a style='<%# "CURSOR:pointer;" + Convert.ToString(DataBinder.Eval(Container, "DataItem.VisibleSelectButtonFair")) %>' onclick='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.FairScript")) %>'>
													[all Fair] </a>
											</td>
										</tr>
									</table>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'>
											</td>
										</TR>
										<TR>
											<TD height="25px" vAlign="middle" align="center">
												<asp:Image id="Image1" runat="server" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.IsProcessed") %>'>
												</asp:Image></TD>
										</TR>
									</TABLE>
								</td>
								<td style="border-color:#9E755F;" valign="middle">
									<table width="100%" cellspacing="0">
										<tr>
											<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'>
											</td>
										</tr>
										<tr valign="middle">
											<td height="25px" valign="middle">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ItemName") %>'>
												</asp:Label>
												<asp:Label id="ServiceCheckId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceCheckId") %>'>
												</asp:Label>
												<asp:Label id="ServiceResultId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceResultId") %>'>
												</asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td style="border-color:#9E755F;">
									<table width="100%" cellspacing="0">
										<tr>
											<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'>
											</td>
										</tr>
										<tr>
											<td height="25px" valign="middle" align="center">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
												</asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR>
											<TD height="25px" vAlign="middle" align="center">
												<div id='<%# DataBinder.Eval(Container, "DataItem.OkayCatId") %>' name='<%# DataBinder.Eval(Container, "DataItem.OkayCatId") %>'>
													<asp:CheckBox id="_chOkay" runat="server" onclick="javascript:return ClickOnOkay(this.id);" Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.OkayChecked")) %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
													</asp:CheckBox>
												</div>
											</TD>
										</TR>
									</TABLE>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR vAlign="middle" align="center">
											<TD height="25px">
												<div id='<%# DataBinder.Eval(Container, "DataItem.FairCatId") %>' name='<%# DataBinder.Eval(Container, "DataItem.FairCatId") %>'>
													<asp:CheckBox id="_chFair" runat="server" onclick="javascript:return ClickOnFair(this.id);" Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.FairChecked")) %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
													</asp:CheckBox>
												</div>
											</TD>
										</TR>
									</TABLE>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR vAlign="middle" align="center">
											<TD height="25px">
												<asp:CheckBox id="_chRNeeded" runat="server" onclick="javascript: return ClickOnRN(this.id);" Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.RNChecked")) %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
												</asp:CheckBox>
											</TD>
										</TR>
									</TABLE>
								</td>
								<td style="border-color:#9E755F;">
									<table width="100%" cellspacing="0" height="100%">
										<tr>
											<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'>
											</td>
										</tr>
										<tr valign="middle" align="center">
											<td height="25px">
												<asp:CheckBox id="_cbNoService" runat="server" onclick="javascript:ClickOnNS(this.id);" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessCheck")) %>' Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.NSChecked")) %>'>
												</asp:CheckBox>
											</td>
										</tr>
									</table>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR vAlign="middle" align="center">
											<TD height="25px">
												<asp:LinkButton id="lbRepair" runat="server" CausesValidation="False" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' CommandName="SetRepairStatus">
													<asp:CheckBox id="_cbRepaired" runat="server" onclick="javascript: return ClickOnRepair(this.id);" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessCheck")) %>' Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.RepairedChecked")) %>' ToolTip="Set the Repaired status">
													</asp:CheckBox>
												</asp:LinkButton>
											</TD>
										</TR>
									</TABLE>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE height="100%" cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR vAlign="middle" align="center">
											<TD height="25px">
												<asp:LinkButton CssClass="CURSOR:none" id="lbReplace" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' CommandName="SetReplaceStatus" CausesValidation="False">
													<asp:CheckBox id="_cbReplaced" runat="server" onclick="javascript: return ClickOnReplace(this.id);" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessCheck")) %>' Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.ReplacedChecked")) %>' ToolTip="Set the Replaced status">
													</asp:CheckBox>
												</asp:LinkButton>
											</TD>
										</TR>
									</TABLE>
								</td>
							</tr>
						</ItemTemplate>
						<AlternatingItemTemplate>
							<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.Header")) %>
							<tr valign="middle" bgcolor="#FFF7BE">
								<td bgcolor="#CCCCCC" style="border-color:#9E755F;">
									<table width="100%" cellspacing="0">
										<tr>
											<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>' colspan="2">
											</td>
										</tr>
										<tr>
											<td valign="middle" nowrap height="25px" align="left">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
												</asp:Label>
											</td>
											<td height="25px" valign="middle" nowrap align="right">
												<a style='<%# "CURSOR:pointer;" + Convert.ToString(DataBinder.Eval(Container, "DataItem.VisibleSelectButtonOkay")) %>' onclick='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.OkayScript")) %>'>
													[all Ok] </a><a style='<%# "CURSOR:pointer;" + Convert.ToString(DataBinder.Eval(Container, "DataItem.VisibleSelectButtonFair")) %>' onclick='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.FairScript")) %>'>
													[all Fair] </a>
											</td>
										</tr>
									</table>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR>
											<TD height="25px" vAlign="middle" align="center">
												<asp:Image id="Image2" runat="server" ImageUrl='<%# DataBinder.Eval(Container, "DataItem.IsProcessed") %>'>
												</asp:Image></TD>
										</TR>
									</TABLE>
								</td>
								<td style="border-color:#9E755F;">
									<table width="100%" cellspacing="0">
										<tr>
											<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'>
											</td>
										</tr>
										<tr valign="middle">
											<td height="25px">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ItemName") %>'>
												</asp:Label>
												<asp:Label id="ServiceCheckId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceCheckId") %>'>
												</asp:Label>
												<asp:Label id="ServiceResultId" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container, "DataItem.ServiceResultId") %>'>
												</asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td style="border-color:#9E755F;">
									<table width="100%" cellspacing="0">
										<tr>
											<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'>
											</td>
										</tr>
										<tr>
											<td valign="middle" align="center" height="25px">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SummaryName") %>'>
												</asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR vAlign="middle" align="center">
											<TD height="25px">
												<div id='<%# DataBinder.Eval(Container, "DataItem.OkayCatId") %>' name='<%# DataBinder.Eval(Container, "DataItem.OkayCatId") %>'>
													<asp:CheckBox id="_chOkay" runat="server" onclick="javascript:return ClickOnOkay(this.id);" Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.OkayChecked")) %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
													</asp:CheckBox>
												</div>
											</TD>
										</TR>
									</TABLE>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR vAlign="middle" align="center">
											<TD height="25px">
												<div id='<%# DataBinder.Eval(Container, "DataItem.FairCatId") %>' name='<%# DataBinder.Eval(Container, "DataItem.FairCatId") %>'>
													<asp:CheckBox id="_chFair" runat="server" onclick="javascript:return ClickOnFair(this.id);" Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.FairChecked")) %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
													</asp:CheckBox>
												</div>
											</TD>
										</TR>
									</TABLE>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR vAlign="middle" align="center">
											<TD height="25px">
												<asp:CheckBox id="_chRNeeded" runat="server" onclick="javascript:return ClickOnRN(this.id);" Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.RNChecked")) %>' Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Access")) %>'>
												</asp:CheckBox>
											</TD>
										</TR>
									</TABLE>
								</td>
								<td style="border-color:#9E755F;">
									<table width="100%" cellspacing="0">
										<tr>
											<td bgcolor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'>
											</td>
										</tr>
										<tr valign="middle" align="center">
											<td height="25px">
												<asp:CheckBox id="_cbNoService" runat="server" onclick="javascript:return ClickOnNS(this.id);" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessCheck")) %>' Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.NSChecked")) %>'>
												</asp:CheckBox>
											</td>
										</tr>
									</table>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR vAlign="middle" align="center">
											<TD height="25px">
												<asp:LinkButton id="lbRepair" runat="server" CausesValidation="False" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' CommandName="SetRepairStatus">
													<asp:CheckBox id="_cbRepaired" runat="server" onclick="javascript:ClickOnRepair(this.id);" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessCheck")) %>' Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.RepairedChecked")) %>' ToolTip="Set the Repaired status">
													</asp:CheckBox>
												</asp:LinkButton>
											</TD>
										</TR>
									</TABLE>
								</td>
								<td style="border-color:#9E755F;">
									<TABLE cellSpacing="0" width="100%">
										<TR>
											<TD bgColor='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.BorderColor")) %>'></TD>
										</TR>
										<TR vAlign="middle" align="center">
											<TD height="25px">
												<asp:LinkButton id="lbReplace" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' CommandName="SetReplaceStatus" CausesValidation="False">
													<asp:CheckBox id="_cbReplaced" runat="server" onclick="javascript:ClickOnReplace(this.id);" Enabled='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.AccessCheck")) %>' Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.ReplacedChecked")) %>' ToolTip="Set the Replaced status">
													</asp:CheckBox>
												</asp:LinkButton>
											</TD>
										</TR>
									</TABLE>
								</td>
							</tr>
						</AlternatingItemTemplate>
						<FooterTemplate>
	</table>
	</FooterTemplate> </asp:repeater></TD></TR>
	<TR>
		<TD colSpan="2"><br>
		</TD>
	</TR>
	<tr>
		<td bgColor="#000000" colSpan="2"></td>
	</tr>
	<tr>
		<td colSpan="2"><br>
		</td>
	</tr>
	<TR>
		<TD class="tblSubHead1" width="100%" colSpan="2">Technician Signature that 
			completed the inspection</TD>
	</TR>
	<tr vAlign="top">
		<td class="RowCap">Initials</td>
		<td class="RowElem"><asp:textbox id="tbInitial" runat="server" Width="50px" MaxLength="3"></asp:textbox>&nbsp;<asp:requiredfieldvalidator id="rfvInitials" runat="server" ControlToValidate="tbInitial" ErrorMessage="Initials is required"></asp:requiredfieldvalidator>
			&nbsp;<asp:regularexpressionvalidator id="revInitials" runat="server" ControlToValidate="tbInitial" ErrorMessage="must be 2 or 3 symbols"
				ValidationExpression="\w{2,3}"></asp:regularexpressionvalidator>
		</td>
	</tr>
	<tr vAlign="top">
		<td class="RowCap">PIN Code</td>
		<td class="RowElem"><asp:textbox id="tbPIN" runat="server" Width="50px" MaxLength="10" TextMode="Password"></asp:textbox>&nbsp;<asp:requiredfieldvalidator id="rfvPIN" runat="server" ControlToValidate="tbPIN" ErrorMessage="PIN is required"></asp:requiredfieldvalidator>
			&nbsp;<asp:regularexpressionvalidator id="revPIN" runat="server" ControlToValidate="tbPIN" ErrorMessage="must be 4 digits or more"
				ValidationExpression="\d{4,}"></asp:regularexpressionvalidator>
		</td>
	</tr>
	<tr vAlign="top">
		<td colSpan="2"><br>
			<table cellSpacing="-1" cellPadding="-1" width="100%" border="0">
				<tr>
					<td noWrap>Completed By</td>
					<td></td>
					<td noWrap align="center"><asp:label id="lblSign" runat="server" Font-Size="Small" Font-Italic="True" Font-Names="Georgia"
							Font-Bold="True"></asp:label></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td noWrap align="center"><asp:label id="lblSignDate" runat="server" Font-Bold="True"></asp:label></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr vAlign="top">
					<td></td>
					<td></td>
					<td bgColor="#000000"></td>
					<td></td>
					<td bgColor="#000000"></td>
					<td></td>
				</tr>
				<tr vAlign="top">
					<td></td>
					<td></td>
					<td noWrap align="center">Technician's Signature</td>
					<td></td>
					<td noWrap align="center">Sign Date</td>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colSpan="2">
		</td>
	</tr>
	<tr>
		<td class="RowCap" nowrap width="30%">
			Automatically Create Next Inspection
		</td>
		<td class="RowElem" width="70%">
			<asp:CheckBox id="cbAutoCreateWO" runat="server"></asp:CheckBox>
		</td>
	</tr>
	<TR>
		<TD class="RowCap" noWrap width="30%">Inspection Date
		</TD>
		<TD class="RowElem" width="70%">
			<cc1:activedatetime id="adtInspection" runat="server" AllowNull="False" AlertEnabled="True" MinYear="1970"
				MaxYear="2020" Format=";MONTH;/;DAY;/;YEAR;"></cc1:activedatetime></TD>
	</TR>
	<tr>
		<td></td>
		<td><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></td>
	</tr>
	</TBODY></TABLE>
</form>
