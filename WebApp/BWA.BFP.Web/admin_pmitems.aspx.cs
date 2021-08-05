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
using Micajah.Common;

namespace BWA.BFP.Web.admin
{
	/// <summary>
	/// Summary description for admin_pmitems.
	/// </summary>
	public class admin_pmitems : BFPPage
	{
		protected Micajah.Common.DataGridEx dgPMItems;
		protected System.Web.UI.WebControls.DropDownList ddlCategory;
		protected System.Web.UI.WebControls.TextBox tbItemName;
		protected System.Web.UI.WebControls.Button btnAddPMItem;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvItemName;

		private clsPMSchedService pmitems = null;
		private DataTable dtCats = null;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_pmitems.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				this.PageTitle = "Preventive Maintenances Items Manager";
				Header.LeftBarHtml = "Add/Edit/Delete PM Items";

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
					pmitems = new clsPMSchedService();
					pmitems.iOrgId = OrgId;
					dgPMItems.DataSource = pmitems.GetPMServicesList();
					dgPMItems.DataBind();
					dtCats = pmitems.GetRepairCatsList();
					ddlCategory.DataSource = dtCats;
					ddlCategory.DataBind();
					ViewState["Categories"] = dtCats;
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
				if(pmitems != null)
					pmitems.Dispose();
			}
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.dgPMItems.EditCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPMItems_EditCommand);
			this.dgPMItems.CancelCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPMItems_CancelCommand);
			this.dgPMItems.UpdateCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPMItems_UpdateCommand);
			this.dgPMItems.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPMItems_DeleteCommand);
			this.dgPMItems.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.dgPMItems_ItemDataBound);
			this.btnAddPMItem.Click += new System.EventHandler(this.btnAddPMItem_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnAddPMItem_Click(object sender, System.EventArgs e)
		{
			try
			{
				pmitems = new clsPMSchedService();
				pmitems.cAction = "U"; 
				pmitems.iOrgId = OrgId;
				pmitems.iPMServiceId = 0;
				pmitems.iRepairCatId = Convert.ToInt32(ddlCategory.SelectedValue);
				pmitems.sPMServiceName = tbItemName.Text;
				pmitems.PMServiceDetails();
				dgPMItems.DataSource = pmitems.GetPMServicesList();
				dgPMItems.DataBind();
				tbItemName.Text= "";
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmitems.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(pmitems != null)
					pmitems.Dispose();
			}		
		}

		private void dgPMItems_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgPMItems.EditItemIndex = -1;
				pmitems = new clsPMSchedService();
				pmitems.iOrgId = OrgId;
				dgPMItems.DataSource = pmitems.GetPMServicesList();
				dgPMItems.DataBind();
				
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmitems.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(pmitems != null)
					pmitems.Dispose();
			}		
		}

		private void dgPMItems_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				pmitems = new clsPMSchedService();
				pmitems.cAction = "D"; 
				pmitems.iOrgId = OrgId;
				pmitems.iPMServiceId = Convert.ToInt32(e.CommandArgument);
				switch(pmitems.PMServiceDetails())
				{
					case -1:
						Header.ErrorMessage = _functions.ErrorMessage(172);
						return;
					case -2:
						Header.ErrorMessage = _functions.ErrorMessage(173);
						return;
					default:
						break;
				}
				dgPMItems.EditItemIndex = -1;
				dgPMItems.DataSource = pmitems.GetPMServicesList();
				dgPMItems.DataBind();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmitems.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(pmitems != null)
					pmitems.Dispose();
			}		
		}

		private void dgPMItems_EditCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgPMItems.EditItemIndex = e.Item.ItemIndex;
				pmitems = new clsPMSchedService();
				pmitems.iOrgId = OrgId;
				dgPMItems.DataSource = pmitems.GetPMServicesList();
				dgPMItems.DataBind();
				
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmitems.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(pmitems != null)
					pmitems.Dispose();
			}		
		}

		private void dgPMItems_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				pmitems = new clsPMSchedService();
				pmitems.cAction = "U"; 
				pmitems.iOrgId = OrgId;
				pmitems.iPMServiceId = Convert.ToInt32(e.CommandArgument);
				pmitems.sPMServiceName = ((TextBox)e.Item.FindControl("tbPMServiceName")).Text;
				pmitems.iRepairCatId = Convert.ToInt32(((DropDownList)e.Item.FindControl("dg_ddlCategories")).SelectedValue);
				if(pmitems.PMServiceDetails() == -1)
				{
					Header.ErrorMessage = _functions.ErrorMessage(172);
				}
				else
				{
					dgPMItems.EditItemIndex = -1;
					dgPMItems.DataSource = pmitems.GetPMServicesList();
					dgPMItems.DataBind();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmitems.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(pmitems != null)
					pmitems.Dispose();
			}		
		}

		private void dgPMItems_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
		{
			try
			{
				if(e.Item.ItemType == ListItemType.EditItem)
				{
					dtCats = (DataTable)ViewState["Categories"];
					DropDownList dg_ddlCategories = ((DropDownList)e.Item.FindControl("dg_ddlCategories"));
					dg_ddlCategories.DataSource = new DataView(dtCats);
					dg_ddlCategories.DataBind();
					dg_ddlCategories.SelectedValue = dg_ddlCategories.Attributes["SelectedValueEx"];
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmitems.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}
	}
}
