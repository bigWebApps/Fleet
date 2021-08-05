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
	public class _admin_holidays : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgHolidays;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvHolidayName;
		protected System.Web.UI.WebControls.TextBox tbNewHolidayName;
		protected System.Web.UI.WebControls.ListBox lbNewPercentOff;
		protected ActiveUp.WebControls.ActiveDateTime adtNewStartDate;
		protected ActiveUp.WebControls.ActiveDateTime adtNewEndDate;
		protected System.Web.UI.WebControls.Button btnAddHoliday;
		protected System.Web.UI.HtmlControls.HtmlAnchor A1;
		protected System.Web.UI.HtmlControls.HtmlAnchor A2;

		private clsInspections inspect = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_holidays.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				this.PageTitle  = "Holidays Date Manage";
				Header.AddJavaScriptFile("/OpenWindows.js");
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.LeftBarHtml = "Add/Edit/Delete Holidays";
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
			DateTime daCurrentDate;
			try
			{
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				if(!IsPostBack)
				{
					daCurrentDate = DateTime.Now;
					adtNewEndDate.Date = daCurrentDate;
					adtNewStartDate.Date = daCurrentDate;
					inspect = new clsInspections();
					inspect.iOrgId = OrgId;
					ShowHolidays();
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

		private void ShowHolidays()
		{
			try
			{
				dgHolidays.DataSource = new DataView(inspect.GetHolidaysList());
				dgHolidays.DataBind();
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
			this.dgHolidays.EditCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgHolidays_EditCommand);
			this.dgHolidays.CancelCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgHolidays_CancelCommand);
			this.dgHolidays.UpdateCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgHolidays_UpdateCommand);
			this.dgHolidays.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgHolidays_DeleteCommand);
			this.btnAddHoliday.Click += new System.EventHandler(this.btnAddHoliday_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnAddHoliday_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(adtNewEndDate.Date >= adtNewStartDate.Date)
				{
					inspect = new clsInspections();
					inspect.cAction = "U";
					inspect.iOrgId = OrgId;
					inspect.iHolidayId = 0;
					inspect.daHolidayStartDate = adtNewStartDate.Date;
					inspect.daHolidayEndDate = adtNewEndDate.Date;
					inspect.sHolidayName = tbNewHolidayName.Text;
					inspect.iHolidayPercentOff = Convert.ToInt32(lbNewPercentOff.SelectedValue);
					inspect.HolidayDetail();
					ShowHolidays();
				}
				else
					Header.ErrorMessage = "Start Date must be less than End Date";
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_holidays.aspx";
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

		private void dgHolidays_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				inspect = new clsInspections();
				inspect.cAction = "D";
				inspect.iOrgId = OrgId;
				inspect.iHolidayId = Convert.ToInt32(e.Item.Cells[0].Text);
				if(inspect.HolidayDetail() == -1)
				{
					Session["lastpage"] = "admin_holidays.aspx";
					Session["error"] = _functions.ErrorMessage(153);
					Response.Redirect("error.aspx", false);
					return;
				}
				ShowHolidays();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_holidays.aspx";
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

		private void dgHolidays_EditCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgHolidays.EditItemIndex = e.Item.ItemIndex;
				inspect = new clsInspections();
				inspect.iOrgId = OrgId;
				ShowHolidays();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_holidays.aspx";
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

		private void dgHolidays_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				if(((ActiveUp.WebControls.ActiveDateTime)e.Item.FindControl("adtEndDate")).Date >= ((ActiveUp.WebControls.ActiveDateTime)e.Item.FindControl("adtStartDate")).Date)
				{
					inspect = new clsInspections();
					inspect.cAction = "U";
					inspect.iOrgId = OrgId;
					inspect.iHolidayId = Convert.ToInt32(e.Item.Cells[0].Text);
					inspect.daHolidayStartDate = ((ActiveUp.WebControls.ActiveDateTime)e.Item.FindControl("adtStartDate")).Date;
					inspect.daHolidayEndDate = ((ActiveUp.WebControls.ActiveDateTime)e.Item.FindControl("adtEndDate")).Date;
					inspect.sHolidayName = ((TextBox)e.Item.FindControl("tbHolidayName")).Text;
					inspect.iHolidayPercentOff = Convert.ToInt32(((ListBox)e.Item.FindControl("lbPercentOff")).SelectedValue);
					if(inspect.HolidayDetail() == -1)
					{
						Session["lastpage"] = "admin_holidays.aspx";
						Session["error"] = _functions.ErrorMessage(153);
						Response.Redirect("error.aspx", false);
						return;
					}
					dgHolidays.EditItemIndex = -1;
					ShowHolidays();
				}
				else
					Header.ErrorMessage = "Start Date must be less than End Date";
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_holidays.aspx";
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

		private void dgHolidays_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgHolidays.EditItemIndex = -1;
				inspect = new clsInspections();
				inspect.iOrgId = OrgId;
				ShowHolidays();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_holidays.aspx";
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
