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
	public class _e_viewEquipAssignmentReport : BFPPage
	{
		protected System.Web.UI.WebControls.Button btnReport;
		protected ActiveUp.WebControls.ActiveDateTime adtStartDate;
		protected ActiveUp.WebControls.ActiveDateTime adtEndDate;
		protected Micajah.DataGrid.DataGrid_A dgAssignments;
		protected System.Web.UI.HtmlControls.HtmlSelect ddlDateRange;
		protected System.Web.UI.HtmlControls.HtmlAnchor A1;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.HtmlControls.HtmlAnchor A2;
	
		private DateTime dtCurrentDate;
		private clsEquipment equip = null;
		private int EquipId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "e_viewEquipAssignmentReport.aspx.cs";
				
				this.PageTitle  = "Equipment Assignment Report";
				Header.AddJavaScriptFile("/e_viewTempOperatorReport.js");
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
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "e_list.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "e_list.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}	
				
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddBreadCrumb("Equipment List", "/e_list.aspx");
				Header.AddBreadCrumb("Equipment Detail", "/e_view.aspx?id="+EquipId.ToString());
				Header.LeftBarHtml = "View Operators Assignments of Equipment";

				if(!IsPostBack)
				{
					dtCurrentDate = DateTime.Now;
					adtEndDate.Date = dtCurrentDate;
					adtStartDate.Date = dtCurrentDate.AddDays(-365);
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iId = EquipId;
					if(equip.GetEquipInfo() == -1)
					{
						Session["lastpage"] = "e_view.aspx?id=" + EquipId.ToString();
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
					}
					lblEquipId.Text = equip.sEquipId.Value;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_view.aspx?id=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
					equip.Dispose();
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
			this.btnReport.Click += new System.EventHandler(this.btnReport_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnReport_Click(object sender, System.EventArgs e)
		{
			try
			{
				equip = new clsEquipment();
				equip.iOrgId = OrgId;
				equip.iId = EquipId;
				equip.daMinDate = adtStartDate.Date;
				equip.daMaxDate = adtEndDate.Date.AddHours(23).AddMinutes(59);
				dgAssignments.DataSource = new DataView(equip.GetEquipmentAssignmentList());
				dgAssignments.DataBind();
				lblEquipId.Text = equip.sEquipId.Value;
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_viewEquipAssignmentReport.aspx?id=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
					equip.Dispose();
			}
		}
	}
}
