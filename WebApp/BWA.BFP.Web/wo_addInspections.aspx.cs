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
	public class _wo_addInspections : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgInspections;
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
		protected Micajah.DataGrid.DataGrid_A dgFutureInspections;
		
		private int OrderId;
		
		private clsWorkOrders order = null;

		private DataTable dtFutureInspections = null;

		private string m_sBackUrl;
		private string m_sLastPage;

		private bool IsPast = false;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_addInspections.aspx.cs";

				this.PageTitle = "Select Inspections";
				Header.LeftBarHtml = "Add/Delete Inspection to/from Work Order";
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
					Session["lastpage"] = "wo_default.aspx";
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
					Session["lastpage"] = "wo_default.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				Header.AddJavaScriptFile("/OpenWindows.js");

				// if the coming was from order detail screen or for the past work order creating
				if(Request.QueryString["back"] != null)
				{
					if(Request.QueryString["back"] == "past")
					{
						IsPast = true;

						tblMain.Rows[4].Visible = true;
						tblMain.Rows[5].Visible = false;

						m_sBackUrl = "wo_addInspections.aspx?back=past&id=" + OrderId.ToString();
						m_sLastPage = "wo_editAddInfo.aspx?back=past&id=" + OrderId.ToString() + "&equipid=0";

						NextBackControl.BackPage = m_sLastPage;

					}
					else
					{
						tblMain.Rows[4].Visible = false;
						tblMain.Rows[5].Visible = true;

						m_sBackUrl = "wo_addInspections.aspx?id=" + OrderId.ToString() + "&back=view";
						m_sLastPage = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
					
						// getting the Bread Crumbs from Cookie and add last item
                        if (Request.Cookies.Count > 0 && Request.Cookies["bfp_navigate"] != null)
						    Header.BrdCrumbsSerialization = Request.Cookies["bfp_navigate"].Value;
						Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "&#Issues");

						SaveCancelControl.ParentPageURL = this.ParentPageURL;
						SaveCancelControl.ButtonText = " Save ";
					}
				}
				else
				{ // the coming was usual from previous wizard screen is the Add Preventive Maintenance
					tblMain.Rows[4].Visible = true;
					tblMain.Rows[5].Visible = false;

					m_sBackUrl = "wo_addInspections.aspx?id=" + OrderId.ToString();
					m_sLastPage = "wo_addPreventiveMaintenance.aspx?id=" + OrderId.ToString() + "&back=inspect";

					NextBackControl.BackPage = "wo_addPreventiveMaintenance.aspx?id=" + OrderId.ToString() + "&back=inspect";
				}

				// reloading if coming from the Inspection History screen
				if(Session["reload"] != null)
				{
					if((bool)Session["reload"] == true)
					{
						Session["reload"] = null;
						Response.Redirect(m_sBackUrl, false);
						return;
					}
				}

				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					if(order.GetWorkOrderId() == -1)
					{
						Session["lastpage"] = m_sLastPage;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
					}
					ViewState["WorkOrderCreatedDate"] = order.daCreated.Value;
					ViewState["WorkOrderNumber"] = order.iWorkOrderNumber.Value;
					if(IsPast)
						order.daCurrentDate = order.daCreated;
					else
						order.daCurrentDate = DateTime.Now;
					dgInspections.DataSource = new DataView(order.GetInspectionsListForWorkOrder());
					dgInspections.DataBind();
					dtFutureInspections = order.GetFutureInspections();
					if(dtFutureInspections.Rows.Count > 0)
					{
						dgFutureInspections.DataSource = new DataView(dtFutureInspections);
						dgFutureInspections.DataBind();
					}
					else
					{
						tblMain.Rows[2].Visible = false;
						tblMain.Rows[3].Visible = false;
					}
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

		#region The adding/deleting operations on Inspections
		/// <summary>
		/// Procedure is processing the inspections on screen, i.e. to add or delete 
		/// if them check boxes was selected/unselected
		/// </summary>
		private void ProcessingItems()
		{
			try
			{
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				foreach(DataGridItem item in dgInspections.Items)
				{
					if(((CheckBox)item.FindControl("chAdd")).Enabled)
					{
						if(IsPast)
							order.daCurrentDate = ((DateTime)ViewState["WorkOrderCreatedDate"]);
						else
							order.daCurrentDate = DateTime.Now;
						order.iInspectSchedDetailId = Convert.ToInt32(item.Cells[0].Text);
						order.iWOInspectionId = Convert.ToInt32(item.Cells[1].Text);
						order.bChecked = ((CheckBox)item.FindControl("chAdd")).Checked;
						order.UpdateInspection();
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
				
		#region Next Screen
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				ProcessingItems();
				if(IsPast)
				{
					BackFinishScreen finish = new BackFinishScreen();
					
					finish.sMainText = "The Past Work Order " + ((DateTime)ViewState["WorkOrderCreatedDate"]).ToString("yyyy-MM-dd") + "-" + ViewState["WorkOrderNumber"].ToString() + " has been created successfully.";
					
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
				else
					Response.Redirect("wo_preview.aspx?id=" + OrderId.ToString(), false);
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

		#region Save Inspection
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				ProcessingItems();
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
			this.dgFutureInspections.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgFutureInspections_ItemCommand);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Assign the future Inspections to current work order
		private void dgFutureInspections_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				int FutureOrderId;
				if(e.CommandName == "Assign")
				{
					order = new clsWorkOrders();
					order.iId = OrderId;
					order.iOrgId = OrgId;
					order.iWOInspectionId = Convert.ToInt32(e.Item.Cells[0].Text);
					// move inspection from future work order
					if(order.SetFutureInspection() == -1)
					{
						Session["lastpage"] = m_sBackUrl;
						Session["error"] = _functions.ErrorMessage(124);
						Response.Redirect("error.aspx", false);
					}
					// delete future empty work order
					if(order.DeleteFutureWorkOrder() == -1)
					{
						Session["lastpage"] = m_sBackUrl;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
					}
					order.iId = OrderId;
					dgInspections.DataSource = new DataView(order.GetInspectionsListForWorkOrder());
					dgInspections.DataBind();
					dtFutureInspections = order.GetFutureInspections();
					if(dtFutureInspections.Rows.Count > 0)
					{
						dgFutureInspections.DataSource = new DataView(dtFutureInspections);
						dgFutureInspections.DataBind();
					}
					else
					{
						tblMain.Rows[2].Visible = false;
						tblMain.Rows[3].Visible = false;
					}
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
