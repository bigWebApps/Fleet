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
	public class _edit : BFPPage
	{
		protected System.Web.UI.WebControls.TextBox tbEquipId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvEquipId;
		protected System.Web.UI.WebControls.TextBox tbYear;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvYear;
		protected System.Web.UI.WebControls.RegularExpressionValidator revYear;
		protected System.Web.UI.WebControls.TextBox tbVinSerial;
		protected System.Web.UI.WebControls.TextBox tbFuelCode;
		protected System.Web.UI.WebControls.DropDownList ddlDepts;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvDepartment;
		protected System.Web.UI.WebControls.DropDownList ddlLocs;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvLocation;
		protected System.Web.UI.WebControls.CheckBox chShare;
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected BWA.BFP.Web.Controls.User.MakesModels mmValue;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;

		public clsEquipment equip = null;
		private clsDepartments dep = null;
		private clsLocations loc = null;
		private int EquipId;
		protected System.Web.UI.WebControls.TextBox tbPlateNumber;
		protected System.Web.UI.WebControls.Label lblAssignedTo;
		protected System.Web.UI.WebControls.CheckBox cbReassign;
		private string sURL_return;

		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId=Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				string [,] arrBrdCrumbs = new string [3,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="list.aspx";
				arrBrdCrumbs[1,1]="Equipment List";
				arrBrdCrumbs[2,0]="view.aspx?id="+EquipId+"";
				arrBrdCrumbs[2,1]="Equipment Detail";
				PageTitle = "Equipment-Edit Main";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;

				SaveCancelControl.ParentPageURL= ParentPageURL;

				SourcePageName = "edit.aspx.cs";
				if(!IsPostBack)
				{
					equip = new clsEquipment();
					loc = new clsLocations();
					dep = new clsDepartments();
					equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
					equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					equip.iId = EquipId;
					equip.cAction = "S";

					dep.iOrgId = _functions.GetUserOrgId(Context.User.Identity.Name, false);
					ddlDepts.DataValueField = "Id";
					ddlDepts.DataTextField = "vchName";
					ddlDepts.DataSource = new DataView(dep.GetDepartmentsList());
					ddlDepts.DataBind();
					
					loc.iOrgId = _functions.GetUserOrgId(Context.User.Identity.Name, false);
					ddlLocs.DataValueField = "Id";
					ddlLocs.DataTextField = "vchName";
					ddlLocs.DataSource = new DataView(loc.GetLocationsList());
					ddlLocs.DataBind();
					
					// showing a Equipment's main data from fixed fields
					if(equip.EquipmentDetail() == -1)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					ViewState["EquipType"] = equip.iTypeId.Value;
					if(equip.sAssignedTo.IsNull)
						lblAssignedTo.Text = "";
					else
						lblAssignedTo.Text = equip.sAssignedTo.Value;

					if(equip.sEquipId.IsNull)
						tbEquipId.Text = "";
					else
						tbEquipId.Text = equip.sEquipId.Value;
					if(equip.iYear.IsNull)
						tbYear.Text = "";
					else
						tbYear.Text = equip.iYear.Value.ToString();
					if(equip.sVinSerial.IsNull)
						tbVinSerial.Text = "";
					else
						tbVinSerial.Text = equip.sVinSerial.Value;
					if(equip.sFuelCode.IsNull)
						tbFuelCode.Text = "";
					else
						tbFuelCode.Text = equip.sFuelCode.Value;
					if(equip.sPlateNumber.IsNull)
						tbPlateNumber.Text = "";
					else
						tbPlateNumber.Text = equip.sPlateNumber.Value;
					if(equip.bShare.IsNull)
						chShare.Checked = false;
					else
						chShare.Checked = equip.bShare.Value;

					if(equip.iModelId.IsNull)
					{
						mmValue.IsComponent = false;
						mmValue.TypeId = equip.iTypeId.Value;
						mmValue.DataBind();
					}
					else
					{
						mmValue.IsComponent = false;
						mmValue.TypeId = equip.iTypeId.Value;
						mmValue.ModelId = equip.iModelId.Value;
						mmValue.DataBind();
					}
					if(!equip.iDeptId.IsNull)
						ddlDepts.SelectedValue = equip.iDeptId.Value.ToString();
					if(!equip.iLocId.IsNull)
						ddlLocs.SelectedValue = equip.iLocId.Value.ToString();
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
				if(loc != null)
				{
					loc.Dispose();
				}
				if(dep != null)
				{
					dep.Dispose();
				}
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		}

		#region Save Equipment Main
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					sURL_return = "error.aspx";
					return;
				}
				try
				{
					EquipId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					sURL_return = "error.aspx";
					return;
				}
				equip = new clsEquipment();
				equip.cAction = "U";
				equip.iId = EquipId;
				equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				equip.iModelId = mmValue.ModelId;
				equip.iYear = Convert.ToInt32(tbYear.Text);
				equip.iDeptId = Convert.ToInt32(ddlDepts.SelectedValue);
				equip.iLocId = Convert.ToInt32(ddlLocs.SelectedValue);
				equip.bShare = chShare.Checked;
				equip.sFuelCode = tbFuelCode.Text;
				equip.sEquipId = tbEquipId.Text;
				equip.sVinSerial = tbVinSerial.Text;
				equip.sPlateNumber = tbPlateNumber.Text;
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				if(equip.EquipmentDetail() == -1)
				{
					Session["lastpage"] = "edit.aspx?id=" + EquipId.ToString();
					Session["error"] = _functions.ErrorMessage(107);
					sURL_return = "error.aspx";
				}
				else
				{
					if(cbReassign.Checked)
					{
						sURL_return = "reassign.aspx?id=" + EquipId.ToString();
					}
					else
					{
						sURL_return = "view.aspx?id=" + EquipId.ToString();
					}
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "edit2.aspx?id=" + EquipId.ToString();
				Session["error"] = _functions.ErrorMessage(108);
				sURL_return = "error.aspx";
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "edit2.aspx?id=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				sURL_return = "error.aspx";
			}
			finally
			{
				if(equip != null)
				{
					equip.Dispose();
				}
			}
			Response.Redirect(sURL_return, true);
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
