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

namespace BWA.BFP.Web.operatorkiosk
{
	public class _ok_viewServices : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Repeater repPMItems;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneIssues;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNonePMItems;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneInspections;
		protected System.Web.UI.WebControls.Repeater repIssues;
		protected System.Web.UI.WebControls.Label lblInspectionTitle;
		protected System.Web.UI.WebControls.Repeater repInspectItems;
		protected System.Web.UI.WebControls.Repeater repInspections;

		private clsWorkOrders order = null;
		
		private DataSet dsIssueItems;
		
		private int OrderId;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_viewServices.aspx.cs";

				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + NextBackControl.NextClientId + "');";
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
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "ok_selectWorkOrder.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "ok_selectWorkOrder.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				NextBackControl.BackText = "<< Back";
				NextBackControl.BackPage = "ok_selectWorkOrder.aspx?id=" + OrderId.ToString();
				NextBackControl.NextText = "Continue >>";
				NextBackControl.sCSSClass = "ok_input_button";
				
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;

					dsIssueItems = order.GetWorkOrderIssuesItems();
					
					if(dsIssueItems.Tables[0].Rows.Count > 0)
						html_tblNoneIssues.Visible = false;
					else
						html_tblNoneIssues.Visible = true;

					repIssues.DataSource = new DataView(dsIssueItems.Tables[0]);
					repIssues.DataBind();

					if(dsIssueItems.Tables[1].Rows.Count > 0)
						html_tblNonePMItems.Visible = false;
					else
						html_tblNonePMItems.Visible = true;
					
					repPMItems.DataSource = new DataView(dsIssueItems.Tables[1]);
					repPMItems.DataBind();
					
					if(dsIssueItems.Tables[2].Rows.Count > 0)
					{
						html_tblNoneInspections.Visible = false;
						if(dsIssueItems.Tables[3].Rows.Count == 1)
							lblInspectionTitle.Text = "Serviced Items of " + dsIssueItems.Tables[2].Rows[0]["InspectionName"].ToString();
						repInspectItems.DataSource = new DataView(dsIssueItems.Tables[2]);
						repInspectItems.DataBind();
					}
					else
					{
						lblInspectionTitle.Text = "Serviced Inspections";
						if(dsIssueItems.Tables[3].Rows.Count > 0)
						{
							html_tblNoneInspections.Visible = false;
							repInspections.DataSource = new DataView(dsIssueItems.Tables[3]);
							repInspections.DataBind();
						}
						else
							html_tblNoneInspections.Visible = true;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_selectWorkOrder.aspx";
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


		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			Response.Redirect("ok_viewIssues.aspx?id=" + OrderId.ToString() ,false);
		}
		
		
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			this.NextBackControl.BubbleClick += new EventHandler(this.btNext_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
		}
		
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
