using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.SqlTypes;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web.admin
{
	public class _admin_pmschedule_detail_edit : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Label lblScheduleName;
		protected System.Web.UI.WebControls.DropDownList ddlPMServices;
		protected System.Web.UI.WebControls.TextBox tbDays;
		protected System.Web.UI.WebControls.RegularExpressionValidator revDays;
		protected System.Web.UI.WebControls.TextBox tbUnits;
		protected System.Web.UI.WebControls.RegularExpressionValidator revUnits;
		protected System.Web.UI.WebControls.DropDownList ddlMeasures;
		protected System.Web.UI.WebControls.Button btnDelete;
	
		private int PMSchedId;
		private int DetailId;
		private string sLastPage, sCurrentPage;
		private clsPMSchedService pmitem = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_pmschedule_detail_edit.aspx.cs";

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
					Session["lastpage"] = "admin_pmschedules.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					PMSchedId = Convert.ToInt32(Request.QueryString["id"]);
					DetailId = Convert.ToInt32(Request.QueryString["detailid"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "admin_pmschedules.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				sLastPage = "admin_pmschedule_detail.aspx?id=" + PMSchedId.ToString();
				sCurrentPage = "admin_pmschedule_detail_edit.aspx?id=" + PMSchedId.ToString() + "&detailid=" + DetailId.ToString();

				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("Preventive Maintenances Schedules Manager", "/admin_pmschedules.aspx");
				Header.AddBreadCrumb("Preventive Maintenance Schedule Detail", "/" + sLastPage);
				this.PageTitle = "PM Schedule Detail Edit";
				Header.LeftBarHtml = "Edit Preventive Maintenance Schedule";

				SaveCancelControl.CancelText= " Back ";
				SaveCancelControl.ParentPageURL = sLastPage;

				if(!IsPostBack)
				{
					pmitem = new clsPMSchedService();
					pmitem.cAction = "S";
					pmitem.iOrgId = OrgId;
					pmitem.iPMSchedId = PMSchedId;
					pmitem.iPMSchedDetailId = DetailId;
					ddlPMServices.DataSource = pmitem.GetPMServicesList();
					ddlPMServices.DataBind();
					ddlMeasures.DataSource = pmitem.GetUnitMeasureList();
					ddlMeasures.DataBind();
					if(pmitem.PMScheduleDetails() == -1)
					{
						Header.ErrorMessage = _functions.ErrorMessage(169);
						return;
					}
					lblScheduleName.Text = pmitem.sPMSchedName.Value;

					if(DetailId != 0)
					{
						if(pmitem.PMSchedServiceDetails() == -1)
						{
							Header.ErrorMessage = _functions.ErrorMessage(174);
							return;
						}
						ddlPMServices.SelectedValue = pmitem.iPMServiceId.Value.ToString();
						ddlMeasures.SelectedValue = pmitem.iUnitMeasureId.Value.ToString();
						tbDays.Text = pmitem.iDays.IsNull?"":pmitem.iDays.Value.ToString();
						tbUnits.Text = pmitem.dmUnits.IsNull?"":Convert.ToDouble(pmitem.dmUnits.Value).ToString();
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
				if(pmitem != null)
					pmitem.Dispose();
			}
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			this.SaveCancelControl.BubbleClick += new EventHandler(this.btSave_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
		}
		
		private void InitializeComponent()
		{    
			this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Save PM Schedule Detail
		/// <summary>
		/// Update the PM Schedule Detail info
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				pmitem = new clsPMSchedService();
				pmitem.cAction = "U";
				pmitem.iOrgId = OrgId;
				pmitem.iPMSchedDetailId = DetailId;
				pmitem.iPMSchedId = PMSchedId;
				pmitem.iPMServiceId = Convert.ToInt32(ddlPMServices.SelectedValue);
				pmitem.iUnitMeasureId = Convert.ToInt32(ddlMeasures.SelectedValue);
				pmitem.iDays = tbDays.Text.Length>0?Convert.ToInt32(tbDays.Text):SqlInt32.Null;
				pmitem.dmUnits = tbUnits.Text.Length>0?Convert.ToDecimal(tbUnits.Text):SqlDecimal.Null;
				if(pmitem.PMSchedServiceDetails() == -1)
				{
					Header.ErrorMessage = _functions.ErrorMessage(174);
					return;
				}
				Response.Redirect(sLastPage, false);
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
				if(pmitem != null)
					pmitem.Dispose();
			}
		}
		#endregion

		private void btnDelete_Click(object sender, System.EventArgs e)
		{
			try
			{
				pmitem = new clsPMSchedService();
				pmitem.cAction = "D";
				pmitem.iOrgId = OrgId;
				pmitem.iPMSchedDetailId = DetailId;
				switch(pmitem.PMSchedServiceDetails())
				{
					case -1:
						Header.ErrorMessage = _functions.ErrorMessage(174);
						return;
					case -2:
						Header.ErrorMessage = _functions.ErrorMessage(175);
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
				if(pmitem != null)
					pmitem.Dispose();
			}
		}

	}
}
