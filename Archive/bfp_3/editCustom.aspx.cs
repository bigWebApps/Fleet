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

namespace BWA.BFP.Web.equip
{
	public class _editCustom : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblAssignedTo;
		protected System.Web.UI.WebControls.CheckBox cbReassign;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected System.Web.UI.WebControls.Repeater repCustomFields;
		
		public int EquipId;
		private clsEquipment equip = null;
		private clsMakesModels mm = null;
		private clsDepartments dep = null;
		private clsLocations loc = null;
		private DataTable dtCustomFields = null;
		private DataTable dtCustomFieldsFromDB = null;
		private ArrayList arrCFD = null;
		private clsCustomFieldsDef cfd = null;

	
		private void Page_Load(object sender, System.EventArgs e)
		{
			int j;
			string sTypeName;
			try
			{
				
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId=Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				
				string [,] arrBrdCrumbs = new string [3,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="list.aspx";
				arrBrdCrumbs[1,1]="Equipment List";
				arrBrdCrumbs[2,0]="view.aspx?id=" + EquipId.ToString();
				arrBrdCrumbs[2,1]="Equipment Detail";
				PageTitle = "Equipment-Edit Custom Fields";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;
				SaveCancelControl.ParentPageURL = ParentPageURL;
				SourcePageName = "editCustom.aspx.cs";

				if(!IsPostBack)
				{
					equip = new clsEquipment();
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
					dtCustomFields.Columns.Add("Val_Visible");
					dtCustomFields.Columns.Add("ErrorMessage");
					dtCustomFields.Columns.Add("Exp");

					equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					equip.iId = EquipId;
					equip.cAction="S";

					dtCustomFieldsFromDB = equip.EquipmentDetail_CustomFields(null);
					if(equip.iId == -1)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					if(dtCustomFieldsFromDB.Rows.Count >0)
					{

						// adding data into DropDownList controls
						// parsing the custom fields in the dtCustomFieldsFromDB table
						arrCFD = _functions.GetCustomFields(CFDataType.Equipment, Convert.ToInt32(dtCustomFieldsFromDB.Rows[0]["TypeId"]), HttpContext.Current.User.Identity.Name);
						ViewState["EquipTypeId"] = dtCustomFieldsFromDB.Rows[0]["TypeId"];

						if(arrCFD == null)
						{
							Session["lastpage"] = ParentPageURL;
							Session["error"] = _functions.ErrorMessage(114);
							Response.Redirect("error.aspx", false);
							return;
						}
					
						// filling custom fields in the dtCustomFields table
						for(j = 0; j < arrCFD.Count; j++)
						{
							cfd = (clsCustomFieldsDef)arrCFD[j];
							sTypeName = _functions.GetFieldTypeText(cfd.FieldTypeId) + cfd.NumberColumn.ToString();

							switch(cfd.FieldTypeId)
							{
								case DBFieldType._nvarchar:
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, "False", "", ""});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, dtCustomFieldsFromDB.Rows[0][sTypeName], "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, "False", "", ""});
									break;
								case DBFieldType._int:
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, "True", cfd.NameText + " must be numeric", "^\\d{0,10}?$"});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, dtCustomFieldsFromDB.Rows[0][sTypeName], "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, "True", cfd.NameText + " must be numeric", "^\\d{0,10}?$"});
									break;
								case DBFieldType._float:
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, "True", cfd.NameText + " must be decimal numeric", "^\\d{0,8}(?:\\.\\d{0,8})?$"});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, dtCustomFieldsFromDB.Rows[0][sTypeName], "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, "True", cfd.NameText + " must be decimal numeric", "^\\d{0,8}(?:\\.\\d{0,8})?$"});
									break;
								case DBFieldType._datetime:
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "1970-01-01", "False", "False", "False", "False", "True", cfd.Help, "False", "", ""});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, dtCustomFieldsFromDB.Rows[0][sTypeName], "False", "False", "False", "False", "True", cfd.Help, "False", "", ""});
									break;
								case DBFieldType._bit:
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "False", "False", "True", "False", "False", cfd.Help, "False", "", ""});
									else
									{
										if(((bool)dtCustomFieldsFromDB.Rows[0][sTypeName]) == true)
											dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "True", 0, "2000-01-01", "False", "False", "True", "False", "False", cfd.Help, "False", "", ""});
										else
											dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "False", "False", "True", "False", "False", cfd.Help, "False", "", ""});
									}
									break;
								case DBFieldType._ntext:
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, "False", "", ""});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, (string)dtCustomFieldsFromDB.Rows[0][sTypeName], "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, "False", "", ""});
									break;
								case DBFieldType._sql_variant:
									if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, "False", "", ""});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, (string)dtCustomFieldsFromDB.Rows[0][sTypeName], "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, "False", "", ""});
									break;
								case DBFieldType._lookup:
									if(cfd.NameLookupTable == "EquipModels")
									{
										// adding data into DropDownList controls both Make and Model
										if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
											dtCustomFields.Rows.Add(new object []{sTypeName, "Make/Model", "", "False", 0, "2000-01-01", "False", "False", "False", "True", "False", cfd.Help, "False", "", ""});
										else
											dtCustomFields.Rows.Add(new object []{sTypeName, "Make/Model", "", "False", Convert.ToInt32(dtCustomFieldsFromDB.Rows[0][sTypeName]), "2000-01-01", "False", "False", "False", "True", "False", cfd.Help, "False", "", ""});
									}
									else
									{
										if(dtCustomFieldsFromDB.Rows[0][sTypeName] == DBNull.Value)
											dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, 0, "False", 0, "2000-01-01", "False", "True", "False", "False", "False", cfd.Help, "False", "", ""});
										else
											dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, dtCustomFieldsFromDB.Rows[0][sTypeName], "False", 0, "2000-01-01", "False", "True", "False", "False", "False", cfd.Help, "False", "", ""});
									}
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
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(loc != null)
				{
					loc.Dispose();
				}
				if(dep != null)
				{
					dep.Dispose();
				}
				if(mm != null)
				{
					mm.Dispose();
				}
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		}

		
		#region Save Equipment
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			DBFieldType FieldType;
			string sDataGridName;
			try
			{

				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				
				equip = new clsEquipment();
				dtCustomFields = (DataTable)ViewState["CustomFields"];

				equip.cAction = "U";
				equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				equip.iId = EquipId; // editing a Equipment
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				equip.iTypeId = Convert.ToInt32(ViewState["EquipTypeId"]);

				sDataGridName = "repCustomFields";
				
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
									if((string)dtCustomFields.Rows[i]["ValueName"] != "Make/Model")
									{
										dtCustomFields.Rows[i]["Value_String"] = Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":ddlValue"];
									}
									else
									{
										dtCustomFields.Rows[i]["Value_String"] = Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":mmValue:ddlModels"];
									}
									break;
								default:
									dtCustomFields.Rows[i]["Value_String"] = Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":tbValue"];
									break;
							}
						}
					}
				}

				// saving data to database
				equip.EquipmentDetail_CustomFields(_functions.SetDataToParameters(dtCustomFields));

				if(equip.iId == 0)
				{
					Response.Redirect("view.aspx?id="+EquipId.ToString(), false);
				}
				else
				{
					Session["lastpage"] = "editCustom.aspx?id=" + EquipId.ToString();
					Session["error"] = _functions.ErrorMessage(107);
					Response.Redirect("error.aspx", false);
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "editCustom.aspx?id=" + EquipId.ToString();
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "editCustom.aspx?id=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip!=null)
				{
					equip.Dispose();
				}
			}
		}
		#endregion

		#region Equipment DataBound
		private void repCustomFields_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
		{
			DataTable dtListItems = null;
						
			try
			{
				if(e.Item.ItemType == ListItemType.Item || 
					e.Item.ItemType == ListItemType.AlternatingItem || 
					e.Item.ItemType == ListItemType.SelectedItem)
				{
					switch(((System.Data.DataRowView)e.Item.DataItem).Row.ItemArray[1].ToString())
					{
						case "Make/Model":
							((BWA.BFP.Web.Controls.User.MakesModels)e.Item.FindControl("mmValue")).IsComponent = false;
							((BWA.BFP.Web.Controls.User.MakesModels)e.Item.FindControl("mmValue")).TypeId = Convert.ToInt32(ViewState["EquipTypeId"]);
							((BWA.BFP.Web.Controls.User.MakesModels)e.Item.FindControl("mmValue")).ModelId = Convert.ToInt32(((System.Data.DataRowView)e.Item.DataItem).Row.ItemArray[4]);
							((BWA.BFP.Web.Controls.User.MakesModels)e.Item.FindControl("mmValue")).DataBind();
							break;
						case "Department":
							dep = new clsDepartments();
							dep.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
							dtListItems = dep.GetDepartmentsList();
							((DropDownList)e.Item.FindControl("ddlValue")).DataTextField = "vchName";
							((DropDownList)e.Item.FindControl("ddlValue")).DataValueField = "Id";
							((DropDownList)e.Item.FindControl("ddlValue")).DataSource = new DataView(dtListItems);
							((DropDownList)e.Item.FindControl("ddlValue")).DataBind();
							((DropDownList)e.Item.FindControl("ddlValue")).SelectedValue = Convert.ToString(((System.Data.DataRowView)e.Item.DataItem).Row.ItemArray[2]);
							break;
						case "Location":
							loc = new clsLocations();
							loc.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
							dtListItems = loc.GetLocationsList();
							((DropDownList)e.Item.FindControl("ddlValue")).DataTextField = "vchName";
							((DropDownList)e.Item.FindControl("ddlValue")).DataValueField = "Id";
							((DropDownList)e.Item.FindControl("ddlValue")).DataSource = new DataView(dtListItems);
							((DropDownList)e.Item.FindControl("ddlValue")).DataBind();
							((DropDownList)e.Item.FindControl("ddlValue")).SelectedValue = Convert.ToString(((System.Data.DataRowView)e.Item.DataItem).Row.ItemArray[2]);
							break;
						default:
							break;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(mm != null)
				{
					mm.Dispose();
				}
				if(loc != null)
				{
					loc.Dispose();
				}
				if(dep != null)
				{
					dep.Dispose();
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
			this.repCustomFields.ItemDataBound += new System.Web.UI.WebControls.RepeaterItemEventHandler(this.repCustomFields_ItemDataBound);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

	}
}
