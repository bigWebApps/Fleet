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
	public class _admin_pmschedule_detail : BFPPage
	{
		protected Micajah.Common.DataGridEx dgPMSchedDetails;
		protected System.Web.UI.WebControls.HyperLink hlAddPMService;
		protected System.Web.UI.WebControls.Label lblBack;
		protected System.Web.UI.WebControls.Label lblPMScheduleName;

		private clsPMSchedService pmitems = null;
		private int PMSchedId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_pmschedule_detail.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("Preventive Maintenances Schedules Manager", "/admin_pmschedules.aspx");
				this.PageTitle = "Preventive Maintenance Schedule Detail";
				Header.LeftBarHtml = "View Preventive Maintenance Schedule";

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
			OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
			if(Request.QueryString["id"] == null)
			{
				Session["lastpage"] = "admin_pmschedules.aspx";
				Session["error"] = _functions.ErrorMessage(104);
				Response.Redirect("error.aspx", false);
				return;
			}
			try
			{
				PMSchedId = Convert.ToInt32(Request.QueryString["id"]);
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "admin_pmschedules.aspx";
				Session["error"] = _functions.ErrorMessage(105);
				Response.Redirect("error.aspx", false);
				return;
			}

			try
			{
				if(!IsPostBack)
				{
					pmitems = new clsPMSchedService();
					pmitems.cAction = "S";
					pmitems.iOrgId = OrgId;
					pmitems.iPMSchedId = PMSchedId;
					if(pmitems.PMScheduleDetails() == -1)
					{
						Header.ErrorMessage = _functions.ErrorMessage(169);
						return;
					}
					lblPMScheduleName.Text = pmitems.sPMSchedName.Value;
					hlAddPMService.NavigateUrl = "admin_pmschedule_detail_edit.aspx?id=" + PMSchedId.ToString() + "&detailid=0";
					lblBack.Text = "<input type=button value=\" Back \" onclick=\"document.location='" + this.ParentPageURL + "'\">";
					dgPMSchedDetails.DataSource = pmitems.GetPMServicesListForSchedule();
					dgPMSchedDetails.DataBind();
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
	this.Load += new System.EventHandler(this.Page_Load);

}
	#endregion
}
}
