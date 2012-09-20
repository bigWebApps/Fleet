using System;
using System.Web;
using System.Data;
using System.Web.Security;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web
{
	public class _main : BFPPage
	{
		protected System.Web.UI.WebControls.Repeater repOrders;
		protected System.Web.UI.WebControls.HyperLink hlCreateWO;
		protected System.Web.UI.WebControls.HyperLink hlCreateRR;
		protected System.Web.UI.WebControls.HyperLink hlCreateWOInspection;
		protected System.Web.UI.WebControls.HyperLink hlToday;
		protected System.Web.UI.WebControls.HyperLink hlWODaily;
		protected System.Web.UI.WebControls.HyperLink hlWOWeekly;
		protected System.Web.UI.WebControls.HyperLink hlWOMonthly;
		protected System.Web.UI.WebControls.HyperLink hlWOCompleted;
		protected System.Web.UI.WebControls.HyperLink hlWOUnassigned;
		protected System.Web.UI.WebControls.HyperLink hlViewList;
		protected System.Web.UI.WebControls.HyperLink hlAddEquipment;
		protected System.Web.UI.WebControls.HyperLink hlManageRI;
		protected System.Web.UI.WebControls.HyperLink hlChangeTempOper;
		protected System.Web.UI.WebControls.HyperLink hlTempOperatorReport;
		protected System.Web.UI.WebControls.HyperLink hlEquipWorkOrderReport;
		protected System.Web.UI.WebControls.HyperLink hlTrainingOpen;
		protected System.Web.UI.WebControls.HyperLink hlDeactivate;
		protected System.Web.UI.WebControls.HyperLink hlCreatePastWO;
	
		private clsWorkOrders order = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "main.aspx.cs";
				Response.Cookies["bfp_mode"].Value = "TechnicianMode";
				Response.Cookies["bfp_mode"].Path = "/";
				Response.Cookies["bfp_mode"].Expires = DateTime.Now.AddYears(1);
				
				Header.MainMenuSelectedItem = "&nbsp;Home&nbsp;";
				this.PageTitle="Home";
				Header.AddMetaTag("<META HTTP-EQUIV=\"REFRESH\" CONTENT=\"30\">");
				Header.LeftBarHtml = "Active Work Orders";
				base.OnLoad(e);
				
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "selectMode.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				Session["PathToViewOrder"] = null;

				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.daCurrentDate = DateTime.Now;
					repOrders.DataSource = new DataView(order.GetActivityWorkOrder());
					repOrders.DataBind();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "selectMode.aspx";
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
			base.OnInit(e);
			InitializeComponent();
			base.CheckLinks(this.Page);
			
		}
		
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
