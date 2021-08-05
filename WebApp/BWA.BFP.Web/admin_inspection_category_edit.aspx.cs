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
	public class _admin_inspection_category_edit : BFPPage
	{
		protected System.Web.UI.WebControls.TextBox tbCategory;
		protected System.Web.UI.WebControls.Label lblInspectionName;
		protected System.Web.UI.WebControls.Label lblError;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvCategory;
		protected Micajah.DataGrid.DataGrid_A dgInspectItems;
		protected System.Web.UI.WebControls.DropDownList ddlOrder;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Button btnDelete;

		private int InspectionId;
		private int CategoryId;
		private string sLastPage, sCurrentPage;

		private clsInspections inspect = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_inspection_category_edit.aspx.cs";

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
					
				if(Request.QueryString["id"] == null || Request.QueryString["catid"] == null)
				{
					Session["lastpage"] = "admin_inspections.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					InspectionId = Convert.ToInt32(Request.QueryString["id"]);
					CategoryId = Convert.ToInt32(Request.QueryString["catid"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "admin_inspections.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				sLastPage = "admin_inspections_items.aspx?id=" + InspectionId.ToString();
				sCurrentPage = "admin_inspection_category_edit.aspx?id=" + InspectionId.ToString() + "&catid=" + CategoryId.ToString();

				this.PageTitle = "Inspection Category Edit";
				Header.MainMenuSelectedItem = "Administration";
				Header.AddJavaScriptFile("/admin_inspection_category_edit.js");
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("Inspections Manager", "/admin_inspections.aspx");
				Header.AddBreadCrumb("Inspection Items Manager", "/" + sLastPage);
				Header.LeftBarHtml = "Add/Edit/Delete Inspection Category and Set Category Position and Items Position";

				SaveCancelControl.CancelText= " Back ";
				SaveCancelControl.ParentPageURL = sLastPage;
				if(!IsPostBack)
				{
					inspect = new clsInspections();
					inspect.cAction = "S";
					inspect.iOrgId = OrgId;
					inspect.iId = InspectionId;
					inspect.iCategoryId = CategoryId;
					if(inspect.InspectCatDetails() == -1)
					{
						Session["lastpage"] = sLastPage;
						Session["error"] = _functions.ErrorMessage(156);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblInspectionName.Text = inspect.sInspectionName.Value;
					tbCategory.Text = inspect.sCategoryName.Value;
					for(int i=1; i<= inspect.iCatMaxPosition.Value; i++)
					{
						ddlOrder.Items.Add(new ListItem(i.ToString(),i.ToString()));
					}
					ddlOrder.SelectedValue = inspect.iCatPosition.Value.ToString();

					dgInspectItems.DataSource = new DataView(inspect.GetInspectionItemsListByCategory());
					dgInspectItems.DataBind();
					
					if(dgInspectItems.Items.Count > 0 || CategoryId == 0)
						btnDelete.Enabled = false;
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
			this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Save Inspection Category
		/// <summary>
		/// Update the Category information and positions of items
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			int Position, NewPosition;
			try
			{
				inspect = new clsInspections();
				inspect.cAction = "U";
				inspect.iOrgId = OrgId;
				inspect.iId = InspectionId;
				inspect.iCategoryId = CategoryId;
				inspect.sCategoryName = tbCategory.Text;
				inspect.iCatPosition = Convert.ToInt32(ddlOrder.SelectedValue);
				if(inspect.InspectCatDetails() == -1)
				{
					Session["lastpage"] = sCurrentPage;
					Session["error"] = _functions.ErrorMessage(156);
					Response.Redirect("error.aspx", false);
					return;
				}
				foreach(DataGridItem Item in dgInspectItems.Items)
				{
					Position = Convert.ToInt32(((Label)Item.FindControl("lblCatId")).Text);
					NewPosition = Convert.ToInt32(Request.Params["FormPosition" + Item.ItemIndex.ToString()]);
					if(Position != NewPosition)
					{
						inspect.iInspectItemId = Convert.ToInt32(Item.Cells[0].Text);
						inspect.iItemPosition = NewPosition;
						inspect.UpdatePosInspectItem();
					}
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
				inspect.iCategoryId = CategoryId;
				if(inspect.InspectCatDetails() == -1)
				{
					Session["lastpage"] = sCurrentPage;
					Session["error"] = _functions.ErrorMessage(156);
					Response.Redirect("error.aspx", false);
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
				if(inspect != null)
					inspect.Dispose();
			}
		}

	}
}
