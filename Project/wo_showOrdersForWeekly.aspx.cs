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

namespace BWA.BFP.Web.workorder
{
	public class _wo_showOrdersForWeekly : BFPPage
	{
		protected System.Web.UI.WebControls.LinkButton lbPreviousMonth;
		protected System.Web.UI.WebControls.Label lblCurrentDate;
		protected System.Web.UI.WebControls.Label lblMondayDate;
		protected Micajah.DataGrid.DataGrid_A dgWorkOrdersMonday;
		protected System.Web.UI.WebControls.LinkButton lbNextMonth;
		protected System.Web.UI.WebControls.LinkButton lbPreviousWeek;
		protected System.Web.UI.WebControls.LinkButton lbNextWeek;
		protected System.Web.UI.WebControls.Label lblTuesdayDate;
		protected Micajah.DataGrid.DataGrid_A dgWorkOrdersTuesday;
		protected System.Web.UI.WebControls.Label lblWednesdayDate;
		protected Micajah.DataGrid.DataGrid_A dgWorkOrdersWednesday;
		protected System.Web.UI.WebControls.Label lblThursdayDate;
		protected Micajah.DataGrid.DataGrid_A dgWorkOrdersThursday;
		protected System.Web.UI.WebControls.Label lblFridayDate;
		protected Micajah.DataGrid.DataGrid_A dgWorkOrdersFriday;
		protected System.Web.UI.WebControls.Label lblWeekendDate;
		protected Micajah.DataGrid.DataGrid_A dgWorkOrdersWeekend;
		
		private clsWorkOrders order = null;
		private DateTime dtCurrentDate;
		private DataTable dtWorkOrders = null;
		private DataView dwOrderMonday = null;
		private DataView dwOrderTuesday = null;
		private DataView dwOrderWednesday = null;
		private DataView dwOrderThursday = null;
		private DataView dwOrderFriday = null;
		private DataView dwOrderWeekend = null;
		private double l_iWeekDay;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_showOrdersForWeekly.aspx.cs";
				
				this.PageTitle = "Weekly Work Orders View";
				
				Header.AddBreadCrumb("Home", "/main.aspx");
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
				Session["PathToViewOrder"] = "Weekly";
				if(!IsPostBack)
				{
					if(Session["CurrentDay"] == null)
						dtCurrentDate = DateTime.Now.Date;
					else
						dtCurrentDate = ((DateTime)Session["CurrentDay"]).Date;
					
					ShowWorkOrders();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "main.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}
		}

