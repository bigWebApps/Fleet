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
	public class _wo_closeWorkOrder : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Signature Signature;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Label lblWorkOrderId;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Label lblSpareEquipId;
		protected System.Web.UI.WebControls.Label lblTech;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.WebControls.TextBox tbCleanliness;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvNotes;
		protected System.Web.UI.WebControls.Repeater repTechNotes;
		protected System.Web.UI.WebControls.Repeater repCustomFields;
		protected System.Web.UI.WebControls.TextBox tbTechNote;
		protected System.Web.UI.WebControls.TextBox tbCheckOutNote;
		protected ActiveUp.WebControls.ActiveDateTime adtClosed;

		private int OrderId;
		private clsWorkOrders order = null;
		private clsUsers user = null;
		private clsCustomFieldsDef cfd = null;

		private ArrayList arrCFD = null;
		private DataTable dtCustomFields = null;
		private DataTable dtCustomFieldsFromDB = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_closeWorkOrder.aspx.cs";

				this.PageTitle = "Close Work Order";
				Header.LeftBarHtml = "Enter Check-Out Note for operator, your Signature and Close the Work Order";
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
                Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString());

				SaveCancelControl.ParentPageURL = this.ParentPageURL;
				SaveCancelControl.ButtonText = "  Close & Sign  ";
				
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					user = new clsUsers();
					
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					if(order.WorkOrderDetails() == -1)
					{
						Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}

					if(!user.IsTechnician(_functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true)))
					{
						Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(131);
						Response.Redirect("error.aspx", false);
						return;
					}
					if(order.iTechId.Value == 0)
					{
						Signature.sError = _functions.ErrorMessage(143);
						SaveCancelControl.EnableSave = false;
					}
					if(order.GetCompleteAbleOrder() != 1)
					{
						Signature.sError = _functions.ErrorMessage(142);
						SaveCancelControl.EnableSave = false;
					}

					lblWorkOrderId.Text = order.daCreated.Value.ToString("yyyy-MM-dd") + "-" + order.iWorkOrderNumber.Value.ToString();
					lblEquipId.Text = order.sEquipId.Value;
					lblSpareEquipId.Text = order.sSpareEquipId.Value;
					lblTech.Text = order.sTechName.Value;
					lblOperator.Text = order.sOperatorName.Value;
					tbCleanliness.Text = order.sCleanliness.Value;
					if(order.daClosed.IsNull)
						adtClosed.Date = DateTime.Now;
					else
						adtClosed.Date = order.daClosed.Value;

					if(order.iStatusId.Value == (int)WorkOrderStatus.Closed
						|| order.iStatusId.Value == (int)WorkOrderStatus.Scheduled)
					{
						tbCleanliness.Enabled = false;
						tbTechNote.Enabled = false;
						tbCheckOutNote.Enabled = false;
						Signature.Enabled = false;
						SaveCancelControl.EnableSave = false;
						Signature.sError = _functions.ErrorMessage(141);
					}
					// show notes
					order.iItemId = OrderId;
					order.iNoteTypeId = (int)NoteTypes.TechnicianNote;
					repTechNotes.DataSource = new DataView(order.GetNotesList());
					repTechNotes.DataBind();
					
					order.iNoteId = 0;
					order.iNoteTypeId = (int)NoteTypes.CheckOutNote;
					if(order.NoteDetails() != -1)
					{
						tbCheckOutNote.Text = order.sNote.Value;
					}
					
					ShowCustomFields();
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

		#region Close Work Order
		/// <summary>
		/// Procedure close and sign the work order
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			string sDataGridName;
			DBFieldType FieldType;
			DateTime daCurrentDate;
			try
			{
				daCurrentDate = DateTime.Now;
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				order.sInitials = Signature.sInitials;
				order.sPIN = Signature.sPIN;
				order.sCleanliness = tbCleanliness.Text;
				order.daCurrentDate = _functions.CorrectDate(adtClosed.Date);
				if(order.SigningWorkOrderClose() == -1)
				{
					Signature.sError = _functions.ErrorMessage(140);
				}
				else
				{
					order.cAction = "U";
					order.iNoteId = 0;
					order.iItemId = OrderId;
					order.daCreated = daCurrentDate;
						
					if(tbTechNote.Text.Length > 0)
					{
						order.iNoteTypeId = (int)NoteTypes.TechnicianNote;
						order.sNote = tbTechNote.Text;
						order.NoteDetails();
					}
					if(tbCheckOutNote.Text.Length > 0)
					{
						order.iNoteTypeId = (int)NoteTypes.CheckOutNote;
						order.sNote = tbCheckOutNote.Text;
						order.NoteDetails();
					}

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

					// redirect to the finish screen
					BackFinishScreen finish = new BackFinishScreen();
						
					finish.sMainText = "The Work Order closed successfully!";

					finish.bMainMenuVisible = true;
					finish.sMainMenuText = "[Return to Main Menu]";
					finish.sMainMenuURL = "main.aspx";

					finish.bContinueVisible = true;
					finish.sContinueText = "[Continue to Check-Out Equipment by Technician]";
					finish.sContinueURL = "wo_viewCheckOut.aspx?id=" + OrderId.ToString();

					finish.bViewVisible = true;
					finish.sViewText = "[Return to Work Order Detail]";
					finish.sViewURL = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
					
					finish.bAdditionalVisible = false;
					
					finish.bPrintVisible = true;
					finish.sPrintText = "[Print the Closed Work Order]";
					finish.sPrintURL = "ReportViewer.aspx?Report=FleetProReports%2fCompletedOrder&OrderId=" + OrderId.ToString()+ "&OrgId=" + OrgId.ToString();

					Session["BackFinish"] = finish;

					Response.Redirect("wo_finish.aspx", false);
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_closeWorkOrder.aspx?id=" + OrderId.ToString();
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
