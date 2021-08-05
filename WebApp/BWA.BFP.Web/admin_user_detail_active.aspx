<%@ Page language="c#" Codebehind="admin_user_detail_active.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_user_detail_active" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<form id="Form1" method="post" runat="server">
	<table id="tblMain" runat="server" name="tblMain">
		<TBODY>
			<TR>
				<TD colSpan="3">
					<table cellSpacing="0" cellPadding="0" width="100%" border="0">
						<tr>
							<td class="tblSubHead1" align="left">User Information</td>
						</tr>
					</table>
				</TD>
			</TR>
			<tr vAlign="top">
				<td class="bg01">First Name</td>
				<td class="bg02" width="66%" colSpan="2"><asp:label id="lblFirstName" runat="server"></asp:label></td>
			</tr>
			<tr vAlign="top">
				<td class="bg01">Last Name</td>
				<td class="bg02" colSpan="2"><asp:label id="lblLastName" runat="server"></asp:label></td>
			</tr>
			<tr vAlign="top">
				<td class="bg01">Email</td>
				<td class="bg02" colSpan="2"><asp:label id="lblEmail" runat="server"></asp:label></td>
			</tr>
			<tr vAlign="top">
				<td class="bg01">Type</td>
				<td class="bg02" colSpan="2"><asp:label id="lblType" runat="server"></asp:label></td>
			</tr>
			<TR vAlign="top">
				<TD class="bg01">Created Date</TD>
				<TD class="bg02" colSpan="2"><asp:label id="lblCreatedDate" runat="server"></asp:label></TD>
			</TR>
			<TR>
				<TD class="bg01">Current Status</TD>
				<TD class="bg02" colSpan="2"><asp:label id="lblUserActivateStatus" runat="server"></asp:label></TD>
			</TR>
			<TR>
				<TD colSpan="3"><br>
				</TD>
			</TR>
			<TR>
				<TD colSpan="3">
					<table cellSpacing="0" cellPadding="0" width="100%" border="0">
						<tr>
							<td class="tblSubHead2" align="left">All Equipments and Active Work Orders where 
								User is Operator</td>
						</tr>
					</table>
				</TD>
			</TR>
			<tr>
				<td colSpan="3"><asp:repeater id="repOperatorEquipments" runat="server">
						<HeaderTemplate>
							<table style="border-color:#CCCCCC;border-width:1px;border-style:solid;width:100%;border-collapse:collapse;"
								cellSpacing="0" cellPadding="1" border="1" rules="all" borderColor="#CCCCCC">
								<tr valign="middle" class="ag03">
									<td align="center" nowrap>Equip Id</td>
									<td align="center">Type</td>
									<td align="center">Make</td>
									<td align="center">Model</td>
									<td align="center">Year</td>
									<td align="left" nowrap>Assign New Operator</td>
								</tr>
						</HeaderTemplate>
						<ItemTemplate>
							<tr valign="middle" bgcolor="#FFFFCC">
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EquipId") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MakeName") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ModelName") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Year") %>'>
									</asp:Label>
								</td>
								<td align="left" nowrap width="20%">
									<asp:DropDownList id="ddlOperators" runat="server" DataTextField="vchName" DataValueField="Id" EquipId='<%# DataBinder.Eval(Container, "DataItem.Id") %>' IsNobody='<%# DataBinder.Eval(Container, "DataItem.IsNobody") %>'>
									</asp:DropDownList>
									<asp:Label id="rfvItem" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td colspan="6">
									<%# DataBinder.Eval(Container, "DataItem.WorkOrders") %>
								</td>
							</tr>
						</ItemTemplate>
						<AlternatingItemTemplate>
							<tr valign="middle" bgcolor="#FFF7BE">
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EquipId") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MakeName") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ModelName") %>'>
									</asp:Label>
								</td>
								<td align="center">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Year") %>'>
									</asp:Label>
								</td>
								<td align="left" nowrap width="20%">
									<asp:DropDownList id="ddlOperators" runat="server" DataTextField="vchName" DataValueField="Id" EquipId='<%# DataBinder.Eval(Container, "DataItem.Id") %>' IsNobody='<%# DataBinder.Eval(Container, "DataItem.IsNobody") %>'>
									</asp:DropDownList>
									<asp:Label id="rfvItem" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td colspan="6">
									<%# DataBinder.Eval(Container, "DataItem.WorkOrders") %>
								</td>
							</tr>
						</AlternatingItemTemplate>
						<FooterTemplate>
	</table>
	</FooterTemplate> </asp:Repeater><font color="red">*</font> If equipment has 
	active work order(s) then you must reassign another operator to 
	equipment</TD></TR>
	<TR>
		<TD colSpan="3"><br>
		</TD>
	</TR>
	<TR>
		<TD colSpan="3">
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td class="tblSubHead2" align="left">All Active Work Orders where user is 
						Technician</td>
				</tr>
			</table>
		</TD>
	</TR>
	<TR>
		<td colSpan="3"><asp:repeater id="repWorkOrders" runat="server">
				<HeaderTemplate>
					<table style="border-color:#CCCCCC;border-width:1px;border-style:solid;width:100%;border-collapse:collapse;"
						cellSpacing="0" cellPadding="1" border="1" rules="all" borderColor="#CCCCCC">
						<tr valign="middle" class="ag03">
							<td align="center" nowrap>Work Order Id</td>
							<td align="center" nowrap>Work Order Type</td>
							<td align="center" nowrap>Operator Name</td>
							<td align="center">Status</td>
							<td align="center" nowrap>Operator Status</td>
							<td align="center" nowrap>Scheduled Date</td>
							<td align="left" nowrap>Assign New Technician</td>
						</tr>
				</HeaderTemplate>
				<ItemTemplate>
					<tr valign="middle" bgcolor="#FFFFCC">
						<td align="center">
							<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>'>
							</asp:Label>
						</td>
						<td align="center">
							<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
							</asp:Label>
						</td>
						<td align="center">
							<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
							</asp:Label>
						</td>
						<td align="center">
							<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
								<tr>
									<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.StatusColor")) %>'>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
										</asp:Label>
									</td>
								</tr>
							</table>
						</td>
						<td align="center" nowrap>
							<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
								<tr>
									<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
										</asp:Label>
									</td>
								</tr>
							</table>
						</td>
						<td align="center">
							<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ScheduledDate") %>'>
							</asp:Label>
						</td>
						<td align="left">
							<asp:DropDownList id="ddlTechs" runat="server" DataTextField="vchName" DataValueField="Id" OrderId='<%# DataBinder.Eval(Container, "DataItem.Id") %>' IsNobody='<%# DataBinder.Eval(Container, "DataItem.IsNobody") %>'>
							</asp:DropDownList>
							<asp:Label id="rfvItem" runat="server"></asp:Label>
						</td>
					</tr>
				</ItemTemplate>
				<AlternatingItemTemplate>
					<tr valign="middle" bgcolor="#FFF7BE">
						<td align="center">
							<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchWorkOrderNumber") %>'>
							</asp:Label>
						</td>
						<td align="center">
							<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TypeName") %>'>
							</asp:Label>
						</td>
						<td align="center">
							<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorName") %>'>
							</asp:Label>
						</td>
						<td align="center">
							<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
								<tr>
									<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.StatusColor")) %>'>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StatusName") %>'>
										</asp:Label>
									</td>
								</tr>
							</table>
						</td>
						<td align="center" nowrap>
							<table border="0" cellpadding="-1" cellspacing="-1" width="100%">
								<tr>
									<td align="center" style='<%# "background-color:" + Convert.ToString(DataBinder.Eval(Container, "DataItem.OperatorColor")) %>'>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OperatorStatusName") %>'>
										</asp:Label>
									</td>
								</tr>
							</table>
						</td>
						<td align="center">
							<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ScheduledDate") %>'>
							</asp:Label>
						</td>
						<td align="left">
							<asp:DropDownList id="ddlTechs" runat="server" DataTextField="vchName" DataValueField="Id" OrderId='<%# DataBinder.Eval(Container, "DataItem.Id") %>' IsNobody='<%# DataBinder.Eval(Container, "DataItem.IsNobody") %>'>
							</asp:DropDownList>
							<asp:Label id="rfvItem" runat="server"></asp:Label>
						</td>
					</tr>
				</AlternatingItemTemplate>
				<FooterTemplate>
	</table>
	</FooterTemplate>
			</asp:repeater><font color="red">*</font> If work order(s) is opened then you 
			must reassign another technician to the work order(s)</td>
	</TR>
	<TR>
		<TD colSpan="3"><br>
		</TD>
	</TR>
	<TR>
		<TD></TD>
		<TD colSpan="2"><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
	</TR>
	</TBODY></TABLE></form>