		private void ShowWorkOrders()
		{
			try
			{
				lblCurrentDate.Text = dtCurrentDate.ToLongDateString();
				order = new clsWorkOrders();
				order.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				switch(dtCurrentDate.DayOfWeek)
				{
					case DayOfWeek.Monday:
						l_iWeekDay = 0;
						break;
					case DayOfWeek.Tuesday:
						l_iWeekDay = 1;
						break;
					case DayOfWeek.Wednesday:
						l_iWeekDay = 2;
						break;
					case DayOfWeek.Thursday:
						l_iWeekDay = 3;
						break;
					case DayOfWeek.Friday:
						l_iWeekDay = 4;
						break;
					case DayOfWeek.Saturday:
						l_iWeekDay = 5;
						break;
					case DayOfWeek.Sunday:
						l_iWeekDay = 6;
						break;
				}
				lblMondayDate.Text = "Monday " + dtCurrentDate.AddDays(-(l_iWeekDay)).ToShortDateString();
				lblTuesdayDate.Text = "Tuesday " + dtCurrentDate.AddDays(1-l_iWeekDay).ToShortDateString();
				lblWednesdayDate.Text = "Wednesday " + dtCurrentDate.AddDays(2-l_iWeekDay).ToShortDateString();
				lblThursdayDate.Text = "Thursday " + dtCurrentDate.AddDays(3-l_iWeekDay).ToShortDateString();
				lblFridayDate.Text = "Friday " + dtCurrentDate.AddDays(4-l_iWeekDay).ToShortDateString();
				lblWeekendDate.Text = "Saturday/Sunday " + dtCurrentDate.AddDays(5-l_iWeekDay).ToShortDateString() + " - " + dtCurrentDate.AddDays(6-l_iWeekDay).ToShortDateString();

				order.daMaxDate = dtCurrentDate.AddDays(7-l_iWeekDay);
				order.daMinDate = dtCurrentDate.AddDays(-(l_iWeekDay));
				dtWorkOrders = order.GetWOListForDate();
				// Monday
				dwOrderMonday = new DataView(dtWorkOrders);
				dwOrderMonday.RowFilter = "[WeekDay] = 2";
				dgWorkOrdersMonday.DataSource = dwOrderMonday;
				dgWorkOrdersMonday.DataBind();
				// Tuesday
				dwOrderTuesday = new DataView(dtWorkOrders);
				dwOrderTuesday.RowFilter = "[WeekDay] = 3";
				dgWorkOrdersTuesday.DataSource = dwOrderTuesday;
				dgWorkOrdersTuesday.DataBind();
				// Wednesday
				dwOrderWednesday = new DataView(dtWorkOrders);
				dwOrderWednesday.RowFilter = "[WeekDay] = 4";
				dgWorkOrdersWednesday.DataSource = dwOrderWednesday;
				dgWorkOrdersWednesday.DataBind();
				// Thursday
				dwOrderThursday = new DataView(dtWorkOrders);
				dwOrderThursday.RowFilter = "[WeekDay] = 5";
				dgWorkOrdersThursday.DataSource = dwOrderThursday;
				dgWorkOrdersThursday.DataBind();
				// Friday
				dwOrderFriday = new DataView(dtWorkOrders);
				dwOrderFriday.RowFilter = "[WeekDay] = 6";
				dgWorkOrdersFriday.DataSource = dwOrderFriday;
				dgWorkOrdersFriday.DataBind();
				// Weekend
				dwOrderWeekend = new DataView(dtWorkOrders);
				dwOrderWeekend.RowFilter = "[WeekDay] in (1,7)";
				dgWorkOrdersWeekend.DataSource = dwOrderWeekend;
				dgWorkOrdersWeekend.DataBind();

				Session["CurrentDay"] = dtCurrentDate;
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally
			{
				if(order != null)
					order.Dispose();
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
			this.lbPreviousMonth.Click += new System.EventHandler(this.lbPreviousMonth_Click);
			this.lbPreviousWeek.Click += new System.EventHandler(this.lbPreviousWeek_Click);
			this.lbNextWeek.Click += new System.EventHandler(this.lbNextWeek_Click);
			this.lbNextMonth.Click += new System.EventHandler(this.lbNextMonth_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void lbNextWeek_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(Session["CurrentDay"] == null)
					dtCurrentDate = DateTime.Now.Date;
				else
					dtCurrentDate = ((DateTime)Session["CurrentDay"]).Date.AddDays(7);
				ShowWorkOrders();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForWeekly.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}
		}

		private void lbPreviousWeek_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(Session["CurrentDay"] == null)
					dtCurrentDate = DateTime.Now.Date;
				else
					dtCurrentDate = ((DateTime)Session["CurrentDay"]).Date.AddDays(-7);
				ShowWorkOrders();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForWeekly.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}
		}

		private void lbNextMonth_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(Session["CurrentDay"] == null)
					dtCurrentDate = DateTime.Now.Date;
				else
					dtCurrentDate = ((DateTime)Session["CurrentDay"]).Date.AddMonths(1);
				ShowWorkOrders();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForWeekly.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}		
		}

		private void lbPreviousMonth_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(Session["CurrentDay"] == null)
					dtCurrentDate = DateTime.Now.Date;
				else
					dtCurrentDate = ((DateTime)Session["CurrentDay"]).Date.AddMonths(-1);
				ShowWorkOrders();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForWeekly.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}		
		}
	}
}
