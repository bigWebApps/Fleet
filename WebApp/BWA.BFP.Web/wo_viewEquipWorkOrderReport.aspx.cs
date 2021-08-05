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
	public class _wo_viewEquipWorkOrderReport : BFPPage
	{
		protected System.Web.UI.WebControls.TextBox tbEquipId;
		protected ActiveUp.WebControls.ActiveDateTime adtStartDate;
		protected ActiveUp.WebControls.ActiveDateTime adtEndDate;
		protected System.Web.UI.HtmlControls.HtmlSelect ddlDateRange;
		protected System.Web.UI.HtmlControls.HtmlAnchor A1;
		protected System.Web.UI.HtmlControls.HtmlAnchor A2;
		protected System.Web.UI.WebControls.DropDownList ddlRepairCats;
		protected System.Web.UI.WebControls.DropDownList ddlWOTypes;
		protected System.Web.UI.WebControls.DropDownList ddlTech;
		protected System.Web.UI.WebControls.DropDownList ddlOperators;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvEquipId;
		protected System.Web.UI.WebControls.Repeater repWorkOrders;
		protected System.Web.UI.WebControls.Button btnReport;
	
		private clsWorkOrders order = null;
		private clsUsers user = null;

		private DateTime dtCurrentDate;
		protected System.Web.UI.WebControls.Label lblTotalCost;
		private DataSet dsRepairItemsCats = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_viewEquipWorkOrderReport.aspx.cs";
				
				this.PageTitle = "Equipment Work Order Report";
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddJavaScriptFile("/e_viewTempOperatorReport.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + tbEquipId.ClientID + "');";
				Header.LeftBarHtml = "View the Work Orders during selected date range for current Equipment";
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

				Session["PathToViewOrder"] = "EquipWOReport";
					
				if(!IsPostBack)
				{
					dtCurrentDate = DateTime.Now;
					adtEndDate.Date = dtCurrentDate;
					adtStartDate.Date = dtCurrentDate.AddDays(-365);
					
					order = new clsWorkOrders();
					order.iOrgId = OrgId;

					dsRepairItemsCats = order.GetRepairItemsAndCats();
					
					ddlRepairCats.DataSource = dsRepairItemsCats;
					ddlRepairCats.DataBind();
					ddlRepairCats.Items[0].Text = "All";
					
					ddlWOTypes.DataSource = order.GetTypesList();
					ddlWOTypes.DataBind();
					ddlWOTypes.Items.Insert(0, new ListItem("All","0"));

					user = new clsUsers();
					user.iOrgId = OrgId;
					user.iTypeId = (int)UserTypes.Technician;
					ddlTech.DataSource = new DataView(user.GetUserListByType());
					ddlTech.DataBind();
					ddlTech.Items[0].Text = "All";

					user.iTypeId = (int)UserTypes.Operator;
					ddlOperators.DataSource = new DataView(user.GetUserListByType());
					ddlOperators.DataBind();
					ddlOperators.Items[0].Text = "All";

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
				if(user != null)
					user.Dispose();
				if(order != null)
					order.Dispose();
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
			this.btnReport.Click += new System.EventHandler(this.btnReport_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnReport_Click(object sender, System.EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.sEquipId = tbEquipId.Text;
				order.daMinDate = adtStartDate.Date;
				order.daMaxDate = adtEndDate.Date;
				order.iTypeId = Convert.ToInt32(ddlWOTypes.SelectedValue);
				order.iRepairCatId = Convert.ToInt32(ddlRepairCats.SelectedValue);
				order.iTechId = Convert.ToInt32(ddlTech.SelectedValue);
				order.iOperatorId = Convert.ToInt32(ddlOperators.SelectedValue);
				DataTable dtReport = order.GetEquipWorkOrderReport();
				repWorkOrders.DataSource = new DataView(dtReport);
				repWorkOrders.DataBind();
				double dmTotalCost = 0.0;
				foreach(DataRow _row in dtReport.Rows)
				{
					dmTotalCost += Convert.ToDouble(_row["TotalCost"]);
				}
				lblTotalCost.Text = "$" + dmTotalCost.ToString();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_viewEquipWorkOrderReport.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(order != null)
					order.Dispose();
			}
		}
	}
}
