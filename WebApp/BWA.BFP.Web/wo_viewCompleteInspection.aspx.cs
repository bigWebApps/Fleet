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
	public class _wo_viewCompleteInspection : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Label lblInspectName;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Label lblEquipMake;
		protected System.Web.UI.WebControls.Label lblEquipModel;
		protected System.Web.UI.WebControls.TextBox tbPIN;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvPIN;
		protected System.Web.UI.WebControls.RegularExpressionValidator revPIN;
		protected System.Web.UI.WebControls.TextBox tbInitial;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvInitials;
		protected System.Web.UI.WebControls.RegularExpressionValidator revInitials;
		protected System.Web.UI.HtmlControls.HtmlTable tableMain;
		protected System.Web.UI.WebControls.HyperLink hlPrintInspectRequest;
		protected System.Web.UI.WebControls.HyperLink hlPrintCompletedInstect;
		protected System.Web.UI.WebControls.Label lblSign;
		protected System.Web.UI.WebControls.Label lblSignDate;
		protected System.Web.UI.WebControls.Repeater repInspectItems;
		protected System.Web.UI.WebControls.LinkButton lbRepair;
		protected System.Web.UI.WebControls.ImageButton imgRepair;
		protected System.Web.UI.WebControls.Label lblInspectSchedule;
		protected System.Web.UI.WebControls.Label lblTargetDaysOut;
		protected System.Web.UI.WebControls.CheckBox cbAutoCreateWO;

		private clsWorkOrders order = null;
		private clsUsers user = null;

		private int InspectId;
		private int OrderId;
		private int ItemId;
		protected ActiveUp.WebControls.ActiveDateTime adtInspection;

		private DataView dwItems = null;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_viewCompleteInspection.aspx.cs";

				this.PageTitle = "Inspection Detail";
				Header.AddJavaScriptFile("/wo_viewCompleteInspection.js");

				Header.LeftBarHtml = "Check all Inspection Items";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			string sDomenName, sReportPath;
			try
			{
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
		
				if(Session["reload"] != null)
				{
					if((bool)Session["reload"] == true)
					{
						Session["reload"] = null;
						Response.Redirect((string)Session["RedirectPath"], false);
						Session["RedirectPath"] = null;
						return;
					}
				}

				if(Request.QueryString["id"] == null || Request.QueryString["inspectid"] == null)
				{
					Session["lastpage"] = "main.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
					InspectId = Convert.ToInt32(Request.QueryString["inspectid"]);
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

				SaveCancelControl.ParentPageURL = ParentPageURL;
				SaveCancelControl.EnableSave = true;
				SaveCancelControl.ButtonText = " Complete/Sign ";
				SaveCancelControl.CancelText = " Back ";
				
				if(!IsPostBack)
				{
					sReportPath = _functions.GetValueFromConfig("SQLRS.Folder");
					hlPrintInspectRequest.NavigateUrl = "ReportViewer.aspx?Report=" + sReportPath + "%2fInspectionRequest&OrgId=" + OrgId.ToString() + "&OrderId=" + OrderId.ToString() + "&InspectId=" + InspectId.ToString();
					hlPrintCompletedInstect.NavigateUrl = "ReportViewer.aspx?Report=" + sReportPath + "%2fCompletedInspection&OrgId=" + OrgId.ToString() + "&OrderId=" + OrderId.ToString() + "&InspectId=" + InspectId.ToString();
				
					user = new clsUsers();
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					order.iInspectionId = InspectId;
					order.iTechId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
					switch(order.GetInfoForInspection())
					{
						case 1:
							tableMain.Rows[19].Visible = false;
							tableMain.Rows[20].Visible = false;
							tableMain.Rows[21].Visible = false;
							tableMain.Rows[22].Visible = true;
							tableMain.Rows[23].Visible = true;
							tableMain.Rows[24].Visible = false;
							tableMain.Rows[25].Visible = false;
							SaveCancelControl.EnableSave = false;
							
							order.iDocumentId = InspectId;
							order.iDocumentTypeId = (int)DocumentTypes.InspectionCompleted;
							if(order.GetSignedDocument() != -1)
							{
								hlPrintInspectRequest.Enabled = false;
								hlPrintCompletedInstect.Enabled = true;
								lblSign.Text = order.sUserName.Value;
								lblSignDate.Text = order.daReportDate.Value.ToShortDateString() + " " + order.daReportDate.Value.ToShortTimeString();
							}
							else
							{
								hlPrintInspectRequest.Enabled = true;
								hlPrintCompletedInstect.Enabled = false;
								lblSign.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
							}
							break;
						case -1:
							Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
							Session["error"] = _functions.ErrorMessage(124);
							Response.Redirect("error.aspx", false);
							return;
						default:
							hlPrintCompletedInstect.Enabled = false;
							adtInspection.Date = DateTime.Now;
							tableMain.Rows[22].Visible = false;
							break;
					}
					if(!user.IsTechnician(_functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true)))
					{
						SaveCancelControl.EnableSave = false;
					}
					ViewState["EquipId"] = order.iEquipId.Value;
					ViewState["InspectSchedDetailId"] = order.iInspectSchedDetailId.Value;
					lblInspectName.Text = order.sInspectionName.Value;
					lblInspectSchedule.Text = order.sInspectSchedule.Value;
					lblTargetDaysOut.Text = order.iInspectTargetDays.Value.ToString() + " days";
					lblEquipId.Text = order.sEquipId.Value;
					lblEquipMake.Text = order.sEquipMake.Value;
					lblEquipModel.Text = order.sEquipModel.Value;

					repInspectItems.DataSource = new DataView(order.GetWorkOrderInspectItems());
					repInspectItems.DataBind();
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
				if(user != null)
					user.Dispose();
				if(order != null)
					order.Dispose();
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
			this.repInspectItems.ItemDataBound += new System.Web.UI.WebControls.RepeaterItemEventHandler(this.repInspectItems_ItemDataBound);
			this.repInspectItems.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repInspectItems_ItemCommand);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Sign the Inspection list
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			string sDomenName;
			int l_iResult;
					
			try
			{
				SaveChangedItems();

				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.iInspectionId = InspectId;
				order.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				order.iTechId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				order.sInitials = tbInitial.Text;
				order.sPIN = tbPIN.Text;
				order.daCurrentDate = _functions.CorrectDate(adtInspection.Date);
				switch(order.SigningInspectionList())
				{
					case 0:
						if(cbAutoCreateWO.Checked)
						{
							order.iInspectSchedDetailId = (int)ViewState["InspectSchedDetailId"];
							order.iEquipId = (int)ViewState["EquipId"];
							order.daCurrentDate = _functions.CorrectDate(adtInspection.Date);
							l_iResult = order.GetDateTimeOfForecastInspection();
							if(l_iResult == -1)
							{
								// error 
								Header.ErrorMessage = _functions.ErrorMessage(order.iErrorCode.Value); 
							}
							else
							{
								if(l_iResult == 2)
								{
									// sent email contain that inspection has been created but The Minimum through Maximum Date range is too small or the Holiday/No Service Date Ranges are too wide and the system is unable to identify any service dates available
								}  
								order.SetInspectWorkOrder();
								// redirect to the finish screen
								BackFinishScreen finish = new BackFinishScreen();
								if(l_iResult == 1)
									finish.sMainText = "The Inspection has been completed successfully. <br>" + _functions.ErrorMessage(order.iErrorCode.Value);
								else
									finish.sMainText = "The Inspection has been completed successfully. <br>Next Inspection has been scheduled by " + order.daScheduled.Value.ToString() + " of work order";

								finish.bMainMenuVisible = true;
								finish.sMainMenuText = "[Return to Main Menu]";
								finish.sMainMenuURL = "main.aspx";

								if(l_iResult == 1)
									finish.bContinueVisible = false;
								else
								{
									finish.bContinueVisible = true;
									finish.sContinueText = "[View the Work Order of Next Inspection]";
									finish.sContinueURL = "wo_viewWorkOrder.aspx?id=" +  order.iId.Value.ToString();
								}

								finish.bViewVisible = true;
								finish.sViewText = "[Return to Work Order Detail]";
								finish.sViewURL = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
					
								finish.bAdditionalVisible = false;
					
								finish.bPrintVisible = false;

								Session["BackFinish"] = finish;

								Response.Redirect("wo_finish.aspx", false);
							}
						}
						else
							Response.Redirect("wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "&#Issues", false);
						return;
					case -1:
						Header.ErrorMessage = _functions.ErrorMessage(140);
						break;
					case -2:
						Header.ErrorMessage = _functions.ErrorMessage(139);
						break;
					default:
						break;
				}
				repInspectItems.DataSource = new DataView(order.GetWorkOrderInspectItems());
				repInspectItems.DataBind();

			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_viewCompleteInspection.aspx?id=" + OrderId.ToString() + "&inspectid=" + InspectId.ToString();
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

		#region Save the selected inspection items
		/// <summary>
		/// The commmon procedure for saving of selected items
		/// </summary>
		private void SaveChangedItems()
		{
			try
			{
				int ServiceCheckId;
				int ServiceResultId;
				int newServiceCheckId = 0;
				int newServiceResultId = 0;
				int InspectItemId;
				bool bOkay, bFair, bRN, bNS, bRepair, bReplace;
				
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
					
				foreach(RepeaterItem item in repInspectItems.Items)
				{
					newServiceCheckId = 0;
					newServiceResultId = 0;

					// old data 
					ServiceCheckId = Convert.ToInt32(((Label)item.FindControl("ServiceCheckId")).Text);
					ServiceResultId = Convert.ToInt32(((Label)item.FindControl("ServiceResultId")).Text);
					InspectItemId = Convert.ToInt32(((LinkButton)item.FindControl("lbRepair")).CommandArgument);
					
					// new data
					bOkay = ((CheckBox)item.FindControl("_chOkay")).Checked;
					bFair = ((CheckBox)item.FindControl("_chFair")).Checked;
					bRN = ((CheckBox)item.FindControl("_chRNeeded")).Checked;
					bNS = ((CheckBox)item.FindControl("_cbNoService")).Checked;
					bRepair = ((CheckBox)item.FindControl("_cbRepaired")).Checked;
					bReplace = ((CheckBox)item.FindControl("_cbReplaced")).Checked;

					// comparing data
					if(bOkay)newServiceCheckId = (int)ServiceChecks._CheckOK;
					if(bFair)newServiceCheckId = (int)ServiceChecks._CheckFair;
					if(bRN)newServiceCheckId = (int)ServiceChecks._CheckRepairs_Needed;
					if(bNS)newServiceResultId = 0;
					if(bRepair)newServiceResultId = (int)ServiceResults._Repaired;
					if(bReplace)newServiceResultId = (int)ServiceResults._Replaced;

					if(ServiceCheckId == newServiceCheckId && ServiceResultId == newServiceResultId)
						;
					else
					{ // if the statuses were changed
						if(ServiceResultId > 0 && newServiceResultId > 0) 
							;
						else // if status wasn't changed to No Service
						{ 
							// to set the changes into database
							order.iInspectItemId = InspectItemId;
							order.iServiceResultId = ServiceResultId;
							if(newServiceCheckId == 0)
								order.iServiceCheckId = SqlInt32.Null;
							else
								order.iServiceCheckId = newServiceCheckId;
							if(order.SetInspectItemChecks() == -1)
							{
								Session["lastpage"] = "wo_viewCompleteInspection.aspx?id=" + OrderId.ToString() + "&inspectid=" + InspectId.ToString();
								Session["error"] = _functions.ErrorMessage(121);
								Response.Redirect("error.aspx", false);
								return;
							}
						}
					}
				}

			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally
			{
				if(order != null)
					order.Dispose();
			}
		}
		#endregion

		private void repInspectItems_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			try
			{
				int InspectItemId;

				if(e.CommandName == "SetRepairStatus" || e.CommandName == "SetReplaceStatus")
				{
					SaveChangedItems();

					InspectItemId = Convert.ToInt32(e.CommandArgument.ToString());
					if(e.CommandName == "SetRepairStatus")
						Response.Redirect("wo_updateRepair.aspx?mode=Add&repairid=0&inspectid=" + InspectId.ToString() + "&type=II&op=Repair&id=" + OrderId.ToString() + "&itemid=" + InspectItemId.ToString(), false);
					else
						Response.Redirect("wo_updateRepair.aspx?mode=Add&repairid=0&inspectid=" + InspectId.ToString() + "&type=II&op=Replace&id=" + OrderId.ToString() + "&itemid=" + InspectItemId.ToString(), false);
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_viewCompleteInspection.aspx?id=" + OrderId.ToString() + "&inspectid=" + InspectId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

		private void repInspectItems_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
		{
			try
			{
				if ((e.Item.ItemType == ListItemType.Pager) ||
					(e.Item.ItemType == ListItemType.Header) ||
					(e.Item.ItemType == ListItemType.Footer))
				{
					return;
				}
				LinkButton btnRepair = (LinkButton)e.Item.FindControl("lbRepair");
				LinkButton btnReplace = (LinkButton)e.Item.FindControl("lbReplace");
				btnRepair.Attributes["onclick"] = this.GetPostBackClientHyperlink(btnRepair, "");
				btnReplace.Attributes["onclick"] = this.GetPostBackClientHyperlink(btnReplace, "");
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_viewCompleteInspection.aspx?id=" + OrderId.ToString() + "&inspectid=" + InspectId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

	}
}
