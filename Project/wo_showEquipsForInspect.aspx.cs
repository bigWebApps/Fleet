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

namespace BWA.BFP.Web.workorder
{
	public class _wo_showEquipsForInspect : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgInspections;
		protected System.Web.UI.WebControls.Button btnFiltration;
		protected System.Web.UI.WebControls.TextBox tbEquipId;
		protected System.Web.UI.WebControls.DropDownList ddlEquipTypes;
		protected System.Web.UI.WebControls.DropDownList ddlSpare;
		protected System.Web.UI.WebControls.DropDownList ddlDepartments;
		protected System.Web.UI.WebControls.DropDownList ddlLocations;
		protected System.Web.UI.WebControls.DropDownList ddlDrivers;
		private clsWorkOrders order = null;
		private clsEquipment equip = null;
		private clsDepartments dep = null;
		private clsLocations loc = null;
		private clsUsers user = null;
		
		private EquipFilter eFilter;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_showEquipsForInspect.aspx.cs";

				this.PageTitle = "Select Equipment with Inspections";
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + tbEquipId.ClientID + "');";
				Header.LeftBarHtml = "Select/Search Equipment for the Creation of Work Order with Inspections";
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
					equip = new clsEquipment();
					loc = new clsLocations();
					dep = new clsDepartments();
					user = new clsUsers();
					equip.iOrgId = OrgId;
					
					ddlEquipTypes.DataSource = new DataView(equip.GetEquipTypesList());
					ddlEquipTypes.DataBind();
					ddlEquipTypes.Items.Insert(0, new ListItem("All","0"));
					
					dep.iOrgId = OrgId;
					ddlDepartments.DataSource = new DataView(dep.GetDepartmentsList());
					ddlDepartments.DataBind();
					ddlDepartments.Items.Insert(0, new ListItem("All","0"));
					
					loc.iOrgId = OrgId;
					ddlLocations.DataSource = new DataView(loc.GetLocationsList());
					ddlLocations.DataBind();
					ddlLocations.Items.Insert(0, new ListItem("All","0"));
					
					user.iOrgId = OrgId;
					user.iTypeId = (int)UserTypes.Operator;
					ddlDrivers.DataSource = new DataView(user.GetUserListByType());
					ddlDrivers.DataBind();
					ddlDrivers.Items[0].Text = "All";

					if(Session["EquipFilter"] == null)
					{
						equip.iTypeId = Convert.ToInt32(ddlEquipTypes.SelectedValue);
						equip.iDeptId = Convert.ToInt32(ddlDepartments.SelectedValue);
						equip.iLocId = Convert.ToInt32(ddlLocations.SelectedValue);
						equip.iUserId = Convert.ToInt32(ddlDrivers.SelectedValue);
						equip.iIsSpare = Convert.ToInt32(ddlSpare.SelectedValue);
						equip.sEquipId_Filter = _functions.ConvertToSQLFilter(tbEquipId.Text);

						eFilter = new EquipFilter();
						eFilter.iTypeId = equip.iTypeId.Value;
						eFilter.iDeptId = equip.iDeptId.Value;
						eFilter.iLocId = equip.iLocId.Value;
						eFilter.iIsSpare = equip.iIsSpare.Value;
						eFilter.iOperatorId = equip.iUserId.Value;
						eFilter.sEquipId = equip.sEquipId_Filter.Value;
						Session["EquipFilter"] = eFilter;
					}
					else
					{
						eFilter = (EquipFilter)Session["EquipFilter"];
						ddlEquipTypes.Items.FindByValue(eFilter.iTypeId.ToString()).Selected = true;
						ddlSpare.Items.FindByValue(eFilter.iIsSpare.ToString()).Selected = true;
						ddlDepartments.Items.FindByValue(eFilter.iDeptId.ToString()).Selected = true;
						ddlLocations.Items.FindByValue(eFilter.iLocId.ToString()).Selected = true;
						ddlDrivers.Items.FindByValue(eFilter.iOperatorId.ToString()).Selected = true;
						tbEquipId.Text = _functions.ConvertFromSQLFilter(eFilter.sEquipId);

						equip.iTypeId = eFilter.iTypeId;
						equip.iDeptId = eFilter.iDeptId;
						equip.iLocId = eFilter.iLocId;
						equip.iIsSpare = eFilter.iIsSpare;
						equip.iUserId = eFilter.iOperatorId;
						equip.sEquipId_Filter = eFilter.sEquipId;
					}

					dgInspections.DataSource = new DataView(equip.GetEquipInspectList_Filter());
					dgInspections.DataBind();
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
				if(equip != null)
					equip.Dispose();
				if(loc != null)
					loc.Dispose();
				if(dep != null)
					dep.Dispose();
				if(user != null)
					user.Dispose();
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
			this.btnFiltration.Click += new System.EventHandler(this.btnFiltration_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnFiltration_Click(object sender, System.EventArgs e)
		{
			try
			{
				equip = new clsEquipment();

				equip.iOrgId = OrgId;
				equip.iTypeId = Convert.ToInt32(ddlEquipTypes.SelectedValue);
				equip.iDeptId = Convert.ToInt32(ddlDepartments.SelectedValue);
				equip.iLocId = Convert.ToInt32(ddlLocations.SelectedValue);
				equip.iIsSpare = Convert.ToInt32(ddlSpare.SelectedValue);
				equip.iUserId = Convert.ToInt32(ddlDrivers.SelectedValue);
				equip.sEquipId_Filter = _functions.ConvertToSQLFilter(tbEquipId.Text);

				eFilter = new EquipFilter();
				eFilter.iTypeId = equip.iTypeId.Value;
				eFilter.iDeptId = equip.iDeptId.Value;
				eFilter.iLocId = equip.iLocId.Value;
				eFilter.iIsSpare = equip.iIsSpare.Value;
				eFilter.iOperatorId = equip.iUserId.Value;
				eFilter.sEquipId = equip.sEquipId_Filter.Value;
				Session["EquipFilter"] = eFilter;
				
				dgInspections.DataSource = new DataView(equip.GetEquipInspectList_Filter());
				dgInspections.DataBind();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showEquipsForInspect.aspx";
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
	}
}
