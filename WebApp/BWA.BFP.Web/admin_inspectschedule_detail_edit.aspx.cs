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
	public class _admin_inspectschedule_detail_edit : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Button btnDelete;
		protected System.Web.UI.WebControls.DropDownList ddlInspections;
		protected System.Web.UI.WebControls.TextBox tbMinDays;
		protected System.Web.UI.WebControls.TextBox tbTagetDays;
		protected System.Web.UI.WebControls.TextBox tbMaxDays;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvMinDays;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvTargetDays;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvMaxDays;
		protected System.Web.UI.WebControls.RegularExpressionValidator revMinDays;
		protected System.Web.UI.WebControls.RegularExpressionValidator revTargetDays;
		protected System.Web.UI.WebControls.RegularExpressionValidator revMaxDays;
		protected System.Web.UI.WebControls.Label lblScheduleName;

		private int InspectSchedId;
		private int DetailId;
		private string sLastPage, sCurrentPage;
		private clsInspections inspect = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_inspectschedule_detail_edit.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
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
					
				if(Request.QueryString["id"] == null || Request.QueryString["detailid"] == null)
				{
					Session["lastpage"] = "admin_inspectschedules.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					InspectSchedId = Convert.ToInt32(Request.QueryString["id"]);
					DetailId = Convert.ToInt32(Request.QueryString["detailid"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "admin_inspectschedules.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				sLastPage = "admin_inspectschedule_detail.aspx?id=" + InspectSchedId.ToString();
				sCurrentPage = "admin_inspectschedule_detail_edit.aspx?id=" + InspectSchedId.ToString() + "&detailid=" + DetailId.ToString();

				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("Inspections Manager", "/admin_inspections.aspx");
				Header.AddBreadCrumb("Inspections Schedules Manager", "/admin_inspectschedules.aspx");
				Header.AddBreadCrumb("Inspection Schedule Detail", "/" + sLastPage);
				this.PageTitle = "Inspection Schedule Detail Edit";
				Header.LeftBarHtml = "Edit Inspection Schedule";

				SaveCancelControl.CancelText= " Back ";
				SaveCancelControl.ParentPageURL = sLastPage;
				if(!IsPostBack)
				{
					inspect = new clsInspections();
					inspect.cAction = "S";
					inspect.iOrgId = OrgId;
					inspect.iInspectSchedDetailId = DetailId;
					inspect.iInspectScheduleId = InspectSchedId;
					ddlInspections.DataSource = new DataView(inspect.GetInspectionsList());
					ddlInspections.DataBind();
					if(inspect.InspectSchedDetailDetails() == -1)
					{
						Session["lastpage"] = sLastPage;
						Session["error"] = _functions.ErrorMessage(159);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblScheduleName.Text = inspect.sInspectScheduleName.Value;
					if(DetailId != 0)
					{
						ddlInspections.SelectedValue = inspect.iId.Value.ToString();
						ddlInspections.Enabled = false;
						tbMinDays.Text = inspect.iMinDays.Value.ToString();
						tbMaxDays.Text = inspect.iMaxDays.Value.ToString();
						tbTagetDays.Text = inspect.iTargetDays.Value.ToString();
					}
					else
						btnDelete.Visible = false;
					
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = sLastPage;
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
			this.SaveCancelControl.BubbleClick += new EventHandler(this.btSave_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Save Inspection Schedule Detail
		/// <summary>
		/// Update the Inspect Schedule Detail info
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			int MinDays, TargetDays, MaxDays;
			try
			{
				MinDays = Convert.ToInt32(tbMinDays.Text);
				MaxDays	= Convert.ToInt32(tbMaxDays.Text);
				TargetDays = Convert.ToInt32(tbTagetDays.Text);
				if(MinDays >= TargetDays)
				{
					Header.ErrorMessage = _functions.ErrorMessage(162);
				}
				else if(TargetDays >= MaxDays)
				{
					Header.ErrorMessage = _functions.ErrorMessage(163);
				}
				else if(MinDays >= MaxDays)
				{
					Header.ErrorMessage = _functions.ErrorMessage(164);
				}				
				else
				{
					inspect = new clsInspections();
					inspect.cAction = "U";
					inspect.iOrgId = OrgId;
					inspect.iInspectSchedDetailId = DetailId;
					inspect.iInspectScheduleId = InspectSchedId;
					inspect.iId = Convert.ToInt32(ddlInspections.SelectedValue);
					inspect.iTargetDays = TargetDays;
					inspect.iMinDays = MinDays;
					inspect.iMaxDays = MaxDays;
					if(inspect.InspectSchedDetailDetails() == -1)
					{
						Session["lastpage"] = sLastPage;
						Session["error"] = _functions.ErrorMessage(159);
						Response.Redirect("error.aspx", false);
						return;
					}
					Response.Redirect(sLastPage, false);
				}
			}
			catch(FormatException fex)
			{
				Header.ErrorMessage = _functions.ErrorMessage(108);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = sCurrentPage;
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
		#endregion

		private void btnDelete_Click(object sender, System.EventArgs e)
		{
			try
			{
				inspect = new clsInspections();
				inspect.cAction = "D";
				inspect.iOrgId = OrgId;
				inspect.iInspectSchedDetailId = DetailId;
				inspect.iInspectScheduleId = InspectSchedId;
				int l_iResult = inspect.InspectSchedDetailDetails();
				if(l_iResult == -1)
				{
					Session["lastpage"] = sLastPage;
					Session["error"] = _functions.ErrorMessage(159);
					Response.Redirect("error.aspx", false);
					return;
				}
				if(l_iResult == -1)
				{
					Header.ErrorMessage = _functions.ErrorMessage(160);
					return;
				}
				Response.Redirect(sLastPage, false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = sCurrentPage;
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
	}
}
