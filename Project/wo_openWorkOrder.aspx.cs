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
	public class _wo_openWorkOrder : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Label lblWorkOrderId;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.WebControls.DropDownList ddlTech;
		protected System.Web.UI.WebControls.TextBox tbDroppedOffBy;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvAssignTech;
		protected System.Web.UI.WebControls.HyperLink hlEquipId;
		protected System.Web.UI.WebControls.HyperLink hlSpareEquipId;
		protected System.Web.UI.WebControls.Label lblStaying;
		protected System.Web.UI.WebControls.TextBox tbMileage;
		protected System.Web.UI.WebControls.Label lblMeasure;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvMileage;
		protected System.Web.UI.WebControls.RangeValidator valRangeUnits;
		protected System.Web.UI.WebControls.RegularExpressionValidator revMiles;
		protected System.Web.UI.WebControls.Repeater repCustomFields;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected System.Web.UI.WebControls.Label lblScheduledDate;
		protected System.Web.UI.WebControls.Label lblArrivalDate;
		protected System.Web.UI.WebControls.Label lblClerkNote;
		
		private int OrderId;
		private clsWorkOrders order = null;
		private clsEquipment equip = null;
		private clsUsers user = null;
		private clsCustomFieldsDef cfd = null;

		private ArrayList arrCFD = null;
		private DataTable dtCustomFields = null;
		protected ActiveUp.WebControls.ActiveDateTime adtOpened;
		private DataTable dtCustomFieldsFromDB = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_openWorkOrder.aspx.cs";

				this.PageTitle = "Open Work Order";
				Header.LeftBarHtml = "Open the Work Order";
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

				NextBackControl.BackPage = ParentPageURL;
				NextBackControl.BackVisible = true;
				NextBackControl.CausesValidation = true;
				
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					user = new clsUsers();
						
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					user.iOrgId = OrgId;
					user.iTypeId = (int)UserTypes.Technician;

					ddlTech.DataSource = new DataView(user.GetUserListByType());
					ddlTech.DataBind();

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
					hlEquipId.Text = order.sEquipId.Value;
					hlEquipId.NavigateUrl = "e_view.aspx?id=" + order.iEquipId.Value.ToString();
					hlSpareEquipId.Text = order.sSpareEquipId.Value;
					if(order.iSpareEquipId.Value > 0)
						hlSpareEquipId.NavigateUrl = "e_view.aspx?id=" + order.iSpareEquipId.Value.ToString();
					lblOperator.Text = order.sOperatorName.Value;
					lblScheduledDate.Text = order.daScheduled.Value.ToLongDateString() + " " + order.daScheduled.Value.ToLongTimeString();
					if(order.bStaying.Value)
						lblStaying.Text = "Yes";
					else
						lblStaying.Text = "No";
					if(ddlTech.Items.FindByValue(order.iTechId.Value.ToString()) != null)
					{
						ddlTech.SelectedValue = order.iTechId.Value.ToString();
					}
					else
					{
						ddlTech.SelectedIndex = 0;
					}
					tbDroppedOffBy.Text = order.sDropedOffBy.Value;
					if(order.iStatusId.Value == (int)WorkOrderStatus.Scheduled &&
						order.iOperatorStatusId.Value ==(int)WorkOrderOperatorStatus.Checked_In)
						lblArrivalDate.Text = order.daArrival.IsNull?"":order.daArrival.Value.ToLongDateString();
					else
					{
						NextBackControl.NextEnabled = false;
						tbMileage.Enabled = false;
						ddlTech.Enabled = false;
						tbDroppedOffBy.Enabled = false;
						tbNotes.Enabled = false;
						Header.ErrorMessage = _functions.ErrorMessage(137);
					}
					if(order.daOpened.IsNull)
						adtOpened.Date = DateTime.Now;
					else
						adtOpened.Date = order.daOpened.Value;
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iId = order.iEquipId;
					if(equip.GetEquipInfo() == -1)
					{
						Session["lastpage"] = this.ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					tbMileage.Text = equip.dmCurrentUnits.Value.ToString("F");
					valRangeUnits.MinimumValue = equip.dmCurrentUnits.Value.ToString();
					valRangeUnits.ErrorMessage = "Value must be greater than was " + equip.dmCurrentUnits.Value.ToString("F") + "<br>";
					lblMeasure.Text = equip.sMeasure.Value;
					
					order.iNoteId = 0;
					order.iNoteTypeId = (int)NoteTypes.CreationNote;
					order.iItemId = OrderId;
					if(order.NoteDetails() != -1)
					{
						lblClerkNote.Text = order.sNote.Value;
					}
					
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
				if(equip != null)
					equip.Dispose();
				
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
					if(order.iStatusId.Value == (int)WorkOrderStatus.Scheduled &&
						order.iOperatorStatusId.Value == (int)WorkOrderOperatorStatus.Checked_In)
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

		#region Open Work Order
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			string sDataGridName;
			DBFieldType FieldType;
			try
			{
				order = new clsWorkOrders();
				
				#region saving the static data
				order.iOrgId = OrgId;
				order.iId = OrderId;

				if(ddlTech.SelectedValue != "0")
					order.iTechId = Convert.ToInt32(ddlTech.SelectedValue);
				else
				{
					Header.ErrorMessage = "The assigned technician is required";
					order.cAction = "S";
					order.iStatusId = (int)WorkOrderStatus.Scheduled;
					order.iOperatorStatusId =(int)WorkOrderOperatorStatus.Checked_In;
					ShowCustomFields();
					return;
				}
				
				order.dmMileage = Convert.ToDecimal(tbMileage.Text);
				order.sDropedOffBy = tbDroppedOffBy.Text;
				order.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				order.daOpened = _functions.CorrectDate(adtOpened.Date);
				order.daCurrentDate = DateTime.Now;
				
				int l_iResult =  order.UpdateOpenWorkOrder();
				switch(l_iResult)
				{
					case -1:
						Session["lastpage"] = "wo_openWorkOrder.aspx?id=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					case -2:
						Header.ErrorMessage = _functions.ErrorMessage(167);
						return;
					default:
						break;
				}
				if(tbNotes.Text.Length > 0)
				{
					order.cAction = "U";
					order.iNoteId = 0;
					order.iNoteTypeId = (int)NoteTypes.CreationNote;
					order.iItemId = OrderId;
					order.sNote = tbNotes.Text;
					order.daCreated = DateTime.Now;
					order.NoteDetails();
				}
				
				#endregion

				#region saving cutom fields

				if(ViewState["CustomFields"] != null)
				{
					order.cAction = "U";
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

				Response.Redirect("wo_addRepairs.aspx?id=" + OrderId.ToString() + "&back=open", false);
			
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_openWorkOrder.aspx?id=" + OrderId.ToString();
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
