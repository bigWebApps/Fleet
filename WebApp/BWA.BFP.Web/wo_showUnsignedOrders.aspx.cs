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
	public class _wo_showUnsignedOrders : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgUnsignedWorkOrders;
		
		private clsWorkOrders order = null;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_showUnsignedOrders.aspx.cs";

				this.PageTitle = "The Incomplete Work Orders";
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
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					dgUnsignedWorkOrders.DataSource = new DataView(order.GetWOUnsignedList());
					dgUnsignedWorkOrders.DataBind();
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
