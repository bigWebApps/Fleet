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
	public class _admin_permissions : BFPPage
	{
		protected System.Web.UI.WebControls.Button btnAddPerm;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvAddNewPermName;
		protected System.Web.UI.WebControls.TextBox tbAddPermName;
		protected System.Web.UI.WebControls.TextBox tbAddPermCode;
		protected System.Web.UI.WebControls.RegularExpressionValidator revAddNewPermCode;
		protected Micajah.DataGrid.DataGrid_A dgPermissions;
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvAddNewPermCode;

		private clsPermissions perm = null;
		private clsPermissions perm2 = null;
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				string [,] arrBrdCrumbs = new string [2,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="admin.aspx";
				arrBrdCrumbs[1,1]="Administration";
				PageTitle = "Permissions Manager";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;
				SourcePageName = "admin_permissions.aspx.cs";
				if(!IsPostBack)
				{
					ShowPermissions();
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
		}

		private void ShowPermissions()
		{
			try
			{
				perm = new clsPermissions();
				dgPermissions.DataSource = new DataView(perm.GetPermissionsList());
				dgPermissions.DataBind();
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
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
			this.dgPermissions.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPermissions_ItemCommand);
			this.btnAddPerm.Click += new System.EventHandler(this.btnAddPerm_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

	
		private void dgPermissions_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				switch(e.CommandName)
				{
					case "Select":
						Response.Redirect("admin_permission_detail.aspx?id=" + e.Item.Cells[1].Text, false);
						break;
					case "Delete":
						perm2 = new clsPermissions();
						perm2.cAction = "D";
						perm2.iId = Convert.ToInt32(e.Item.Cells[1].Text);
						if(perm2.PermissionDetail() == -1)
						{
							Session["lastpage"] = "admin_permissions.aspx";
							Session["error"] = _functions.ErrorMessage(116);
							Response.Redirect("error.aspx", false);
							return;
						}
						dgPermissions.EditItemIndex = -1;
						ShowPermissions();
						break;
					case "Cancel":
						rfvAddNewPermCode.Enabled = true;
						rfvAddNewPermName.Enabled = true;
						btnAddPerm.Enabled = true;
						dgPermissions.EditItemIndex = -1;
						ShowPermissions();
						break;
					case "Edit":
						rfvAddNewPermCode.Enabled = false;
						rfvAddNewPermName.Enabled = false;
						btnAddPerm.Enabled = false;
						dgPermissions.EditItemIndex = e.Item.ItemIndex;
						ShowPermissions();
						break;
					case "Update":
						rfvAddNewPermCode.Enabled = true;
						rfvAddNewPermName.Enabled = true;
						btnAddPerm.Enabled = true;
						perm2 = new clsPermissions();
						perm2.cAction = "U"; 
						perm2.iId = Convert.ToInt32(((Label)e.Item.FindControl("lblEditId")).Text);
						perm2.sName = ((TextBox)e.Item.FindControl("tbNameEdit")).Text;
						if(perm2.PermissionDetail() == -1)
						{
							Session["lastpage"] = "admin_permissions.aspx";
							Session["error"] = _functions.ErrorMessage(116);
							Response.Redirect("error.aspx", false);
							return;
						}

						dgPermissions.EditItemIndex = -1;
						ShowPermissions();
						break;
					default:
						break;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_permissions.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(perm2 != null)
					perm2.Dispose();
			}
		}

		private void btnAddPerm_Click(object sender, System.EventArgs e)
		{
			try
			{
				perm2 = new clsPermissions();
				perm2.cAction = "U"; 
				perm2.iId = 0;
				perm2.sName = tbAddPermName.Text;
				perm2.sCode = tbAddPermCode.Text;
				tbAddPermName.Text = "";
				tbAddPermCode.Text = "";
				if(perm2.PermissionDetail() == -1)
				{
					Session["lastpage"] = "admin_permissions.aspx";
					Session["error"] = _functions.ErrorMessage(116);
					Response.Redirect("error.aspx", false);
					return;
				}
				ShowPermissions();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_permissions.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(perm2 != null)
					perm2.Dispose();
			}
		}

	}
}
