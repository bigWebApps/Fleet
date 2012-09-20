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
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected System.Web.UI.WebControls.DataGrid dgPages;
		protected System.Web.UI.WebControls.DropDownList ddlNewPages;
		private clsPermissions perm = null;
		private DataSet dsPages = null;
		protected System.Web.UI.WebControls.Label lblBack;
		protected System.Web.UI.WebControls.Button btnAddPage;
		private int PermId;

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

				string [,] arrBrdCrumbs = new string [3,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="admin.aspx";
				arrBrdCrumbs[1,1]="Administration";
				arrBrdCrumbs[2,0]="admin_permissions.aspx";
				arrBrdCrumbs[2,1]="Permissions Manager";
				PageTitle = "Pages Manager for Permission";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;
				SourcePageName = "admin_permission_detail.aspx.cs";
				lblBack.Text = "<input type=button value=\" Back \" onclick=\"document.location='admin_permissions.aspx'\">";
				if(!IsPostBack)
				{
					perm = new clsPermissions();
					perm.iId = PermId;
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

		private void dgPages_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
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
					Session["lastpage"] = "admin_permission_detail.aspx?id=" + PermId.ToString();
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
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

		private void btnAddPage_Click(object sender, System.EventArgs e)
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
