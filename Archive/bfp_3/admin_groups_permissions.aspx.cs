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
	public class _admin_groups_permissions_aspx : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected System.Web.UI.WebControls.DataGrid dgPermissions;
		protected System.Web.UI.WebControls.DropDownList ddlNewPerm;
		protected System.Web.UI.WebControls.Button btnAddPerm;
		protected System.Web.UI.WebControls.Label lblBack;
	
		private clsPermissions perm = null;
		private DataSet dsPerm = null;
		private int GroupId;
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "admin_groups.aspx";
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
					Session["lastpage"] = "admin_groups.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				string [,] arrBrdCrumbs = new string [3,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="admin.aspx";
				arrBrdCrumbs[1,1]="Administration";
				arrBrdCrumbs[2,0]="admin_groups.aspx";
				arrBrdCrumbs[2,1]="Groups Manager";
				PageTitle = "Permissions Manager for Group";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;
				SourcePageName = "admin_groups_permissions.aspx.cs";
				lblBack.Text = "<input type=button value=\" Back \" onclick=\"document.location='admin_groups.aspx'\">";
				if(!IsPostBack)
				{
					perm = new clsPermissions();
					perm.iGroupId = GroupId;
					perm.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					dsPerm = perm.GetPermissionListFromGroup();
					dgPermissions.DataSource = new DataView(dsPerm.Tables["Table"]);
					dgPermissions.DataBind();
					if(dsPerm.Tables["Table1"].Rows.Count > 0)
					{
						ddlNewPerm.DataTextField = "vchName";
						ddlNewPerm.DataValueField = "Id";
						ddlNewPerm.DataSource = new DataView(dsPerm.Tables["Table1"]);
						ddlNewPerm.DataBind();
					}
					else
					{
						ddlNewPerm.Items.Add( new ListItem("<none>", "0"));
						btnAddPerm.Enabled = false;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(perm != null)
					perm.Dispose();
			}

		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.dgPermissions.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPermissions_DeleteCommand);
			this.btnAddPerm.Click += new System.EventHandler(this.btnAddPerm_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void dgPermissions_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "admin_groups.aspx";
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
					Session["lastpage"] = "admin_groups.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				perm = new clsPermissions();
				perm.cAction = "D";
				perm.iId = Convert.ToInt32(e.Item.Cells[0].Text);
				perm.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				perm.iGroupId = GroupId;
				if(perm.GroupsPermissionsDetail() == -1)
				{
					Session["lastpage"] = "admin_groups_permissions.aspx?id=" + GroupId.ToString();
					Session["error"] = _functions.ErrorMessage(116);
					Response.Redirect("error.aspx", false);
					return;
				}
				else
					Response.Redirect("admin_groups_permissions.aspx?id=" + GroupId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_groups_permissions.aspx?id=" + GroupId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(perm != null)
					perm.Dispose();
			}
		
		}

		private void btnAddPerm_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "admin_groups.aspx";
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
					Session["lastpage"] = "admin_groups.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				perm = new clsPermissions();
				perm.cAction = "I";
				perm.iId = Convert.ToInt32(ddlNewPerm.SelectedValue);
				perm.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				perm.iGroupId = GroupId;
				if(perm.GroupsPermissionsDetail() == -1)
				{
					Session["lastpage"] = "admin_groups_permissions.aspx?id=" + GroupId.ToString();
					Session["error"] = _functions.ErrorMessage(116);
					Response.Redirect("error.aspx", false);
					return;
				}
				else
					Response.Redirect("admin_groups_permissions.aspx?id=" + GroupId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_groups_permissions.aspx?id=" + GroupId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(perm != null)
					perm.Dispose();
			}
		}
	}
}
