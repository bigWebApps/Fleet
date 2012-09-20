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
	public class _ok_mainDetails : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblWorkOrderN;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Label lblType;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.WebControls.Label lblStatus;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
		protected System.Web.UI.HtmlControls.HtmlInputButton btnCheckIn;
		protected System.Web.UI.HtmlControls.HtmlInputButton btnCheckOut;
		protected System.Web.UI.HtmlControls.HtmlInputButton btnCheckOutSpare;
		protected System.Web.UI.HtmlControls.HtmlInputButton btnAddIssue;
		protected System.Web.UI.WebControls.Label lblOperatorStatus;
		protected System.Web.UI.HtmlControls.HtmlInputButton btnBack;
		protected System.Web.UI.HtmlControls.HtmlInputButton btnReOpen;
	
		private clsWorkOrders order = null;

		private int OrderId;
		private int EquipId;
		private string sBackPage, sBackURL;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_mainDetails.aspx.cs";
				Header.MainMenuVisible = false;
				//Header.MainMenuSelectedItem = "Deactivate Operator Kiosk Terminal";
				Header.AddMetaTag("<META HTTP-EQUIV=\"REFRESH\" CONTENT=\"300;url=ok_mainMenu.aspx\">");
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_mainMenu.aspx";
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
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
					sBackPage = Request.QueryString["back"];
					//EquipId = Convert.ToInt32(Request.QueryString["equipid"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				sBackURL = "ok_mainMenu.aspx";
				if(sBackPage == "mainmenu2")
					sBackURL = "ok_mainMenu2.aspx";
				if(sBackPage == "authcredentials")
					sBackURL = "ok_authCredentials.aspx?orderid=" + OrderId.ToString();
				btnBack.Attributes.Add("onclick","javascript:document.location='" + sBackURL + "'");
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					if(order.WorkOrderDetails() == -1)
					{
						Session["lastpage"] = "ok_mainMenu.aspx";
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}
					EquipId = order.iEquipId.Value;
					lblWorkOrderN.Text = order.daCreated.Value.ToString("yyyy-MM-dd") + "-" + order.iWorkOrderNumber.Value.ToString();
					lblStatus.Text = order.sStatusId.Value;
					lblOperatorStatus.Text = order.sOperatorStatus.Value;
					lblOperator.Text = order.sOperatorName.Value;
					lblEquipId.Text = order.sEquipId.Value;
					lblType.Text = order.sEquipTypeName.Value;

					//Header.AddMainMenuItem("<nobr>Deactivate Operator Kiosk Terminal</nobr>", "/selectMode.aspx");
					if(((WorkOrderStatus)order.iStatusId.Value == WorkOrderStatus.Scheduled) && 
						((WorkOrderOperatorStatus)order.iOperatorStatusId.Value == WorkOrderOperatorStatus.Null))
					{	
						// Arrival Check-In
						tblMain.Rows[4].Visible = false;
						tblMain.Rows[5].Visible = false;
						tblMain.Rows[6].Visible = false;
						tblMain.Rows[7].Visible = false;
						Response.Redirect("ok_selectEquipment.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
						//Header.AddMainMenuItem("Arrival Check-In", "/ok_authCredentials.aspx?op=CheckIn&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString());
					}
					else if(((WorkOrderStatus)order.iStatusId.Value == WorkOrderStatus.Scheduled) && 
						((WorkOrderOperatorStatus)order.iOperatorStatusId.Value == WorkOrderOperatorStatus.Checked_In))
					{
						// Add Issues and Check-Out Spare
						tblMain.Rows[3].Visible = false;
						tblMain.Rows[4].Visible = false;
						tblMain.Rows[5].Visible = false;
						//Header.AddMainMenuItem("Add Reported Issue", "/ok_authCredentials.aspx?op=AddIssue&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString());
						if(order.iSpareEquipId.Value != 0)
						{
							btnCheckOutSpare.Value = " Recheck-Out Spare ";
							//Header.AddMainMenuItem("Recheck-Out Spare", "/ok_authCredentials.aspx?op=CheckOutSpare&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString());
						}
						//else
						//Header.AddMainMenuItem("Check-Out Spare", "/ok_authCredentials.aspx?op=CheckOutSpare&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString());
					}
					else if((WorkOrderStatus)order.iStatusId.Value == WorkOrderStatus.Open ||
						(WorkOrderStatus)order.iStatusId.Value == WorkOrderStatus.ReOpened)
					{
						// Add Issues and Check-Out Spare
						tblMain.Rows[3].Visible = false;
						tblMain.Rows[4].Visible = false;
						tblMain.Rows[5].Visible = false;
						if(order.iSpareEquipId.Value != 0)
						{
							btnCheckOutSpare.Value = " Recheck-Out Spare ";
							//Header.AddMainMenuItem("Recheck-Out Spare", "/ok_authCredentials.aspx?op=CheckOutSpare&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString());
						}
						//else
						//Header.AddMainMenuItem("Check-Out Spare", "/ok_authCredentials.aspx?op=CheckOutSpare&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString());
					}
					else if(((WorkOrderStatus)order.iStatusId.Value == WorkOrderStatus.Closed) && 
						((WorkOrderOperatorStatus)order.iOperatorStatusId.Value == WorkOrderOperatorStatus.Checked_In))
					{
						// Departure Check-Out and ReOpen
						tblMain.Rows[3].Visible = false;
						tblMain.Rows[6].Visible = false;
						tblMain.Rows[7].Visible = false;
						//Header.AddMainMenuItem("Departure Check-Out", "/ok_authCredentials.aspx?op=CheckOut&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString());
					}
					else if(((WorkOrderStatus)order.iStatusId.Value == WorkOrderStatus.Closed) && 
						((WorkOrderOperatorStatus)order.iOperatorStatusId.Value == WorkOrderOperatorStatus.Checked_Out))
					{
						// ReOpen Work Order
						tblMain.Rows[3].Visible = false;
						tblMain.Rows[4].Visible = false;
						tblMain.Rows[6].Visible = false;
						tblMain.Rows[7].Visible = false;
					}
					else
					{
						tblMain.Rows[3].Visible = false;
						tblMain.Rows[4].Visible = false;
						tblMain.Rows[5].Visible = false;
						tblMain.Rows[6].Visible = false;
						tblMain.Rows[7].Visible = false;
					}
					btnCheckIn.Attributes.Add("onclick", "javascript:document.location='ok_selectEquipment.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString() + "&back=maindetails'");
					btnCheckOut.Attributes.Add("onclick", "javascript:document.location='ok_selectWorkOrder.aspx?id=" + OrderId.ToString() + "'");
					btnReOpen.Attributes.Add("onclick", "javascript:document.location='ok_reopenWorkOrder.aspx?id=" + OrderId.ToString() + "'");
					btnCheckOutSpare.Attributes.Add("onclick", "javascript:document.location='ok_selectSpareEquip.aspx?op=CheckOutSpare&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString() + "'");
					btnAddIssue.Attributes.Add("onclick","javascript:document.location='ok_addIssues.aspx?op=AddIssue&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString() + "'");
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = sBackURL;
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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

	}
}
