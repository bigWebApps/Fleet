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
	public class _admin_inspectschedules : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgInspectSchedules;
		protected System.Web.UI.WebControls.TextBox tbScheduleName;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvScheduleName;
		protected System.Web.UI.WebControls.Button btnAddSchedule;

		private clsInspections inspect = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_inspectschedules.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				this.PageTitle = "Inspections Schedules Manager";
				Header.LeftBarHtml = "Add/Edit/Delete Inspection Schedule";

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
					inspect = new clsInspections();
					inspect.iOrgId = OrgId;
					ShowInspectSchedules();
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
				if(inspect != null)
					inspect.Dispose();
			}
		}

		private void ShowInspectSchedules()
		{
			try
			{	 
				dgInspectSchedules.DataSource = new DataView(inspect.GetInspectSchedulesList());
				dgInspectSchedules.DataBind();
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
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
			this.dgInspectSchedules.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgInspectSchedules_ItemCommand);
			this.btnAddSchedule.Click += new System.EventHandler(this.btnAddSchedule_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void dgInspectSchedules_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				inspect = new clsInspections();
				inspect.iOrgId = OrgId;
				inspect.iInspectScheduleId = Convert.ToInt32(e.Item.Cells[0].Text);
				switch(e.CommandName)
				{
					case "Delete":
						inspect.cAction = "D";
						switch(inspect.InspectScheduleDetails())
						{
							case -1:
								Session["lastpage"] = "admin_inspectschedules.aspx";
								Session["error"] = _functions.ErrorMessage(159);
								Response.Redirect("error.aspx", false);
								return;
							case -2:
								Header.ErrorMessage = _functions.ErrorMessage(160);
								break;
							case -3:
								Header.ErrorMessage = _functions.ErrorMessage(161);
								break;
							case 0:
								dgInspectSchedules.EditItemIndex = -1;
								ShowInspectSchedules();
								break;
							default:
								break;
						}
						break;
					case "Cancel":
						dgInspectSchedules.EditItemIndex = -1;
						ShowInspectSchedules();
						break;
					case "Edit":
						dgInspectSchedules.EditItemIndex = e.Item.ItemIndex;
						ShowInspectSchedules();
						break;
					case "Update":
						inspect.cAction = "U"; 
						inspect.sInspectScheduleName = ((TextBox)e.Item.FindControl("tbNameEdit")).Text;
						if(inspect.InspectScheduleDetails() == -1)
						{
							Session["lastpage"] = "admin_inspectschedules.aspx";
							Session["error"] = _functions.ErrorMessage(159);
							Response.Redirect("error.aspx", false);
							return;
						}
						dgInspectSchedules.EditItemIndex = -1;
						ShowInspectSchedules();
						break;
					default:
						break;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_inspectschedules.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(inspect != null)
					inspect.Dispose();
			}
		}

		private void btnAddSchedule_Click(object sender, System.EventArgs e)
		{
			try
			{
				inspect = new clsInspections();
				inspect.cAction = "U"; 
				inspect.iOrgId = OrgId;
				inspect.iInspectScheduleId = 0;
				inspect.sInspectScheduleName= tbScheduleName.Text;
				tbScheduleName.Text = "";
				inspect.InspectScheduleDetails();
				ShowInspectSchedules();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_inspectschedules.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(inspect != null)
					inspect.Dispose();
			}		
		}
	}
}
