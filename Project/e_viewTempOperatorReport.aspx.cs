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

namespace BWA.BFP.Web.equip
{
	public class _e_viewTempOperatorReport : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgAssignments;
	
		private DateTime dtCurrentDate;
		private clsEquipment equip = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "e_viewTempOperatorReport.aspx.cs";
				
				this.PageTitle  = "Temporary Operator Assignment Report";
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.LeftBarHtml = "View Temporary Operator Assignments of Equipment";
				//Header.AddJavaScriptFile("/e_viewTempOperatorReport.js");
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
					dtCurrentDate = DateTime.Now;
//					adtEndDate.Date = dtCurrentDate;
//					adtStartDate.Date = dtCurrentDate.AddDays(-1);
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.daMinDate = dtCurrentDate; //adtStartDate.Date;
					equip.daMaxDate = dtCurrentDate; //adtEndDate.Date.AddHours(23).AddMinutes(59);
					dgAssignments.DataSource = new DataView(equip.GetTempOperatorsAssignmentList());
					dgAssignments.DataBind();
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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
//
//		private void btnReport_Click(object sender, System.EventArgs e)
//		{
//			try
//			{
//				equip = new clsEquipment();
//				equip.iOrgId = OrgId;
//				equip.daMinDate = adtStartDate.Date;
//				equip.daMaxDate = adtEndDate.Date.AddHours(23).AddMinutes(59);
//				dgAssignments.DataSource = new DataView(equip.GetTempOperatorsAssignmentList());
//				dgAssignments.DataBind();
//			}
//			catch(Exception ex)
//			{
//				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
//				Session["lastpage"] = "e_viewTempOperatorReport.aspx";
//				Session["error"] = ex.Message;
//				Session["error_report"] = ex.ToString();
//				Response.Redirect("error.aspx", false);
//			}
//			finally
//			{
//				if(equip != null)
//					equip.Dispose();
//			}
//		}
	}
}
