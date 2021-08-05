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
	public class _wo_addPMHistoryforPMItem : System.Web.UI.Page
	{
		protected ActiveUp.WebControls.ActiveDateTime adtLastTime;
		protected System.Web.UI.WebControls.Label lblServiceName;
		protected System.Web.UI.WebControls.Label lblEquipName;
		protected System.Web.UI.WebControls.TextBox tbUnits;
		protected System.Web.UI.WebControls.Button btnSave;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvUnits;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
		protected System.Web.UI.WebControls.RegularExpressionValidator revUnits;
		protected System.Web.UI.WebControls.RangeValidator valRangeUnits;
		protected System.Web.UI.WebControls.Label lblError;
		protected System.Web.UI.HtmlControls.HtmlForm Form1;
		protected System.Web.UI.WebControls.Label lblCategory;

		private clsWorkOrders order = null;

		private int OrderId;
		private int SchedDetailId;
		private int HistoryId;
		public string sOnLoad = "";
		private string SourcePageName;
		private int OrgId;

		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				SourcePageName = "wo_addPMHistoryforPMItem.aspx.cs";
				
				if(Request.QueryString["id"] == null || Request.QueryString["scheddetailsid"] == null || Request.QueryString["historyid"] == null)
				{
					btnSave.Enabled = false;
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
					SchedDetailId = Convert.ToInt32(Request.QueryString["scheddetailsid"]);
					HistoryId = Convert.ToInt32(Request.QueryString["historyid"]);
					OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
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
					order.iSchedDetailId = SchedDetailId;
					order.iPMHistoryId = HistoryId;
					if(order.PMHistoryDetail() != -1)
					{
						ViewState["EquipId"] = order.iEquipId.Value;
						lblEquipName.Text = order.sEquipId.Value;
						lblServiceName.Text = order.sServiceName.Value;
						lblCategory.Text = order.sRepairCatName.Value;
						if(HistoryId != 0)
						{
							tbUnits.Text = order.dmUnitsHistory.Value.ToString();
							adtLastTime.Date = order.daDateHistory.Value;
						}
						else
						{
							tbUnits.Text = "";
							adtLastTime.Date = DateTime.Now;
						}
						
						switch(order.iPMStatus.Value)
						{
							case 0:
								btnSave.Enabled = false;
								tblMain.Rows[4].Visible = false;
								tblMain.Rows[5].Visible = false;
								break;
							case 1: // days
								tblMain.Rows[4].Visible = true;
								tblMain.Rows[5].Visible = false;
								break;
							case 2: // units
								tblMain.Rows[4].Visible = false;
								tblMain.Rows[5].Visible = true;
								break;
							case 3: // both
								tblMain.Rows[4].Visible = true;
								tblMain.Rows[5].Visible = true;
								break;
							default:
								btnSave.Enabled = false;
								tblMain.Rows[4].Visible = false;
								tblMain.Rows[5].Visible = false;
								break;
						}
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

		/// <summary>
		/// Saving the history for current PM item
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btnSave_Click(object sender, System.EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.cAction = "U";
				order.iPMHistoryId = HistoryId;
				order.iOrgId = OrgId;
				order.iSchedDetailId = SchedDetailId;
				order.iId = OrderId;
				order.iEquipId = (Int32)ViewState["EquipId"];
				if(tblMain.Rows[4].Visible == false)
					order.daDateHistory = DateTime.Now;
				else 
					order.daDateHistory = adtLastTime.Date;
				if(tblMain.Rows[5].Visible == false)
					order.dmUnitsHistory = (SqlDecimal)0; 
				else
					order.dmUnitsHistory = Convert.ToDecimal(tbUnits.Text);
				if(order.PMHistoryDetail() != -1)
				{
					// closing current window and relaod parent window
					sOnLoad = "window.close();opener.document.formAddPMItems.submit();";
					Session["reload"] = true;
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
