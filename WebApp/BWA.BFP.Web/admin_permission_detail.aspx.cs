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
	public class _admin_permission_detail : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgPages;
		protected System.Web.UI.WebControls.DropDownList ddlNewPages;
		protected System.Web.UI.WebControls.Label lblBack;
		protected System.Web.UI.WebControls.Button btnAddPage;
		protected System.Web.UI.WebControls.Label lblPermName;
		protected System.Web.UI.WebControls.Label lblPermCode;

		private clsPermissions perm = null;
		private DataSet dsPages = null;
		private int PermId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_permission_detail.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("Permissions Manager", "/admin_permissions.aspx");
				this.PageTitle = "Pages Manager for Permission";
				Header.LeftBarHtml = "Add/Delete Pages to/from Permission";

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
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "admin_permissions.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					PermId=Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "admin_permissions.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				lblBack.Text = "<input type=button value=\" Back \" onclick=\"document.location='admin_permissions.aspx'\">";
				if(!IsPostBack)
				{
					perm = new clsPermissions();
					perm.iId = PermId;
					perm.cAction = "S";
					if(perm.PermissionDetail() == -1)
					{
						Session["lastpage"] = "admin_permission_detail.aspx?id=" + PermId.ToString();
						Session["error"] = _functions.ErrorMessage(116);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblPermCode.Text = perm.sCode.Value;
					lblPermName.Text = perm.sName.Value;
					dsPages = perm.GetPagesListFromPermission();
					dgPages.DataSource = new DataView(dsPages.Tables["Table"]);
					dgPages.DataBind();
					if(dsPages.Tables["Table1"].Rows.Count > 0)
					{
						ddlNewPages.DataTextField = "vchPageName";
						ddlNewPages.DataValueField = "Id";
						ddlNewPages.DataSource = new DataView(dsPages.Tables["Table1"]);
						ddlNewPages.DataBind();
					}
					else
					{
						ddlNewPages.Items.Add(new ListItem("<none>", "0"));
						btnAddPage.Enabled = false;
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
			this.dgPages.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPages_DeleteCommand);
			this.btnAddPage.Click += new System.EventHandler(this.btnAddPage_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		/// <summary>
		/// Delete page from the permission
		/// </summary>
		/// <param name="source"></param>
		/// <param name="e"></param>
		private void dgPages_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			
			try
			{
				perm = new clsPermissions();
				perm.cAction = "D";
				perm.iId = PermId;
				perm.iPageId = Convert.ToInt32(e.Item.Cells[0].Text);
				if(perm.PagesPermissionDetail() == -1)
				{
					Session["lastpage"] = "admin_permission_detail.aspx?id=" + PermId.ToString();
					Session["error"] = _functions.ErrorMessage(116);
					Response.Redirect("error.aspx", false);
					return;
				}
				else
					Response.Redirect("admin_permission_detail.aspx?id=" + PermId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_permissions_detail.aspx?id=" + PermId.ToString();
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

		/// <summary>
		/// Adding the page to the permission
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btnAddPage_Click(object sender, System.EventArgs e)
		{
			try
			{
				perm = new clsPermissions();
				perm.cAction = "I";
				perm.iId = PermId;
				perm.iPageId = Convert.ToInt32(ddlNewPages.SelectedValue);
				if(perm.PagesPermissionDetail() == -1)
				{
					Session["lastpage"] = "admin_permission_detail.aspx?id=" + PermId.ToString();
					Session["error"] = _functions.ErrorMessage(116);
					Response.Redirect("error.aspx", false);
					return;
				}
				else
					Response.Redirect("admin_permission_detail.aspx?id=" + PermId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_permissions_detail.aspx?id=" + PermId.ToString();
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
