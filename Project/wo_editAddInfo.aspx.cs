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
	public class _wo_editAddInfo : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Repeater repCustomFields;
		protected ActiveUp.WebControls.ActiveDateTime adtScheduled;
		protected System.Web.UI.HtmlControls.HtmlAnchor html_ScheduledDate;
		protected System.Web.UI.WebControls.RadioButtonList rblWOTypes;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvTypes;
		
		private clsWorkOrders order = null;
		private clsUsers user = null;
		private clsEquipment equip = null;
		private clsCustomFieldsDef cfd = null;

		private ArrayList arrCFD = null;
		private DataTable dtCustomFields = null;
		private DataTable dtCustomFieldsFromDB = null;

		private int EquipId;
		private int OrderId;

		private bool IsPast = false;

		private string m_sLastPage;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_addInspectForecast.aspx";
				
				this.PageTitle = "Create the Work Order";
				Header.AddJavaScriptFile("/OpenWindows.js");
				Header.LeftBarHtml = "Select Scheduled date and Create Work Order";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_default.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			DateTime dtCurrentDate;
			try
			{
				SourcePageName = "wo_editAddInfo.aspx.cs";

				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				if(Request.QueryString["id"] == null || Request.QueryString["equipid"] == null)
				{
					Session["lastpage"] = "wo_default.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId = Convert.ToInt32(Request.QueryString["equipid"]);
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "wo_default.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				if(EquipId == 0 && OrderId == 0)
				{
					Session["lastpage"] = "wo_default.aspx";
					Session["error"] = _functions.ErrorMessage(102);
					Response.Redirect("error.aspx", false);
					return;
				}
				m_sLastPage = "wo_editAddInfo.aspx?id=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
				if(Request.QueryString["back"] != null)
					if(Request.QueryString["back"] == "past")
					{
						IsPast = true;
						this.PageTitle = "Create the Past Work Order";	
						m_sLastPage = "wo_editAddInfo.aspx?back=past&id=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					}
				
				NextBackControl.BackVisible = false;
				if(!IsPostBack)
				{
					dtCurrentDate = DateTime.Now;
					// getting the main (fixed) data 
					order = new clsWorkOrders();

					rblWOTypes.DataSource = order.GetTypesList();
					rblWOTypes.DataBind();

					order.iOrgId = OrgId;
					order.iEquipId = EquipId;
					order.iId = OrderId;
					
					if(order.GetInfoForWorkOrder() == -1)
					{
						Session["lastpage"] = "wo_default.aspx";
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblEquipId.Text = order.sEquipId.Value;
					if(order.iTypeId.Value != 0)
						rblWOTypes.SelectedValue = order.iTypeId.Value.ToString();
					if(!order.daScheduled.IsNull)
						adtScheduled.Date = order.daScheduled.Value;
					else
						adtScheduled.Date = dtCurrentDate.AddMinutes(60-dtCurrentDate.Minute);
					
					if(OrderId != 0)
					{
						order.cAction = "S";
						order.iNoteId = 0;
						order.iNoteTypeId = (int)NoteTypes.CreationNote;
						order.iItemId = OrderId;
						if(order.NoteDetails() != -1)
						{
							tbNotes.Text = order.sNote.Value;
							ViewState["NoteId"] = order.iNoteId.Value;
						}
						else
							ViewState["NoteId"] = 0;
					}
					else
						ViewState["NoteId"] = 0;

					ShowCustomFields();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_default.aspx";
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
				if(equip != null)
					equip.Dispose();
			}
		}
		

		#region Show Custom Fields
		/// <summary>
		/// Procedure is showing the equipment's custom fields on screen
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

					if(OrderId != 0)
					{
						order.cAction = "S";
						order.iId = OrderId;
						order.iOrgId = OrgId;
						dtCustomFieldsFromDB = order.WorkOrderDetail_CustomFields(null);
					}
					else
					{
						dtCustomFieldsFromDB = null;
					}
				
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

		#region Next Screen
		/// <summary>
		/// Procedure is adding a new work order into database and redirecting to next screen
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			string sDataGridName;
			DBFieldType FieldType;
			DateTime daCurrent, CorrectDate;
			try
			{
				#region saving the static data
				order = new clsWorkOrders();
				if(IsPast)
				{
					order.cAction = "U";
					order.bWizardUpdate = true;
					order.iOrgId = OrgId;
					order.iId = OrderId;
					order.iEquipId = EquipId;
					order.iStatusId = (int)WorkOrderStatus.Scheduled;
					CorrectDate = _functions.CorrectDate(adtScheduled.Date);
					daCurrent = CorrectDate;
					order.daScheduled = CorrectDate;
					order.iTypeId = Convert.ToInt32(rblWOTypes.SelectedValue);
					order.sDecs = tbNotes.Text;
					order.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
					order.daUpdated = daCurrent;
					order.daCreated = daCurrent;
				}
				else
				{
					daCurrent = DateTime.Now;
					CorrectDate = _functions.CorrectDate(adtScheduled.Date);
					if(CorrectDate < daCurrent)
					{
						Header.ErrorMessage = "The Scheduled date must be in future";
						ShowCustomFields();
						return;
					}
					if(Convert.ToInt32(rblWOTypes.SelectedValue) < 1)
					{
						Header.ErrorMessage = "Work Order Type is required";
						ShowCustomFields();
						return;
					}

					order.cAction = "U";
					order.bWizardUpdate = true;
					order.iOrgId = OrgId;
					order.iId = OrderId;
					order.iEquipId = EquipId;

					order.iStatusId = (int)WorkOrderStatus.Scheduled;

					order.daScheduled = CorrectDate;

					order.iTypeId = Convert.ToInt32(rblWOTypes.SelectedValue);
					order.sDecs = tbNotes.Text;

					order.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
					order.daUpdated = daCurrent;
					order.daCreated = daCurrent;
				}
				if(OrderId == 0)OrderId = order.WorkOrderDetails();
				else order.WorkOrderDetails();

				if(tbNotes.Text.Length > 0)
				{
					order.iNoteId = (int)ViewState["NoteId"];
					order.iNoteTypeId = (int)NoteTypes.CreationNote;
					order.iItemId = OrderId;
					order.daCreated = daCurrent;
					order.sNote = tbNotes.Text;
					order.NoteDetails();
				}

				#endregion

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

				// redirect to next screen
				if(IsPast)
					Response.Redirect("wo_addInspections.aspx?id=" + OrderId.ToString() + "&back=past", false);
				else
					Response.Redirect("wo_addRepairs.aspx?id=" + OrderId.ToString(), false);
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = m_sLastPage;
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
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
				{
					order.Dispose();
				}
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
