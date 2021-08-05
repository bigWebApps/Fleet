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
	public class _wo_showOrdersForMonthly : BFPPage
	{
		protected System.Web.UI.WebControls.LinkButton lbPreviousYear;
		protected System.Web.UI.WebControls.LinkButton lbPreviousMonth;
		protected System.Web.UI.WebControls.LinkButton lbNextMonth;
		protected System.Web.UI.WebControls.LinkButton lbNextYear;
		protected Acme.TemplatedCalendar t_calOrders;
		protected System.Web.UI.WebControls.Label lblCurrentDate;
		
		private clsWorkOrders order = null;
		private DateTime dtCurrentDate;
		protected System.Web.UI.WebControls.HyperLink hlDay;
		private DataView dwWorkOrders = null;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_showOrdersForMonthly.aspx.cs";
				
				this.PageTitle = "Monthly Work Orders View";
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
				Session["PathToViewOrder"] = "Monthly";
				if(!IsPostBack)
				{
					if(Session["CurrentDay"] == null)
						dtCurrentDate = DateTime.Now.Date;
					else
						dtCurrentDate = ((DateTime)Session["CurrentDay"]).Date;
					t_calOrders.TodaysDate = dtCurrentDate;
					t_calOrders.DataBind();
					Session["CurrentDay"] = dtCurrentDate;
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
		
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.lbPreviousYear.Click += new System.EventHandler(this.lbPreviousYear_Click);
			this.lbPreviousMonth.Click += new System.EventHandler(this.lbPreviousMonth_Click);
			this.lbNextMonth.Click += new System.EventHandler(this.lbNextMonth_Click);
			this.lbNextYear.Click += new System.EventHandler(this.lbNextYear_Click);
			this.t_calOrders.DayCommand += new Acme.CalendarDayCommandEventHandler(this.t_calOrders_DayCommand);
			this.t_calOrders.PreRender += new System.EventHandler(this.t_calOrders_PreRender);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

	
		private void t_calOrders_DayCommand(object source, Acme.CalendarDayCommandEventArgs e)
		{

			try
			{
				if(e.CommandName == "Reserve")
				{
					Session["CurrentDay"] = Convert.ToDateTime(e.CommandArgument);
					Response.Redirect("wo_showOrdersForDaily.aspx", false);
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForMonthly.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}
		}

		private void t_calOrders_PreRender(object sender, System.EventArgs e)
		{
			try
			{
				// Procedure is showing all work orders for current date
				lblCurrentDate.Text = t_calOrders.TodaysDate.ToString("y");
				order = new clsWorkOrders();
				order.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				order.daMinDate = ((Acme.CalendarDayCell)t_calOrders.Controls[0].Controls[1].Controls[0]).Date.Date;
				order.daMaxDate = ((Acme.CalendarDayCell)t_calOrders.Controls[0].Controls[t_calOrders.Controls[0].Controls.Count-1].Controls[6]).Date.Date.AddDays(1);
				dwWorkOrders = new DataView(order.GetWOListForDate());

				for(int i = 1; i < t_calOrders.Controls[0].Controls.Count; i++)
				{
					for(int j = 0; j < 7; j++)
					{
						dwWorkOrders.RowFilter = "[Date] = '" + ((Acme.CalendarDayCell)t_calOrders.Controls[0].Controls[i].Controls[j]).Date.ToString() + "'";
						((Repeater)t_calOrders.Controls[0].Controls[i].Controls[j].FindControl("repOrders")).DataSource = dwWorkOrders;
						((Repeater)t_calOrders.Controls[0].Controls[i].Controls[j].FindControl("repOrders")).DataBind();
					}
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
				if(order != null)
					order.Dispose();
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
				Session["CurrentDay"] = dtCurrentDate;
				Response.Redirect("wo_showOrdersForMonthly.aspx", false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForMonthly.aspx";
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
				Session["CurrentDay"] = dtCurrentDate;
				Response.Redirect("wo_showOrdersForMonthly.aspx", false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForMonthly.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}				
		}

		private void lbNextYear_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(Session["CurrentDay"] == null)
					dtCurrentDate = DateTime.Now.Date;
				else
					dtCurrentDate = ((DateTime)Session["CurrentDay"]).Date.AddYears(1);
				Session["CurrentDay"] = dtCurrentDate;
				Response.Redirect("wo_showOrdersForMonthly.aspx", false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForMonthly.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}				
		}

		private void lbPreviousYear_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(Session["CurrentDay"] == null)
					dtCurrentDate = DateTime.Now.Date;
				else
					dtCurrentDate = ((DateTime)Session["CurrentDay"]).Date.AddYears(-1);
				Session["CurrentDay"] = dtCurrentDate;
				Response.Redirect("wo_showOrdersForMonthly.aspx", false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForMonthly.aspx";
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
