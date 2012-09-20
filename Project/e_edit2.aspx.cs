using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.SqlTypes;
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
	public class _e_edit2 :  BFPPage
	{
		protected System.Web.UI.WebControls.DropDownList ddPMScheduleId;
		protected System.Web.UI.WebControls.DropDownList ddInspectionId;
		protected System.Web.UI.WebControls.TextBox tbCurrentUnits;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvPMShed;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvInspection;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvUnits;
		protected System.Web.UI.WebControls.RegularExpressionValidator revUnits;
	
		public clsEquipment equip = null;
		public clsPMSchedService pm = null;
		public clsInspections inspec = null;
		public int EquipId;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "e_edit2.aspx.cs";
				
				this.PageTitle  = "Edit Alternative Info";
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
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "e_list.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
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
				Header.LeftBarHtml = "Edit Alternative Information of Equipment";

				SaveCancelControl.ParentPageURL = this.ParentPageURL;

				if(!IsPostBack)
				{
					
					equip = new clsEquipment();
					pm = new clsPMSchedService();
					inspec = new clsInspections();
					equip.cAction = "S";
					equip.iOrgId = OrgId;
					equip.iId = EquipId;
					pm.iOrgId = OrgId;
					inspec.iOrgId = OrgId;

					ddPMScheduleId.DataTextField = "vchName";
					ddPMScheduleId.DataValueField = "Id";
					ddPMScheduleId.DataSource =  new DataView(pm.GetPMSchedulesList());
					ddPMScheduleId.DataBind();
					
					ddInspectionId.DataTextField = "vchName";
					ddInspectionId.DataValueField = "Id";
					ddInspectionId.DataSource = new DataView(inspec.GetInspectSchedulesList());
					ddInspectionId.DataBind();
					
					// getting equipment's data
					if(equip.EquipmentDetail_Alt() != -1)
					{
						if(equip.iPMSched.IsNull)
							ddPMScheduleId.SelectedValue = "";
						else
							ddPMScheduleId.SelectedValue = equip.iPMSched.Value.ToString();
						if(equip.iInspectScheduleId.IsNull)
							ddInspectionId.SelectedValue = "";
						else
							ddInspectionId.SelectedValue = equip.iInspectScheduleId.Value.ToString();
						if(equip.dmCurrentUnits.IsNull)
							tbCurrentUnits.Text = "";
						else
							tbCurrentUnits.Text = Convert.ToDouble(equip.dmCurrentUnits.Value).ToString();
					}
					else
					{
						Session["lastpage"] = this.ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
					}
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
				if(inspec != null)
				{
					inspec.Dispose();
				}
				if(pm != null)
				{
					pm.Dispose();
				}
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		}

		#region Save Equipment Alt
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
		
				equip = new clsEquipment();
				equip.cAction = "U";
				equip.iOrgId = OrgId;
				equip.iId = EquipId;
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				equip.iPMSched = Convert.ToInt32(ddPMScheduleId.SelectedValue);
				equip.iInspectScheduleId = Convert.ToInt32(ddInspectionId.SelectedValue);
				equip.dmCurrentUnits = Convert.ToDecimal(tbCurrentUnits.Text);
				if(equip.EquipmentDetail_Alt() == -1)
				{
					Session["lastpage"] = "e_edit2.aspx?id=" + EquipId.ToString();
					Session["error"] = _functions.ErrorMessage(107);
					Response.Redirect("error.aspx", false);
					return;
				}
				else
				{
					Response.Redirect("e_view.aspx?id="+EquipId.ToString(), false);
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "e_edit2.aspx?id=" + EquipId.ToString();
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_edit2.aspx?id=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		}
		#endregion

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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
