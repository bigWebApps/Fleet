<%@ Register TagPrefix="uc1" TagName="SaveCancel" Src="controls/SaveCancel.ascx" %>
<%@ Page language="c#" Codebehind="admin_user_detail_edit.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_user_detail_edit" %>
<form id="Form1" method="post" runat="server">
	<table id="tblMain" runat="server">
		<TR>
			<TD colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead1" align="left">User Edit</td>
					</tr>
				</table>
			</TD>
		</TR>
		<tr vAlign="top">
			<td class="RowCap">First Name</td>
			<td class="RowElem"><asp:textbox id="tbFirstName" runat="server" Width="250px" MaxLength="50" onchange="javascript:CheckLetter(this);"></asp:textbox></td>
			<TD class="RowHelp"><asp:requiredfieldvalidator id="rfvFirstName" runat="server" ControlToValidate="tbFirstName" ErrorMessage="First Name is required"
					Display="Dynamic"></asp:requiredfieldvalidator></TD>
		</tr>
		<tr vAlign="top">
			<td class="RowCap">Last Name</td>
			<td class="RowElem"><asp:textbox id="tbLastName" runat="server" Width="250px" MaxLength="50" onchange="javascript:CheckLetter(this);"></asp:textbox></td>
			<TD class="RowHelp"><asp:requiredfieldvalidator id="rfvLastName" runat="server" ControlToValidate="tbLastName" ErrorMessage="Last Name is required"
					Display="Dynamic"></asp:requiredfieldvalidator></TD>
		</tr>
		<TR>
			<TD class="RowCap">Initials</TD>
			<TD class="RowElem"><asp:textbox id="tbInitial" runat="server" Width="50px" MaxLength="3"></asp:textbox></TD>
			<TD class="RowHelp"><asp:requiredfieldvalidator id="rfvInitials" runat="server" ControlToValidate="tbInitial" ErrorMessage="Initials is required"
					Display="Dynamic"></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="revInitials" runat="server" ControlToValidate="tbInitial" ErrorMessage="must be 2 or 3 symbols"
					ValidationExpression="\w{2,3}" Display="Dynamic"></asp:regularexpressionvalidator></TD>
		</TR>
		<tr vAlign="top">
			<td class="RowCap">Email</td>
			<td class="RowElem"><asp:textbox id="tbEmail" runat="server" Width="250px" MaxLength="50"></asp:textbox></td>
			<TD class="RowHelp"><asp:requiredfieldvalidator id="rfvEmail" runat="server" ControlToValidate="tbEmail" ErrorMessage="Email is required"
					Display="Dynamic"></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="revEmail" runat="server" ControlToValidate="tbEmail" ErrorMessage="Email contains invalid characters"
					ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:regularexpressionvalidator></TD>
		</tr>
		<TR>
			<TD class="RowCap">New Password</TD>
			<TD class="RowElem"><asp:textbox id="tbNewPassword" runat="server" MaxLength="14" TextMode="Password"></asp:textbox></TD>
			<TD class="RowHelp"><asp:requiredfieldvalidator id="rfvNewPass" runat="server" ControlToValidate="tbNewPassword" ErrorMessage="Password is required"
					Display="Dynamic"></asp:requiredfieldvalidator></TD>
		</TR>
		<TR>
			<TD class="RowCap">Confirm Password</TD>
			<TD class="RowElem"><asp:textbox id="tbConfirmPassword" runat="server" MaxLength="14" TextMode="Password"></asp:textbox></TD>
			<TD class="RowHelp"><asp:requiredfieldvalidator id="rfvConfirmPassword" runat="server" ControlToValidate="tbConfirmPassword" ErrorMessage="Confirm is required"
					Display="Dynamic"></asp:requiredfieldvalidator><asp:label id="lblComfirmPassword" runat="server" ForeColor="Red" Visible="False">Password is not confirmed</asp:label></TD>
		</TR>
		<TR>
			<TD class="RowCap">New PIN Code</TD>
			<TD class="RowElem"><asp:textbox id="tbNewPIN" runat="server" MaxLength="10" TextMode="Password"></asp:textbox></TD>
			<TD class="RowHelp"><asp:requiredfieldvalidator id="rfvNewPIN" runat="server" ControlToValidate="tbNewPIN" ErrorMessage="PIN code is required"
					Display="Dynamic"></asp:requiredfieldvalidator><asp:regularexpressionvalidator id="revPIN" runat="server" ControlToValidate="tbNewPIN" ErrorMessage="PIN must be 4 digits or more"
					ValidationExpression="\d{4,}" Display="Dynamic"></asp:regularexpressionvalidator></TD>
		</TR>
		<TR>
			<TD class="RowCap">Confirm PIN Code</TD>
			<TD class="RowElem"><asp:textbox id="tbConfirmPIN" runat="server" MaxLength="10" TextMode="Password"></asp:textbox></TD>
			<TD class="RowHelp"><asp:requiredfieldvalidator id="rfvConfirmPIN" runat="server" ControlToValidate="tbConfirmPIN" ErrorMessage="Confirm is required"
					Display="Dynamic"></asp:requiredfieldvalidator><asp:label id="lblConfirmPIN" runat="server" ForeColor="Red" Visible="False">PIN Code is not confirmed</asp:label></TD>
		</TR>
		<tr vAlign="top">
			<td class="RowCap">Type</td>
			<td class="RowElem"><asp:dropdownlist id="ddlType" runat="server">
					<asp:ListItem Value="Technician/Operator">Technician/Operator</asp:ListItem>
					<asp:ListItem Value="Technician">Technician</asp:ListItem>
					<asp:ListItem Value="Operator">Operator</asp:ListItem>
				</asp:dropdownlist></td>
			<TD class="RowHelp"></TD>
		</tr>
		<TR>
			<TD class="RowCap">Hourly Rate</TD>
			<TD class="RowElem">
				<asp:TextBox id="tbHourlyRate" runat="server" MaxLength="10"></asp:TextBox></TD>
			<TD class="RowHelp">
				<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Hourly Rate is required"
					ControlToValidate="tbHourlyRate"></asp:RequiredFieldValidator>
				<asp:regularexpressionvalidator id="revHourlyRate" runat="server" Display="Dynamic" ErrorMessage="Enter numeric or broken number"
					ControlToValidate="tbHourlyRate" ValidationExpression="(\d+\.\d{0,2})|(\d+)"></asp:regularexpressionvalidator></TD>
		</TR>
		<TR vAlign="top">
			<TD class="RowCap">Created Date</TD>
			<TD class="RowElem"><asp:label id="lblCreatedDate" runat="server"></asp:label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap">Current Status</TD>
			<TD class="RowElem"><asp:label id="lblUserActivateStatus" runat="server"></asp:label></TD>
			<TD class="RowHelp"></TD>
		</TR>
		<TR>
			<TD class="RowCap"></TD>
			<TD class="RowElem"><asp:hyperlink id="hlInactive" runat="server" Font-Bold="True">[Deactivate]</asp:hyperlink></TD>
			<td class="RowHelp"></td>
		</TR>
		<tr>
			<td colSpan="3">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td class="tblSubHead2">User's Groups</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr vAlign="top">
			<TD class="RowCap">Groups</TD>
			<TD class="RowElem"><asp:datagrid id="dgGroups" runat="server" Width="100%" ShowHeader="False" AutoGenerateColumns="False"
					BorderColor="#999999" BorderStyle="None" BorderWidth="1px" BackColor="White" CellPadding="3" GridLines="Vertical">
					<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#008A8C"></SelectedItemStyle>
					<AlternatingItemStyle BackColor="#DCDCDC"></AlternatingItemStyle>
					<ItemStyle ForeColor="Black" BackColor="#EEEEEE"></ItemStyle>
					<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#000084"></HeaderStyle>
					<FooterStyle ForeColor="Black" BackColor="#CCCCCC"></FooterStyle>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id"></asp:BoundColumn>
						<asp:TemplateColumn>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:LinkButton runat="server" Text="[remove]" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
					<PagerStyle HorizontalAlign="Center" ForeColor="Black" BackColor="#999999" Mode="NumericPages"></PagerStyle>
				</asp:datagrid></TD>
			<TD class="RowHelp"></TD>
		</tr>
		<tr vAlign="top">
			<td class="RowCap">Group
			</td>
			<td class="RowElem"><asp:dropdownlist id="ddlGroup" runat="server" DataTextField="vchDesc" DataValueField="Id"></asp:dropdownlist></td>
			<td class="RowHelp"><asp:button id="btnAddGroup" runat="server" Text="Add Group to User"></asp:button></td>
		</tr>
		<TR>
			<TD></TD>
			<TD></TD>
			<TD align="center"></TD>
		</TR>
		<TR>
			<TD></TD>
			<TD><uc1:savecancel id="SaveCancelControl" runat="server"></uc1:savecancel></TD>
			<TD></TD>
		</TR>
	</table>
</form>
