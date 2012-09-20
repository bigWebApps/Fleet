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
	public class _admin_users : BFPPage
	{
		protected System.Web.UI.WebControls.TextBox tbLastName;
		protected System.Web.UI.WebControls.TextBox tbEmail;
		protected System.Web.UI.WebControls.DropDownList ddlUserTypes;
		protected System.Web.UI.WebControls.Button btnFilter;
		protected Micajah.DataGrid.DataGrid_A dgUserList;
		protected System.Web.UI.WebControls.TextBox tbFirstName;
		protected System.Web.UI.WebControls.HyperLink hlAdd;
		protected System.Web.UI.WebControls.DropDownList ddlActiveStatus;
		protected System.Web.UI.WebControls.DropDownList ddlGroups;
		
		private clsUsers user = null;
		private UserFilter uFilter;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_users.aspx.cs";
				
				Header.MainMenuSelectedItem = "Administration";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				this.PageTitle = "User Search";
				Header.LeftBarHtml = "Search/View Users";

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
				if(!IsPostBack)
				{
					user = new clsUsers();
					user.iOrgId = OrgId;
					DataTable dtGroups = user.GetGroupsList();
					DataRow _row = dtGroups.NewRow();
					_row["Id"] = 0;
					_row["vchDesc"] = "All";
					_row["CanDelete"] = false;
					dtGroups.Rows.Add(_row);
					DataView dwGroups = new DataView(dtGroups);
					dwGroups.Sort = "Id asc";
					ddlGroups.DataSource = dwGroups;
					ddlGroups.DataBind();
					if(Session["UserFilter"] != null)
					{
						uFilter = (UserFilter)Session["UserFilter"];
						user.sFirstName = uFilter.sFirstName;
						user.sLastName = uFilter.sLastName;
						user.sEmail = uFilter.sEmail;
						user.iTypeId = uFilter.iTypeId;
						user.iActiveStatus = uFilter.iActiveStatus;
						user.iGroupId = uFilter.iGroupId;
						dgUserList.DataSource = new DataView(user.GetUserList_Filter());
						dgUserList.DataBind();
						tbFirstName.Text = uFilter.sFirstName;
						tbLastName.Text = uFilter.sLastName;
						tbEmail.Text = uFilter.sEmail;
						ddlUserTypes.SelectedValue = uFilter.iTypeId.ToString();
						ddlActiveStatus.SelectedValue = uFilter.iActiveStatus.ToString();
						ddlGroups.SelectedValue = uFilter.iGroupId.ToString();
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user!=null)
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
			this.btnFilter.Click += new System.EventHandler(this.btnFilter_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		/// <summary>
		/// Showing found users
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btnFilter_Click(object sender, System.EventArgs e)
		{
			try
			{
				user = new clsUsers();
				user.iOrgId = OrgId;
				user.sFirstName = tbFirstName.Text;
				user.sLastName = tbLastName.Text;
				user.sEmail = tbEmail.Text;
				user.iTypeId = Convert.ToInt32(ddlUserTypes.SelectedValue);
				user.iActiveStatus = Convert.ToInt32(ddlActiveStatus.SelectedValue);
				user.iGroupId = Convert.ToInt32(ddlGroups.SelectedValue);
				uFilter = new UserFilter();
				uFilter.sFirstName = user.sFirstName.Value;
				uFilter.sLastName = user.sLastName.Value;
				uFilter.sEmail = user.sEmail.Value;
				uFilter.iTypeId = user.iTypeId.Value;
				uFilter.iActiveStatus = user.iActiveStatus.Value;
				uFilter.iGroupId = user.iGroupId.Value;
				Session["UserFilter"] = uFilter;
				dgUserList.DataSource = new DataView(user.GetUserList_Filter());
				dgUserList.DataBind();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_users.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user!=null)
					user.Dispose();
			}
		}
	}
}
