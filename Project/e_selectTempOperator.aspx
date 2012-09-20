<%@ Page language="c#" Codebehind="e_selectTempOperator.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.equip._e_selectTempOperator" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TBODY>
			<TR vAlign="top">
				<TD class="tblSubHead1" colSpan="2">
					Equipment Information</TD>
			</TR>
			<TR vAlign="top">
				<TD class="RowCap" width="30%">Equipment #</TD>
				<TD class="RowElem">
					<asp:label id="lblEquipId" runat="server" Font-Bold="True"></asp:label></TD>
			</TR>
			<TR vAlign="top">
				<TD class="RowCap" width="30%">Equipment Type</TD>
				<TD class="RowElem">
					<asp:label id="lblEquipType" runat="server" Font-Bold="True"></asp:label></TD>
			</TR>
			<TR>
				<TD class="RowCap" width="30%">Make/Model</TD>
				<TD class="RowElem">
					<asp:label id="lblMakeModel" runat="server" Font-Bold="True"></asp:label></TD>
			</TR>
			<TR>
				<TD class="RowCap" width="30%">Year</TD>
				<TD class="RowElem">
					<asp:label id="lblYear" runat="server" Font-Bold="True"></asp:label></TD>
			</TR>
			<TR>
				<TD class="RowCap" width="30%">VIN/Serial #</TD>
				<TD class="RowElem">
					<asp:label id="lblSerial" runat="server" Font-Bold="True"></asp:label></TD>
			</TR>
			<TR vAlign="top">
				<TD class="RowCap" width="30%">Assigned Equipment Operator</TD>
				<TD class="RowElem">
					<asp:label id="lblOperator" runat="server" Font-Bold="True"></asp:label></TD>
			</TR>
			<TR>
				<TD class="RowCap" width="30%">Assigned Temporary Operator</TD>
				<TD class="RowElem">
					<asp:label id="lblTempOperator" runat="server" Font-Bold="True"></asp:label></TD>
			</TR>
			<asp:panel id="pnlVerifyOperator" runat="server" Visible="False"> <!-- verify operator -->
				<TR>
					<TD class="RowCap" width="30%">New Temporary Operator</TD>
					<TD class="RowElem">
						<asp:label id="lblNewTempOperator" runat="server" Font-Bold="True"></asp:label></TD>
				</TR>
				<TR vAlign="top">
					<TD class="RowCap" noWrap width="30%">Note *</TD>
					<TD class="RowElem">
						<asp:TextBox id="tbNote" runat="server" Columns="40" Rows="3" MaxLength="250" TextMode="MultiLine"></asp:TextBox>&nbsp;
					</TD>
				</TR>
				<TR vAlign="top">
					<TD class="RowCap" width="30%">If Temporary Operator is not correct</TD>
					<TD class="RowElem">
						<asp:LinkButton id="lbChangeOperator" runat="server" Font-Bold="True" CausesValidation="False">Change Temporary Operator</asp:LinkButton></TD>
				</TR>
				<TR>
					<TD colSpan="2"><BR>
					</TD>
				</TR>
				<TR vAlign="top">
					<TD colSpan="2">
						<uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
				</TR>
			</asp:panel>
			<asp:panel id="pnlSelectOperator" runat="server" Visible="False"> <!-- search operator -->
				<TR vAlign="top">
					<TD class="RowCap" width="30%">If Temporary Operator is no</TD>
					<TD class="RowElem">
						<asp:LinkButton id="lbUnassign" runat="server" Font-Bold="True">Unassign</asp:LinkButton></TD>
				</TR>
				<TR>
					<TD colSpan="2"><BR>
					</TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2">
						<TABLE class="tblMicajah" cellSpacing="0" cellPadding="1" border="1">
							<TR vAlign="top">
								<TD class="tblSubHead1" colSpan="3">Search for Temporary Operator
								</TD>
							</TR>
							<TR>
								<TD class="bg01">First Name</TD>
								<TD class="bg01">Last Name</TD>
								<TD class="bg01"></TD>
							</TR>
							<TR>
								<TD class="RowElem">
									<asp:TextBox id="tbFirstName" runat="server"></asp:TextBox></TD>
								<TD class="RowElem">
									<asp:TextBox id="tbLastName" runat="server"></asp:TextBox></TD>
								<TD class="RowElem" align="center">
									<asp:Button id="btnSearch" runat="server" Text="Search"></asp:Button></TD>
							</TR>
							<asp:repeater id="repOperators" runat="server">
								<ItemTemplate>
									<tr valign="middle" bgcolor="#FFFFCC">
										<td>
											<asp:Label id="lblFirstName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.FirstName") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label id="lblLastName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LastName") %>'>
											</asp:Label>
										</td>
										<td align="center">
											<asp:LinkButton runat="server" Text="Select" CommandName="Select" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' ID="Linkbutton1">
											</asp:LinkButton>
										</td>
									</tr>
								</ItemTemplate>
								<AlternatingItemTemplate>
									<tr valign="middle" bgcolor="#FFF7BE">
										<td>
											<asp:Label id="lblFirstName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.FirstName") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label id="lblLastName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LastName") %>'>
											</asp:Label>
										</td>
										<td align="center">
											<asp:LinkButton runat="server" Text="Select" CommandName="Select" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>' ID="Linkbutton2">
											</asp:LinkButton>
										</td>
									</tr>
								</AlternatingItemTemplate>
							</asp:repeater></TABLE>
					</TD>
				</TR>
				<TR>
					<TD colSpan="2"><BR>
					</TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2">
						<asp:Button id="btnBack" runat="server" Text="  << Back  "></asp:Button></TD>
				</TR>
			</asp:panel>
		</TBODY></table>
</form>
