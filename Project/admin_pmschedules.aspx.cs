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
	public class _admin_pmschedules : BFPPage
	{
		protected System.Web.UI.WebControls.TextBox tbScheduleName;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvScheduleName;
		protected Micajah.Common.DataGridEx dgPMSchedules;
		protected System.Web.UI.WebControls.Button btnAddSchedule;

		private clsPMSchedService pmitems = null;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_pmschedules.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				this.PageTitle = "Preventive Maintenances Schedules Manager";
				Header.LeftBarHtml = "Add/Edit/Delete PM Schedule";

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
					dgPMSchedules.DataSource = pmitems.GetPMSchedulesList();
					dgPMSchedules.DataBind();
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
			this.dgPMSchedules.EditCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPMSchedules_EditCommand);
			this.dgPMSchedules.CancelCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPMSchedules_CancelCommand);
			this.dgPMSchedules.UpdateCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPMSchedules_UpdateCommand);
			this.dgPMSchedules.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPMSchedules_DeleteCommand);
			this.btnAddSchedule.Click += new System.EventHandler(this.btnAddSchedule_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnAddSchedule_Click(object sender, System.EventArgs e)
		{
			try
			{
				pmitems = new clsPMSchedService();
				pmitems.cAction = "U"; 
				pmitems.iOrgId = OrgId;
				pmitems.iPMSchedId = 0;
				pmitems.sPMSchedName = tbScheduleName.Text;
				pmitems.PMScheduleDetails();
				dgPMSchedules.EditItemIndex = -1;
				dgPMSchedules.DataSource = pmitems.GetPMSchedulesList();
				dgPMSchedules.DataBind();
				tbScheduleName.Text = "";
				
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmschedules.aspx";
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

		private void dgPMSchedules_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgPMSchedules.EditItemIndex = -1;
				pmitems = new clsPMSchedService();
				pmitems.iOrgId = OrgId;
				dgPMSchedules.DataSource = pmitems.GetPMSchedulesList();
				dgPMSchedules.DataBind();
				
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmschedules.aspx";
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

		private void dgPMSchedules_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				pmitems = new clsPMSchedService();
				pmitems.cAction = "D"; 
				pmitems.iOrgId = OrgId;
				pmitems.iPMSchedId = Convert.ToInt32(e.CommandArgument);
				switch(pmitems.PMScheduleDetails())
				{
					case -1:
						Header.ErrorMessage = _functions.ErrorMessage(169);
						return;
					case -2:
						Header.ErrorMessage = _functions.ErrorMessage(170);
						return;
					case -3:
						Header.ErrorMessage = _functions.ErrorMessage(171);
						return;
					default:
						break;
				}
				dgPMSchedules.EditItemIndex = -1;
				dgPMSchedules.DataSource = pmitems.GetPMSchedulesList();
				dgPMSchedules.DataBind();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmschedules.aspx";
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

		private void dgPMSchedules_EditCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgPMSchedules.EditItemIndex = e.Item.ItemIndex;
				pmitems = new clsPMSchedService();
				pmitems.iOrgId = OrgId;
				dgPMSchedules.DataSource = pmitems.GetPMSchedulesList();
				dgPMSchedules.DataBind();
				
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmschedules.aspx";
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

		private void dgPMSchedules_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				pmitems = new clsPMSchedService();
				pmitems.cAction = "U"; 
				pmitems.iOrgId = OrgId;
				pmitems.iPMSchedId = Convert.ToInt32(e.CommandArgument);
				pmitems.sPMSchedName = ((TextBox)e.Item.FindControl("tbPMScheduleName")).Text;
				if(pmitems.PMScheduleDetails() == -1)
				{
					Header.ErrorMessage = _functions.ErrorMessage(169);
				}
				else
				{
					dgPMSchedules.EditItemIndex = -1;
					dgPMSchedules.DataSource = pmitems.GetPMSchedulesList();
					dgPMSchedules.DataBind();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_pmschedules.aspx";
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
	}
}
