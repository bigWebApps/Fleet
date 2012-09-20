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
	public class _admin_inspection_item_edit : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Label lblInspectionName;
		protected System.Web.UI.WebControls.TextBox tbItemName;
		protected System.Web.UI.WebControls.DataGrid dgPMItems;
		protected System.Web.UI.WebControls.DropDownList ddlPMSchedules;
		protected System.Web.UI.WebControls.DropDownList ddlPMServices;
		protected System.Web.UI.WebControls.Button btnLink;
		protected System.Web.UI.WebControls.Button btnDelete;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvItemName;
		protected System.Web.UI.WebControls.DropDownList ddlCategories;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
		protected MetaBuilders.WebControls.ListLink ListLink;
	
		private int InspectionId;
		private int ItemId;
		private string sLastPage, sCurrentPage;
		private DataSet dsPMSchedServices = null;

		private clsInspections inspect = null;
		private clsPMSchedService pmsched = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_inspection_item_edit.aspx.cs";

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
					
				if(Request.QueryString["id"] == null || Request.QueryString["itemid"] == null)
				{
					Session["lastpage"] = "admin_inspections.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					InspectionId = Convert.ToInt32(Request.QueryString["id"]);
					ItemId = Convert.ToInt32(Request.QueryString["itemid"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "admin_inspections.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				sLastPage = "admin_inspections_items.aspx?id=" + InspectionId.ToString();
				sCurrentPage = "admin_inspection_item_edit.aspx?id=" + InspectionId.ToString() + "&itemid=" + ItemId.ToString();

				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("Inspections Manager", "/admin_inspections.aspx");
				Header.AddBreadCrumb("Inspection Items Manager", "/" + sLastPage);
				Header.LeftBarHtml = "Add/Edit/Delete Inspection Item and Add/Delete relationship to PM Items";
				this.PageTitle = "Inspection Item Edit";
				
				SaveCancelControl.CancelText= " Back ";
				SaveCancelControl.ParentPageURL = sLastPage;
				if(!IsPostBack)
				{
					inspect = new clsInspections();
					inspect.cAction = "S";
					inspect.iOrgId = OrgId;
					inspect.iId = InspectionId;
					inspect.iInspectItemId = ItemId;
					ddlCategories.DataSource = new DataView(inspect.GetInspectCategoriesList());
					ddlCategories.DataBind();
					if(inspect.InspectItemDetails() == -1)
					{
						Session["lastpage"] = sLastPage;
						Session["error"] = _functions.ErrorMessage(127);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblInspectionName.Text = inspect.sInspectionName.Value;
					tbItemName.Text = inspect.sInspectItemName.Value;
					
					if(ItemId == 0)
					{
						tblMain.Rows[5].Visible = false;
						tblMain.Rows[6].Visible = false;
						tblMain.Rows[7].Visible = false;
						tblMain.Rows[8].Visible = false;
						tblMain.Rows[9].Visible = false;
						tblMain.Rows[10].Visible = false;
						btnDelete.Visible = false;
					}
					else
					{
						ddlCategories.SelectedValue = inspect.iCategoryId.Value.ToString();

						dgPMItems.DataSource = new DataView(inspect.GetPMServicesByInspectionItem());
						dgPMItems.DataBind();
						if(dgPMItems.Items.Count == 0)
							dgPMItems.Visible = false;

						ShowPMItems();
					}
					
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

		private void ShowPMItems()
		{
			try
			{
				pmsched = new clsPMSchedService();
				pmsched.iOrgId = OrgId;
				pmsched.iInspectItemId = ItemId;
				dsPMSchedServices = pmsched.GetPMSchedPMServicesList();
				dsPMSchedServices.Relations.Add(new DataRelation( "Schedules_Services", dsPMSchedServices.Tables["Table"].Columns["Id"], dsPMSchedServices.Tables["Table1"].Columns["PMSchedId"]));

				ddlPMSchedules.DataSource = dsPMSchedServices;
				ddlPMSchedules.DataMember = "Table";
				ddlPMSchedules.DataBind();

				ddlPMServices.DataSource = dsPMSchedServices;
				ddlPMServices.DataMember = "Table1";
				ddlPMServices.DataBind();
						
				ListLink.Enabled = true;
				ListLink.DataBind();
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally
			{
				if(pmsched != null)
					pmsched.Dispose();
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
			this.dgPMItems.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPMItems_DeleteCommand);
			this.btnLink.Click += new System.EventHandler(this.btnLink_Click);
			this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Save Inspection Item
		/// <summary>
		/// Update the Inspection Items
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
				try
				{
					if(ddlCategories.Items.Count > 0)
					{
						inspect = new clsInspections();
						inspect.cAction = "U";
						inspect.iOrgId = OrgId;
						inspect.iInspectItemId = ItemId;
						inspect.iId = InspectionId;
						inspect.iCategoryId = Convert.ToInt32(ddlCategories.SelectedValue);
						inspect.sInspectItemName = tbItemName.Text;
						inspect.bEnabled = true;
						inspect.InspectItemDetails();
						
						Response.Redirect(sLastPage, false);
					}
					else
						Header.ErrorMessage = _functions.ErrorMessage(158);
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
				inspect.iId = InspectionId;
				inspect.iInspectItemId = ItemId;
				int iResult = inspect.InspectItemDetails();
				if(iResult == -1)
				{
					Session["lastpage"] = sLastPage;
					Session["error"] = _functions.ErrorMessage(127);
					Response.Redirect("error.aspx", false);
					return;
				}
				if(iResult == -2)
				{
					Header.ErrorMessage = _functions.ErrorMessage(157);
				}
				if(iResult == 0)
				{
					Response.Redirect(sLastPage, false);
				}
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

		private void btnLink_Click(object sender, System.EventArgs e)
		{
			try
			{
				inspect = new clsInspections();
				inspect.cAction = "I";
				inspect.iOrgId = OrgId;
				inspect.iInspectItemId = ItemId;
				inspect.iPMSchedDetailId = Convert.ToInt32(ddlPMServices.SelectedValue);

				inspect.InspectItemPMItemDetails();
				
				dgPMItems.DataSource = new DataView(inspect.GetPMServicesByInspectionItem());
				dgPMItems.DataBind();
				dgPMItems.Visible = true;

				ShowPMItems();
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

		private void dgPMItems_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				inspect = new clsInspections();
				inspect.cAction = "D";
				inspect.iOrgId = OrgId;
				inspect.iInspectItemId = ItemId;
				inspect.iInspectItemPMItemId = Convert.ToInt32(e.Item.Cells[0].Text);
				
				inspect.InspectItemPMItemDetails();
				
				dgPMItems.DataSource = new DataView(inspect.GetPMServicesByInspectionItem());
				dgPMItems.DataBind();
				if(dgPMItems.Items.Count == 0)
					dgPMItems.Visible = false;

				ShowPMItems();
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
