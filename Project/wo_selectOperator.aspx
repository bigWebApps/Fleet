<%@ Register TagPrefix="uc1" TagName="NextBack" Src="controls/NextBack.ascx" %>
<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Page language="c#" Codebehind="wo_selectOperator.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.workorder._wo_selectOperator" %>
<form id="Form1" method="post" runat="server">
	<table>
		<TBODY>
			<tr>
				<td colspan="2">Verify that the operator assigned to the disabled equipment is the 
					correct operator that made the emergency call
				</td>
			</tr>
			<tr>
				<td colspan="2"><br>
				</td>
			</tr>
			<TR vAlign="top">
				<TD class="tblSubHead1" colSpan="2">The Equipment Information</TD>
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
			<TR>
				<TD class="RowCap" width="30%">Assigned Temporary Operator</TD>
				<TD class="RowElem">
					<asp:label id="lblTempOperator" runat="server" Font-Bold="True"></asp:label></TD>
			</TR>
			<TR vAlign="top">
				<TD class="RowCap" width="30%">Assigned Equipment Operator</TD>
				<TD class="RowElem">
					<asp:label id="lblOperator" runat="server" Font-Bold="True"></asp:label></TD>
			</TR>
			<asp:panel id="pnlVerifyOperator" runat="server" Visible="False"> <!-- verify operator -->
				<TR vAlign="top">
					<TD class="RowCap" width="30%">If operator is not correct</TD>
					<TD class="RowElem">
						<asp:LinkButton id="lbChangeOperator" runat="server" Font-Bold="True" CausesValidation="False">Change Operator</asp:LinkButton></TD>
				</TR>
				<TR>
					<TD class="RowCap" width="30%">Assigned Technician
					</TD>
					<TD class="RowElem">
						<asp:dropdownlist id="ddlTech" runat="server" DataTextField="vchName" DataValueField="Id"></asp:dropdownlist>&nbsp;
						<asp:RequiredFieldValidator id="rfvAssignTech" runat="server" ControlToValidate="ddlTech" ErrorMessage="The assigned technician is required"
							InitialValue="0"></asp:RequiredFieldValidator></TD>
				</TR>
				<TR>
					<TD colSpan="2"><BR>
					</TD>
				</TR>
				<TR vAlign="top">
					<TD colSpan="2">
						<uc1:nextback id="NextBackControl" runat="server"></uc1:nextback></TD>
				</TR>
			</asp:panel>
			<asp:panel id="pnlSelectOperator" runat="server" Visible="False"> <!-- search operator -->
				<TR>
					<TD colSpan="2"><BR>
					</TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2">
						<TABLE class="tblMicajah" cellSpacing="0" cellPadding="1" border="1">
							<TR vAlign="top">
								<TD class="tblSubHead1" colSpan="3">Please select correct equipment operator 
									for&nbsp;
									<asp:label id="lblEquipType2" runat="server"></asp:label>&nbsp;#
									<asp:label id="lblEquipId2" runat="server"></asp:label></TD>
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
								<TD class="RowElem">
									<asp:Button id="btnSearch" runat="server" Text="Search"></asp:Button></TD>
							</TR>
							<asp:repeater id="repOperators" runat="server">
								<ItemTemplate>
									<tr valign="middle" bgcolor="#FFFFCC">
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.FirstName") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LastName") %>'>
											</asp:Label>
										</td>
										<td align="center">
											<asp:LinkButton runat="server" Text="Select" CommandName="Select" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
											</asp:LinkButton>
										</td>
									</tr>
								</ItemTemplate>
								<AlternatingItemTemplate>
									<tr valign="middle" bgcolor="#FFF7BE">
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.FirstName") %>'>
											</asp:Label>
										</td>
										<td>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LastName") %>'>
											</asp:Label>
										</td>
										<td align="center">
											<asp:LinkButton runat="server" Text="Select" CommandName="Select" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'>
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
						<asp:Button id="btnBack" runat="server" Text="<< Back"></asp:Button></TD>
				</TR>
			</asp:panel>
		</TBODY></table>
</form>
