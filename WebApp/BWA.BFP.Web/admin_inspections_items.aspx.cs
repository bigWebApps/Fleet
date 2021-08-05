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
	public class _admin_inspections_items : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblInspectionName;
		protected System.Web.UI.WebControls.Label lblBack;
		protected System.Web.UI.WebControls.HyperLink hlCategories;
		protected System.Web.UI.WebControls.HyperLink hlAddInspectionItem;
		protected System.Web.UI.WebControls.Repeater repInspections;
		protected System.Web.UI.WebControls.HyperLink hlAddCategory;
	
		private int InspectId;
		private clsInspections inspect = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_inspections_items.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
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

				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "admin_inspections.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					InspectId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "admin_inspections.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("Inspections Manager", "/admin_inspections.aspx");
				Header.LeftBarHtml = "View Inspection Items";
				this.PageTitle = "Inspection Items Manager";

				lblBack.Text = "<input type=button value=\" Back \" onclick=\"document.location='admin_inspections.aspx'\">";
				if(!IsPostBack)
				{
					inspect = new clsInspections();
					inspect.iOrgId = OrgId;
					inspect.iId = InspectId;
					repInspections.DataSource = new DataView(inspect.GetInspectionItemsList());
					repInspections.DataBind();
					lblInspectionName.Text = inspect.sInspectionName.Value;
					hlAddCategory.NavigateUrl = "admin_inspection_category_edit.aspx?id=" + InspectId.ToString() + "&catid=0";
					hlAddInspectionItem.NavigateUrl = "admin_inspection_item_edit.aspx?id=" + InspectId.ToString() + "&itemid=0";
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
				if(inspect != null)
					inspect.Dispose();
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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
