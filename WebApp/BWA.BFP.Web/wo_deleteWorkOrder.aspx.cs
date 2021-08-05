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
	public class _wo_deleteWorkOrder : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblWorkOrderId;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Label lblTech;
		protected System.Web.UI.WebControls.Button btnYes;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.HtmlControls.HtmlInputButton html_btnNo;
	
		private int OrderId;
		private clsWorkOrders order = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_deleteWorkOrder.aspx.cs";

				this.PageTitle = "Delete Work Order";
				Header.LeftBarHtml = "Delete Work Order";
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
					Session["lastpage"] = "main.aspx";
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
					Session["lastpage"] = "main.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				
				// getting the Bread Crumbs from Cookie and add last item
                if (Request.Cookies.Count > 0 && Request.Cookies["bfp_navigate"] != null)
                    Header.BrdCrumbsSerialization = Request.Cookies["bfp_navigate"].Value;
                Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString());

				html_btnNo.Attributes.Add("onclick", "javascript:document.location='wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "'");
								
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					if(order.WorkOrderDetails() == -1)
					{
						Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblEquipId.Text = order.sEquipId.Value;
					lblWorkOrderId.Text = order.daCreated.Value.ToString("yyyy-MM-dd") + "-" + order.iWorkOrderNumber.Value.ToString();
					lblTech.Text = order.sTechName.Value;
					lblOperator.Text = order.sOperatorName.Value;
					if((WorkOrderStatus)order.iStatusId.Value != WorkOrderStatus.Closed)
					{
						if(order.GetDeleteAbleOrder() == 1)
							btnYes.Enabled = true;
						else
						{
							btnYes.Enabled = false;
							Header.ErrorMessage = _functions.ErrorMessage(146);
						}
					}
					else
					{
						btnYes.Enabled = false;
						Header.ErrorMessage = _functions.ErrorMessage(145);
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
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

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.btnYes.Click += new System.EventHandler(this.btnYes_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnYes_Click(object sender, System.EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				order.daCurrentDate = DateTime.Now;

				if(order.DeleteWorkOrder() == -1)
				{
					Session["lastpage"] = "wo_deleteWorkOrder.aspx?id=" + OrderId.ToString();
					Session["error"] = _functions.ErrorMessage(120);
					Response.Redirect("error.aspx", false);
					return;
				}
				// redirect to the finish screen
				BackFinishScreen finish = new BackFinishScreen();
						
				finish.sMainText = "The Work Order has been successfully deleted!";

				finish.bMainMenuVisible = true;
				finish.sMainMenuText = "[Return to Main Menu]";
				finish.sMainMenuURL = "main.aspx";

				finish.bContinueVisible = false;

				finish.bViewVisible = false;
					
				finish.bAdditionalVisible = false;
					
				finish.bPrintVisible = false;

				Session["BackFinish"] = finish;

				Response.Redirect("wo_finish.aspx", false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_deleteWorkOrder.aspx?id=" + OrderId.ToString();
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
