<%@ Page language="c#" Codebehind="wo_updateRepair.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_updateRepair" %>
<%@ Register tagprefix="mbll" namespace="MetaBuilders.WebControls" Assembly="MetaBuilders.WebControls.ListLink" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<form id="Form1" method="post" runat="server">
	<table cellSpacing="0" cellPadding="0" border="0">
		<tr vAlign="top">
			<td colSpan="2">
				<table id="tblSource" width="100%" runat="server">
					<tr>
						<td class="tblSubHead1" colSpan="5">Source Issue</td>
					</tr>
					<tr>
						<td class="ag01">Issue Type</td>
						<td class="ag02"><asp:label id="lblSourceType" runat="server"></asp:label></td>
					</tr>
					<tr>
						<td class="ag01">Category</td>
						<td class="ag02"><asp:label id="lblRepairCategory" runat="server"></asp:label></td>
					</tr>
					<tr>
						<td class="ag01">Issue</td>
						<td class="ag02"><asp:label id="lblIssue" runat="server"></asp:label></td>
					</tr>
				</table>
				<br>
				<table width="100%">
					<tr>
						<td class="tblSubHead1" colSpan="5"><asp:label id="lblTableTitle" runat="server">Serviced Repairs</asp:label></td>
					</tr>
					<asp:repeater id="repReportedIssues" runat="server">
						<HeaderTemplate>
							<tr valign="middle" class="ag01">
								<td align="center">Associate</td>
								<td align="left">Category</td>
								<td align="left">Status</td>
								<td align="left">Issue</td>
								<td>&nbsp;&nbsp;&nbsp;</td>
							</tr>
						</HeaderTemplate>
						<ItemTemplate>
							<tr valign="middle" class="ag02">
								<td align="center">
									<asp:CheckBox id="cbIssue" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Associated")) %>' Enabled='<%# !Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Associated")) %>'>
									</asp:CheckBox>
								</td>
								<td align="left">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
									</asp:Label>
								</td>
								<td align="left">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
									</asp:Label>
								</td>
								<td align="left">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.IssueName") %>'>
									</asp:Label>
								</td>
								<td align="center">
									&nbsp;
								</td>
							</tr>
						</ItemTemplate>
						<FooterTemplate>
							<tr>
								<td class="tblSubHead1" colSpan="5">Serviced Repairs</td>
							</tr>
						</FooterTemplate>
					</asp:repeater>
					<asp:repeater id="repRepairs" runat="server">
						<HeaderTemplate>
							<tr valign="middle" class="ag01">
								<td align="center">Associate</td>
								<td align="left">Category</td>
								<td align="left">Item</td>
								<td align="left">Notes</td>
								<td>&nbsp;&nbsp;&nbsp;</td>
							</tr>
						</HeaderTemplate>
						<ItemTemplate>
							<tr valign="middle" class="ag02">
								<td align="center">
									<asp:CheckBox id="cbRepair" runat="server" Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.Associated")) %>'>
									</asp:CheckBox>
								</td>
								<td align="left">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CatName") %>'>
									</asp:Label>
								</td>
								<td align="left">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ItemName") %>'>
									</asp:Label>
								</td>
								<td align="left">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RepairDesc") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:LinkButton id="lbEditRepair" runat="server" CommandName="DirectEdit" CausesValidation="False" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>[edit]</asp:LinkButton>
								</td>
							</tr>
						</ItemTemplate>
					</asp:repeater>
					<tr class="ag02" vAlign="middle">
						<td align="center"><INPUT id="html_chNewRepair" onclick="javascript:CheckEditMode();" type="checkbox" CHECKED
								name="html_chNewRepair" runat="server">
						</td>
						<td colSpan="4"><asp:label id="lblTableFooter" runat="server">New Repair</asp:label></td>
					</tr>
					<tr vAlign="middle">
						<td class="ag01">Category</td>
						<td class="ag02" colSpan="2"><asp:dropdownlist id="ddlRepairCats" runat="server" DataValueField="Id" DataTextField="vchName" DataMember="Table"></asp:dropdownlist>&nbsp;
							<asp:label id="lblValidatorCategory" style="DISPLAY: none; COLOR: red" runat="server">Category is required</asp:label></td>
						<td class="RowHelp" colSpan="2">Category to which was executed repair</td>
					</tr>
					<tr vAlign="middle">
						<td class="ag01">Item</td>
						<td class="ag02" colSpan="2"><asp:dropdownlist id="ddlRepairItems" runat="server" DataValueField="Id" DataTextField="vchDesc" DataMember="Table1"></asp:dropdownlist>&nbsp;
							<asp:label id="lblValidatorItem" style="DISPLAY: none; COLOR: red" runat="server">Item is required</asp:label><mbll:listlink id="ListLink" runat="server" DataRelation="Cats_Items" LockFirstItem="True" ParentList="ddlRepairCats"
								ChildList="ddlRepairItems"></mbll:listlink></td>
						<td class="RowHelp" colSpan="2">Item to which was executed repair</td>
					</tr>
					<tr vAlign="top">
						<td class="ag01">Notes</td>
						<td class="ag02" colSpan="2"><asp:textbox id="tbNotes" runat="server" Width="280px" TextMode="MultiLine" Height="120px"></asp:textbox></td>
						<td class="RowHelp" colSpan="2">Repair description<br>
						</td>
					</tr>
					<tr valign="top">
						<td class="ag01">Hours<B>:</B>Mins</td>
						<td class="ag02" colspan="2">
							<asp:textbox id="tbHours" runat="server" Width="50px" MaxLength="10"></asp:textbox><B>:</B>
							<asp:textbox id="tbMinutes" runat="server" Width="50px" MaxLength="50"></asp:textbox>&nbsp;
							<asp:regularexpressionvalidator id="revHours" runat="server" ErrorMessage="incorrect hours&nbsp;" ControlToValidate="tbHours"
								ValidationExpression="\d+" Display="Dynamic"></asp:regularexpressionvalidator>
							<asp:regularexpressionvalidator id="revMinutes" runat="server" ErrorMessage="incorrect minutes" ControlToValidate="tbMinutes"
								ValidationExpression="(0[0-9]|[1-5][0-9])" Display="Dynamic"></asp:regularexpressionvalidator></td>
						<td class="RowHelp" colSpan="2">Simple Time Tracking Log</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colSpan="2"><br>
			</td>
		</tr>
		<asp:Panel runat="server" id="RepairLogsLinksPanel">		
		<tr>
			<td></td>
			<td><span onclick="javascript:return ValidRepairItems();"><asp:linkbutton id="lbAddRepair" runat="server" Font-Bold="True" CausesValidation="False">[Save & Add New Repair]</asp:linkbutton>&nbsp;
						&nbsp;<asp:linkbutton id="lbAddLog" runat="server" CausesValidation="False" Font-Bold="True"> [Advanced Time Log]<br></asp:linkbutton><br />
				</span></td>
		</tr>
		</asp:Panel>
		<asp:Panel runat="server" id="WarehousePanel">		
		<tr>
			<td colSpan="2" style="padding-bottom: 5px"><asp:LinkButton runat="server" id="WarehouseLink" Font-Size="12pt" OnClick="WarehouseLink_Click" CausesValidation="False" OnClientClick="return ValidRepairItemsWithOpenWindow();" text="Add Parts" />
			</td>
		</tr>
		</asp:Panel>
		<tr vAlign="top">
			<td class="tblSubHead1" colSpan="2" height="19">The parts used in repair&nbsp;
			</td>
		</tr>
		<tr vAlign="top">
			<td colSpan="2">
				<table width="100%">
					<asp:repeater id="repParts" runat="server">
						<HeaderTemplate>
							<tr valign="middle" class="ag01">
								<td align="center" width="50px">Qty</td>
								<td align="center">Stock #</td>
								<td align="center">Description</td>
								<td align="center">Cost</td>
								<td></td>
							</tr>
						</HeaderTemplate>
						<ItemTemplate>
							<tr valign="middle" bgcolor="#FFFFCC">
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Qty") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Stock") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Desc") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# "$" + Convert.ToString(Convert.ToDecimal(DataBinder.Eval(Container, "DataItem.Cost")) * Convert.ToInt32(DataBinder.Eval(Container, "DataItem.Qty"))) %>'>
									</asp:Label>
								</td>
								<td align="center">
									<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this part?')">
										<asp:LinkButton runat="server" CausesValidation="false" Text="remove" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>[remove]</asp:LinkButton>
									</SPAN>
								</td>
							</tr>
						</ItemTemplate>
						<AlternatingItemTemplate>
							<tr valign="middle" bgcolor="#FFF7BE">
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Qty") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Stock") %>'>
									</asp:Label>
								</td>
								<td>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Desc") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# "$" + Convert.ToString(Convert.ToDecimal(DataBinder.Eval(Container, "DataItem.Cost")) * Convert.ToInt32(DataBinder.Eval(Container, "DataItem.Qty"))) %>'>
									</asp:Label>
								</td>
								<td align="center">
									<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this part?')">
										<asp:LinkButton runat="server" CausesValidation="false" Text="remove" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>[remove]</asp:LinkButton>
									</SPAN>
								</td>
							</tr>
						</AlternatingItemTemplate>
					</asp:repeater>
					<tr class="ag02" vAlign="middle">
						<td align="center"><asp:textbox id="tbQty" runat="server" Width="100%" MaxLength="10"></asp:textbox></td>
						<td align="center"><asp:textbox id="tbStock" runat="server" Width="100%"></asp:textbox></td>
						<td align="center"><asp:textbox id="tbDesc" runat="server" Width="100%"></asp:textbox></td>
						<td align="center"><asp:textbox id="tbCost" runat="server" Width="100%" MaxLength="12"></asp:textbox></td>
						<td align="center"><asp:button id="btnAddPart" runat="server" Width="100%" Text="Add Part"></asp:button></td>
					</tr>
					<TR vAlign="top">
						<TD align="left" colSpan="2">
							<asp:requiredfieldvalidator id="rfvQty" runat="server" ControlToValidate="tbQty" ErrorMessage="Qty is required"></asp:requiredfieldvalidator><br>
							<asp:regularexpressionvalidator id="revQty" runat="server" ControlToValidate="tbQty" ErrorMessage="Qty must be number "
								ValidationExpression="\d{1,10}"></asp:regularexpressionvalidator><br>
							<asp:rangevalidator id="rvQty" runat="server" ControlToValidate="tbQty" ErrorMessage="Qty must be greater than was 0"
								Type="Integer" MaximumValue="9999999" MinimumValue="1"></asp:rangevalidator>
						</TD>
						<TD align="center"><asp:requiredfieldvalidator id="rfvDesc" runat="server" ControlToValidate="tbDesc" ErrorMessage="Description is required"></asp:requiredfieldvalidator></TD>
						<TD align="center"><asp:regularexpressionvalidator id="revCost" runat="server" ControlToValidate="tbCost" ErrorMessage="Cost must be currency numeric"
								ValidationExpression="^\d{0,10}(?:\.\d{0,2})?$"></asp:regularexpressionvalidator></TD>
						<TD></TD>
					</TR>
					<tr>
						<td width="50"></td>
						<td width="50"></td>
						<td width="50%"></td>
						<td width="70"></td>
						<td width="100"></td>
					</tr>
				</table>
			</td>
		</tr>
		<TR>
			<td></td>
			<TD><uc1:savecancel id="SaveCancelControl" runat="server" SaveOnClick="javascript:return ValidRepairItems();"></uc1:savecancel></TD>
		</TR>
	</table>
</form>
