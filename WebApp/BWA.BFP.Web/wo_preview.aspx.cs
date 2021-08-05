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
	public class _wo_preview : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Signature Signature;
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Label lblWorkOrderN;
		protected System.Web.UI.WebControls.HyperLink hlPMItems;
		protected System.Web.UI.WebControls.HyperLink hlInspections;
		protected System.Web.UI.WebControls.HyperLink hlStart;
		protected System.Web.UI.WebControls.Label lblStatus;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.WebControls.Label lblStaying;
		protected System.Web.UI.WebControls.Label lblSpare;
		protected System.Web.UI.WebControls.Label lblTech;
		protected System.Web.UI.WebControls.Label lblDroppedOffBy;
		protected System.Web.UI.WebControls.Label lblArrivalDate;
		protected System.Web.UI.WebControls.HyperLink hlEquipId;
		protected System.Web.UI.WebControls.Label lblType;
		protected System.Web.UI.WebControls.Label lblMakeModel;
		protected System.Web.UI.WebControls.Label lblYear;
		protected System.Web.UI.WebControls.Label lblUnits;
		protected System.Web.UI.WebControls.Repeater repCustomFields;
		protected System.Web.UI.WebControls.HyperLink hlIssues;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneIssues;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNonePMItems;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneInspections;
		protected System.Web.UI.WebControls.Repeater repIssues;
		protected System.Web.UI.WebControls.Repeater repPMItems;
		protected System.Web.UI.WebControls.Repeater repInspections;
		protected System.Web.UI.WebControls.Label lblOperatorStatus;
		protected System.Web.UI.WebControls.Label lblScheduledDate;
		protected System.Web.UI.WebControls.Repeater repCreationNotes;
		protected System.Web.UI.WebControls.Repeater repOperatorNotes;
		protected System.Web.UI.WebControls.Label lblWOType;

		private clsWorkOrders order = null;
		private clsMakesModels mm = null;
		private clsDepartments dep = null;
		private clsLocations loc = null;
		private clsUsers user = null;
		private clsCustomFieldsDef cfd = null;

		private DataSet dsRepairs = null;
		private DataView dwPMItems = null;
		private DataView dwInspections = null;
		private DataTable dtCustomFields = null;
		private DataTable dtCustomFieldsFromDB = null;
		private ArrayList arrCFD = null;

		private int OrderId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_preview.aspx.cs";

				this.PageTitle = "Work Order Preview";
				Header.LeftBarHtml = "View and Check a input data of work order";
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
			try
			{
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
				NextBackControl.BackPage = "wo_addInspections.aspx?id=" + OrderId.ToString();
				NextBackControl.BackVisible = true;
				NextBackControl.NextText = "Open/Finish";
				
				if(!IsPostBack)
				{
					hlStart.NavigateUrl = "wo_openWorkOrder.aspx?id=" + OrderId.ToString();
					hlInspections.NavigateUrl = "wo_addInspections.aspx?id=" + OrderId.ToString();
					hlIssues.NavigateUrl = "wo_addRepairs.aspx?id=" + OrderId.ToString() + "&back=open";
					hlPMItems.NavigateUrl = "wo_addPreventiveMaintenance.aspx?id=" + OrderId.ToString() + "&back=preview";

					dtCustomFields = new DataTable();
					dtCustomFields.Columns.Add("ValueName");
					dtCustomFields.Columns.Add("Value");

					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					if(order.WorkOrderDetails() == -1)
					{
						Session["lastpage"] = "wo_addInspections.aspx?id=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}
					if(order.iStatusId.Value != (int)WorkOrderStatus.Scheduled ||
						order.iOperatorStatusId.Value !=(int)WorkOrderOperatorStatus.Checked_In)
					{
						Signature.sError = _functions.ErrorMessage(144);
						NextBackControl.NextEnabled = false;
					}


					// showing main info
					lblWorkOrderN.Text = order.daCreated.Value.ToString("yyyy-MM-dd") + "-" + order.iWorkOrderNumber.Value.ToString();
					lblWOType.Text = order.sType.Value;
					lblStatus.Text = order.sStatusId.Value;
					lblOperatorStatus.Text = order.sOperatorStatus.Value;
					lblOperator.Text = order.sOperatorName.Value;
					lblStaying.Text = order.bStaying.IsNull?"not defined":(order.bStaying.Value?"Yes":"No");
					lblSpare.Text = order.sSpareEquipId.Value;
					lblTech.Text = order.sTechName.Value;
					lblDroppedOffBy.Text = order.sDropedOffBy.Value;
					lblArrivalDate.Text = order.daArrival.IsNull?"":order.daArrival.Value.ToLongDateString();
					lblScheduledDate.Text = order.daScheduled.Value.ToLongDateString();
					
					hlEquipId.Text = order.sEquipId.Value;
					hlEquipId.NavigateUrl = "e_view.aspx?id=" + order.iEquipId.Value.ToString();
					lblType.Text = order.sEquipTypeName.Value;
					lblMakeModel.Text = order.sEquipMakeModel.Value;
					lblYear.Text = (order.sEquipYear.Value == "0")?"unknown":order.sEquipYear.Value;
					lblUnits.Text = Convert.ToDouble(order.dmMileage.Value).ToString();
					
					// showing issues
					dsRepairs = order.GetReportedIssueLists();
					if(dsRepairs.Tables[0].Rows.Count > 0)
					{
						html_tblNoneIssues.Visible = false;
					}
					else
					{
						html_tblNoneIssues.Visible = true;
					}
					repIssues.DataSource = new DataView(dsRepairs.Tables[0]);
					repIssues.DataBind();

					// showing the pm items
					dwPMItems = new DataView(order.GetPMServicesListForWorkOrder());
					dwPMItems.RowFilter = "IsChecked='True'";
					if(dwPMItems.Count > 0)
					{
						html_tblNonePMItems.Visible = false;
					}
					else
					{
						html_tblNonePMItems.Visible = true;
					}
					repPMItems.DataSource = dwPMItems;
					repPMItems.DataBind();

					// showing the inspections
					dwInspections = new DataView(order.GetInspectionsListForWorkOrder());
					dwInspections.RowFilter = "IsChecked='True'";
					if(dwInspections.Count > 0)
					{
						html_tblNoneInspections.Visible = false;
					}
					else
					{
						html_tblNoneInspections.Visible = true;
					}
					repInspections.DataSource = dwInspections;
					repInspections.DataBind();

					// showing notes

					order.iItemId = OrderId;
					order.iNoteTypeId = (int)NoteTypes.CreationNote;
					repCreationNotes.DataSource = new DataView(order.GetNotesList());
					repCreationNotes.DataBind();
					
					order.iNoteTypeId = (int)NoteTypes.OperatorNote;
					repOperatorNotes.DataSource = new DataView(order.GetNotesList());
					repOperatorNotes.DataBind();

					#region Showing custom fields of order on screen
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
												mm.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
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
												dep.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
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
												loc.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
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
				Session["lastpage"] = "wo_addInspections.aspx?id=" + OrderId.ToString();
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


		#region Next Screen
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.sInitials = Signature.sInitials;
				order.sPIN = Signature.sPIN;
				order.daCurrentDate = DateTime.Now;
				switch(order.SigningWorkOrderOpen())
				{
					case -1:
						Signature.sError = _functions.ErrorMessage(140);
						break;
					case -2:
						Session["lastpage"] = "wo_preview.aspx?id=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					case 0:
						// redirect to the finish screen
						BackFinishScreen finish = new BackFinishScreen();
						
						finish.sMainText = "The Work Order opened successfully!";

						finish.bMainMenuVisible = true;
						finish.sMainMenuText = "[Return to Main Menu]";
						finish.sMainMenuURL = "main.aspx";

						finish.bContinueVisible = false;
					
						finish.bViewVisible = true;
						finish.sViewText = "[View the Opened Work Order]";
						finish.sViewURL = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
					
						finish.bAdditionalVisible = false;
					
						finish.bPrintVisible = true;
						finish.sPrintText = "[Print the Opened Work Order]";
						finish.sPrintURL = "ReportViewer.aspx?Report=FleetProReports%2fWorkOrderRequest&rs:Command=Render&rc:Parameters=false&OrderId=" + OrderId.ToString() + "&OrgId=" + OrgId.ToString();

						Session["BackFinish"] = finish;

						Response.Redirect("wo_finish.aspx", false);
						break;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_preview.aspx?id=" + OrderId.ToString();
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
