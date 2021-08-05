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
	public class _wo_viewWorkOrder : BFPPage
	{
		#region Controls
		protected System.Web.UI.WebControls.Label lblWorkOrderN;
		protected System.Web.UI.WebControls.HyperLink hlPMItems;
		protected System.Web.UI.WebControls.HyperLink hlInspections;
		protected System.Web.UI.WebControls.Label lblStatus;
		protected System.Web.UI.WebControls.Label lblStaying;
		protected System.Web.UI.WebControls.Label lblSpare;
		protected System.Web.UI.WebControls.Label lblType;
		protected System.Web.UI.WebControls.Label lblMakeModel;
		protected System.Web.UI.WebControls.Label lblYear;
		protected System.Web.UI.WebControls.Label lblUnits;
		protected System.Web.UI.WebControls.Label lblTech;
		protected System.Web.UI.WebControls.Label lblDroppedOffBy;
		protected System.Web.UI.WebControls.Label lblReleasedTo;
		protected System.Web.UI.WebControls.Repeater repCustomFields;
		protected System.Web.UI.WebControls.HyperLink hlEquipId;
		protected System.Web.UI.WebControls.HyperLink hlPrintOrderRequest;
		protected System.Web.UI.WebControls.HyperLink hlPrintCompletedOrder;
		protected System.Web.UI.WebControls.HyperLink hlPrintPartUsed;
		protected System.Web.UI.WebControls.Label lblCleanliness;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected System.Web.UI.WebControls.LinkButton lbSaveNotes;
		protected System.Web.UI.WebControls.HyperLink hlOpenOrder;
		protected System.Web.UI.WebControls.HyperLink hlMainEdit;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneIssues;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneInspections;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneRepairs;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneParts;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNonePMItems;
		protected System.Web.UI.WebControls.Repeater repIssues;
		protected System.Web.UI.WebControls.HyperLink hlReportedIssues;
		protected System.Web.UI.WebControls.Repeater repPMItems;
		protected System.Web.UI.WebControls.Repeater repInspections;
		protected System.Web.UI.WebControls.Label lblSignOpenedBy;
		protected System.Web.UI.WebControls.Label lblSignDateOpenedBy;
		protected System.Web.UI.WebControls.Label lblSignOpenedByUnder;
		protected System.Web.UI.WebControls.Repeater repRepairs;
		protected System.Web.UI.WebControls.Repeater repPartsUsed;
		protected System.Web.UI.WebControls.LinkButton LinkButton1;
		protected System.Web.UI.WebControls.HyperLink hlCheckIn;
		protected System.Web.UI.WebControls.HyperLink hlCheckOut;
		protected System.Web.UI.WebControls.Label lblSignCheckInBy;
		protected System.Web.UI.WebControls.Label lblSignDateCheckInBy;
		protected System.Web.UI.WebControls.Label lblSignCheckOutBy;
		protected System.Web.UI.WebControls.Label lblSignDateCheckOutBy;
		protected System.Web.UI.WebControls.Label lblSignCheckOutByUnder;
		protected System.Web.UI.WebControls.Label lblOperatorStatus;
		protected System.Web.UI.WebControls.Repeater repCreationNotes;
		protected System.Web.UI.WebControls.Repeater repOperatorNotes;
		protected System.Web.UI.WebControls.Repeater repTechNotes;
		protected System.Web.UI.WebControls.HyperLink hlCloseOrder;
		protected System.Web.UI.WebControls.Label lblSignClosedBy;
		protected System.Web.UI.WebControls.Label lblSignDateClosedBy;
		protected System.Web.UI.WebControls.Label lblSignClosedByUnder;
		protected System.Web.UI.WebControls.Label lblSignCheckInByUnder;
		protected System.Web.UI.WebControls.Label lblWOType;
		protected System.Web.UI.WebControls.Label lblSerial;
		protected System.Web.UI.WebControls.HyperLink hlServiceDates;
		protected System.Web.UI.WebControls.HyperLink hlDeleteOrder;
		protected System.Web.UI.WebControls.HyperLink hlAddRepair;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvNote;
		protected System.Web.UI.WebControls.HyperLink hlTimeLog;
		protected System.Web.UI.WebControls.Repeater repTimeLog;
		protected System.Web.UI.WebControls.Label lblTotalHours;
		protected System.Web.UI.WebControls.Label lblTotalCosts;
		protected System.Web.UI.HtmlControls.HtmlTableRow html_trTotalHours;
		protected System.Web.UI.HtmlControls.HtmlTableRow html_trTotalCosts;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneTimeLog;
		#endregion

		#region Members
		private int OrderId;
		private int ItemId;
		private int RepairId;
		
		private clsWorkOrders order = null;
		private clsMakesModels mm = null;
		private clsDepartments dep = null;
		private clsLocations loc = null;
		private clsUsers user = null;
		private clsCustomFieldsDef cfd = null;
		
		private DataTable dtIssues = null;
		private DataTable dtPMItems = null;
		private DataTable dtInspections = null;
		private DataTable dtPartsUsed = null;
		private DataTable dtRepairs = null;
		private DataTable dtCustomFields = null;
		private DataTable dtCustomFieldsFromDB = null;
		private ArrayList arrCFD = null;

		private string m_sLastPage;
		private WorkOrderStatus status;
		private WorkOrderOperatorStatus opstatus;
		#endregion
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_viewWorkOrder.aspx.cs";
				
				this.PageTitle = "Work Order Detail";
				Header.LeftBarHtml = "View/Manage the Work Order";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		
		private void Page_Load(object sender, System.EventArgs e)
		{
			string sTypeName;
			string sDomenName;
			string sReportPath;
			try{
				int l_iCount;

				#region Header Section
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
				
				if((string)Session["PathToViewOrder"] != "Monthly-Daily")
					l_iCount = 2;
				else
					l_iCount = 3;
				
				Header.AddJavaScriptFile("/OpenWindows.js");

				Header.AddBreadCrumb("Home", "/main.aspx");
					
				switch((string)Session["PathToViewOrder"])
				{
					case "Monthly-Daily":
						Header.AddBreadCrumb("Monthly Work Orders View", "/wo_showOrdersForMonthly.aspx");
						Header.AddBreadCrumb("Daily Work Orders View", "/wo_showOrdersForDaily.aspx");
						m_sLastPage = "wo_showOrdersForDaily.aspx";
						break;
					case "Monthly":
						Header.AddBreadCrumb("Monthly Work Orders View", "/wo_showOrdersForMonthly.aspx");
						m_sLastPage = "wo_showOrdersForMonthly.aspx";
						break;
					case "Daily":
						Header.AddBreadCrumb("Daily Work Orders View", "/wo_showOrdersForDaily.aspx");
						m_sLastPage = "wo_showOrdersForDaily.aspx";
						break;
					case "Today":
						Header.AddBreadCrumb("Work Orders Overview", "/wo_showOrdersForToday.aspx");
						m_sLastPage = "wo_showOrdersForToday.aspx";
						break;
					case "Weekly":
						Header.AddBreadCrumb("Weekly Work Orders View", "/wo_showOrdersForWeekly.aspx");
						m_sLastPage = "wo_showOrdersForWeekly.aspx";
						break;
					case "Scheduled":
						Header.AddBreadCrumb("The Scheduled Orders", "/wo_showUnassignedOrders.aspx");
						m_sLastPage = "wo_showUnassignedOrders.aspx";
						break;
					case "Completed":
						Header.AddBreadCrumb("Completed Work Orders", "/wo_showCompletedOrders.aspx");
						m_sLastPage = "wo_showCompletedOrders.aspx";
						break;
					case "EquipWOReport":
						Header.AddBreadCrumb("Equipment Work Order Report", "/wo_viewEquipWorkOrderReport.aspx");
						m_sLastPage = "wo_viewEquipWorkOrderReport.aspx";
						break;
					default:
						Header.AddBreadCrumb("Work Orders Overview", "/wo_showOrdersForToday.aspx");
						m_sLastPage = "wo_showOrdersForToday.aspx";
						break;
				}
				Response.Cookies["bfp_navigate"].Value = Header.BrdCrumbsSerialization;
				Response.Cookies["bfp_navigate"].Path = "/";
				Response.Cookies["bfp_navigate"].Expires = DateTime.Now.AddYears(1);
				//Session["BrdCrumbs"] = arrBrdCrumbs;
				#endregion

				if(!IsPostBack)
				{
					dtCustomFields = new DataTable();
					dtCustomFields.Columns.Add("ValueName");
					dtCustomFields.Columns.Add("Value");

					order = new clsWorkOrders();
					user = new clsUsers();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					if(order.WorkOrderDetails() == -1)
					{
						Session["lastpage"] = m_sLastPage;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}

					#region Processing of the Operation Area
					
					hlMainEdit.NavigateUrl = "wo_editWorkOrder.aspx?id=" + OrderId.ToString();
					hlCloseOrder.NavigateUrl = "wo_closeWorkOrder.aspx?id=" + OrderId.ToString();
					hlOpenOrder.NavigateUrl = "wo_openWorkOrder.aspx?id=" + OrderId.ToString();
					hlDeleteOrder.NavigateUrl = "wo_deleteWorkOrder.aspx?id=" + OrderId.ToString();

					hlCheckIn.NavigateUrl = "wo_viewCheckIn.aspx?id=" + OrderId.ToString();
					hlCheckOut.NavigateUrl = "wo_viewCheckOut.aspx?id=" + OrderId.ToString();
					hlTimeLog.NavigateUrl = "wo_updateTimeLog.aspx?id=" + OrderId.ToString();
					
					hlReportedIssues.NavigateUrl = "wo_addRepairs.aspx?id=" + OrderId.ToString() + "&back=view";
					hlPMItems.NavigateUrl  = "wo_addPreventiveMaintenance.aspx?id=" + OrderId.ToString() + "&back=view";
					hlInspections.NavigateUrl = "wo_addInspections.aspx?id=" + OrderId.ToString() + "&back=view";
					
					sReportPath = _functions.GetValueFromConfig("SQLRS.Folder");
					hlPrintPartUsed.NavigateUrl = "ReportViewer.aspx?Report=" + sReportPath + "%2fPartsList&OrderId=" + OrderId.ToString() + "&OrgId=" + OrgId.ToString();
					hlPrintOrderRequest.NavigateUrl = "ReportViewer.aspx?Report=" + sReportPath + "%2fWorkOrderRequest&OrderId=" + OrderId.ToString() + "&OrgId=" + OrgId.ToString();
					hlPrintCompletedOrder.NavigateUrl = "ReportViewer.aspx?Report=" + sReportPath + "%2fCompletedOrder&OrderId=" + OrderId.ToString()+ "&OrgId=" + OrgId.ToString();

					hlAddRepair.NavigateUrl = "wo_updateRepair.aspx?mode=Edit&repairid=0&inspectid=0&type=FREE&op=Repair&id=" + OrderId.ToString() + "&itemid=0";

					status = (WorkOrderStatus)order.iStatusId.Value;
					opstatus = order.iOperatorStatusId.IsNull?WorkOrderOperatorStatus.Null:(WorkOrderOperatorStatus)order.iOperatorStatusId.Value;

					ViewState["status"] = status;
					ViewState["opstatus"] = opstatus;
					switch(status)
					{
						case WorkOrderStatus.Scheduled: // Scheduled status
							hlMainEdit.Enabled = true;
							hlMainEdit.Text = "[Change the Scheduled Date]";
							hlReportedIssues.Enabled = true;
							hlPMItems.Enabled = true;
							hlInspections.Enabled = true;
							hlCloseOrder.Enabled = false;
							hlDeleteOrder.Enabled = true;
							hlTimeLog.Enabled = false;
							if(opstatus == WorkOrderOperatorStatus.Checked_In)
							{
								// check-in status
								hlOpenOrder.Enabled = true;
							}
							else
							{
								// not check-in status
								hlCheckIn.Enabled = true;
							}
							break;
						case WorkOrderStatus.Open: // Opened status
							hlMainEdit.Enabled = true;
							hlReportedIssues.Enabled = true;
							hlPMItems.Enabled = true;
							hlInspections.Enabled = true;
							hlPrintOrderRequest.Enabled = true;
							hlPrintPartUsed.Enabled = true;
							hlAddRepair.Enabled = true;
							lbSaveNotes.Enabled = true;
							hlTimeLog.Enabled = true;
							break;
						case WorkOrderStatus.ReOpened: // ReOpened status
							hlMainEdit.Enabled = true;
							hlReportedIssues.Enabled = true;
							hlPMItems.Enabled = true;
							hlInspections.Enabled = true;
							hlPrintOrderRequest.Enabled = true;
							hlPrintPartUsed.Enabled = true;
							hlAddRepair.Enabled = true;
							lbSaveNotes.Enabled = true;
							hlTimeLog.Enabled = true;
							break;
						case WorkOrderStatus.Closed: // Closed Status
							hlMainEdit.Enabled = true;
							hlMainEdit.Text = "[Change the Order Dates]";
							hlPrintCompletedOrder.Enabled = true;
							hlPrintPartUsed.Enabled = true;
							hlTimeLog.Enabled = true;
							if(opstatus == WorkOrderOperatorStatus.Checked_In)
							{
								// check-in status
								hlCheckOut.Enabled = true;
							}
							break;
					}
					#endregion
					
					#region Processing of the Information Area
					if(status == WorkOrderStatus.Closed)
						Session["CurrentDay"] = order.daClosed.Value;
					else
						Session["CurrentDay"] = order.daScheduled.Value;
					lblWorkOrderN.Text = order.daCreated.Value.ToString("yyyy-MM-dd") + "-" + order.iWorkOrderNumber.Value.ToString();
					lblWOType.Text = order.sType.Value;
					lblStatus.Text = order.sStatusId.Value;
					lblOperatorStatus.Text = order.sOperatorStatus.Value;
					lblStaying.Text = order.bStaying.IsNull?"not defined":(order.bStaying.Value?"Yes":"No");
					lblSpare.Text = order.sSpareEquipId.Value;
					lblTech.Text = order.sTechName.Value;
					lblOperator.Text = order.sOperatorName.Value;
					lblDroppedOffBy.Text = order.sDropedOffBy.Value;
					lblReleasedTo.Text = order.sReleasedTo.Value;
					lblCleanliness.Text = order.sCleanliness.Value;
					
					hlServiceDates.Attributes.Add("onclick", "window.open('wo_viewDates.aspx?id=" + OrderId.ToString() + "', 'popupcal', 'width=350,height=200,left=' + event.screenX + ',top=' + event.screenY + ',scrollbars=no');");
					
					// showing equipment info
					hlEquipId.Text = order.sEquipId.Value;
					hlEquipId.NavigateUrl = "e_view.aspx?id=" + order.iEquipId.Value.ToString();
					lblType.Text = order.sEquipTypeName.Value;
					lblMakeModel.Text = order.sEquipMakeModel.Value;
					lblYear.Text = (order.sEquipYear.Value == "0")?"unknown":order.sEquipYear.Value;
					lblSerial.Text = order.sEquipVinSerial.Value;
					lblUnits.Text = Convert.ToDouble(order.dmMileage.Value).ToString();
					#endregion

					#region Processing of the Issues Area
					order.iTechId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
					dtPMItems = order.GetWorkOrderPMItems();
					if(dtPMItems.Rows.Count > 0)
						html_tblNonePMItems.Visible = false;
					else
						html_tblNonePMItems.Visible = true;
					repPMItems.DataSource = new DataView(dtPMItems);
					repPMItems.DataBind();
					
					dtIssues = order.GetWorkOrderReportedIssues();
					if(dtIssues.Rows.Count > 0)
						html_tblNoneIssues.Visible = false;
					else
						html_tblNoneIssues.Visible = true;

					repIssues.DataSource = new DataView(dtIssues);
					repIssues.DataBind();

					dtInspections = order.GetWorkOrderInspections();
					if(dtInspections.Rows.Count > 0)
						html_tblNoneInspections.Visible = false;
					else
						html_tblNoneInspections.Visible = true;
					repInspections.DataSource = new DataView(dtInspections);
					repInspections.DataBind();
					#endregion

					#region Processing of the Serviced Repairs Area and the Time Log Area
					ShowRepairList();
					#endregion

					#region Processing of the Notes Area
					order.iItemId = OrderId;
					order.iNoteTypeId = (int)NoteTypes.CreationNote;
					repCreationNotes.DataSource = new DataView(order.GetNotesList());
					repCreationNotes.DataBind();
					
					order.iNoteTypeId = (int)NoteTypes.OperatorNote;
					repOperatorNotes.DataSource = new DataView(order.GetNotesList());
					repOperatorNotes.DataBind();

					order.iNoteTypeId = (int)NoteTypes.TechnicianNote;
					repTechNotes.DataSource = new DataView(order.GetNotesList());
					repTechNotes.DataBind();
					#endregion

					#region Processing of the Signatures Area
					order.iDocumentId = OrderId;
					order.iDocumentTypeId = (int)DocumentTypes.WorkOrderCheckedIn;
					if(order.GetSignedDocument() != -1)
					{
						lblSignCheckInBy.Text = order.sUserName.Value;
						lblSignCheckInByUnder.Text = order.sUserName.Value;
						lblSignDateCheckInBy.Text = order.daReportDate.Value.ToShortDateString() + " " + order.daReportDate.Value.ToShortTimeString();
					}
					else
					{
						lblSignCheckInBy.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					order.iDocumentTypeId = (int)DocumentTypes.WorkOrderReOpened;
					if(order.GetSignedDocument() != -1)
					{
						lblSignOpenedBy.Text = order.sUserName.Value;
						lblSignOpenedByUnder.Text = order.sUserName.Value;
						lblSignDateOpenedBy.Text = order.daReportDate.Value.ToShortDateString() + " " + order.daReportDate.Value.ToShortTimeString();
					}
					else
					{
						order.iDocumentTypeId = (int)DocumentTypes.WorkOrderOpen;
						if(order.GetSignedDocument() != -1)
						{
							lblSignOpenedBy.Text = order.sUserName.Value;
							lblSignOpenedByUnder.Text = order.sUserName.Value;
							lblSignDateOpenedBy.Text = order.daReportDate.Value.ToShortDateString() + " " + order.daReportDate.Value.ToShortTimeString();
						}
						else
						{
							lblSignOpenedBy.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						}
					}
					if(status == WorkOrderStatus.Closed)
					{
						order.iDocumentTypeId = (int)DocumentTypes.WorkOrderClosed;
						if(order.GetSignedDocument() != -1)
						{
							lblSignClosedBy.Text = order.sUserName.Value;
							lblSignClosedByUnder.Text = order.sUserName.Value;
							lblSignDateClosedBy.Text = order.daReportDate.Value.ToShortDateString() + " " + order.daReportDate.Value.ToShortTimeString();
						}
					}
					if(opstatus == WorkOrderOperatorStatus.Checked_Out)
					{
						order.iDocumentTypeId = (int)DocumentTypes.WorkOrderCheckedOut;
						if(order.GetSignedDocument() != -1)
						{
							lblSignCheckOutBy.Text = order.sUserName.Value;
							lblSignCheckOutByUnder.Text = order.sUserName.Value;
							lblSignDateCheckOutBy.Text = order.daReportDate.Value.ToShortDateString() + " " + order.daReportDate.Value.ToShortTimeString();
						}
					}
					#endregion

					#region Processing of the Custom Fields
					dtCustomFieldsFromDB = order.WorkOrderDetail_CustomFields(null);

					if(dtCustomFieldsFromDB.Rows.Count > 0)
					{
						arrCFD = _functions.GetCustomFields(CFDataType.WorkOrder, 0, HttpContext.Current.User.Identity.Name);
						if(arrCFD.Count > 0)
						{
							// fill custom fields
							for(int j = 0; j < arrCFD.Count; j++)
							{
								cfd = (clsCustomFieldsDef)arrCFD[j];
								sTypeName = _functions.GetFieldTypeText(cfd.FieldTypeId) + cfd.NumberColumn.ToString();

								switch(cfd.FieldTypeId)
								{
									case DBFieldType._lookup:
										switch(cfd.NameLookupTable)
										{
											case "EquipModels":
												if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
												{
													dtCustomFields.Rows.Add(new object []{"Make/Model", ""});
												}
												else
												{
													mm = new clsMakesModels();
													mm.iOrgId = OrgId;
													mm.iModelId = Convert.ToInt32(dtCustomFieldsFromDB.Rows[0][sTypeName]);
													mm.GetModelMakes();
													dtCustomFields.Rows.Add(new object []{"Make/Model", mm.sMakeName + "/" + mm.sModelName});
													if(mm != null)
														mm.Dispose();
												}
												break;
											case "Departments":
												if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
												{
													dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
												}
												else
												{
													dep =  new clsDepartments();
													dep.cAction = "S";
													dep.iOrgId = OrgId;
													dep.iId = Convert.ToInt32(dtCustomFieldsFromDB.Rows[0][sTypeName]);
													if(dep.DepartmentDetail() == 0)
													{
														dtCustomFields.Rows.Add(new object []{cfd.NameText, dep.sName.Value});
													}
													else
													{
														dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
													}
													if(dep != null)
														dep.Dispose();
												}
												break;
											case "Locations":
												if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
												{
													dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
												}
												else
												{
													loc = new clsLocations();
													loc.cAction = "S";
													loc.iOrgId = OrgId;
													loc.iId = Convert.ToInt32(dtCustomFieldsFromDB.Rows[0][sTypeName]);
													if(loc.LocationDetail() == 0)
													{
														dtCustomFields.Rows.Add(new object []{cfd.NameText, loc.sName.Value});
													}
													else
													{
														dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
													}
													if(loc != null)
														loc.Dispose();
												}
												break;
											default:
												break;
										}
										break;
									case DBFieldType._datetime:
										if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										{
											dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
										}
										else
										{
											dtCustomFields.Rows.Add(new object []{cfd.NameText, ((DateTime)dtCustomFieldsFromDB.Rows[0][sTypeName]).ToShortDateString()});
										}
										break;
									case DBFieldType._bit:
										if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										{
											dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
										}
										else
										{
											if(((bool)dtCustomFieldsFromDB.Rows[0][sTypeName]) == true)
												dtCustomFields.Rows.Add(new object []{cfd.NameText, "Yes"});
											else
												dtCustomFields.Rows.Add(new object []{cfd.NameText, "No"});
										}
										break;
									default:
										if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										{
											dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
										}
										else
										{
											dtCustomFields.Rows.Add(new object []{cfd.NameText, dtCustomFieldsFromDB.Rows[0][sTypeName]});
										}
										break;
								}
								cfd = null;
							}
					
							// showing a Equipment's data from custom fields
							repCustomFields.DataSource = new DataView(dtCustomFields);
							repCustomFields.DataBind();
						}
					}
					#endregion
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
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.repIssues.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repIssues_ItemCommand);
			this.repPMItems.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repPMItems_ItemCommand);
			this.repInspections.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repInspections_ItemCommand);
			this.repRepairs.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repRepairs_ItemCommand);
			this.lbSaveNotes.Click += new System.EventHandler(this.lbSaveNotes_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		/// <summary>
		/// DataBinding te RepairList and PartsList
		/// </summary>
		private void ShowRepairList()
		{
			try
			{
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.iTechId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);

				dtRepairs = order.GetRepairsList();
				if(dtRepairs.Rows.Count > 0)
					html_tblNoneRepairs.Visible = false;
				else
					html_tblNoneRepairs.Visible = true;

				repRepairs.DataSource = new DataView(dtRepairs);
				repRepairs.DataBind();

				dtPartsUsed = order.GetPartsUsedListForOrder();
				if(dtPartsUsed.Rows.Count > 0)
					html_tblNoneParts.Visible = false;
				else
					html_tblNoneParts.Visible = true;

				repPartsUsed.DataSource = new DataView(dtPartsUsed);
				repPartsUsed.DataBind();

				if(order.GetCompleteAbleOrder() == 1)
					hlCloseOrder.Enabled = true;
				else
					hlCloseOrder.Enabled = false;
				
				if(order.GetDeleteAbleOrder() == 1)
					hlDeleteOrder.Enabled = true;
				else
					hlDeleteOrder.Enabled = false;

				order.iId = OrderId;
				order.iTechId = 0;
				DataTable dtTimeLog = order.GetTimeLogList();
				if(dtTimeLog.Rows.Count > 0)
				{
					repTimeLog.DataSource = new DataView(dtTimeLog);
					repTimeLog.DataBind();
					html_tblNoneTimeLog.Visible = false;
					lblTotalHours.Text = order.sReportDesc.Value;
					lblTotalCosts.Text = order.sDecs.Value;
					user = new clsUsers();
					user.iOrgId = OrgId;
					user.iOrderId = OrderId;
					if(user.GetTechnicianInfo() != -1)
						if(!user.bTechCanViewHourlyRate.Value)
							html_trTotalCosts.Visible = false;
						else
							html_trTotalCosts.Visible = true;
				}
				else
				{
					repTimeLog.Visible = false;
					html_tblNoneTimeLog.Visible = true;
					html_trTotalHours.Visible = false;
					html_trTotalCosts.Visible = false;
				}

			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}


		private void lbSaveNotes_Click(object sender, System.EventArgs e)
		{
			try
			{	
				Header.BodyOnloadScript  = "javascript:document.location='#Notes'";
				//Header.Render();

				order = new clsWorkOrders();
				order.cAction = "U";
				order.iOrgId = OrgId;
				order.iNoteId = 0;
				order.iNoteTypeId = (int)NoteTypes.TechnicianNote;
				order.iItemId = OrderId;
				order.daCreated = DateTime.Now;
				order.sNote = tbNotes.Text;
				order.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				order.NoteDetails();
				tbNotes.Text = "";
				order.iNoteTypeId = (int)NoteTypes.TechnicianNote;
				repTechNotes.DataSource = new DataView(order.GetNotesList());
				repTechNotes.DataBind();
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

		
		private void repIssues_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			try
			{
				int ServiceCheckId;
				int ServiceResultId;

				if(e.CommandName.Length > 0)
				{
					status = (WorkOrderStatus)ViewState["status"];
					opstatus = (WorkOrderOperatorStatus)ViewState["opstatus"];

					if(status == WorkOrderStatus.Scheduled 
						&& e.CommandName != "Delete")
					{
						if(opstatus == WorkOrderOperatorStatus.Null)
						{
							Response.Redirect("wo_viewCheckIn.aspx?id=" + OrderId.ToString(), false);
							return;
						}
						else
						{
							Response.Redirect("wo_openWorkOrder.aspx?id=" + OrderId.ToString(), false);
							return;
						}
					}
				
					Header.BodyOnloadScript = "javascript:document.location='#Issues'";
					//Header.Render();

					ItemId = Convert.ToInt32(((Label)e.Item.FindControl("IssueId")).Text);
					ServiceCheckId = Convert.ToInt32(((Label)e.Item.FindControl("ServiceCheckId")).Text);
					ServiceResultId = Convert.ToInt32(((Label)e.Item.FindControl("ServiceResultId")).Text);
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					order.iReportedIssueId = ItemId;
					switch(e.CommandName)
					{
						case "Delete":
							order.cAction = "D";
							int iResult = order.WorkOrderReportedIssuesDetail();
							if(iResult < 0)
							{
								Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
								if(iResult == -1)
									Session["error"] = _functions.ErrorMessage(121);
								else
									Session["error"] = _functions.ErrorMessage(126);
								Response.Redirect("error.aspx", false);
							}					
							break;
						case "OK":	// if the status already okay then ServiceCheckId = null else
							// see what was status of ServiceResultId, if more than 0 then ServiceResultId = null
							if(ServiceCheckId == (int)ServiceChecks._CheckOK)
							{
								order.iServiceCheckId = SqlInt32.Null;
								order.iServiceResultId = SqlInt32.Null;
							}
							else
							{
								order.iServiceCheckId = (int)ServiceChecks._CheckOK;
								order.iServiceResultId = ServiceResultId;
							}
							if(order.SetIssueChecks() == -1)
							{
								Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
								Session["error"] = _functions.ErrorMessage(121);
								Response.Redirect("error.aspx", false);
								return;
							}
							break;
						case "FAIR":
							if(ServiceCheckId == (int)ServiceChecks._CheckFair)
							{
								order.iServiceCheckId = SqlInt32.Null;
								order.iServiceResultId = SqlInt32.Null;
							}
							else
							{
								order.iServiceCheckId = (int)ServiceChecks._CheckFair;
								order.iServiceResultId = ServiceResultId;
							}
							if(order.SetIssueChecks() == -1)
							{
								Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
								Session["error"] = _functions.ErrorMessage(121);
								Response.Redirect("error.aspx", false);
								return;
							}
							break;
						case "RepairNeeded":
							if(ServiceCheckId == (int)ServiceChecks._CheckRepairs_Needed)
							{
								order.iServiceCheckId = SqlInt32.Null;
								order.iServiceResultId = ServiceResultId;
							}
							else
							{
								order.iServiceCheckId = (int)ServiceChecks._CheckRepairs_Needed;
								order.iServiceResultId = SqlInt32.Null;
							}
							if(order.SetIssueChecks() == -1)
							{
								Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
								Session["error"] = _functions.ErrorMessage(121);
								Response.Redirect("error.aspx", false);
								return;
							}
							break;
						case "NoService":
							if(ServiceResultId > 0) // значит ремонт у этого итема был и мы удаляем его
							{
								order.iServiceCheckId = (int)ServiceChecks._CheckRepairs_Needed;
								order.iServiceResultId = ServiceResultId;
								if(order.SetIssueChecks() == -1)
								{
									Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
									Session["error"] = _functions.ErrorMessage(121);
									Response.Redirect("error.aspx", false);
									return;
								}
							}
							break;
						case "Repaired":
							Response.Redirect("wo_updateRepair.aspx?mode=Add&repairid=0&inspectid=0&type=RI&op=Repair&id=" + OrderId.ToString() + "&itemid=" + ItemId.ToString(), false);
							return;
						case "Replaced":
							Response.Redirect("wo_updateRepair.aspx?mode=Add&repairid=0&inspectid=0&type=RI&op=Replace&id=" + OrderId.ToString() + "&itemid=" + ItemId.ToString(), false);
							return;
						default:
							break;
					}
					order.cAction = "S";
					order.iId = OrderId;
					order.iTechId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);

					dtIssues = order.GetWorkOrderReportedIssues();
					if(dtIssues.Rows.Count > 0)
						html_tblNoneIssues.Visible = false;
					else
						html_tblNoneIssues.Visible = true;

					repIssues.DataSource = new DataView(dtIssues);
					repIssues.DataBind();

					ShowRepairList();
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

		private void repPMItems_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			int ServiceCheckId;
			int ServiceResultId;
			try
			{
				if(e.CommandName.Length > 0)
				{
					status = (WorkOrderStatus)ViewState["status"];
					opstatus = (WorkOrderOperatorStatus)ViewState["opstatus"];

					if(status == WorkOrderStatus.Scheduled 
						&& e.CommandName != "Delete")
					{
						if(opstatus == WorkOrderOperatorStatus.Null)
						{
							Response.Redirect("wo_viewCheckIn.aspx?id=" + OrderId.ToString(), false);
							return;
						}
						else
						{
							Response.Redirect("wo_openWorkOrder.aspx?id=" + OrderId.ToString(), false);
							return;
						}
					}

					Header.BodyOnloadScript = "javascript:document.location='#Issues'";
					//Header.Render();

					ItemId = Convert.ToInt32(((Label)e.Item.FindControl("PMItemId")).Text);
					ServiceCheckId = Convert.ToInt32(((Label)e.Item.FindControl("ServiceCheckId")).Text);
					ServiceResultId = Convert.ToInt32(((Label)e.Item.FindControl("ServiceResultId")).Text);
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					order.iPMItemId = ItemId;
					switch(e.CommandName)
					{
						case "Delete":
							order.cAction = "D";
							int iResult = order.WorkOrderPMItemsDetail();
							if(iResult < 0)
							{
								Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
								if(iResult == -1)
									Session["error"] = _functions.ErrorMessage(123);
								else
									Session["error"] = _functions.ErrorMessage(126);
								Response.Redirect("error.aspx", false);
							}
							break;
						case "OK":	// if the status already okay then ServiceCheckId = null else
							// see what was status of ServiceResultId, if more than 0 then ServiceResultId = null
							if(ServiceCheckId == (int)ServiceChecks._CheckOK)
							{
								order.iServiceCheckId = SqlInt32.Null;
								order.iServiceResultId = SqlInt32.Null;
							}
							else
							{
								order.iServiceCheckId = (int)ServiceChecks._CheckOK;
								order.iServiceResultId = ServiceResultId;
							}
							if(order.SetPMItemChecks() == -1)
							{
								Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
								Session["error"] = _functions.ErrorMessage(133);
								Response.Redirect("error.aspx", false);
								return;
							}
							break;
						case "FAIR":
							if(ServiceCheckId == (int)ServiceChecks._CheckFair)
							{
								order.iServiceCheckId = SqlInt32.Null;
								order.iServiceResultId = SqlInt32.Null;
							}
							else
							{
								order.iServiceCheckId = (int)ServiceChecks._CheckFair;
								order.iServiceResultId = ServiceResultId;
							}
							if(order.SetPMItemChecks() == -1)
							{
								Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
								Session["error"] = _functions.ErrorMessage(133);
								Response.Redirect("error.aspx", false);
								return;
							}
							break;
						case "RepairNeeded":
							if(ServiceCheckId == (int)ServiceChecks._CheckRepairs_Needed)
							{
								order.iServiceCheckId = SqlInt32.Null;
								order.iServiceResultId = ServiceResultId;
							}
							else
							{
								order.iServiceCheckId = (int)ServiceChecks._CheckRepairs_Needed;
								order.iServiceResultId = SqlInt32.Null;
							}
							if(order.SetPMItemChecks() == -1)
							{
								Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
								Session["error"] = _functions.ErrorMessage(133);
								Response.Redirect("error.aspx", false);
								return;
							}
							break;
						case "NoService":
							if(ServiceResultId > 0) // значит ремонт у этого итема был и мы удаляем его
							{
								order.iServiceCheckId = (int)ServiceChecks._CheckRepairs_Needed;
								order.iServiceResultId = ServiceResultId;
								if(order.SetPMItemChecks() == -1)
								{
									Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
									Session["error"] = _functions.ErrorMessage(133);
									Response.Redirect("error.aspx", false);
									return;
								}
							}
							break;
						case "Repaired":
							Response.Redirect("wo_updateRepair.aspx?mode=Add&repairid=0&inspectid=0&type=PMI&op=Repair&id=" + OrderId.ToString() + "&itemid=" + ItemId.ToString(), false);
							return;
						case "Replaced":
							Response.Redirect("wo_updateRepair.aspx?mode=Add&repairid=0&inspectid=0&type=PMI&op=Replace&id=" + OrderId.ToString() + "&itemid=" + ItemId.ToString(), false);
							return;
						default:
							break;
					}
					order.cAction = "S";
					order.iId = OrderId;
					order.iTechId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);

					dtPMItems = order.GetWorkOrderPMItems();
					if(dtPMItems.Rows.Count > 0)
						html_tblNonePMItems.Visible = false;
					else
						html_tblNonePMItems.Visible = true;
					
					repPMItems.DataSource = new DataView(dtPMItems);
					repPMItems.DataBind();

					ShowRepairList();
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

		private void repInspections_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			try
			{
				if(e.CommandName.Length > 0)
				{
					status = (WorkOrderStatus)ViewState["status"];
					opstatus = (WorkOrderOperatorStatus)ViewState["opstatus"];

					if(status == WorkOrderStatus.Scheduled 
						&& e.CommandName != "Delete")
					{
						if(opstatus == WorkOrderOperatorStatus.Null)
						{
							Response.Redirect("wo_viewCheckIn.aspx?id=" + OrderId.ToString(), false);
							return;
						}
						else
						{
							Response.Redirect("wo_openWorkOrder.aspx?id=" + OrderId.ToString(), false);
							return;
						}
					}
					if(e.CommandName == "Complete")
					{
						Response.Redirect("wo_viewCompleteInspection.aspx?id=" + OrderId.ToString() + "&inspectid=" + e.CommandArgument, false);
						return;
					}

					if(e.CommandName == "Delete")
					{
						Header.BodyOnloadScript = "javascript:document.location='#Issues'";
						//Header.Render();

						order = new clsWorkOrders();
						order.cAction = "D";
						order.iOrgId = OrgId;
						order.iId = OrderId;
						order.iWOInspectionId = Convert.ToInt32(e.CommandArgument);
						order.iTechId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
						if(order.WorkOrderInspectionsDetail() == -1)
						{
							Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
							Session["error"] = _functions.ErrorMessage(124);
							Response.Redirect("error.aspx", false);
						}
						else
						{
							dtInspections = order.GetWorkOrderInspections();
							if(dtInspections.Rows.Count > 0)
								html_tblNoneInspections.Visible = false;
							else
								html_tblNoneInspections.Visible = true;

							repInspections.DataSource = new DataView(dtInspections);
							repInspections.DataBind();

							ShowRepairList();
						}
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

		private void repRepairs_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			try
			{
				if(e.CommandName == "Delete")
				{
					Header.BodyOnloadScript = "javascript:document.location='#Repairs'";
					//Header.Render();

					order = new clsWorkOrders();
					order.cAction = "D";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					order.iRepairId = Convert.ToInt32(e.CommandArgument);
					order.iTechId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
					if(order.RepairCommonDetails() == -1)
					{
						Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(128);
						Response.Redirect("error.aspx", false);
					}
					else
					{
						repIssues.DataSource = new DataView(order.GetWorkOrderReportedIssues());
						repIssues.DataBind();
						
						repPMItems.DataSource = new DataView(order.GetWorkOrderPMItems());
						repPMItems.DataBind();
						
						repInspections.DataSource = new DataView(order.GetWorkOrderInspections());
						repInspections.DataBind();

						ShowRepairList();
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
	}
}
