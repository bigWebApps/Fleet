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
	public class _addEquip : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Header Header;
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
		protected System.Web.UI.WebControls.CheckBox chShare;
		protected System.Web.UI.WebControls.RegularExpressionValidator revYear;
		protected System.Web.UI.WebControls.DropDownList ddlTypes;
		protected System.Web.UI.WebControls.DropDownList ddlDepts;
		protected System.Web.UI.WebControls.DropDownList ddlLocs;
		
		private int EquipId;
		private clsEquipment equip = null;
		private clsDepartments dep = null;
		private clsLocations loc = null;
		protected System.Web.UI.WebControls.TextBox tbPlateNumber;
		private string sURL_return;
				
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				string [,] arrBrdCrumbs = new string [2,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="list.aspx";
				arrBrdCrumbs[1,1]="Equipment List";
				PageTitle = "Add Equipment";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;
				SaveCancelControl.ParentPageURL=ParentPageURL;
				SourcePageName = "addEquip.aspx.cs";
				if(!IsPostBack)
				{
					loc = new clsLocations();
					dep = new clsDepartments();
					equip = new clsEquipment();
					equip.iOrgId = _functions.GetUserOrgId(Context.User.Identity.Name, false);
					ddlTypes.DataValueField = "Id";
					ddlTypes.DataTextField = "vchName";
					ddlTypes.DataSource = new DataView(equip.GetEquipTypesList());
					ddlTypes.DataBind();
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
					mmValue.IsComponent = false;
					mmValue.TypeId = Convert.ToInt32(ddlTypes.SelectedValue);
					mmValue.DataBind();
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

		
		#region Save Equipment
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				equip = new clsEquipment();

				equip.cAction="U";
				equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				equip.iId = 0; // adding a Equipment
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				equip.iTypeId = Convert.ToInt32(ddlTypes.SelectedValue);
				equip.iModelId = mmValue.ModelId;
				equip.iYear = Convert.ToInt32(tbYear.Text);
				equip.iDeptId = Convert.ToInt32(ddlDepts.SelectedValue);
				equip.iLocId = Convert.ToInt32(ddlLocs.SelectedValue);
				equip.bShare = chShare.Checked;
				equip.sFuelCode = tbFuelCode.Text;
				equip.sEquipId = tbEquipId.Text;
				equip.sVinSerial = tbVinSerial.Text;
				equip.sPlateNumber = tbPlateNumber.Text;
				// saving data to database
				EquipId = equip.EquipmentDetail();
				if(EquipId > 0)
				{
					sURL_return = "reassign.aspx?id=" + EquipId.ToString();
				}
				else
				{
					Session["lastpage"] = "addEquip.aspx";
					Session["error"] = _functions.ErrorMessage(103);
					sURL_return = "error.aspx";
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "addEquip.aspx";
				Session["error"] = _functions.ErrorMessage(108);
				sURL_return = "error.aspx";
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "addEquip.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				sURL_return = "error.aspx";
			}
			finally
			{
				if(equip!=null)
				{
					equip.Dispose();
				}
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
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{   
			this.ddlTypes.SelectedIndexChanged += new System.EventHandler(this.ddlTypes_SelectedIndexChanged);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

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
				Session["lastpage"] = "addEquip.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

		
	}
}
