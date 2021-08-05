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
	public class _wo_addInspectForecast : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected ActiveUp.WebControls.ActiveDateTime adtScheduled;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected System.Web.UI.HtmlControls.HtmlAnchor html_ScheduledDate;
		protected System.Web.UI.WebControls.Label lblInspectSchedule;
		protected System.Web.UI.WebControls.Label lblInspectName;
		protected System.Web.UI.WebControls.Label lblStatus;
		protected System.Web.UI.WebControls.Label lblLastInspectDate;
		protected System.Web.UI.WebControls.Label lblDateRange;
		protected System.Web.UI.WebControls.Label lblScheduledDate;
		protected System.Web.UI.WebControls.Label lblWOType;
		protected System.Web.UI.WebControls.Label lblErrorScheduled;

		private clsWorkOrders order = null;
		private clsEquipment equip = null;

		private int EquipId;
		private int InspectSchedDetailId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_addInspectForecast.aspx";
				
				this.PageTitle = "Create Future Work Order with Inspection";
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddBreadCrumb("Select Equipment with Inspections", "/wo_showEquipsForInspect.aspx");
				Header.AddJavaScriptFile("/OpenWindows.js");
				Header.LeftBarHtml = "Select Schedule Date and Create Future Work Order with Inspection";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = this.ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			DateTime dtCurrentDate;
			int l_iResult;
			try
			{
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				if(Request.QueryString["sid"] == null || Request.QueryString["equipid"] == null)
				{
					Session["lastpage"] = "wo_showEquipsForInspect.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId = Convert.ToInt32(Request.QueryString["equipid"]);
					InspectSchedDetailId = Convert.ToInt32(Request.QueryString["sid"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "wo_showEquipsForInspect.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				NextBackControl.BackPage = "wo_showEquipsForInspect.aspx";
				NextBackControl.NextText = " << Create >> ";

				if(!IsPostBack)
				{
					dtCurrentDate = DateTime.Now;
					// getting the main (fixed) data 
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iEquipId = EquipId;
					order.iInspectSchedDetailId = InspectSchedDetailId;
					order.daCurrentDate = dtCurrentDate;
					
					l_iResult = order.GetInfoForCreateWOInspection();
					if(l_iResult == -1)
					{
						Session["lastpage"] = "wo_showEquipsForInspect.aspx";
						Session["error"] = _functions.ErrorMessage(147);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblEquipId.Text = order.sEquipId.Value;
					lblWOType.Text = order.sType.Value;
					lblInspectSchedule.Text = order.sInspectSchedule.Value;
					lblInspectName.Text = order.sInspectionName.Value;
					lblStatus.Text = order.sStatusId.Value;
					lblLastInspectDate.Text = order.sLastInspection.Value;
					lblDateRange.Text = order.sDatesRange.Value;

					if(order.sStatusId.Value == "No Service History")
					{
						dtCurrentDate = dtCurrentDate.AddMinutes(60-dtCurrentDate.Minute);
						//lblScheduledDate.Text = dtCurrentDate.ToLongDateString() + " " + dtCurrentDate.ToShortTimeString();
						lblScheduledDate.Text = "System cannot calculate the optimal date for inspection without history. Please select the next scheduled date of inspection.";
						lblScheduledDate.Font.Italic = true;
						adtScheduled.Date = dtCurrentDate;
						// if exist a future work order then alert
						if(l_iResult == 1)
						{
							Header.ErrorMessage = "Warning: " + _functions.ErrorMessage(152); 
							dtCurrentDate = dtCurrentDate.AddMinutes(60-dtCurrentDate.Minute);
							//lblScheduledDate.Text = dtCurrentDate.ToLongDateString() + " " + dtCurrentDate.ToLongTimeString();
							adtScheduled.Date = dtCurrentDate;
						}
					}
					else
					{
						l_iResult = order.GetDateTimeOfForecastInspection();
						if(l_iResult == -1)
						{
							// error 
							Header.ErrorMessage = _functions.ErrorMessage(order.iErrorCode.Value); 
							NextBackControl.NextEnabled = false;
							adtScheduled.Date = dtCurrentDate.AddMinutes(60-dtCurrentDate.Minute);
							return;
						}
						else
						{
							if(l_iResult == 1)
								Header.ErrorMessage = "Warning: " + _functions.ErrorMessage(152); 

//								{dtCurrentDate = dtCurrentDate.AddMinutes(60-dtCurrentDate.Minute);
//								lblScheduledDate.Text = dtCurrentDate.ToLongDateString() + " " + dtCurrentDate.ToShortTimeString();
//								adtScheduled.Date = dtCurrentDate;
//								return;	}
							if(l_iResult == 2)
								Header.ErrorMessage = "Warning: " + _functions.ErrorMessage(149); 

							if(dtCurrentDate < order.daScheduled.Value)
								dtCurrentDate = order.daScheduled.Value;
							else
								dtCurrentDate = dtCurrentDate.AddMinutes(60-dtCurrentDate.Minute);
							lblScheduledDate.Text = dtCurrentDate.ToLongDateString() + " " + dtCurrentDate.ToShortTimeString();
							adtScheduled.Date = dtCurrentDate;
						}
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showEquipsForInspect.aspx";
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

		#region Create Work Order with Inspection
		/// <summary>
		/// Procedure is adding a new work order into database and redirecting to finish screen
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			string sDataGridName;
			DBFieldType FieldType;
			DateTime daTmpForFixBug, daCurrent;
			try
			{
				daCurrent = DateTime.Now;
				if(adtScheduled.Date < daCurrent)
				{
					lblErrorScheduled.Text = "The Scheduled date must be in future";
					return;
				}
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iEquipId = EquipId;
				if(adtScheduled.Date.Hour == 0 || adtScheduled.Date.Hour == 12)
				{
					daTmpForFixBug = adtScheduled.Date;
					if(daTmpForFixBug.Hour == 0)daTmpForFixBug = daTmpForFixBug.AddHours(12);
					else daTmpForFixBug = daTmpForFixBug.AddHours(-12);
				}
				else
					daTmpForFixBug = adtScheduled.Date;
				order.daScheduled = daTmpForFixBug;
				order.iInspectSchedDetailId = InspectSchedDetailId;
				order.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				order.daCurrentDate = daCurrent;
				order.SetInspectWorkOrder();

				if(tbNotes.Text.Length > 0)
				{
					order.cAction = "U";
					order.iNoteId = 0;
					order.iNoteTypeId = (int)NoteTypes.CreationNote;
					order.iItemId = order.iId;
					order.daCreated = daCurrent;
					order.sNote = tbNotes.Text;
					order.NoteDetails();
				}

				BackFinishScreen finish = new BackFinishScreen();

				finish.sMainText = "The Work Order with Inspection has been created successfully.";

				finish.bMainMenuVisible = true;
				finish.sMainMenuText = "[Return to Main Menu]";
				finish.sMainMenuURL = "main.aspx";

				finish.bContinueVisible = true;
				finish.sContinueText = "[Create a New Future Work Order with Inspection]";
				finish.sContinueURL = "wo_showEquipsForInspect.aspx";

				finish.bViewVisible = true;
				finish.sViewText = "[View a new Work Order with Inspection]";
				finish.sViewURL = "wo_viewWorkOrder.aspx?id=" +  order.iId.Value.ToString();
					
				finish.bAdditionalVisible = false;
					
				finish.bPrintVisible = false;

				Session["BackFinish"] = finish;

				Response.Redirect("wo_finish.aspx", false);

			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_addInspectForecast.aspx?equipid=" + EquipId.ToString() + "&sid=" + InspectSchedDetailId.ToString();
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
			this.NextBackControl.BubbleClick += new EventHandler(btNext_FormSubmit);
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
