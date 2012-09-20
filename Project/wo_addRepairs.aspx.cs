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
	public class _wo_addRepairs : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgRepairs;
		protected System.Web.UI.WebControls.Button btnAddRepair;
		protected System.Web.UI.WebControls.DropDownList ddlCategory;
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected Micajah.DataGrid.DataGrid_A dgPreviousRepairs;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvDesc;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvCategory;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.TextBox tbDescPrevious;
		protected System.Web.UI.WebControls.TextBox tbDescMain;
		protected System.Web.UI.WebControls.TextBox tbDesc;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
		protected Micajah.DataGrid.DataGrid_A dgFutureIssues;

		private clsWorkOrders order = null;

		private DataTable dtCategory = null;
		private DataSet dsRepairs = null;
		
		private int OrderId;
		
		private string m_sBack;
		private string m_sBackUrl;
		private string m_sLastPage;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_addRepairs.aspx.cs";

				this.PageTitle = "Add Reported Issues";
				Header.LeftBarHtml = "Add/Edit/Remove the Reported Issues of Work Order";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			string [,] arrBrdCrumbs;
			
			try
			{
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "wo_default.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
					OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "wo_default.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				// if the coming was from order detail screen 
				m_sBack = Request.QueryString["back"];

				switch(m_sBack)
				{
					case "view": // from View Work Order Detial screen
						m_sBackUrl = "wo_addRepairs.aspx?id=" + OrderId.ToString() + "&back=view";
						m_sLastPage = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "&#Issues";

						tblMain.Rows[9].Visible = false;
						tblMain.Rows[10].Visible = true;
					
						// getting the Bread Crumbs from Cookie and add last item
                        if (Request.Cookies.Count > 0 && Request.Cookies["bfp_navigate"] != null)
                            Header.BrdCrumbsSerialization = Request.Cookies["bfp_navigate"].Value;
                        Header.AddBreadCrumb("Work Order Detail", "/" + m_sLastPage);

						SaveCancelControl.CausesValidation = false;
						SaveCancelControl.ParentPageURL = ParentPageURL;
						SaveCancelControl.ButtonText = " Save ";
						break;
					case "open": // from Open Work Order screen
						m_sBackUrl = "wo_addRepairs.aspx?id=" + OrderId.ToString() + "&back=open";
						m_sLastPage = "wo_openWorkOrder.aspx?id=" + OrderId.ToString();
					
						tblMain.Rows[9].Visible = true;
						tblMain.Rows[10].Visible = false;

						NextBackControl.BackPage = m_sLastPage;
						NextBackControl.BackVisible = true;
						NextBackControl.CausesValidation = false;
						break;
					case "past":
						m_sBackUrl = "wo_addRepairs.aspx?back=past&id=" + OrderId.ToString();
						m_sLastPage = "wo_editAddInfo.aspx?back=past&id=" + OrderId.ToString() + "&equipid=0";
					
						tblMain.Rows[9].Visible = true;
						tblMain.Rows[10].Visible = false;

						NextBackControl.BackPage = m_sLastPage;
						NextBackControl.BackVisible = true;
						NextBackControl.CausesValidation = false;						break;
					default:	// from Create Work Order screen
						m_sBackUrl = "wo_addRepairs.aspx?id=" + OrderId.ToString();
						m_sLastPage = "wo_editAddInfo.aspx?id=" + OrderId.ToString() + "&equipid=0";
					
						tblMain.Rows[9].Visible = true;
						tblMain.Rows[10].Visible = false;
						
						NextBackControl.BackPage = m_sLastPage;
						NextBackControl.BackVisible = true;
						NextBackControl.CausesValidation = false;
						break;
				}
				
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					dtCategory = order.GetCategoryList();
					ddlCategory.DataSource = new DataView(dtCategory);
					ddlCategory.DataBind();
					ddlCategory.Items.Insert(0, "");
					
					ShowIssues(OrderId);
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sLastPage;
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

		
		#region Showing Issues
		/// <summary>
		/// Showing all Issues in two tables for current equipment
		/// </summary>
		/// <param name="_orderId">Work Order Id</param>
		void ShowIssues(int _orderId)
		{
			try
			{
				order.iId = _orderId;
				dsRepairs = order.GetReportedIssueLists();
				if(dsRepairs.Tables[0].Rows.Count > 0)
				{
					tblMain.Rows[0].Visible = true;
					tblMain.Rows[1].Visible = true;
					dgRepairs.DataSource = new DataView(dsRepairs.Tables[0]);
					dgRepairs.DataBind();
				}
				else
				{
					tblMain.Rows[0].Visible = false;
					tblMain.Rows[1].Visible = false;
				}
				if(dsRepairs.Tables[1].Rows.Count > 0)
				{
					tblMain.Rows[2].Visible = true;
					tblMain.Rows[3].Visible = true;
					lblEquipId.Text = order.sEquipId.IsNull?"none":order.sEquipId.Value;
					dgPreviousRepairs.DataSource = new DataView(dsRepairs.Tables[1]);
					dgPreviousRepairs.DataBind();
				}
				else
				{
					tblMain.Rows[2].Visible = false;
					tblMain.Rows[3].Visible = false;
				}
				if(dsRepairs.Tables[2].Rows.Count > 0)
				{
					tblMain.Rows[4].Visible = true;
					tblMain.Rows[5].Visible = true;
					dgFutureIssues.DataSource = new DataView(dsRepairs.Tables[2]);
					dgFutureIssues.DataBind();
				}
				else
				{
					tblMain.Rows[4].Visible = false;
					tblMain.Rows[5].Visible = false;
				}
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}
		
		#endregion
		
		#region Next Screen
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
					
				if(ddlCategory.SelectedIndex != 0 && tbDesc.Text.Length != 0)
				{
					order.cAction = "U";
					order.iOrgId = OrgId;
					order.iReportedIssueId = 0;
					order.iRepairCatId = Convert.ToInt32(ddlCategory.SelectedValue);
					order.sReportDesc = tbDesc.Text;
					order.iId = OrderId;
					order.iServiceResultId = SqlInt32.Null;
					order.iServiceCheckId = SqlInt32.Null;
					order.iRepairMultId = SqlInt32.Null;
					if(order.WorkOrderReportedIssuesDetail() == -1)
					{
						Session["lastpage"] = m_sBackUrl;
						Session["error"] = _functions.ErrorMessage(121);
						Response.Redirect("error.aspx", false);
						return;
					}
				}
				if(m_sBack == "open")
					Response.Redirect("wo_addPreventiveMaintenance.aspx?id=" + OrderId.ToString(), false);
				else
				{ 
					// redirect to finish screen
					order.iOrgId = OrgId;
					order.iId = OrderId;

					if(order.GetWorkOrderId() == -1)
					{
						Session["lastpage"] = m_sBackUrl;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					
					BackFinishScreen finish = new BackFinishScreen();
					finish.sMainText = "The Work Order " + order.daCreated.Value.ToString("yyyy-MM-dd") + "-" + order.iWorkOrderNumber.Value.ToString() + " has been created successfully!";
					
					finish.bMainMenuVisible = true;
					finish.sMainMenuText = "[Return to Main Menu]";
					finish.sMainMenuURL = "main.aspx";

					finish.bContinueVisible = true;
					finish.sContinueText = "[Continue to Check-In Equipment by Technician]";
					finish.sContinueURL = "wo_viewCheckIn.aspx?id=" + OrderId.ToString();

					finish.bViewVisible = true;
					finish.sViewText = "[View the Scheduled Work Order]";
					finish.sViewURL = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();

					finish.bAdditionalVisible = true;
					finish.sAdditionalText = "[Create a New Work Order]";
					finish.sAdditionalURL = "wo_default.aspx";

					finish.bPrintVisible = false;

					Session["BackFinish"] = finish;

					Response.Redirect("wo_finish.aspx", false);	
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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

		#region Save Issues
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				if(ddlCategory.SelectedIndex != 0 && tbDesc.Text.Length != 0)
				{
					order = new clsWorkOrders();
					order.cAction = "U";
					order.iOrgId = OrgId;
					order.iReportedIssueId = 0;
					order.iRepairCatId = Convert.ToInt32(ddlCategory.SelectedValue);
					order.sReportDesc = tbDesc.Text;
					order.iId = OrderId;
					order.iServiceResultId = SqlInt32.Null;
					order.iServiceCheckId = SqlInt32.Null;
					order.iRepairMultId = SqlInt32.Null;
					if(order.WorkOrderReportedIssuesDetail() == -1)
					{
						Session["lastpage"] = m_sBackUrl;
						Session["error"] = _functions.ErrorMessage(121);
						Response.Redirect("error.aspx", false);
						return;
					}
				}
				Response.Redirect("wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "&#Issues", false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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
			this.SaveCancelControl.BubbleClick += new EventHandler(this.btSave_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.dgRepairs.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgRepairs_ItemCommand);
			this.dgRepairs.EditCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgRepairs_EditCommand);
			this.dgRepairs.CancelCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgRepairs_CancelCommand);
			this.dgRepairs.UpdateCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgRepairs_UpdateCommand);
			this.dgPreviousRepairs.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPreviousRepairs_ItemCommand);
			this.dgPreviousRepairs.EditCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPreviousRepairs_EditCommand);
			this.dgPreviousRepairs.CancelCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPreviousRepairs_CancelCommand);
			this.dgPreviousRepairs.UpdateCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgPreviousRepairs_UpdateCommand);
			this.dgFutureIssues.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgFutureIssues_ItemCommand);
			this.btnAddRepair.Click += new System.EventHandler(this.btnAddRepair_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Processing the Previous Issues table
		private void dgPreviousRepairs_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				if(e.CommandName == "Assign")
				{
					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iReportedIssueId = Convert.ToInt32(e.Item.Cells[1].Text);
					// getting the undone repair information
					if(order.WorkOrderReportedIssuesDetail() == -1)
					{
						Session["lastpage"] = m_sBackUrl;
						Session["error"] = _functions.ErrorMessage(121);
						Response.Redirect("error.aspx", false);
					}
					// updating the old undone repair
					order.cAction = "U";
					order.iId = OrderId;
					order.iServiceResultId = SqlInt32.Null;
					//order.iServiceCheckId = SqlInt32.Null;
					order.iRepairMultId = SqlInt32.Null;
					if(order.WorkOrderReportedIssuesDetail() == -1)
					{
						Session["lastpage"] = m_sBackUrl;
						Session["error"] = _functions.ErrorMessage(121);
						Response.Redirect("error.aspx", false);
					}
					// assigning the undone repair in the new (current) work order
					// creating the new repair 
					ShowIssues(OrderId);					
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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
		private void dgPreviousRepairs_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgPreviousRepairs.EditItemIndex = -1;
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				ShowIssues(OrderId);	
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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

		private void dgPreviousRepairs_EditCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgPreviousRepairs.EditItemIndex = e.Item.ItemIndex;
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				ShowIssues(OrderId);	
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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

		private void dgPreviousRepairs_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.cAction = "S";
				order.iOrgId = OrgId;
				order.iReportedIssueId = Convert.ToInt32(((Label)e.Item.FindControl("lblReportIssueId2")).Text);
				if(order.WorkOrderReportedIssuesDetail() == -1)
				{
					Session["lastpage"] = m_sBackUrl;
					Session["error"] = _functions.ErrorMessage(121);
					Response.Redirect("error.aspx", false);
				}
				order.cAction = "U";
				order.sReportDesc = ((TextBox)e.Item.FindControl("tbDescPrevious")).Text;
				if(order.WorkOrderReportedIssuesDetail() == -1)
				{
					Session["lastpage"] = m_sBackUrl;
					Session["error"] = _functions.ErrorMessage(121);
					Response.Redirect("error.aspx", false);
				}
				dgPreviousRepairs.EditItemIndex = -1;
				ShowIssues(OrderId);	
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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

		#region Processing the Assigned Issues table
		private void dgRepairs_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				switch(e.CommandName)
				{
					case "Unassign":
						order = new clsWorkOrders();
						order.cAction = "S";
						order.iOrgId = OrgId;
						order.iReportedIssueId = Convert.ToInt32(e.Item.Cells[0].Text);
						if(order.WorkOrderReportedIssuesDetail() == -1)
						{
							Session["lastpage"] = m_sBackUrl;
							Session["error"] = _functions.ErrorMessage(121);
							Response.Redirect("error.aspx", false);
							return;
						}
						order.cAction = "U";
						order.iLastWorkOrderId = order.iId;
						order.iId = SqlInt32.Null;
						order.WorkOrderReportedIssuesDetail();
						ShowIssues(OrderId);
						break;
					case "Delete":
						order = new clsWorkOrders();
						order.cAction = "D";
						order.iOrgId = OrgId;
						order.iReportedIssueId = Convert.ToInt32(e.Item.Cells[0].Text);
						if(order.WorkOrderReportedIssuesDetail() == -1)
						{
							Session["lastpage"] = m_sBackUrl;
							Session["error"] = _functions.ErrorMessage(121);
							Response.Redirect("error.aspx", false);
							return;
						}
						ShowIssues(OrderId);
						break;
					default:
						break;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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
		private void dgRepairs_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgRepairs.EditItemIndex = -1;
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				ShowIssues(OrderId);	
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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

		private void dgRepairs_EditCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				dgRepairs.EditItemIndex = e.Item.ItemIndex;
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				ShowIssues(OrderId);	
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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

		private void dgRepairs_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.cAction = "S";
				order.iOrgId = OrgId;
				order.iReportedIssueId = Convert.ToInt32(((Label)e.Item.FindControl("lblReportIssueId")).Text);
				if(order.WorkOrderReportedIssuesDetail() == -1)
				{
					Session["lastpage"] = m_sBackUrl;
					Session["error"] = _functions.ErrorMessage(121);
					Response.Redirect("error.aspx", false);
					return;
				}
				order.cAction = "U";
				order.sReportDesc = ((TextBox)e.Item.FindControl("tbDescMain")).Text;
				if(order.WorkOrderReportedIssuesDetail() == -1)
				{
					Session["lastpage"] = m_sBackUrl;
					Session["error"] = _functions.ErrorMessage(121);
					Response.Redirect("error.aspx", false);
					return;
				}
				dgRepairs.EditItemIndex = -1;
				ShowIssues(OrderId);	
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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

		#region Adding and Assigning the Issues
		private void btnAddRepair_Click(object sender, System.EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.cAction = "U";
				order.iOrgId = OrgId;
				order.iReportedIssueId = 0;
				order.iRepairCatId = Convert.ToInt32(ddlCategory.SelectedValue);
				order.sReportDesc = tbDesc.Text;
				order.iId = OrderId;
				order.iServiceResultId = SqlInt32.Null;
				order.iServiceCheckId = SqlInt32.Null;
				order.iRepairMultId = SqlInt32.Null;
				if(order.WorkOrderReportedIssuesDetail() == -1)
				{
					Session["lastpage"] = m_sBackUrl;
					Session["error"] = _functions.ErrorMessage(121);
					Response.Redirect("error.aspx", false);
				}
				tbDesc.Text = "";
				ddlCategory.SelectedIndex = 0;
				ShowIssues(OrderId);	
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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

		#region Processing the Future Issues tabel
		private void dgFutureIssues_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				int FutureOrderId;

				if(e.CommandName == "Assign")
				{
					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iReportedIssueId = Convert.ToInt32(e.Item.Cells[0].Text);
					// getting the undone repair information
					if(order.WorkOrderReportedIssuesDetail() == -1)
					{
						Session["lastpage"] = m_sBackUrl;
						Session["error"] = _functions.ErrorMessage(121);
						Response.Redirect("error.aspx", false);
					}
					FutureOrderId = order.iId.Value;
					// updating the old undone repair
					order.cAction = "U";
					order.iId = OrderId;
					order.iServiceResultId = SqlInt32.Null;
					order.iServiceCheckId = SqlInt32.Null;
					order.iRepairMultId = SqlInt32.Null;
					if(order.WorkOrderReportedIssuesDetail() == -1)
					{
						Session["lastpage"] = m_sBackUrl;
						Session["error"] = _functions.ErrorMessage(121);
						Response.Redirect("error.aspx", false);
					}
					// check future work order 
					// if it is empty then to delete it
					order.iId = FutureOrderId;
					if(order.DeleteFutureWorkOrder() == -1)
					{
						Session["lastpage"] = m_sBackUrl;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
					}
					ShowIssues(OrderId);					
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBackUrl;
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
	}
}
