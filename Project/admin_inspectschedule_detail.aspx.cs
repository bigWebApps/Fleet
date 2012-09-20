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
	public class _admin_inspectschedule_detail : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblBack;
		protected Micajah.DataGrid.DataGrid_A dgInspectSchedDetails;
		protected System.Web.UI.WebControls.Label lblScheduleName;
		protected System.Web.UI.WebControls.HyperLink hlAddInspection;
		
		private clsInspections inspect = null;
		private int InspectSchedId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_inspectschedule_detail.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("Inspections Manager", "/admin_inspections.aspx");
				Header.AddBreadCrumb("Inspections Schedules Manager", "/admin_inspectschedules.aspx");
				this.PageTitle = "Inspection Schedule Detail";
				Header.LeftBarHtml = "View Inspection Schedule";

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

				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "admin_inspectschedules.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					InspectSchedId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "admin_inspectschedules.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				lblBack.Text = "<input type=button value=\" Back \" onclick=\"document.location='admin_inspectschedules.aspx'\">";
				if(!IsPostBack)
				{
					inspect = new clsInspections();
					inspect.iOrgId = OrgId;
					inspect.iInspectScheduleId = InspectSchedId;
					dgInspectSchedDetails.DataSource = new DataView(inspect.GetInspectSchedDetailsList());
					dgInspectSchedDetails.DataBind();
					lblScheduleName.Text = inspect.sInspectScheduleName.Value;
					hlAddInspection.NavigateUrl = "admin_inspectschedule_detail_edit.aspx?id=" + InspectSchedId.ToString() + "&detailid=0";
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = this.ParentPageURL;
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
