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
	public class _admin_groups : BFPPage
	{
		protected System.Web.UI.WebControls.TextBox tbGroupName;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvGroupName;
		protected System.Web.UI.WebControls.Button btnAddGroup;
		protected Micajah.DataGrid.DataGrid_A dgGroups;
		protected BWA.BFP.Web.Controls.User.Header Header;
		
		private clsUsers user = null;
		private clsUsers user2 = null;
		private DataTable dtGroups = null;

		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				string [,] arrBrdCrumbs = new string [2,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="admin.aspx";
				arrBrdCrumbs[1,1]="Administration";
				PageTitle = "Groups Manager";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;
				SourcePageName = "admin_groups.aspx.cs";
				if(!IsPostBack)
				{
					ShowGroups();
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

		private void ShowGroups()
		{
			try
			{
				user = new clsUsers();
				user.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				dtGroups = user.GetGroupsList();
				dgGroups.DataSource = new DataView(dtGroups);
				dgGroups.DataBind();
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
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
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.dgGroups.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgGroups_ItemCommand);
			this.btnAddGroup.Click += new System.EventHandler(this.btnAddGroup_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void dgGroups_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				switch(e.CommandName)
				{
					case "Delete":
						user2 = new clsUsers();
						user2.cAction = "D";
						user2.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
						user2.iGroupId = Convert.ToInt32(e.Item.Cells[0].Text);
						switch(user2.GroupDetails())
						{
							case -1:
								Session["lastpage"] = "admin_groups.aspx";
								Session["error"] = _functions.ErrorMessage(117);
								Response.Redirect("error.aspx", false);
								return;
							case 1:
								Session["lastpage"] = "admin_groups.aspx";
								Session["error"] = _functions.ErrorMessage(118);
								Response.Redirect("error.aspx", false);
								return;
							case 0:
								dgGroups.EditItemIndex = -1;
								ShowGroups();
								break;
							default:
								break;
						}
						break;
					case "Cancel":
						dgGroups.EditItemIndex = -1;
						ShowGroups();
						break;
					case "Edit":
						dgGroups.EditItemIndex = e.Item.ItemIndex;
						ShowGroups();
						break;
					case "Update":
						user2 = new clsUsers();
						user2.cAction = "U"; 
						user2.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
						user2.iGroupId = Convert.ToInt32(((Label)e.Item.FindControl("lblEditId")).Text);
						user2.sGroupName = ((TextBox)e.Item.FindControl("tbNameEdit")).Text;
						if(user2.GroupDetails() == -1)
						{
							Session["lastpage"] = "admin_groups.aspx";
							Session["error"] = _functions.ErrorMessage(117);
							Response.Redirect("error.aspx", false);
							return;
						}

						dgGroups.EditItemIndex = -1;
						ShowGroups();
						break;
					default:
						break;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_groups.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user2 != null)
					user2.Dispose();
			}
		}

		private void btnAddGroup_Click(object sender, System.EventArgs e)
		{
			try
			{
				user2 = new clsUsers();
				user2.cAction = "U"; 
				user2.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				user2.iGroupId = 0;
				user2.sGroupName = tbGroupName.Text;
				tbGroupName.Text = "";
				if(user2.GroupDetails() == -1)
				{
					Session["lastpage"] = "admin_groups.aspx";
					Session["error"] = _functions.ErrorMessage(117);
					Response.Redirect("error.aspx", false);
					return;
				}
				ShowGroups();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_groups.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user2 != null)
					user2.Dispose();
			}
		}

	}
}
