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
	public class _e_addEquip : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.MakesModels mmValue;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.TextBox tbEquipId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvEquipId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvTypeId;
		protected System.Web.UI.WebControls.TextBox tbYear;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvYear;
		protected System.Web.UI.WebControls.TextBox tbVinSerial;
		protected System.Web.UI.WebControls.TextBox tbFuelCode;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvDepartment;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvLocation;
		protected System.Web.UI.WebControls.RegularExpressionValidator revYear;
		protected System.Web.UI.WebControls.DropDownList ddlTypes;
		protected System.Web.UI.WebControls.DropDownList ddlDepts;
		protected System.Web.UI.WebControls.DropDownList ddlLocs;
		protected System.Web.UI.WebControls.TextBox tbPlateNumber;
		protected System.Web.UI.WebControls.CheckBox chSpare;
		protected System.Web.UI.WebControls.DropDownList ddPMScheduleId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvPMShed;
		protected System.Web.UI.WebControls.DropDownList ddInspectionId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvInspection;
		protected System.Web.UI.WebControls.TextBox tbCurrentUnits;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvUnits;
		protected System.Web.UI.WebControls.RegularExpressionValidator revUnits;
		
		private int EquipId;
		private string sURL_return;
		private clsEquipment equip = null;
		private clsDepartments dep = null;
		public clsPMSchedService pm = null;
		public clsInspections inspec = null;
		private clsLocations loc = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "e_addEquip.aspx.cs";
				
				this.PageTitle  = "Add Equipment";
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddBreadCrumb("Equipment List", "/e_list.aspx");
				Header.LeftBarHtml = "Add Main Information of Equipment";
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

				SaveCancelControl.ParentPageURL = this.ParentPageURL;
				if(!IsPostBack)
				{
					loc = new clsLocations();
					dep = new clsDepartments();
					equip = new clsEquipment();
					pm = new clsPMSchedService();
					inspec = new clsInspections();
					equip.iOrgId = OrgId;
					ddlTypes.DataValueField = "Id";
					ddlTypes.DataTextField = "vchName";
					ddlTypes.DataSource = new DataView(equip.GetEquipTypesList());
					ddlTypes.DataBind();
					dep.iOrgId = OrgId;
					ddlDepts.DataValueField = "Id";
					ddlDepts.DataTextField = "vchName";
					ddlDepts.DataSource = new DataView(dep.GetDepartmentsList());
					ddlDepts.DataBind();
					loc.iOrgId = OrgId;
					ddlLocs.DataValueField = "Id";
					ddlLocs.DataTextField = "vchName";
					ddlLocs.DataSource = new DataView(loc.GetLocationsList());
					ddlLocs.DataBind();
					mmValue.IsComponent = false;
					mmValue.TypeId = Convert.ToInt32(ddlTypes.SelectedValue);
					mmValue.DataBind();

					pm.iOrgId = OrgId;
					inspec.iOrgId = OrgId;

					ddPMScheduleId.DataTextField = "vchName";
					ddPMScheduleId.DataValueField = "Id";
					ddPMScheduleId.DataSource =  new DataView(pm.GetPMSchedulesList());
					ddPMScheduleId.DataBind();
					ddPMScheduleId.Items.Insert(0, new ListItem("", ""));
					
					ddInspectionId.DataTextField = "vchName";
					ddInspectionId.DataValueField = "Id";
					ddInspectionId.DataSource = new DataView(inspec.GetInspectSchedulesList());
					ddInspectionId.DataBind();
					ddInspectionId.Items.Insert(0, new ListItem("", ""));

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
				if(pm != null)
					pm.Dispose();
				if(inspec != null)
					inspec.Dispose();
				if(loc != null)
					loc.Dispose();
				if(dep != null)
					dep.Dispose();
				if(equip != null)
					equip.Dispose();
			}
		}

		
		#region Save Equipment
		/// <summary>
		/// Adding a new equipment to database
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				equip = new clsEquipment();

				equip.cAction="U";
				equip.iOrgId = OrgId;
				equip.iId = 0; // adding a Equipment
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				equip.iTypeId = Convert.ToInt32(ddlTypes.SelectedValue);
				equip.iModelId = mmValue.ModelId;
				equip.iYear = Convert.ToInt32(tbYear.Text);
				equip.iDeptId = Convert.ToInt32(ddlDepts.SelectedValue);
				equip.iLocId = Convert.ToInt32(ddlLocs.SelectedValue);
				equip.bSpare = chSpare.Checked;
				equip.sFuelCode = tbFuelCode.Text;
				equip.sEquipId = tbEquipId.Text;
				equip.sVinSerial = tbVinSerial.Text;
				equip.sPlateNumber = tbPlateNumber.Text;
				// saving data to database
				EquipId = equip.EquipmentDetail();
				if(EquipId > 0)
				{
					sURL_return = "e_reassign.aspx?id=" + EquipId.ToString();
				}
				else
				{
					Session["lastpage"] = "e_addEquip.aspx";
					Session["error"] = _functions.ErrorMessage(103);
					sURL_return = "error.aspx";
				}
				equip.iId = EquipId;
				equip.iPMSched = Convert.ToInt32(ddPMScheduleId.SelectedValue);
				equip.iInspectScheduleId = Convert.ToInt32(ddInspectionId.SelectedValue);
				equip.dmCurrentUnits = Convert.ToDecimal(tbCurrentUnits.Text);
				if(equip.EquipmentDetail_Alt() == -1)
				{
					Session["lastpage"] = "e_addEquip.aspx";
					Session["error"] = _functions.ErrorMessage(107);
					sURL_return = "error.aspx";
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "e_addEquip.aspx";
				Session["error"] = _functions.ErrorMessage(108);
				sURL_return = "error.aspx";
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_addEquip.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				sURL_return = "error.aspx";
			}
			finally
			{
				if(equip!=null)
					equip.Dispose();

				Response.Redirect(sURL_return, true);
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
			this.ddlTypes.SelectedIndexChanged += new System.EventHandler(this.ddlTypes_SelectedIndexChanged);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		/// <summary>
		/// selecting the equipment type
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void ddlTypes_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			try
			{
				mmValue.IsComponent = false;
				mmValue.TypeId = Convert.ToInt32(ddlTypes.SelectedValue);
				mmValue.DataBind();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_addEquip.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

		
	}
}
