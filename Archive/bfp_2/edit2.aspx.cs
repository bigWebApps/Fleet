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

namespace BWA.BFP.Web.home.equip
{
	/// <summary>
	/// Summary description for edit2.
	/// </summary>
	public class _edit2 :  BFPPage
	{
		protected System.Web.UI.WebControls.DropDownList ddStatusId;
		protected System.Web.UI.WebControls.DropDownList ddPMScheduleId;
		protected System.Web.UI.WebControls.DropDownList ddInspectionId;
		protected System.Web.UI.WebControls.TextBox tbCurrentUnits;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected BWA.BFP.Web.Controls.User.Header Header;
	
		public clsEquipment equip = null;
		public clsPMSchedService pm = null;
		public clsInspections inspec = null;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvPMShed;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvInspection;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvUnits;
		protected System.Web.UI.WebControls.RegularExpressionValidator revUnits;
		public int EquipId;
		
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
				PageTitle = "Equipment-Edit Alt";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;

				SaveCancelControl.ParentPageURL= ParentPageURL;
				
				if(!IsPostBack)
				{
					equip = new clsEquipment();
					pm = new clsPMSchedService();
					inspec = new clsInspections();
					equip.cAction = "S";
					equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					equip.iId = EquipId;
					pm.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					inspec.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

					ddStatusId.DataTextField = "vchName";
					ddStatusId.DataValueField = "Id";
					ddStatusId.DataSource = new DataView(equip.GetEquipStatusList());
					ddStatusId.DataBind();

					ddPMScheduleId.DataTextField = "vchName";
					ddPMScheduleId.DataValueField = "Id";
					ddPMScheduleId.DataSource =  new DataView(pm.GetPMSchedulesList());
					ddPMScheduleId.DataBind();
					ddPMScheduleId.Items.Insert(0, new ListItem("", "0"));
					
					ddInspectionId.DataTextField = "vchName";
					ddInspectionId.DataValueField = "Id";
					ddInspectionId.DataSource = new DataView(inspec.GetInspectionsList());
					ddInspectionId.DataBind();
					ddInspectionId.Items.Insert(0, new ListItem("", "0"));
					
					// getting equipment's data
					if(equip.EquipmentDetail() != -1)
					{
						ddStatusId.SelectedValue = Convert.ToString(equip.iStatusId);
						ddPMScheduleId.SelectedValue = Convert.ToString(equip.iPMSched);
						ddInspectionId.SelectedValue = Convert.ToString(equip.iInspectId);
						tbCurrentUnits.Text = Convert.ToString(equip.iCurrentUnits);
					}
					else
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log("Application error: \n" + ex.ToString());
				Session["lastpage"] = ParentPageURL;
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
				
				equip = new clsEquipment();
				equip.cAction = "S";
				equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				equip.iId = EquipId;
				if(equip.EquipmentDetail() != -1)
				{
					equip.cAction = "U";
					equip.iStatusId = Convert.ToInt32(ddStatusId.SelectedValue);
					equip.iPMSched = Convert.ToInt32(ddPMScheduleId.SelectedValue) != 0 ? Convert.ToInt32(ddPMScheduleId.SelectedValue) : SqlInt32.Null;
					equip.iInspectId = Convert.ToInt32(ddInspectionId.SelectedValue) != 0 ? Convert.ToInt32(ddInspectionId.SelectedValue) : SqlInt32.Null;
					equip.iCurrentUnits = Convert.ToInt32(tbCurrentUnits.Text);
					switch(equip.EquipmentDetail())
					{
						case -1:
							Session["lastpage"] = "edit2.aspx?id=" + EquipId.ToString();
							Session["error"] = _functions.ErrorMessage(107);
							Response.Redirect("error.aspx", false);
							return;
						case 1:
							Session["lastpage"] = "edit2.aspx?id=" + EquipId.ToString();
							Session["error"] = _functions.ErrorMessage(109);
							Response.Redirect("error.aspx", false);
							return;
						default:
							break;
					}
				}
				else
				{
					Session["lastpage"] = "edit2.aspx?id=" + EquipId.ToString();
					Session["error"] = _functions.ErrorMessage(107);
					Response.Redirect("error.aspx", false);
					return;
				}
				Response.Redirect("view.aspx?id="+EquipId+"", false);
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "edit2.aspx?id=" + EquipId.ToString();
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
			}	  
			catch(Exception ex)
			{
				_functions.Log("Application error: \n" + ex.ToString());
				Session["lastpage"] = "edit2.aspx?id=" + EquipId.ToString();
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
