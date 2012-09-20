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

namespace BWA.BFP.Web.workorder
{
	public class _manageIssues : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Label lblType;
		protected System.Web.UI.WebControls.Label lblMakeModel;
		protected System.Web.UI.WebControls.Label lblYear;
		protected System.Web.UI.WebControls.Label lblUnits;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected Micajah.DataGrid.DataGrid_A dgUnAssignedIssues;
		protected Micajah.DataGrid.DataGrid_A dgAssignedIssues;
		protected System.Web.UI.WebControls.DropDownList ddlCategory;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvCategory;
		protected System.Web.UI.WebControls.TextBox tbDesc;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvDesc;
		protected System.Web.UI.WebControls.Button btnAddRepair;
		protected System.Web.UI.WebControls.HyperLink hlCreateOrder;

		private clsEquipment equip = null;
		private clsWorkOrders order = null;
		
		private int EquipId;
		private DataSet dsIssues = null;
		private string sCurrentPage;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "manageIssues.aspx.cs";

				this.PageTitle  = "Manage Reported Issues";
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddBreadCrumb("Select Equipment", "/wo_default.aspx?select=AddIssue");
				Header.LeftBarHtml = "Add/Edit/Delete Unassigned Reported Issues";
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
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "main.aspx";
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
					Session["lastpage"] = "main.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				sCurrentPage = "manageIssues.aspx?id=" + EquipId.ToString();

				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					ddlCategory.DataSource = new DataView(order.GetCategoryList());
					ddlCategory.DataBind();
					ddlCategory.Items.Insert(0, "");

					equip = new clsEquipment();
					equip.cAction = "S";
					equip.iId = EquipId;
					equip.iOrgId = OrgId;
					if(equip.EquipmentDetail() == -1)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblEquipId.Text = equip.sEquipId.Value;
					lblMakeModel.Text = equip.sMakeModelName.Value;
					lblOperator.Text = equip.sEquipOperator.Value;
					lblType.Text = equip.sType.Value;
					lblYear.Text = equip.iYear.Value.ToString();
					if(!equip.dmCurrentUnits.IsNull)
						lblUnits.Text = Convert.ToDouble(equip.dmCurrentUnits.Value).ToString();
					hlCreateOrder.NavigateUrl = "wo_existingWorkOrders.aspx?id=" + EquipId.ToString();
					
					ShowIssues();
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
				if(order != null)
					order.Dispose();
				if(equip != null)
					equip.Dispose();
			}
		}

		#region Showing All Issues in tables
		/// <summary>
		/// Showing All Issues in tables
		/// </summary>
		void ShowIssues()
		{
			try
			{
				dsIssues = equip.GetReportedIssueLists();

				dgAssignedIssues.DataSource = new DataView(dsIssues.Tables[0]);
				dgAssignedIssues.DataBind();

				dgUnAssignedIssues.DataSource = new DataView(dsIssues.Tables[1]);
				dgUnAssignedIssues.DataBind();
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}
		#endregion

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.dgUnAssignedIssues.EditCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgUnAssignedIssues_EditCommand);
			this.dgUnAssignedIssues.CancelCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgUnAssignedIssues_CancelCommand);
			this.dgUnAssignedIssues.UpdateCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgUnAssignedIssues_UpdateCommand);
			this.dgUnAssignedIssues.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgUnAssignedIssues_DeleteCommand);
			this.btnAddRepair.Click += new System.EventHandler(this.btnAddRepair_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void dgUnAssignedIssues_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgUnAssignedIssues.EditItemIndex = -1;
				equip = new clsEquipment();
				equip.iId = EquipId;
				equip.iOrgId = OrgId;
				ShowIssues();
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
				if(equip != null)
					equip.Dispose();
			}
		}

		private void dgUnAssignedIssues_EditCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgUnAssignedIssues.EditItemIndex = e.Item.ItemIndex;
				equip = new clsEquipment();
				equip.iId = EquipId;
				equip.iOrgId = OrgId;
				ShowIssues();
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
				if(equip != null)
					equip.Dispose();
			}		
		}

		private void dgUnAssignedIssues_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				equip = new clsEquipment();
				equip.iId = EquipId;
				equip.iOrgId = OrgId;
				order.cAction = "S";
				order.iOrgId = OrgId;
				order.iReportedIssueId = Convert.ToInt32(((Label)e.Item.FindControl("lblReportIssueId")).Text);
				if(order.WorkOrderReportedIssuesDetail() == -1)
				{
					Session["lastpage"] = sCurrentPage;
					Session["error"] = _functions.ErrorMessage(121);
					Response.Redirect("error.aspx", false);
					return;
				}
				order.cAction = "U";
				order.sReportDesc = ((TextBox)e.Item.FindControl("tbIssueName")).Text;
				if(order.WorkOrderReportedIssuesDetail() == -1)
				{
					Session["lastpage"] = sCurrentPage;
					Session["error"] = _functions.ErrorMessage(121);
					Response.Redirect("error.aspx", false);
					return;
				}
				dgUnAssignedIssues.EditItemIndex = -1;
				
				ShowIssues();
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
				if(equip != null)
					equip.Dispose();
				if(order != null)
					order.Dispose();
			}			
		}

		private void dgUnAssignedIssues_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				equip = new clsEquipment();
				equip.iId = EquipId;
				equip.iOrgId = OrgId;
				order.cAction = "D";
				order.iOrgId = OrgId;
				order.iReportedIssueId = Convert.ToInt32(e.Item.Cells[0].Text);
				if(order.WorkOrderReportedIssuesDetail() == -1)
				{
					Session["lastpage"] = sCurrentPage;
					Session["error"] = _functions.ErrorMessage(121);
					Response.Redirect("error.aspx", false);
					return;
				}

				ShowIssues();
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
				if(equip != null)
					equip.Dispose();
				if(order != null)
					order.Dispose();
			}					
		}

		private void btnAddRepair_Click(object sender, System.EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				equip = new clsEquipment();
				equip.iId = EquipId;
				equip.iOrgId = OrgId;
				order.cAction = "U";
				order.iOrgId = OrgId;
				order.iEquipId = EquipId;
				order.iReportedIssueId = 0;
				order.iRepairCatId = Convert.ToInt32(ddlCategory.SelectedValue);
				order.sReportDesc = tbDesc.Text;
				order.iId = SqlInt32.Null;
				order.iServiceResultId = SqlInt32.Null;
				order.iServiceCheckId = SqlInt32.Null;
				order.iRepairMultId = SqlInt32.Null;
				if(order.WorkOrderReportedIssuesDetail() == -1)
				{
					Session["lastpage"] = sCurrentPage;
					Session["error"] = _functions.ErrorMessage(121);
					Response.Redirect("error.aspx", false);
				}
				tbDesc.Text = "";
				ddlCategory.SelectedIndex = 0;
				
				ShowIssues();
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
				if(equip != null)
					equip.Dispose();
				if(order != null)
					order.Dispose();
			}								
		}
	}
}
