using System;
using System.Text;
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
	public class _wo_editWorkOrder : BFPPage
	{
		protected System.Web.UI.WebControls.DropDownList ddlTech;
		protected System.Web.UI.WebControls.RadioButtonList rblStaying;
		protected System.Web.UI.WebControls.TextBox tbDroppedOffBy;
		protected System.Web.UI.WebControls.TextBox tbReleasedTo;
		protected System.Web.UI.WebControls.Label lblWorkOrderId;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Repeater repCustomFields;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected ActiveUp.WebControls.ActiveDateTime adtScheduled;
		protected System.Web.UI.WebControls.TextBox tbCleanliness;
		protected System.Web.UI.WebControls.HyperLink hlEquipId;
		protected System.Web.UI.WebControls.HyperLink hlSpareEquipId;
		protected System.Web.UI.WebControls.HyperLink hlChangeSpare;
		protected System.Web.UI.HtmlControls.HtmlAnchor html_ScheduledDate;
		protected System.Web.UI.WebControls.RadioButtonList rblWOTypes;
		protected System.Web.UI.WebControls.Label lblCreatedDate;
		protected ActiveUp.WebControls.ActiveDateTime adtCheckIn;
		protected ActiveUp.WebControls.ActiveDateTime adtOpened;
		protected ActiveUp.WebControls.ActiveDateTime adtClosed;
		protected ActiveUp.WebControls.ActiveDateTime adtCheckOut;
		protected System.Web.UI.HtmlControls.HtmlTableRow trCheckInDate;
		protected System.Web.UI.HtmlControls.HtmlTableRow trOpenedDate;
		protected System.Web.UI.HtmlControls.HtmlTableRow trClosedDate;
		protected System.Web.UI.HtmlControls.HtmlTableRow trCheckOutDate;
		
		private clsWorkOrders order = null;
		private clsUsers user = null;
		private clsCustomFieldsDef cfd = null;

		private DataTable dtCustomFields = null;
		private DataTable dtCustomFieldsFromDB = null;

		private int OrderId;
		private ArrayList arrCFD = null;

		private WorkOrderStatus status;
		protected ActiveUp.WebControls.ActiveDateTime adtInspection;
		protected System.Web.UI.HtmlControls.HtmlTableRow trInspectionDate;
		private WorkOrderOperatorStatus opstatus;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_editWorkOrder.aspx.cs";

				this.PageTitle = "Work Order Edit";
				Header.AddJavaScriptFile("/OpenWindows.js");
				Header.LeftBarHtml = "Edit main information of the Work Order";
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
				
				// getting the Bread Crumbs from Cookie and add last item
                if (Request.Cookies.Count > 0 && Request.Cookies["bfp_navigate"] != null)
                    Header.BrdCrumbsSerialization = Request.Cookies["bfp_navigate"].Value;
                Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "&#Main");

				SaveCancelControl.ParentPageURL = this.ParentPageURL;
				
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					user = new clsUsers();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					user.iOrgId = OrgId;
					user.iTypeId = (int)UserTypes.Technician;

					rblWOTypes.DataSource = order.GetTypesList();
					rblWOTypes.DataBind();

					ddlTech.DataSource = new DataView(user.GetUserListByType());
					ddlTech.DataBind();
					
					if(order.WorkOrderDetails() == -1)
					{
						Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}
					
					status = (WorkOrderStatus)order.iStatusId.Value;
					opstatus = order.iOperatorStatusId.IsNull?WorkOrderOperatorStatus.Null:(WorkOrderOperatorStatus)order.iOperatorStatusId.Value;

					ViewState["StatusId"] = status;

					lblWorkOrderId.Text = order.daCreated.Value.ToString("yyyy-MM-dd") + "-" + order.iWorkOrderNumber.Value.ToString();
					rblWOTypes.SelectedValue = order.iTypeId.Value.ToString();
					hlEquipId.Text = order.sEquipId.Value;
					hlEquipId.NavigateUrl = "e_view.aspx?id=" + order.iEquipId.Value.ToString();
					hlSpareEquipId.Text = order.sSpareEquipId.Value;
					hlChangeSpare.NavigateUrl = "wo_selectSpareEquip.aspx?id=" + OrderId.ToString() + "&back=edit";
					if(order.iSpareEquipId.Value > 0)
						hlSpareEquipId.NavigateUrl = "e_view.aspx?id=" + order.iSpareEquipId.Value.ToString();
					if(order.iTechId.Value != 0)
					{
						ddlTech.Items.Remove(ddlTech.Items[0]);
						if(ddlTech.Items.FindByValue(order.iTechId.Value.ToString()) != null)
							ddlTech.SelectedValue = order.iTechId.Value.ToString();
						else
							Header.ErrorMessage = "Cannot find the assigned technician in the technician list";
					}
					lblOperator.Text = order.sOperatorName.Value;
					
					if(order.bStaying.Value)
						rblStaying.SelectedValue = "True";
					else
						rblStaying.SelectedValue = "False";
					tbDroppedOffBy.Text = order.sDropedOffBy.Value;
					tbReleasedTo.Text = order.sReleasedTo.Value;
					tbCleanliness.Text = order.sCleanliness.Value;
					adtScheduled.Date = order.daScheduled.Value;
					lblCreatedDate.Text = order.daCreated.Value.ToLongDateString();
					switch(status)
					{
						case WorkOrderStatus.Scheduled: // Scheduled status
							hlChangeSpare.Enabled = false;
							ddlTech.Enabled = false;
							rblStaying.Enabled = false;
							tbDroppedOffBy.Enabled = false;
							tbCleanliness.Enabled = false;
							tbReleasedTo.Enabled = false;
							adtScheduled.Enabled = true;
							html_ScheduledDate.Visible = true;
							SaveCancelControl.EnableSave = true;
							if(opstatus == WorkOrderOperatorStatus.Checked_In)
							{
								hlChangeSpare.Enabled = true;
								trCheckInDate.Visible = true;
								adtCheckIn.Date = order.daArrival.Value;
							}
							else
								trCheckInDate.Visible = false;
							trCheckOutDate.Visible = false;
							trClosedDate.Visible = false;
							trOpenedDate.Visible = false;
							break;
						case WorkOrderStatus.Open: // Opened status
							ViewState["ScheduledDate"] = order.daScheduled.Value;
							adtScheduled.Enabled = false;
							html_ScheduledDate.Visible = false;
							SaveCancelControl.EnableSave = true;
							trCheckInDate.Visible = true;
							adtCheckIn.Date = order.daArrival.Value;
							trOpenedDate.Visible = true;
							adtOpened.Date = order.daOpened.Value;
							trCheckOutDate.Visible = false;
							trClosedDate.Visible = false;
							break;
						case WorkOrderStatus.ReOpened: // Opened status
							ViewState["ScheduledDate"] = order.daScheduled.Value;
							adtScheduled.Enabled = false;
							html_ScheduledDate.Visible = false;
							SaveCancelControl.EnableSave = true;
							trCheckInDate.Visible = true;
							adtCheckIn.Date = order.daArrival.Value;
							trOpenedDate.Visible = true;
							adtOpened.Date = order.daOpened.Value;
							trCheckOutDate.Visible = false;
							trClosedDate.Visible = false;
							break;
						case WorkOrderStatus.Closed: // Closed Status
							ViewState["ScheduledDate"] = order.daScheduled.Value;
							hlChangeSpare.Enabled = false;
							ddlTech.Enabled = false;
							rblStaying.Enabled = false;
							tbDroppedOffBy.Enabled = true;
							adtScheduled.Enabled = false;
							html_ScheduledDate.Visible = false;
							tbCleanliness.Enabled = true;
							tbReleasedTo.Enabled = true;
							SaveCancelControl.EnableSave = true;
							trCheckInDate.Visible = true;
							adtCheckIn.Date = order.daArrival.Value;
							trOpenedDate.Visible = true;
							adtOpened.Date = order.daOpened.Value;
							trClosedDate.Visible = true;
							adtClosed.Date = order.daClosed.Value;
							if(opstatus  == WorkOrderOperatorStatus.Checked_Out)
							{
								trCheckOutDate.Visible = true;
								adtCheckOut.Date = order.daDeparture.Value;
							}
							else
								trCheckOutDate.Visible = false;
							break;

					}
					if(order.iOperatorId.Value == 6)
						hlChangeSpare.Enabled = false;
					
					ShowCustomFields();

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

		
		#region Show Custom Fields
		/// <summary>
		/// Procedure is closing the custom fields of the work order 
		/// </summary>
		private void ShowCustomFields()
		{
			int j;
			string sTypeName;
			try
			{
				// getting the custom fields of Work Order
				arrCFD = _functions.GetCustomFields(CFDataType.WorkOrder, 0, HttpContext.Current.User.Identity.Name);
					
				if(arrCFD != null)
				{
					// initializing the data table for custom fields
					dtCustomFields = new DataTable();
					
					dtCustomFields.Columns.Add("TypeName");
					dtCustomFields.Columns.Add("ValueName");
					dtCustomFields.Columns.Add("Value_String");
					dtCustomFields.Columns.Add("Value_Boolean");
					dtCustomFields.Columns.Add("Value_Int");
					dtCustomFields.Columns.Add("Value_DateTime");
					dtCustomFields.Columns.Add("TB_Visible");
					dtCustomFields.Columns.Add("DDL_Visible");
					dtCustomFields.Columns.Add("CB_Visible");
					dtCustomFields.Columns.Add("MM_Visible");
					dtCustomFields.Columns.Add("DT_Visible");
					dtCustomFields.Columns.Add("Help");
					dtCustomFields.Columns.Add("RFV_Visible");
					dtCustomFields.Columns.Add("Val_Visible");
					dtCustomFields.Columns.Add("ErrorMessage");
					dtCustomFields.Columns.Add("Exp");

					DataColumn dcEnabled = new DataColumn("Enabled");
					if(order.iStatusId.Value == (int)WorkOrderStatus.Open || 
						order.iStatusId.Value == (int)WorkOrderStatus.ReOpened)
						dcEnabled.DefaultValue = "True";
					else
						dcEnabled.DefaultValue = "False";
					dtCustomFields.Columns.Add(dcEnabled);
				
					dtCustomFieldsFromDB = order.WorkOrderDetail_CustomFields(null);
				
					// filling custom fields in the dtCustomFields table
					for(j = 0; j < arrCFD.Count; j++)
					{
						cfd = (clsCustomFieldsDef)arrCFD[j];
						sTypeName = _functions.GetFieldTypeText(cfd.FieldTypeId) + cfd.NumberColumn.ToString();
						switch(cfd.FieldTypeId)
						{
							case DBFieldType._nvarchar:
								if(OrderId == 0)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
								else
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
								else
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, dtCustomFieldsFromDB.Rows[0][sTypeName], "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
								break;
							case DBFieldType._int:
								if(OrderId == 0)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "True", cfd.NameText + " must be numeric", "^\\d{0,10}?$"});
								else
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "True", cfd.NameText + " must be numeric", "^\\d{0,10}?$"});
								else
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, dtCustomFieldsFromDB.Rows[0][sTypeName], "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "True", cfd.NameText + " must be numeric", "^\\d{0,10}?$"});
								break;
							case DBFieldType._float:
								if(OrderId == 0)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "True", cfd.NameText + " must be decimal numeric", "^\\d{0,8}(?:\\.\\d{0,8})?$"});
								else
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "True", cfd.NameText + " must be decimal numeric", "^\\d{0,8}(?:\\.\\d{0,8})?$"});
								else
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, dtCustomFieldsFromDB.Rows[0][sTypeName], "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "True", cfd.NameText + " must be decimal numeric", "^\\d{0,8}(?:\\.\\d{0,8})?$"});
								break;
							case DBFieldType._datetime:
								if(OrderId == 0)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "1970-01-01", "False", "False", "False", "False", "True", cfd.Help, "False", "False", "", ""});
								else
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "1970-01-01", "False", "False", "False", "False", "True", cfd.Help, "False", "False", "", ""});
								else
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, dtCustomFieldsFromDB.Rows[0][sTypeName], "False", "False", "False", "False", "True", cfd.Help, "False", "False", "", ""});
								break;
							case DBFieldType._bit:
								if(OrderId == 0)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "False", "False", "True", "False", "False", cfd.Help, "False", "False", "", ""});
								else
								{
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "False", "False", "True", "False", "False", cfd.Help, "False", "False", "", ""});
									else
									{
										if(((bool)dtCustomFieldsFromDB.Rows[0][sTypeName]) == true)
											dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "True", 0, "2000-01-01", "False", "False", "True", "False", "False", cfd.Help, "False", "False", "", ""});
										else
											dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "False", "False", "True", "False", "False", cfd.Help, "False", "False", "", ""});
									}
								}
								break;
							case DBFieldType._ntext:
								if(OrderId == 0)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
								else
								{
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, (string)dtCustomFieldsFromDB.Rows[0][sTypeName], "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
								}
								break;
							case DBFieldType._sql_variant:
								if(OrderId == 0)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
								else
								{
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, (string)dtCustomFieldsFromDB.Rows[0][sTypeName], "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
								}
								break;
							case DBFieldType._lookup:
								if(OrderId == 0)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, 0, "False", 0, "2000-01-01", "False", "True", "False", "False", "False", cfd.Help, "False", "False", "", ""});
								else
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, 0, "False", 0, "2000-01-01", "False", "True", "False", "False", "False", cfd.Help, "False", "False", "", ""});
								else
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, dtCustomFieldsFromDB.Rows[0][sTypeName], "False", 0, "2000-01-01", "False", "True", "False", "False", "False", cfd.Help, "False", "False", "", ""});
								break;
							default:
								break;
						}
						cfd = null;
					}

					// binding main datalist
					ViewState["CustomFields"] = dtCustomFields;
					repCustomFields.DataSource = new DataView(dtCustomFields);
					repCustomFields.DataBind();
				}
				else
					ViewState["CustomFields"] = null;
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}
		#endregion

		#region Save Work Order
		/// <summary>
		/// Procedure is updating the work order info
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			string sDataGridName;
			DBFieldType FieldType;
			DateTime daCurrentDate, daScheduled;
			try
			{
				#region saving the static data
				daCurrentDate = DateTime.Now;
				status = (WorkOrderStatus)ViewState["StatusId"];
				order = new clsWorkOrders();
				order.cAction = "U";
				order.bWizardUpdate = false;
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.iTypeId = Convert.ToInt32(rblWOTypes.SelectedValue);
				order.iTechId = Convert.ToInt32(ddlTech.SelectedValue);
				order.bStaying = Convert.ToBoolean(rblStaying.SelectedValue);
				order.sDropedOffBy = tbDroppedOffBy.Text;
				order.sReleasedTo = tbReleasedTo.Text;
				order.sCleanliness = tbCleanliness.Text;
				order.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				
				if(ViewState["ScheduledDate"] == null)
				{
					order.daScheduled = _functions.CorrectDate(adtScheduled.Date);
				}
				else
					order.daScheduled = (DateTime)ViewState["ScheduledDate"];
				if(trCheckInDate.Visible)
					order.daArrival = _functions.CorrectDate(adtCheckIn.Date);
				if(trOpenedDate.Visible)
					order.daOpened = _functions.CorrectDate(adtOpened.Date);
				if(trClosedDate.Visible)
					order.daClosed = _functions.CorrectDate(adtClosed.Date);
				if(trCheckOutDate.Visible)
					order.daDeparture = _functions.CorrectDate(adtCheckOut.Date);
				order.daUpdated = daCurrentDate;
				if(order.WorkOrderDetails() == -1)
				{
					Session["lastpage"] = "wo_editWorkOrder.aspx?id=" + OrderId.ToString();
					Session["error"] = _functions.ErrorMessage(120);
					Response.Redirect("error.aspx", false);
					return;
				}
				#endregion

				if(status == WorkOrderStatus.Open || status == WorkOrderStatus.ReOpened)
				{
					#region saving cutom fields
					if(ViewState["CustomFields"] != null)
					{
						order.iId = OrderId;
						dtCustomFields = (DataTable)ViewState["CustomFields"];
				
						sDataGridName = repCustomFields.ClientID;

						// getting data from Form and changing the dtCustomFields datatable
						for(int i=0; i<dtCustomFields.Rows.Count; i++)
						{
							for(int j=0; j<Request.Form.Count; j++)
							{
								if((string)dtCustomFields.Rows[i]["TypeName"] == Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":inputTypeName"])
								{
									FieldType = _functions.TypeNameParser((string)dtCustomFields.Rows[i]["TypeName"]); // nvarchar1...n, ...
									switch(FieldType)
									{
										case DBFieldType._nvarchar:
											dtCustomFields.Rows[i]["Value_String"] = Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":tbValue"];
											break;
										case DBFieldType._int:
											dtCustomFields.Rows[i]["Value_String"] = Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":tbValue"];
											break;
										case DBFieldType._float:
											dtCustomFields.Rows[i]["Value_String"] = Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":tbValue"];
											break;
										case DBFieldType._datetime:
											dtCustomFields.Rows[i]["Value_String"] = new SqlDateTime(Convert.ToInt32(Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":adtValue_year"]), 
												Convert.ToInt32(Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":adtValue_month"]),
												Convert.ToInt32(Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":adtValue_day"]));
											break;
										case DBFieldType._bit:
											if(Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":chValue"] != null)
											{
												dtCustomFields.Rows[i]["Value_String"] = "True";
											}
											else
											{
												dtCustomFields.Rows[i]["Value_String"] = "False";
											}
											break;
										case DBFieldType._ntext:
											dtCustomFields.Rows[i]["Value_String"] = Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":tbValue"];
											break;
										case DBFieldType._sql_variant:
											dtCustomFields.Rows[i]["Value_String"] = Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":tbValue"];
											break;
										case DBFieldType._lookup:
											dtCustomFields.Rows[i]["Value_String"] = Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":ddlValue"];
											break;
										default:
											dtCustomFields.Rows[i]["Value_String"] = Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":tbValue"];
											break;
									}
								}
							}
						}
						// saving data to database
						order.WorkOrderDetail_CustomFields(_functions.SetDataToParameters(dtCustomFields));
					}
					#endregion
				}
				Response.Redirect("wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "&#Main", false);
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "wo_editWorkOrder.aspx?id=" + OrderId.ToString();
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_editWorkOrder.aspx?id=" + OrderId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(order != null)
				{
					order.Dispose();
				}
			}
		}
		#endregion

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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
