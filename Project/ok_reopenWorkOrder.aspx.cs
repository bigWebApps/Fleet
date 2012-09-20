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
	public class _ok_reopenWorkOrder : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Repeater repIssues;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneIssues;
		protected System.Web.UI.WebControls.Repeater repPMItems;
		protected System.Web.UI.WebControls.Label lblInspectionTitle;
		protected System.Web.UI.WebControls.Repeater repInspectItems;
		protected System.Web.UI.WebControls.Repeater repInspections;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNonePMItems;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneInspections;
		protected System.Web.UI.HtmlControls.HtmlInputButton btnAddIssue;
		protected System.Web.UI.HtmlControls.HtmlInputButton btnAddComment;

		private clsWorkOrders order = null;
		private DataSet dsIssueItems;
		private OperatorInfo op = null;
		private string Operation;
		private int OrderId;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_reopenWorkOrder.aspx.cs";
				Header.MainMenuVisible = false;
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
					Session["lastpage"] = "ok_mainMenu.aspx";
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
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);
					
				NextBackControl.BackText = "<< Back";
				NextBackControl.BackPage = "ok_mainDetails.aspx?id=" + OrderId.ToString();
				NextBackControl.NextText = "  Continue >> ";
				NextBackControl.sCSSClass = "ok_input_button";
				if(Request.QueryString["op"] == null)
					NextBackControl.NextEnabled = false;
				else
				{
					Operation = Request.QueryString["op"];
					NextBackControl.BackVisible = false;
				}
				
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
					
					if(order.GetEquipInfo() == -1)
					{
						Session["lastpage"] = "ok_mainDetails.aspx?id=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					btnAddIssue.Attributes.Add("onclick", "javascript:document.location='ok_addIssues.aspx?op=AddIssueReOpen&orderid=" + OrderId.ToString() + "&equipid=" + order.iEquipId.Value.ToString() + "'");
					btnAddComment.Attributes.Add("onclick", "javascript:document.location='ok_editNote.aspx?op=AddCommentReOpen&orderid=" + OrderId.ToString() + "&equipid=" + order.iEquipId.Value.ToString() + "'");
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_mainDetails.aspx?id=" + OrderId.ToString();
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

		#region Next Screen
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				DateTime dtCurrentTime = DateTime.Now;
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.iOperatorId = op.Id;
				if(Operation == "AddIssueReOpen")
					order.iReOpenCategoryId = 2; //Forgot to report an issue
				else if(Operation == "AddCommentReOpen")
					order.iReOpenCategoryId = 1; //Issue not resolved
				else
				{
					Header.ErrorMessage = _functions.ErrorMessage(166);
					return;
				}
				order.daCurrentDate = dtCurrentTime;
				if(order.UpdateReOpenWorkOrder() == -1)
				{
					Session["lastpage"] = "ok_reopenWorkOrder.aspx?id=" + OrderId.ToString() + "&op=Issue";
					Session["error"] = _functions.ErrorMessage(120);
					Response.Redirect("error.aspx", false);
					return;
				}
				order.iUserId = op.Id;
				if(order.SigningWorkOrderReOpen() == -1)
				{
					Session["lastpage"] = "ok_reopenWorkOrder.aspx?id=" + OrderId.ToString() + "&op=Issue";
					Session["error"] = _functions.ErrorMessage(120);
					Response.Redirect("error.aspx", false);
					return;
				}
				Response.Redirect("ok_viewReOpen.aspx?id=" + OrderId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_reopenWorkOrder.aspx?id=" + OrderId.ToString() + "&op=Issue";
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
		#endregion

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
