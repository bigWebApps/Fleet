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
	/// <summary>
	/// Summary description for wo_updateTimeLog.
	/// </summary>
	public class _wo_updateTimeLog : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblWorkOrderId;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Label lblTech;
		protected System.Web.UI.WebControls.DropDownList ddlTechnicians;
		protected System.Web.UI.WebControls.TextBox tbNote;
		protected System.Web.UI.WebControls.Button btnAddTimeLog;
		protected System.Web.UI.HtmlControls.HtmlInputButton html_btnBack;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.WebControls.RegularExpressionValidator revHours;
		protected System.Web.UI.WebControls.TextBox tbHours;
		protected System.Web.UI.WebControls.RegularExpressionValidator revMinutes;
		protected System.Web.UI.WebControls.TextBox tbMinutes;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvHourlyRate;
		protected System.Web.UI.WebControls.TextBox tbHourlyRate;
		protected System.Web.UI.WebControls.DropDownList ddlRepairs;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvRepairs;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvTechnicians;
		protected System.Web.UI.WebControls.Repeater repTimeLog;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneTimeLog;
		protected System.Web.UI.WebControls.RegularExpressionValidator revHourlyRate;
		protected System.Web.UI.HtmlControls.HtmlTableRow html_trTotalHours;
		protected System.Web.UI.HtmlControls.HtmlTableRow html_trTotalCosts;
		protected System.Web.UI.WebControls.Label lblTotalHours;
		protected System.Web.UI.WebControls.Label lblTotalCosts;
		protected Telerik.WebControls.RadDateInput rdiStartTime;
		protected Telerik.WebControls.RadDateInput rdiStopTime;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblMain;
		
		private clsWorkOrders order = null;
		private clsUsers user = null;
		private int OrderId;
		private int RepairId;
		private DataTable dtTimeLog;
		private DateTime dtNow;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_updateTimeLog.aspx.cs";

				this.PageTitle = "Time Tracking Log";
				Header.LeftBarHtml = "Technician's Time Tracking Log";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Header.ErrorMessage = ex.Message;
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
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
				if(Request.QueryString["repairid"] != null)
					RepairId = Convert.ToInt32(Request.QueryString["repairid"]);
				else
					RepairId = 0;

				html_btnBack.Attributes.Add("onclick", "document.location='wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "&#TimeLog';");
                if (Request.Cookies.Count > 0 && Request.Cookies["bfp_navigate"] != null)
                    Header.BrdCrumbsSerialization = Request.Cookies["bfp_navigate"].Value;
                Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString());
				dtNow = DateTime.Now;
				if(!IsPostBack)
				{
					rdiStartTime.SelectedDate = dtNow;
					rdiStopTime.SelectedDate = dtNow;
					order = new clsWorkOrders();
					user = new clsUsers();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					user.iOrgId = OrgId;
					user.iOrderId = OrderId;
					user.iTypeId = (int)UserTypes.Technician;

					DataTable dtTechList = user.GetUserListByType();
					dtTechList.Rows[0].Delete();
					ddlTechnicians.DataSource = new DataView(dtTechList);
					ddlTechnicians.DataBind();

					DataTable dtRepairList = order.GetRepairsShortList();
					dtRepairList.Rows[0].Delete();
					ddlRepairs.DataSource = new DataView(dtRepairList);
					ddlRepairs.DataBind();

					if(order.WorkOrderDetails() == -1)
					{
						Session["lastpage"] = this.ParentPageURL;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}
					
					if(!user.IsTechnician(_functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true)))
					{
						Session["lastpage"] = this.ParentPageURL;
						Session["error"] = _functions.ErrorMessage(131);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblWorkOrderId.Text = order.daCreated.Value.ToString("yyyy-MM-dd") + "-" + order.iWorkOrderNumber.Value.ToString();
					lblEquipId.Text = order.sEquipId.Value;
					lblOperator.Text = order.sOperatorName.Value;
					lblTech.Text = order.sTechName.Value;
					if(user.GetTechnicianInfo() != -1)
					{
						tbHourlyRate.Text = user.dmHourlyRate.Value.ToString("F");
						if(!user.bTechCanViewHourlyRate.Value)
						{
							ViewState["HourlyRate"] = user.dmHourlyRate.Value;
							html_tblMain.Rows[12].Visible = false;
							html_trTotalCosts.Visible = false;
						}
						else
						{
							ViewState["HourlyRate"] = null;
							html_tblMain.Rows[12].Visible = true;
							html_trTotalCosts.Visible = true;
						}
					}
					else
					{
						html_trTotalCosts.Visible = true;
						html_tblMain.Rows[12].Visible = true;
						tbHourlyRate.Text = "0.0";
						ViewState["HourlyRate"] = null;
					}	
					if(ddlTechnicians.Items.FindByValue(order.iTechId.Value.ToString()) != null)
					{
						ddlTechnicians.SelectedValue = order.iTechId.Value.ToString();
					}
					else
					{
						ddlTechnicians.SelectedIndex = 0;
					}
					if(ddlRepairs.Items.FindByValue(RepairId.ToString()) != null)
					{
						ddlRepairs.SelectedValue = RepairId.ToString();
					}
					else
					{
						ddlRepairs.SelectedIndex = 0;
					}
					order.iTechId = 0;
					dtTimeLog = order.GetTimeLogList();
					if(dtTimeLog.Rows.Count > 0)
					{
						repTimeLog.DataSource = new DataView(dtTimeLog);
						repTimeLog.DataBind();
						html_tblNoneTimeLog.Visible = false;
						lblTotalHours.Text = order.sReportDesc.Value;
						lblTotalCosts.Text = order.sDecs.Value;
					}
					else
					{
						html_tblNoneTimeLog.Visible = true;
						repTimeLog.Visible = false;
						html_trTotalHours.Visible = false;
						html_trTotalCosts.Visible = false;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = this.ParentPageURL;
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
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.ddlTechnicians.SelectedIndexChanged += new System.EventHandler(this.ddlTechnicians_SelectedIndexChanged);
			this.btnAddTimeLog.Click += new System.EventHandler(this.btnAddTimeLog_Click);
			this.repTimeLog.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repTimeLog_ItemCommand);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void repTimeLog_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			try
			{
				if(e.CommandName == "Delete")
				{
					order = new clsWorkOrders();
					order.cAction = "D";
					order.iOrgId = OrgId;
					order.iTimeLogId = Convert.ToInt32(e.CommandArgument);
					order.TimeLogDetails();
					order.iId = OrderId;
					order.iTechId = 0;
					dtTimeLog = order.GetTimeLogList();
					if(dtTimeLog.Rows.Count > 0)
					{
						repTimeLog.DataSource = new DataView(dtTimeLog);
						repTimeLog.DataBind();
						html_tblNoneTimeLog.Visible = false;
						lblTotalHours.Text = order.sReportDesc.Value;
						lblTotalCosts.Text = order.sDecs.Value;
					}
					else
					{
						repTimeLog.Visible = false;
						html_tblNoneTimeLog.Visible = true;
						html_trTotalHours.Visible = false;
						html_trTotalCosts.Visible = false;
					}
				}
			} 
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_updateTimeLog.aspx?id=" + OrderId.ToString();
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

		private void btnAddTimeLog_Click(object sender, System.EventArgs e)
		{
			try
			{
				double Hours = 0.0;
				DateTime daStartTime, daStopTime;
				TimeSpan tsDiff = new TimeSpan(0);
				daStopTime = rdiStopTime.SelectedDate;
				daStartTime = rdiStartTime.SelectedDate;

				if(tbHours.Text.Length > 0 || tbMinutes.Text.Length > 0)
				{
					if(tbHours.Text.Length > 0) Hours += Convert.ToDouble(tbHours.Text);
					if(tbMinutes.Text.Length > 0) Hours += Convert.ToDouble(tbMinutes.Text)/60;
				}
				else
				{
					// get hours from the difference betweent the Stop and Start time entries
					if(daStopTime <= daStartTime)
					{
						Header.ErrorMessage = _functions.ErrorMessage(204);
						return;
					}
					else
					{
						tsDiff = daStopTime - daStartTime;
						Hours = tsDiff.TotalHours;
					}
				}
				if(Hours >= 1000)
				{
					Header.ErrorMessage = _functions.ErrorMessage(203);
					return;
				}
				order = new clsWorkOrders();
				order.cAction = "U";
				order.iTimeLogId = 0;
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.iRepairId = Convert.ToInt32(ddlRepairs.SelectedValue);
				order.iTechId = Convert.ToInt32(ddlTechnicians.SelectedValue);
				if(tsDiff.Ticks != 0)
				{
					order.daStartTime = daStartTime;
					order.daStopTime = daStopTime;
				}
				else
				{
					order.daStartTime = SqlDateTime.Null;
					order.daStopTime = SqlDateTime.Null;
				}
				order.dmHours = Convert.ToDecimal(Hours);
				if(ViewState["HourlyRate"] == null)
					order.dmHourlyRate = Convert.ToDecimal(tbHourlyRate.Text);
				else
					order.dmHourlyRate = Convert.ToDecimal(ViewState["HourlyRate"]);
				order.sNote = tbNote.Text;
				order.TimeLogDetails();
				//order.Dispose();
				//order = new clsWorkOrders();
				//order.iOrgId = OrgId;
				tbHourlyRate.Text = "";
				tbHours.Text = "";
				tbMinutes.Text = "";
				tbNote.Text = "";
				rdiStartTime.SelectedDate = dtNow;
				rdiStopTime.SelectedDate = dtNow;
				Response.Redirect("wo_updateTimeLog.aspx?id=" + OrderId.ToString() + "&repairid=" + RepairId.ToString(), false);
			}
			catch(FormatException fex)
			{
				Header.ErrorMessage = _functions.ErrorMessage(108);
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_updateTimeLog.aspx?id=" + OrderId.ToString();
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

		private void ddlTechnicians_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			try
			{
				user = new clsUsers();
				user.iOrgId = OrgId;
				user.iOrderId = OrderId;
				user.iId = Convert.ToInt32(ddlTechnicians.SelectedValue);
				if(user.GetTechnicianInfo() != -1)
				{
					tbHourlyRate.Text = user.dmHourlyRate.Value.ToString("F");
					if(!user.bTechCanViewHourlyRate.Value)
					{
						ViewState["HourlyRate"] = user.dmHourlyRate.Value;
						html_tblMain.Rows[12].Visible = false;
						html_trTotalCosts.Visible = false;
					}
					else
					{
						ViewState["HourlyRate"] = null;
						html_tblMain.Rows[12].Visible = true;
						html_trTotalCosts.Visible = true;
					}
				}
				else
				{
					html_tblMain.Rows[12].Visible = true;
					html_trTotalCosts.Visible = true;
					tbHourlyRate.Text = "0.0";
					ViewState["HourlyRate"] = null;
				}				
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_updateTimeLog.aspx?id=" + OrderId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user != null)
					user.Dispose();
			}
		}
	}
}
