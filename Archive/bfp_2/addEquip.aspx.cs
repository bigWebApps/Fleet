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

namespace BWA.BFP.Web.home.equip
{
	public class _addEquip : BFPPage
	{
		
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected System.Web.UI.WebControls.DropDownList ddlEquipType;
		protected System.Web.UI.WebControls.Repeater repCustomFields;

		public int EquipId;
		public clsEquipment equip = null;
		public clsMakesModels mm = null;
		public clsDepartments dep = null;
		public clsLocations loc = null;
		public DataTable dtEquipTypes = null;
		public DataTable dtCustomFields = null;
		public DataTable dtCustomFieldsFromDB = null;
		public DataRow drItem = null;
		public ArrayList arrCFD = null;
		public DataSet dsMMList = null;
				
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				string [,] arrBrdCrumbs = new string [2,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="list.aspx";
				arrBrdCrumbs[1,1]="Equipment List";
				PageTitle = "Add Equipment";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;

				SaveCancelControl.ParentPageURL=ParentPageURL;
	
				if(!IsPostBack)
				{
					equip = new clsEquipment();
					
					equip.cAction = "S";
					equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					
					dtEquipTypes = equip.GetEquipTypesList();

					if(dtEquipTypes.Rows.Count > 0)
					{

						ddlEquipType.DataSource = new DataView(dtEquipTypes);
						ddlEquipType.DataBind();

						if(Session["EquipTypeId"] != null)
						{
							ddlEquipType.SelectedValue = Convert.ToString(Session["EquipTypeId"]);

						}
						else
						{
							ddlEquipType.SelectedIndex = 0;
							Session["EquipTypeId"] = ddlEquipType.SelectedValue;
						}

						equip.iTypeId = Convert.ToInt32(ddlEquipType.SelectedValue);

						GenerateCustomFields();
					}
					else
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(101);
						Response.Redirect("error.aspx", false);
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log("Application error: \n" + ex.ToString());
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

		
		#region Generation controls for Equipment custom fields
		private void GenerateCustomFields()
		{
			clsCustomFieldsDef cfd = null;
			int j;
			string sTypeName;

			try
			{
				dtCustomFields = new DataTable();
				dtCustomFields.Columns.Add("TypeName");
				dtCustomFields.Columns.Add("ValueName");
				dtCustomFields.Columns.Add("Value_String");
				dtCustomFields.Columns.Add("TB_Visible");
				dtCustomFields.Columns.Add("DDL_Visible");
				dtCustomFields.Columns.Add("CB_Visible");
				dtCustomFields.Columns.Add("MM_Visible");
				dtCustomFields.Columns.Add("DT_Visible");
				dtCustomFields.Columns.Add("Help");
				dtCustomFields.Columns.Add("Val_Visible");
				dtCustomFields.Columns.Add("ErrorMessage");
				dtCustomFields.Columns.Add("Exp");
				
				arrCFD = _functions.GetCustomFields(false, Convert.ToInt32(Session["EquipTypeId"]), HttpContext.Current.User.Identity.Name);

				if(arrCFD != null)
				{
					// filling custom fields in the dtCustomFields table
					for(j = 0; j < arrCFD.Count; j++)
					{
						cfd = (clsCustomFieldsDef)arrCFD[j];
						sTypeName = _functions.GetFieldTypeText(cfd.FieldTypeId) + cfd.NumberColumn.ToString();
						switch(cfd.FieldTypeId)
						{
							case DBFieldType._nvarchar:
								dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "True", "False", "False", "False", "False", cfd.Help, "False", "", ""});
								break;
							case DBFieldType._int:
								dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "True", "False", "False", "False", "False", cfd.Help, "True", cfd.NameText + " must be numeric", "^\\d{0,10}?$"});
								break;
							case DBFieldType._float:
								dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "True", "False", "False", "False", "False", cfd.Help, "True", cfd.NameText + " must be decimal numeric", "^\\d{0,8}(?:\\.\\d{0,8})?$"});
								break;
							case DBFieldType._datetime:
								dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", "False", "False", "False", "True", cfd.Help, "False", "", ""});
								break;
							case DBFieldType._bit:
								dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", "False", "True", "False", "False", cfd.Help, "False", "", ""});
								break;
							case DBFieldType._ntext:
								dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "True", "False", "False", "False", "False", cfd.Help, "False", "", ""});
								break;
							case DBFieldType._sql_variant:
								dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "True", "False", "False", "False", "False", cfd.Help, "False", "", ""});
								break;
							case DBFieldType._lookup:
								if(cfd.NameLookupTable == "EquipModels")
								{
									// adding data into DropDownList controls both Make and Model
									dtCustomFields.Rows.Add(new object []{sTypeName, "Make/Model", "", "False", "False", "False", "True", "False", cfd.Help, "False", "", ""});
								}
								else
								{
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", "True", "False", "False", "False", cfd.Help, "False", "", ""});
								}
								break;
							default:
								break;
						}
						cfd = null;
					}	
					// binding main datalist
					Session["CustomFields"] = dtCustomFields;
					repCustomFields.DataSource = new DataView(dtCustomFields);
					repCustomFields.DataBind();	
				}
				else
				{
					Session["lastpage"] = ParentPageURL;
					Session["error"] = _functions.ErrorMessage(114);
					Response.Redirect("error.aspx", false);
				}
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message);
			}
			finally
			{
			}

		}
		#endregion

		#region Save Equipment
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			DBFieldType FieldType;
			string sDataGridName;
			try
			{
				equip = new clsEquipment();
				dtCustomFields = (DataTable)Session["CustomFields"];

				equip.cAction="U";
				equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				equip.iId = 0; // adding a Equipment
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				equip.iTypeId = Convert.ToInt32(ddlEquipType.SelectedValue);
				equip.iStatusId = 1;

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
				if(equip.iId > 0)
				{
					Response.Redirect("reassign.aspx?id="+equip.iId.Value.ToString() +"", false);
				}
				else
				{
					Session["lastpage"] = "addEquip.aspx";
					Session["error"] = _functions.ErrorMessage(103);
					Response.Redirect("error.aspx", false);
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "addEquip.aspx";
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
			}	  
			catch(Exception ex)
			{
				_functions.Log("Application error: \n" + ex.ToString());
				Session["lastpage"] = "addEquip.aspx";
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
		
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			this.SaveCancelControl.BubbleClick += new EventHandler(this.btSave_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
			
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{   
			this.ddlEquipType.SelectedIndexChanged += new System.EventHandler(this.btnChangeType_Click);
			this.repCustomFields.ItemDataBound += new System.Web.UI.WebControls.RepeaterItemEventHandler(this.repCustomFields_ItemDataBound);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnChangeType_Click(object sender, System.EventArgs e)
		{
			try
			{
				Session["EquipTypeId"] = ddlEquipType.SelectedValue;

				equip = new clsEquipment();
					
				equip.cAction = "S";
				equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				equip.iTypeId = Convert.ToInt32(ddlEquipType.SelectedValue);

				GenerateCustomFields();
			}
			catch(Exception ex)
			{
				_functions.Log("Application error: \n" + ex.ToString());
				Session["lastpage"] = "addEquip.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		
		}


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
							((BWA.BFP.Web.Controls.User.MakesModels)e.Item.FindControl("mmValue")).iTypeId = Convert.ToInt32(Session["EquipTypeId"]);
							((BWA.BFP.Web.Controls.User.MakesModels)e.Item.FindControl("mmValue")).ModelId = 0;
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
							break;
						case "Location":
							loc = new clsLocations();
							loc.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
							dtListItems = loc.GetLocationsList();
							((DropDownList)e.Item.FindControl("ddlValue")).DataTextField = "vchName";
							((DropDownList)e.Item.FindControl("ddlValue")).DataValueField = "Id";
							((DropDownList)e.Item.FindControl("ddlValue")).DataSource = new DataView(dtListItems);
							((DropDownList)e.Item.FindControl("ddlValue")).DataBind();
							break;
						default:
							break;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log("Application error: \n" + ex.ToString());
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
			}
		}
	}
}
