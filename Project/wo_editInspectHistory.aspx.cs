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
	public class _wo_editInspectHistory : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.Label lblInspectionName;
		protected System.Web.UI.WebControls.Label lblEquipName;
		protected System.Web.UI.WebControls.Button btnSave;
		protected ActiveUp.WebControls.ActiveDateTime adtLastTime;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
		protected System.Web.UI.WebControls.Label lblHeader;
		protected System.Web.UI.WebControls.Label lblError;
		protected System.Web.UI.WebControls.Label lblInspectSchedule;

		private clsWorkOrders order = null;
		
		private int OrderId;
		private int InspectSchedDetailId;
		private int HistoryId;
		public string sOnLoad = "";
		private string SourcePageName;
		private int OrgId;
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				SourcePageName = "wo_addPMHistoryforPMItem.aspx.cs";

				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				if(Request.QueryString["id"] == null || Request.QueryString["inspectid"] == null || Request.QueryString["historyid"] == null)
				{
					btnSave.Enabled = false;
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
					InspectSchedDetailId = Convert.ToInt32(Request.QueryString["inspectid"]);
					HistoryId = Convert.ToInt32(Request.QueryString["historyid"]);
				}
				catch(FormatException fex)
				{
					btnSave.Enabled = false;
					return;
				}

				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					order.iInspectSchedDetailId = InspectSchedDetailId;
					order.iInspectHistoryId = HistoryId;
					if(order.InspectHistoryDetail() != -1)
					{
						ViewState["EquipId"] = order.iEquipId.Value;
						lblEquipName.Text = order.sEquipId.Value;
						lblInspectionName.Text = order.sInspectionName.Value;
						lblInspectSchedule.Text = order.sInspectSchedule.Value;
						if(HistoryId != 0)
						{
							adtLastTime.Date = order.daDateHistory.Value;
							lblHeader.Text = "Edit Date of Last Inspection";
						}
						else
						{
							adtLastTime.Date = DateTime.Now;
							lblHeader.Text = "Add Date of Last Inspection";
						}
						ViewState["Date"] = adtLastTime.Date;
					}
					else
					{
						btnSave.Enabled = false;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
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
		}
		
		private void InitializeComponent()
		{    
			this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnSave_Click(object sender, System.EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.cAction = "U";
				if(((DateTime)ViewState["Date"]).CompareTo(adtLastTime.Date) <= 0)
				{
					lblError.Text = "The date cannot more then " + ((DateTime)ViewState["Date"]).ToShortDateString();
				}
				else
				{
					order.iInspectHistoryId = HistoryId;
					order.iOrgId = OrgId;
					order.iInspectSchedDetailId = InspectSchedDetailId;
					order.iId = OrderId;
					order.iEquipId = (Int32)ViewState["EquipId"];
					order.daDateHistory = adtLastTime.Date;
					if(order.InspectHistoryDetail() != -1)
					{
						// closing the current window and reloading the parent window
						sOnLoad = "window.close();opener.document.formSelectInspect.submit();";
						Session["reload"] = true;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
			finally
			{
				if(order != null)
					order.Dispose();
			}
		}
	}
}
