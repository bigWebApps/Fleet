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

	public class _wo_addPreventiveMaintenance : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected Micajah.DataGrid.DataGrid_A dgPMServices;
		protected System.Web.UI.WebControls.Label lblCurrentUnits;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
		protected Micajah.DataGrid.DataGrid_A dgFuturePMItems;

		private clsWorkOrders order = null;
		
		private DataTable dtPMServices = null;
		private DataTable dtFuturePMService = null;
		
		private int OrderId;
		private string m_sCurrentUrl;
		private string m_sMainBackUrl;
		private string m_sNextUrl;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_addPreventiveMaintenance.aspx.cs";

				Header.AddJavaScriptFile("/OpenWindows.js");
				this.PageTitle = "Select the Preventive Maintenance Items";
				Header.LeftBarHtml = "Add/Delete the PM Items to/from Work Order";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			string sBack;
			bool bBack = false;

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

				if(Request.QueryString["back"] != null)
				{
					// see whence came user
					switch(Request.QueryString["back"])
					{
						case "view": // from the work order detail screen
							m_sCurrentUrl = "wo_addPreventiveMaintenance.aspx?id=" + OrderId.ToString() + "&back=view";
							m_sMainBackUrl = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
							m_sNextUrl = m_sMainBackUrl;

							tblMain.Rows[4].Visible = false;
							tblMain.Rows[5].Visible = true;
					
							// getting the Bread Crumbs from Cookie and add last item
                            if (Request.Cookies.Count > 0 && Request.Cookies["bfp_navigate"] != null)
                                Header.BrdCrumbsSerialization = Request.Cookies["bfp_navigate"].Value;
                            Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "&#Issues");

							SaveCancelControl.ParentPageURL = ParentPageURL;
							SaveCancelControl.ButtonText = " Save ";
							
							bBack = false;
							break;
						case "inspect": // from the Add Inpection screen
							m_sCurrentUrl = "wo_addPreventiveMaintenance.aspx?id=" + OrderId.ToString() + "&back=inspect";
							m_sMainBackUrl = "wo_addInspections.aspx?id=" + OrderId.ToString();
							m_sNextUrl = "wo_addRepairs.aspx?id=" + OrderId.ToString() + "&back=open";

							bBack = true;
							break;
						case "preview": // from the Preview screen
							m_sCurrentUrl = "wo_addPreventiveMaintenance.aspx?id=" + OrderId.ToString() + "&back=preview";
							m_sMainBackUrl = "wo_preview.aspx?id=" + OrderId.ToString();
							m_sNextUrl = "wo_preview.aspx?id=" + OrderId.ToString();

							bBack = true;
							break;
						default: // from the Add Issues screen
							m_sCurrentUrl = "wo_addPreventiveMaintenance.aspx?id=" + OrderId.ToString();
							m_sMainBackUrl = "wo_addRepairs.aspx?id=" + OrderId.ToString() + "&back=open";
							m_sNextUrl = "wo_addInspections.aspx?id=" + OrderId.ToString();

							bBack = true;
							break;
					}
				}
				else
				{
					m_sCurrentUrl = "wo_addPreventiveMaintenance.aspx?id=" + OrderId.ToString();
					m_sMainBackUrl = "wo_addRepairs.aspx?id=" + OrderId.ToString() + "&back=open";
					m_sNextUrl = "wo_addInspections.aspx?id=" + OrderId.ToString();
					bBack = true;
				}
				// if previos screen was from wizard screen then
				if(bBack)
				{
					tblMain.Rows[4].Visible = true;
					tblMain.Rows[5].Visible = false;
					
//					Header.PageTitle = PageTitle;
					
					NextBackControl.BackPage = "wo_addRepairs.aspx?id=" + OrderId.ToString() + "&back=open";
				}

				// reloading if coming from the PM Item History screen	
				if(Session["reload"] != null)
				{
					if((bool)Session["reload"] == true)
					{
						Session["reload"] = null;
						Response.Redirect(m_sCurrentUrl, false);
						return;
					}
				}

				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					dtPMServices = order.GetPMServicesListForWorkOrder();
					if(dtPMServices.Rows.Count > 0)
					{
						lblCurrentUnits.Text = "The current units for this Equipment is <b>" + 
							(order.dmMileage.IsNull?"Unknown":Convert.ToDouble(order.dmMileage.Value).ToString()) + 
							"</b>, date is <b>" + (order.daReportDate.IsNull?DateTime.Now.ToString("MM/dd/yyyy"):order.daReportDate.Value.ToString("MM/dd/yyyy")) + "</b>";
						dgPMServices.DataSource = new DataView(dtPMServices);
						dgPMServices.DataBind();

						dtFuturePMService = order.GetFuturePMItems();
						if(dtFuturePMService.Rows.Count > 0)
						{
							dgFuturePMItems.DataSource = new DataView(dtFuturePMService);
							dgFuturePMItems.DataBind();
						}
						else
						{
							tblMain.Rows[2].Visible = false;
							tblMain.Rows[3].Visible = false;
						}
					}
					else
					{
						Response.Redirect(m_sNextUrl, false);
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sMainBackUrl;
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

		#region The adding/deleting operations on PM Items
		/// <summary>
		/// Procedure is processing  the PM Items on screen, i.e. to add or delete 
		/// if them check boxes was selected/unselected
		/// </summary>
		private void ProcessingItems()
		{
			try
			{
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;

				foreach(DataGridItem item in dgPMServices.Items)
				{
					order.iPMItemId = Convert.ToInt32(item.Cells[2].Text);;
					order.iSchedDetailId = Convert.ToInt32(item.Cells[0].Text);
					order.bChecked = ((CheckBox)item.FindControl("chAdd")).Checked;
					order.UpdatePMItem();						
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
				Response.Redirect("wo_addInspections.aspx?id=" + OrderId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sCurrentUrl;
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

		#region Save PM Items
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
				Session["lastpage"] = m_sCurrentUrl;
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
			this.dgFuturePMItems.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgFuturePMItems_ItemCommand);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Assign the future PM Item to current work order
		private void dgFuturePMItems_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				int FutureOrderId;
				if(e.CommandName == "Assign")
				{
					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iPMItemId = Convert.ToInt32(e.Item.Cells[0].Text);
					// getting the undone repair information
					if(order.WorkOrderPMItemsDetail() == -1)
					{
						Session["lastpage"] = m_sCurrentUrl;
						Session["error"] = _functions.ErrorMessage(123);
						Response.Redirect("error.aspx", false);
					}
					FutureOrderId = order.iId.Value;
					// updating the old undone repair
					order.cAction = "U";
					order.iId = OrderId;
					order.iServiceResultId = SqlInt32.Null;
					order.iServiceCheckId = SqlInt32.Null;
					order.iRepairMultId = SqlInt32.Null;
					if(order.WorkOrderPMItemsDetail() == -1)
					{
						Session["lastpage"] = m_sCurrentUrl;
						Session["error"] = _functions.ErrorMessage(123);
						Response.Redirect("error.aspx", false);
					}
					// check future work order 
					// if it is empty then to delete it
					order.iId = FutureOrderId;
					if(order.DeleteFutureWorkOrder() == -1)
					{
						Session["lastpage"] = m_sCurrentUrl;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
					}

					// show updated PM Items
					order.iId = OrderId;
					dtPMServices = order.GetPMServicesListForWorkOrder();
					dgPMServices.DataSource = new DataView(dtPMServices);
					dgPMServices.DataBind();

					dtFuturePMService = order.GetFuturePMItems();
					if(dtFuturePMService.Rows.Count > 0)
					{
						dgFuturePMItems.DataSource = new DataView(dtFuturePMService);
						dgFuturePMItems.DataBind();
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
				Session["lastpage"] = m_sCurrentUrl;
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
