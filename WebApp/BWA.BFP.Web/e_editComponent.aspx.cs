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
	public class _e_editComponent : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Repeater repCustomFields;
		protected System.Web.UI.WebControls.Label lblLastUpdate;
		protected System.Web.UI.WebControls.DropDownList ddlStatus;
		protected System.Web.UI.WebControls.Button btnRemove;
		
		public int ComponentId;
		public int EquipId;
		private clsComponents comp = null;
		private clsMakesModels mm = null;
		private clsDepartments dep = null;
		private clsLocations loc = null;
		private DataTable dtCustomFields = null;
		private DataTable dtCustomFieldsFromDB = null;
		private ArrayList arrCFD = null;
		private clsCustomFieldsDef cfd = null;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "e_editComponent.aspx.cs";
			
				this.PageTitle  = "Edit Component";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			int j;
			string sTypeName;
			object oItem;
			try
			{
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "e_view.aspx?id=" + Session["EquipId"].ToString();
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					ComponentId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "e_view.aspx?id=" + Session["EquipId"].ToString();
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddBreadCrumb("Equipment List", "/e_list.aspx");
				if(Session["EquipId"] != null)
					Header.AddBreadCrumb("Equipment Detail", "/e_view.aspx?id=" + Session["EquipId"].ToString());
				else
					Header.AddBreadCrumb("Equipment Detail", "/e_list.aspx");
				Header.LeftBarHtml = "Edit Component of Equipment";

				SaveCancelControl.ParentPageURL = this.ParentPageURL;

				if(!IsPostBack)
				{	
					comp = new clsComponents();

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

					if(ComponentId == 0)
					{ // adding a component
						lblLastUpdate.Text = "";
						ddlStatus.SelectedValue = "1";
						ViewState["ComponentTypeId"] = Convert.ToInt32(Request.QueryString["typeid"]);
						btnRemove.Visible = false;
					}
					else
					{ // editing a component
						comp.iOrgId = OrgId;
						comp.iId = ComponentId;
						comp.cAction="S";
						btnRemove.Visible = true;
						dtCustomFieldsFromDB = comp.ComponentDetail_CustomFields(null);

						lblLastUpdate.Text = dtCustomFieldsFromDB.Rows[0]["UserName"].ToString() + " " + Convert.ToDateTime(dtCustomFieldsFromDB.Rows[0]["dtUpdated"]).ToString();
						if((bool)dtCustomFieldsFromDB.Rows[0]["btActive"])
							ddlStatus.SelectedValue = "1";
						else
							ddlStatus.SelectedValue = "0";

						ViewState["ComponentTypeId"] = Convert.ToInt32(dtCustomFieldsFromDB.Rows[0]["TypeId"]);
					}
					#region Show Custom Fields
					// showing the Custom Fields for Component
					arrCFD = _functions.GetCustomFields(CFDataType.Component, (int)ViewState["ComponentTypeId"], HttpContext.Current.User.Identity.Name);
					if(arrCFD.Count > 0)
					{
						// filling custom fields in the dtCustomFields table
						for(j = 0; j < arrCFD.Count; j++)
						{
							cfd = (clsCustomFieldsDef)arrCFD[j];
							sTypeName = _functions.GetFieldTypeText(cfd.FieldTypeId) + cfd.NumberColumn.ToString();
							if(ComponentId == 0)
								oItem = DBNull.Value;
							else
								oItem = dtCustomFieldsFromDB.Rows[0][sTypeName];
							switch(cfd.FieldTypeId)
							{
								case DBFieldType._nvarchar:
									if(oItem != DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, oItem, "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
									break;
								case DBFieldType._int:
									if(oItem != DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, oItem, "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "True", cfd.NameText + " must be numeric", "^\\d{0,10}?$"});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "True", cfd.NameText + " must be numeric", "^\\d{0,10}?$"});
									break;
								case DBFieldType._float:
									if(oItem != DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, oItem, "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "True", cfd.NameText + " must be decimal numeric", "^\\d{0,8}(?:\\.\\d{0,8})?$"});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "True", cfd.NameText + " must be decimal numeric", "^\\d{0,8}(?:\\.\\d{0,8})?$"});
									break;
								case DBFieldType._datetime:
									if(oItem != DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, ((SqlDateTime)oItem).Value.ToShortDateString(), "False", "False", "False", "False", "True", cfd.Help, "False", "False", "", ""});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "", "False", "False", "False", "False", "True", cfd.Help, "False", "False", "", ""});
									break;
								case DBFieldType._bit:
									if(oItem != DBNull.Value)
									{
										if(((SqlBoolean)oItem) == SqlBoolean.True)
											dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "True", 0, "2000-01-01", "False", "False", "True", "False", "False", cfd.Help, "False", "False", "", ""});
										else
											dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "False", "False", "True", "False", "False", cfd.Help, "False", "False", "", ""});
										break;
									}
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "False", 0, "2000-01-01", "False", "False", "True", "False", "False", cfd.Help, "False", "False", "", ""});
									break;
								case DBFieldType._ntext:
									if(oItem != DBNull.Value)
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, oItem, "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, "", "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
									break;
								case DBFieldType._sql_variant:
									dtCustomFields.Rows.Add(new object []{sTypeName, cfd.NameText, (string)dtCustomFieldsFromDB.Rows[0][sTypeName], "2000-01-01", 0, "2000-01-01", "True", "False", "False", "False", "False", cfd.Help, cfd.Required.ToString(), "False", "", ""});
									break;
								case DBFieldType._lookup:
									if(oItem != DBNull.Value)
									{
										if(cfd.NameLookupTable == "EquipModels")
											// adding data into DropDownList controls both Make and Model
											dtCustomFields.Rows.Add(new object []{sTypeName, "Make/Model", "", "False", Convert.ToInt32(oItem), "2000-01-01", "False", "False", "False", "True", "False", cfd.Help, "False", "False", "", ""});
										else
											dtCustomFields.Rows.Add(new object []{sTypeName, "Make/Model", "", "False", "0", "2000-01-01", "False", "False", "False", "True", "False", cfd.Help, "False", "False", "", ""});
									}
									else
										dtCustomFields.Rows.Add(new object []{sTypeName, "Make/Model", "", "False", "0", "2000-01-01", "False", "False", "False", "True", "False", cfd.Help, "False", "False", "", ""});
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
					#endregion
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
				if(comp != null)
				{
					comp.Dispose();
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
				comp = new clsComponents();

				dtCustomFields = (DataTable)ViewState["CustomFields"];

				comp.cAction="U";
				comp.iOrgId = OrgId;
				comp.iId = ComponentId; // editing a Equipment ot adding if ComponentId is zero
				comp.iEquipId = Convert.ToInt32(Session["EquipId"]);
				comp.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				comp.iTypeId = Convert.ToInt32(ViewState["ComponentTypeId"]);
				if(ddlStatus.SelectedValue == "1")
					comp.bitActive = SqlBoolean.True;
				else
					comp.bitActive = SqlBoolean.False;

				sDataGridName = "repCustomFields";

				#region Get Data from Form to Custom Fields
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
									if(Request.Form[sDataGridName + ":_ctl" + j.ToString() + ":chValue"] == "ON")
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
				#endregion

				// saving custom fields to database
				comp.ComponentDetail_CustomFields(_functions.SetDataToParameters(dtCustomFields));				
				if(comp.iId >= 0)
				{
					Response.Redirect("e_view.aspx?id=" + Session["EquipId"].ToString(), false);
				}
				else
				{
					Session["lastpage"] = "e_editComponent.aspx?id=" + ComponentId.ToString();
					Session["error"] = _functions.ErrorMessage(110);
					Response.Redirect("error.aspx", false);
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "e_editComponent.aspx?id=" + ComponentId.ToString();
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_editComponent.aspx?id=" + ComponentId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(comp!=null)
				{
					comp.Dispose();
				}
			}

		}
		#endregion

		#region Component DataBound
		/// <summary>
		/// If there are the lookup data into custom fields then to show them
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
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
							((BWA.BFP.Web.Controls.User.MakesModels)e.Item.FindControl("mmValue")).IsComponent = true;
							((BWA.BFP.Web.Controls.User.MakesModels)e.Item.FindControl("mmValue")).TypeId = (int)ViewState["ComponentTypeId"];
							((BWA.BFP.Web.Controls.User.MakesModels)e.Item.FindControl("mmValue")).ModelId = Convert.ToInt32(((System.Data.DataRowView)e.Item.DataItem).Row.ItemArray[4]);
							((BWA.BFP.Web.Controls.User.MakesModels)e.Item.FindControl("mmValue")).DataBind();
							break;
						case "Department":
							dep = new clsDepartments();
							dep.iOrgId = OrgId;
							dtListItems = dep.GetDepartmentsList();
							((DropDownList)e.Item.FindControl("ddlValue")).DataTextField = "vchName";
							((DropDownList)e.Item.FindControl("ddlValue")).DataValueField = "Id";
							((DropDownList)e.Item.FindControl("ddlValue")).DataSource = new DataView(dtListItems);
							((DropDownList)e.Item.FindControl("ddlValue")).DataBind();
							((DropDownList)e.Item.FindControl("ddlValue")).SelectedValue = Convert.ToString(((System.Data.DataRowView)e.Item.DataItem).Row.ItemArray[2]);
							break;
						case "Location":
							loc = new clsLocations();
							loc.iOrgId = OrgId;
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
				Session["lastpage"] = "e_view.aspx?id=" + Session["EquipId"].ToString();
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
			this.btnRemove.Click += new System.EventHandler(this.btnRemove_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		/// <summary>
		/// Removing current component from equipment
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btnRemove_Click(object sender, System.EventArgs e)
		{
			try
			{
				comp = new clsComponents();
				comp.iOrgId = OrgId;
				comp.iId = ComponentId;
				comp.DeleteComponent();

				Response.Redirect("e_view.aspx?id=" + Session["EquipId"].ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_editComponent.aspx?id=" + ComponentId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(comp != null)
				{
					comp.Dispose();
				}
			}
		}
	}
}
