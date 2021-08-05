<%@ Page language="c#" Codebehind="wo_viewCheckOut.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_viewCheckOut" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Register TagPrefix="BFPCntrls" TagName="Signature" Src="controls/Signature.ascx" %>
<form id="Form1" method="post" runat="server">
	<table id="tableMain" runat="server">
		<TR>
			<TD class="tblSubHead1" colSpan="3">Main Info</TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" nowrap>Work Order #</TD>
			<td class="RowElem" width="40%"><asp:label id="lblWorkOrderId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" nowrap>Equipment Id</TD>
			<td class="RowElem"><asp:label id="lblEquipId" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" nowrap vAlign="middle">Spare Equipment</TD>
			<td class="RowElem" vAlign="middle"><asp:label id="lblSpareEquipId" runat="server"></asp:label></td>
			<td class="RowHelp"><font color="red">Attention!</font> When you check-out 
				equipment the checked out spare equipment will be returned</td>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" nowrap>Assigned Technician</TD>
			<td class="RowElem"><asp:label id="lblTech" runat="server"></asp:label></td>
			<td class="RowHelp"></td>
		</TR>
		<tr>
			<TD class="RowCap" nowrap>Equipment Operator</TD>
			<TD class="RowElem"><asp:label id="lblOperator" runat="server"></asp:label></TD>
			<td class="RowHelp"></td>
		</tr>
		<tr vAlign="top">
			<TD class="RowCap" nowrap vAlign="middle">Dropped Off By</TD>
			<TD class="RowElem" vAlign="middle"><asp:label id="lblDroppedOffBy" runat="server"></asp:label></TD>
			<td class="RowHelp">
				(Optional) Name of person dropping off equipment if different than equipment 
				operator</td>
		</tr>
		<TR vAlign="top">
			<TD class="RowCap" vAlign="middle">Released To</TD>
			<TD class="RowElem" vAlign="middle"><asp:textbox id="tbReleasedTo" runat="server" MaxLength="50"></asp:textbox></TD>
			<TD class="RowHelp">
				(Optional) Name of person picking up equipment if different than equipment 
				operator</TD>
		</TR>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap" vAlign="middle" noWrap>Equipment Cleanliness</TD>
			<TD class="RowElem" vAlign="middle"><asp:label id="lblCleanliness" runat="server"></asp:label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<tr>
			<TD class="RowCap">Scheduled Date</TD>
			<TD class="RowElem"><asp:label id="lblScheduledDate" runat="server"></asp:label></TD>
			<td class="RowHelp"></td>
		</tr>
		<TR>
			<TD class="RowCap">Check-Out Date</TD>
			<TD class="RowElem">
				<cc1:activedatetime id="adtCheckOut" runat="server" AllowNull="False" AlertEnabled="True" MinYear="2000"
					MaxYear="2030" Format=";MONTH;/;DAY;/;YEAR;"></cc1:activedatetime></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="tblSubHead2" vAlign="top" colSpan="3">Check-Out Notes</TD>
		</TR>
		<tr>
			<td colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%">
					<asp:repeater id="repCheckOutNotes" runat="server">
						<ItemTemplate>
							<tr bgcolor="#CCCCCC">
								<td align="left">
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserName") %>' ID="Label1">
									</asp:Label>
								</td>
								<td align="right">
									<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.CreatedDate")).ToString("yyyy-MM-dd hh:mm tt") %>' ID="Label2">
									</asp:Label>
								</td>
							</tr>
							<tr>
								<td align="left" colspan="2">
									<asp:label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Note") %>' ID="Label3">
									</asp:label>
								</td>
							</tr>
						</ItemTemplate>
					</asp:repeater>
				</table>
			</td>
		</tr>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<TR>
			<TD class="tblSubHead1" width="100%" colSpan="3">Technician Signature for Check-Out 
				of the Equipment</TD>
		</TR>
		<tr>
			<td colspan="3">
				<BFPCNTRLS:Signature id="Signature" runat="server"></BFPCNTRLS:Signature>
			</td>
		</tr>
		<tr>
			<td colSpan="3"><br>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></td>
			<td></td>
		</tr>
	</table>
</form>
