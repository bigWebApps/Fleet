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
	public class _wo_showOrdersForDaily : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgWorkOrders;
		protected System.Web.UI.WebControls.Label lblCurrentDate;
		protected System.Web.UI.WebControls.LinkButton lbNextDay;
		protected System.Web.UI.WebControls.LinkButton lbNextMonth;
		protected System.Web.UI.WebControls.LinkButton lbPreviousMonth;
		protected System.Web.UI.WebControls.LinkButton lbPreviousDay;
		protected System.Web.UI.WebControls.Button btnBack;
			
		private clsWorkOrders order = null;
		private DateTime dtCurrentDate;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_showOrdersForDaily.aspx.cs";

				this.PageTitle = "Daily Work Orders View";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				if(Session["PathToViewOrder"] != null && (Session["PathToViewOrder"] == "Monthly" || Session["PathToViewOrder"] == "Monthly-Daily"))
				{
					Header.AddBreadCrumb("Home", "/main.aspx");
					Header.AddBreadCrumb("Monthly Work Orders View", "/wo_showOrdersForMonthly.aspx");
					Session["PathToViewOrder"] = "Monthly-Daily";
				}
				else
				{
					Header.AddBreadCrumb("Home", "/main.aspx");
					Session["PathToViewOrder"] = "Daily";
					btnBack.Visible = false;
				}

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
				Session["lastpage"] = "wo_showOrdersForMonthly.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}
		}

		/// <summary>
		/// Procedure is showing all work orders for current date
		/// </summary>
		private void ShowWorkOrders()
		{
			try
			{
				lblCurrentDate.Text = dtCurrentDate.ToLongDateString();
				order = new clsWorkOrders();
				order.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				order.daMaxDate = dtCurrentDate.AddDays(1);
				order.daMinDate = dtCurrentDate;
				dgWorkOrders.DataSource = new DataView(order.GetWOListForDate());
				dgWorkOrders.DataBind();
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
			this.lbPreviousDay.Click += new System.EventHandler(this.lbPreviousDay_Click);
			this.lbNextDay.Click += new System.EventHandler(this.lbNextDay_Click);
			this.lbNextMonth.Click += new System.EventHandler(this.lbNextMonth_Click);
			this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void lbNextDay_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(Session["CurrentDay"] == null)
					dtCurrentDate = DateTime.Now.Date;
				else
					dtCurrentDate = ((DateTime)Session["CurrentDay"]).Date.AddDays(1);
				ShowWorkOrders();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForDaily.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}	
		}

		private void lbPreviousDay_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(Session["CurrentDay"] == null)
					dtCurrentDate = DateTime.Now.Date;
				else
					dtCurrentDate = ((DateTime)Session["CurrentDay"]).Date.AddDays(-1);
				ShowWorkOrders();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showOrdersForDaily.aspx";
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
				Session["lastpage"] = "wo_showOrdersForDaily.aspx";
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
				Session["lastpage"] = "wo_showOrdersForDaily.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}			
		}

		private void btnBack_Click(object sender, System.EventArgs e)
		{
			Response.Redirect("wo_showOrdersForMonthly.aspx", false);
		}
	}
}
