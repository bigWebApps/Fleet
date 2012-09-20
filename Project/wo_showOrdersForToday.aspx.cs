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
	public class _wo_showOrdersForToday : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgWorkOrders_Today;
		protected Micajah.DataGrid.DataGrid_A dgWorkOrders_Tomorrow;
		protected Micajah.DataGrid.DataGrid_A dgWorkOrders_Future;
		protected Micajah.DataGrid.DataGrid_A dgWorkOrders_Past;

		private clsWorkOrders order = null;
		private DataSet dsWorkOrders = null;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_showOrdersForToday.aspx.cs";
				
				this.PageTitle = "Work Orders Overview";
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
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				Session["PathToViewOrder"] = "Today";
				
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.daCurrentDate = DateTime.Now;
					dsWorkOrders = order.GetWOListForToday();

					dgWorkOrders_Past.DataSource = new DataView(dsWorkOrders.Tables[0]);
					dgWorkOrders_Past.DataBind();

					dgWorkOrders_Today.DataSource = new DataView(dsWorkOrders.Tables[1]);
					dgWorkOrders_Today.DataBind();

					dgWorkOrders_Tomorrow.DataSource = new DataView(dsWorkOrders.Tables[2]);
					dgWorkOrders_Tomorrow.DataBind();

					dgWorkOrders_Future.DataSource = new DataView(dsWorkOrders.Tables[3]);
					dgWorkOrders_Future.DataBind();
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

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
