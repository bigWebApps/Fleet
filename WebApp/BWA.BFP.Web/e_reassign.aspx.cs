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
	public class _e_reassign : BFPPage
	{

		protected System.Web.UI.WebControls.Label lbAssignFrom;
		protected System.Web.UI.WebControls.DropDownList ddAssignTo;
		protected System.Web.UI.WebControls.TextBox tbNote;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvNote;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvAssign;
		protected System.Web.UI.WebControls.Label lblEquipment;
		protected System.Web.UI.WebControls.Label lblType;
		protected System.Web.UI.WebControls.Label lblMakeModel;
		protected System.Web.UI.WebControls.Label lblYear;
		protected System.Web.UI.WebControls.Label lblSerial;
		protected System.Web.UI.WebControls.Label lblFuelCode;
		protected System.Web.UI.WebControls.Label lblDepartment;
		protected System.Web.UI.WebControls.Label lblLocation;
		protected System.Web.UI.WebControls.Label lblSpare;
		
		public clsEquipment equip = null;
		public clsMakesModels mm = null;
		public clsDepartments dep = null;
		public clsLocations loc = null;
		public clsCustomFieldsDef cfd = null;

		public int EquipId;
		public DataTable dtUsers;
		public DataTable dtCustomFields = null;
		public DataTable dtCustomFieldsFromDB = null;
		public ArrayList arrCFD = null;
						
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "e_reassign.aspx.cs";
				
				this.PageTitle  = "Reassign Equipment";
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
				Header.LeftBarHtml = "Reassign Equipment Operator";

				SaveCancelControl.ParentPageURL = this.ParentPageURL;
				if(!IsPostBack)
				{
					equip = new clsEquipment();
					
					equip.iOrgId = OrgId;
					equip.iId = EquipId;
					equip.cAction = "S";
					
					dtUsers = equip.GetEquipAssignTo();
					if(dtUsers.Rows.Count < 1)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(111);
						Response.Redirect("error.aspx", false);
						return;
					}
					ddAssignTo.DataTextField = "vchName";
					ddAssignTo.DataValueField = "id";
					ddAssignTo.DataSource = new DataView(dtUsers);
					ddAssignTo.DataBind();
					ddAssignTo.Items.Insert(0, new ListItem("Nobody", "0"));

					// getting equipment's data
					if(equip.EquipmentDetail() != 0)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblEquipment.Text = equip.sEquipId.Value;
					lblType.Text = equip.sType.Value;
					lblMakeModel.Text = equip.sMakeModelName.Value;
					lblYear.Text = equip.iYear.Value.ToString();
					lblSerial.Text = equip.sVinSerial.Value;
					lblFuelCode.Text = equip.sFuelCode.Value;
					lblDepartment.Text = equip.sDeptName.Value;
					lblLocation.Text = equip.sLocName.Value;
					lblSpare.Text = equip.bSpare.Value?"Yes":"No";
					lbAssignFrom.Text = equip.sEquipOperator.Value;
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
				if(mm != null)
				{
					mm.Dispose();
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
				equip.iOrgId = OrgId;
				equip.iId = EquipId;
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				equip.iEquipOperatorId = Convert.ToInt32(ddAssignTo.SelectedValue);
				equip.sNote = tbNote.Text;
				equip.EquipAssignedTo();
				Response.Redirect("e_view.aspx?id="+EquipId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_reassign.aspx?id=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip!=null)
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
