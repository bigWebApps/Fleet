using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web.admin
{
	public class _admin_groups_users : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgUsers;
		protected System.Web.UI.WebControls.DropDownList ddlUsers;
		protected System.Web.UI.WebControls.Label lblGroupName;
		protected System.Web.UI.WebControls.Button btnAddUser;
		protected System.Web.UI.WebControls.Label lblBack;

		private clsUsers user = null;
		private int GroupId;
		private DataSet dsUsers = null;
			
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_groups_users.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				this.PageTitle  = "Users Manager for Group";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("Groups Manager", "/admin_groups.aspx");
				Header.LeftBarHtml = "Add/Delete Users to/from Group";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = this.ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = this.ParentPageURL;
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					GroupId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = this.ParentPageURL;
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				lblBack.Text = "<input type=button value=\" Back \" onclick=\"document.location='admin_groups.aspx'\">";
				
				if(!IsPostBack)
				{
					user = new clsUsers();
					user.cAction = "S";
					user.iGroupId = GroupId;
					user.iOrgId = OrgId;
					if(user.GroupDetails() == -1)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(117);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblGroupName.Text = user.sGroupName.Value;

					dsUsers = user.GetUsersListFromGroup();
					dgUsers.DataSource = new DataView(dsUsers.Tables["Table"]);
					dgUsers.DataBind();
					if(dsUsers.Tables["Table1"].Rows.Count > 0)
					{
						ddlUsers.DataSource = new DataView(dsUsers.Tables["Table1"]);
						ddlUsers.DataBind();
					}
					else
					{
						ddlUsers.Items.Add(new ListItem("<none>", "0"));
						btnAddUser.Enabled = false;
					}
				}
			}
		
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = this.ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user != null)
					user.Dispose();
			}
		}
		

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.dgUsers.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgUsers_DeleteCommand);
			this.btnAddUser.Click += new System.EventHandler(this.btnAddUser_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		/// <summary>
		/// Adding the user to groups
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btnAddUser_Click(object sender, System.EventArgs e)
		{
			try
			{
				user = new clsUsers();
				user.cAction = "I";
				user.iId = Convert.ToInt32(ddlUsers.SelectedValue);
				user.iOrgId = OrgId;
				user.iGroupId = GroupId;
				if(user.UsersGroupsDetail() == -1)
				{
					Session["lastpage"] = "admin_groups_users.aspx?id=" + GroupId.ToString();
					Session["error"] = _functions.ErrorMessage(117);
					Response.Redirect("error.aspx", false);
					return;
				}
				else
					Response.Redirect("admin_groups_users.aspx?id=" + GroupId.ToString(), false);
					
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_groups_users.aspx?id=" + GroupId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user != null)
					user.Dispose();
			}		
		}

		/// <summary>
		/// Deleting user from group
		/// </summary>
		/// <param name="source"></param>
		/// <param name="e"></param>
		private void dgUsers_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				user = new clsUsers();
				user.cAction = "D";
				user.iId = Convert.ToInt32(e.Item.Cells[0].Text);
				user.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				user.iGroupId = GroupId;
				if(user.UsersGroupsDetail() == -1)
				{
					Session["lastpage"] = "admin_groups_users.aspx?id=" + GroupId.ToString();
					Session["error"] = _functions.ErrorMessage(117);
					Response.Redirect("error.aspx", false);
					return;
				}
				else
					Response.Redirect("admin_groups_users.aspx?id=" + GroupId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_groups_users.aspx?id=" + GroupId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user != null)
					user.Dispose();
			}			
		
		}
	}
}
