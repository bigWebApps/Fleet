<%@ Register TagPrefix="mits" Namespace="Micajah.DataGrid" Assembly="Micajah.DataGrid" %>
<%@ Register TagPrefix="cc1" Namespace="ActiveUp.WebControls" Assembly="ActiveDateTime" %>
<%@ Page language="c#" Codebehind="admin_holidays.aspx.cs" AutoEventWireup="false" Inherits="BWA.BFP.Web.admin._admin_holidays" %>
<form id="Form1" method="post" runat="server">
	<table>
		<tr>
			<td colSpan="3"><mits:datagrid_a id="dgHolidays" runat="server" DataKeyField="Id" Width="100%" AutoGenerateColumns="False"
					ColorScheme="Yellow">
					<Columns>
						<asp:BoundColumn Visible="False" DataField="Id" ReadOnly="True"></asp:BoundColumn>
						<asp:TemplateColumn HeaderText="Start Date">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.dtStartDate")).ToString("MM/dd/yyyy hh:mm tt") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<cc1:activedatetime id="adtStartDate" runat="server" Date='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.dtStartDate")) %>' MinYear="2000" MaxYear="2030" Format="MONTH;/;DAY;/;YEAR" AllowNull="False" AlertEnabled="True">
								</cc1:activedatetime>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="End Date">
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.dtEndDate")).ToString("MM/dd/yyyy hh:mm tt") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<cc1:activedatetime id="adtEndDate" runat="server" Date='<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.dtEndDate")) %>' MinYear="2000" MaxYear="2030" Format="MONTH;/;DAY;/;YEAR" AllowNull="False" AlertEnabled="True">
								</cc1:activedatetime>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Holiday Name">
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:TextBox id="tbHolidayName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vchDesc") %>'>
								</asp:TextBox>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="Percent Off">
							<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container, "DataItem.intPercentOff")) + "%" %>'>
								</asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:ListBox id=lbPercentOff runat="server" Rows="1" SelectedValue='<%# DataBinder.Eval(Container, "DataItem.intPercentOff") %>'>
									<asp:ListItem Value="25">25%</asp:ListItem>
									<asp:ListItem Value="50">50%</asp:ListItem>
									<asp:ListItem Value="75">75%</asp:ListItem>
									<asp:ListItem Value="100">100%</asp:ListItem>
								</asp:ListBox>
							</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:LinkButton runat="server" Text="Edit" CommandName="Edit" CausesValidation="false" ID="Linkbutton1"></asp:LinkButton>
							</ItemTemplate>
							<EditItemTemplate>
&nbsp;
								<asp:LinkButton runat="server" Text="Update" CommandName="Update" CausesValidation="false" ID="Linkbutton2"></asp:LinkButton>&nbsp;
								<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" ID="Linkbutton3"></asp:LinkButton>&nbsp;						
						
</EditItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								&nbsp;
								<SPAN onclick="javascript:return confirm('Are you sure that you want to delete this Holiday?')">
									<asp:LinkButton runat="server" Text="Remove" CommandName="Delete" CausesValidation="false"></asp:LinkButton>
								</SPAN>
								&nbsp;
							
</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</mits:datagrid_a>
			</td>
		</tr>
		<TR>
			<TD colSpan="3"></TD>
		</TR>
		<TR>
			<TD colSpan="3">
				<b>Add New Holiday</b>
			</TD>
		</TR>
		<TR valign="top">
			<TD>Start Date</TD>
			<TD>
				<cc1:activedatetime id="adtNewStartDate" runat="server" MinYear="2000" MaxYear="2030" Format="MONTH;/;DAY;/;YEAR"
					AllowNull="False" AlertEnabled="True"></cc1:activedatetime>
				&nbsp; <A id="A1" style="CURSOR: pointer" onclick="javascript:OpenCalendar('adtNewStartDate', false, event.screenX, event.screenY)"
					runat="server"><IMG id="imgCalBegin1" src="images/calendar-16x16.gif" border="0"></A>
			</TD>
			<TD></TD>
		</TR>
		<TR valign="top">
			<TD>End Date</TD>
			<TD>
				<cc1:activedatetime id="adtNewEndDate" runat="server" MinYear="2000" MaxYear="2030" Format="MONTH;/;DAY;/;YEAR"
					AllowNull="False" AlertEnabled="True"></cc1:activedatetime>
				&nbsp; <A id="A2" style="CURSOR: pointer" onclick="javascript:OpenCalendar('adtNewEndDate', false, event.screenX, event.screenY)"
					runat="server"><IMG id="imgCalBegin2" src="images/calendar-16x16.gif" border="0"></A>
			</TD>
			<TD></TD>
		</TR>
		<tr valign="top">
			<td noWrap>Holiday Name</td>
			<td>
				<asp:TextBox id="tbNewHolidayName" runat="server" TextMode="MultiLine"></asp:TextBox></td>
			<td>
				<asp:RequiredFieldValidator id="rfvHolidayName" runat="server" ErrorMessage="The Holiday Name is required" ControlToValidate="tbNewHolidayName"></asp:RequiredFieldValidator></td>
		</tr>
		<TR valign="top">
			<TD noWrap>Percent Off</TD>
			<TD>
				<asp:ListBox id="lbNewPercentOff" runat="server" Width="100%">
					<asp:ListItem Value="25">25%</asp:ListItem>
					<asp:ListItem Value="50">50%</asp:ListItem>
					<asp:ListItem Value="75">75%</asp:ListItem>
					<asp:ListItem Value="100" Selected="True">100%</asp:ListItem>
				</asp:ListBox>
			</TD>
			<TD>This allows to declare partial day holidays. A holiday/no service date with a 
				percentage of 50% would service only half of the normal calculated work order 
				load.</TD>
		</TR>
		<TR>
			<TD colSpan="3">
				<asp:Button id="btnAddHoliday" runat="server" Text="Add Holiday"></asp:Button></TD>
		</TR>
	</table>
</form>
