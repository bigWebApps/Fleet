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
	public class _view : BFPPage
	{
		protected System.Web.UI.WebControls.Label lbPMSched;
		protected System.Web.UI.WebControls.Label lbInspection;
		protected System.Web.UI.WebControls.Label lbUnits;
		protected System.Web.UI.WebControls.Label lbDtInService;
		protected System.Web.UI.WebControls.Label lbDtAquired;
		protected System.Web.UI.WebControls.Label lbVchPurOrgContact;
		protected System.Web.UI.WebControls.Label lbSmPurAmount;
		protected System.Web.UI.WebControls.Label lbIntPurUnits;
		protected System.Web.UI.WebControls.Label lbVchPurNotes;
		protected System.Web.UI.WebControls.Label lbDtOutOfService;
		protected System.Web.UI.WebControls.Label lbDtDisposed;
		protected System.Web.UI.WebControls.Label lbVchDispMethod;
		protected System.Web.UI.WebControls.Label lbVchDispOrgContact;
		protected System.Web.UI.WebControls.Label lbSmDispAmount;
		protected System.Web.UI.WebControls.Label lbIntDispUnits;
		protected System.Web.UI.WebControls.Label lbVchDispNotes;
		protected System.Web.UI.WebControls.Repeater repComponents;
		protected System.Web.UI.WebControls.Repeater repCustomFields;
		protected BWA.BFP.Web.Controls.User.Header Header;
		
		public int EquipId;
		public clsEquipment equip = null;
		public clsMakesModels mm = null;
		public clsDepartments dep = null;
		public clsLocations loc = null;
		public clsComponents comp = null;
		public DataTable dtCustomFields = null;
		public DataTable dtCustomFieldsFromDB = null;
		public DataTable dtComponents = null;
		public DataRow drItem = null;
		public ArrayList arrCFD = null;
		public clsCustomFieldsDef cfd = null;
		protected System.Web.UI.HtmlControls.HtmlInputHidden hiddenEquipId;
		protected System.Web.UI.WebControls.DropDownList ddlComponentTypes;
		protected System.Web.UI.WebControls.LinkButton lbAddComponent;
		protected System.Web.UI.WebControls.HyperLink hlEdit2;
		protected System.Web.UI.WebControls.HyperLink hlEditAquis;
		protected System.Web.UI.WebControls.HyperLink hlEditDisp;
		protected System.Web.UI.HtmlControls.HtmlTableRow trAddComponent;
		protected System.Web.UI.WebControls.HyperLink hlEditCustom;
		protected System.Web.UI.WebControls.Label lblEquipment;
		protected System.Web.UI.WebControls.Label lblType;
		protected System.Web.UI.WebControls.Label lblMakeModel;
		protected System.Web.UI.WebControls.Label lblYear;
		protected System.Web.UI.WebControls.Label lblSerial;
		protected System.Web.UI.WebControls.Label lblFuelCode;
		protected System.Web.UI.WebControls.Label lblDepartment;
		protected System.Web.UI.WebControls.Label lblLocation;
		protected System.Web.UI.WebControls.Label lblShare;
		protected System.Web.UI.WebControls.HyperLink hlEdit;
		protected System.Web.UI.WebControls.Label lblPlateNumber;
		private string sTypeName;

		private void Page_Load(object sender, System.EventArgs e)
		{
			clsCustomFieldsDef cfd = null;
			int j;
			bool bVisibleLink;
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
				
				string [,] arrBrdCrumbs = new string [2,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="list.aspx";
				arrBrdCrumbs[1,1]="Equipment List";
				PageTitle = "Equipment Detail";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;
				SourcePageName = "view.aspx.cs";

				hlEdit.NavigateUrl = "edit.aspx?id=" + EquipId.ToString();
				hlEdit2.NavigateUrl = "edit2.aspx?id=" + EquipId.ToString();
				hlEditCustom.NavigateUrl = "editCustom.aspx?id=" + EquipId.ToString();
				hlEditAquis.NavigateUrl = "editAquis.aspx?id="+EquipId.ToString();
				hlEditDisp.NavigateUrl = "editDisp.aspx?id="+EquipId.ToString();

				base.CheckLinks(this.Page);

				if(!IsPostBack)
				{
					bVisibleLink = base.CheckPermission("editComponent.aspx");
					trAddComponent.Visible  = bVisibleLink;
					
					Session["EquipId"] = EquipId;
					
					equip = new clsEquipment();
					comp = new clsComponents();
					
					dtCustomFields = new DataTable();
					dtCustomFields.Columns.Add("ValueName");
					dtCustomFields.Columns.Add("Value");

					equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
					equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					equip.iId = EquipId;
					equip.cAction = "S";

					// showing a Equipment's main data from fixed fields
					if(equip.EquipmentDetail() == -1)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblEquipment.Text = equip.sEquipId.Value;
					lblType.Text = equip.sType.Value;
					lblMakeModel.Text = equip.sMakeModelName.Value;
					lblYear.Text = equip.iYear.Value.ToString();
					lblSerial.Text = equip.sVinSerial.Value;
					lblFuelCode.Text = equip.sFuelCode.Value;
					lblPlateNumber.Text = equip.sPlateNumber.Value;
					lblDepartment.Text = equip.sDeptName.Value;
					lblLocation.Text = equip.sLocName.Value;
					lblShare.Text = equip.bShare.Value?"Yes":"No";
					
					// showing a Equipment's Alt data from fixed fields
					if(equip.EquipmentDetail_Alt() == -1)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					lbPMSched.Text = equip.sPMSched.Value;
					lbInspection.Text = equip.sInspect.Value;
					if(!equip.iCurrentUnits.IsNull)
						lbUnits.Text = equip.iCurrentUnits.Value.ToString();

					// showing an Aquisition information from fixed fields
					if(equip.EquipmentDetail_Aquis() == -1)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					if(!equip.daInService.IsNull)
						lbDtInService.Text = equip.daInService.Value.ToShortDateString();
					if(!equip.daAquired.IsNull)
						lbDtAquired.Text = equip.daAquired.Value.ToShortDateString();
					lbVchPurOrgContact.Text = equip.sPurOrgContact.Value;
					if(!equip.curPurAmount.IsNull)
						lbSmPurAmount.Text = equip.curPurAmount.Value.ToString();
					if(!equip.iPurUnits.IsNull)
						lbIntPurUnits.Text = equip.iPurUnits.Value.ToString();
					lbVchPurNotes.Text = equip.sPurNotes.Value;

					// showing a Disposal info from fixed fields
					if(equip.EquipmentDetail_Disp() == -1)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					if(!equip.daOutOfService.IsNull)
						lbDtOutOfService.Text = equip.daOutOfService.Value.ToShortDateString();
					if(!equip.daDisposed.IsNull)
						lbDtDisposed.Text = equip.daDisposed.Value.ToShortDateString();
					if(!equip.sDispMethod.IsNull)
						lbVchDispMethod.Text = equip.sDispMethod.Value;
					if(!equip.sDispOrgContact.IsNull)
						lbVchDispOrgContact.Text = equip.sDispOrgContact.Value;
					if(!equip.curDispAmount.IsNull)
						lbSmDispAmount.Text = equip.curDispAmount.Value.ToString();
					if(!equip.iDispUnits.IsNull)
						lbIntDispUnits.Text = equip.iDispUnits.Value.ToString();
					lbVchDispNotes.Text = equip.sDispNotes.Value;
					
					// getting all component's types to dropdownlist
					comp.iEquipId  = EquipId;
					DataTable dtComponmentAdd = comp.GetComponentTypeList();
					if(dtComponmentAdd.Rows.Count > 0)
					{
						ddlComponentTypes.DataTextField = "vchName";
						ddlComponentTypes.DataValueField = "Id";
						ddlComponentTypes.DataSource = new DataView(dtComponmentAdd);
						ddlComponentTypes.DataBind();
					}
					else
					{
						ddlComponentTypes.Items.Add(new ListItem("<none>", "0"));
						lbAddComponent.Enabled = false;
					}

					// getting the custom fields in the DataList control
					dtCustomFieldsFromDB = equip.EquipmentDetail_CustomFields(null);

					if(dtCustomFieldsFromDB.Rows.Count > 0)
					{
						arrCFD = _functions.GetCustomFields(CFDataType.Equipment, Convert.ToInt32(dtCustomFieldsFromDB.Rows[0]["TypeId"]), HttpContext.Current.User.Identity.Name);
						if(arrCFD.Count > 0)
						{
							// fill custom fields
							for(j = 0; j < arrCFD.Count; j++)
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

							comp.iEquipId = EquipId;
							comp.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
							dtComponents = comp.GetComponentsList();
							dtComponents.Columns.Add("VisibleLink");
							foreach(DataRow _row in dtComponents.Rows)
							{
								if(bVisibleLink)
								{
									_row["VisibleLink"] = "True";
								}
								else
								{
									_row["VisibleLink"] = "False";
								}
							}
							ViewState["Components"] = dtComponents;
							repComponents.DataSource = new DataView(dtComponents);
							repComponents.DataBind();
						}
						else
						{
							Session["lastpage"] = ParentPageURL;
							Session["error"] = _functions.ErrorMessage(102);
							Response.Redirect("error.aspx", false);
						}
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
				if(comp != null)
				{
					comp.Dispose();
				}
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
				if(comp != null)
				{
					comp.Dispose();
				}
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		}
		
		
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
		}
		
		private void InitializeComponent()
		{    
			this.repComponents.ItemDataBound += new System.Web.UI.WebControls.RepeaterItemEventHandler(this.repComponents_ItemDataBound);
			this.lbAddComponent.Click += new System.EventHandler(this.lbAddComponent_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Components DataBound
		private void repComponents_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
		{
			System.Data.DataRowView drItem = null;
			object oItem;
			try
			{
				if(e.Item.ItemType == ListItemType.Item || 
					e.Item.ItemType == ListItemType.AlternatingItem || 
					e.Item.ItemType == ListItemType.SelectedItem)
				{
					dtCustomFields = new DataTable();
					dtCustomFields.Columns.Add("ValueName_Comp");
					dtCustomFields.Columns.Add("Value_Comp");
					
					dtComponents = (DataTable)ViewState["Components"];
					for(int i=0; i< dtComponents.Rows.Count; i++)
					{
						drItem = (System.Data.DataRowView)e.Item.DataItem;
						if(drItem.Row.ItemArray[0].ToString() == dtComponents.Rows[i]["ComponentId"].ToString())
						{
							// getting the custoom fields info for a Component
							arrCFD = _functions.GetCustomFields(CFDataType.Component, Convert.ToInt32(dtComponents.Rows[i]["TypeId"]), HttpContext.Current.User.Identity.Name);
							for(int j = 0; j < arrCFD.Count; j++)
							{
								cfd = (clsCustomFieldsDef)arrCFD[j];
								sTypeName = _functions.GetFieldTypeText(cfd.FieldTypeId) + cfd.NumberColumn.ToString();
								oItem = dtComponents.Rows[i][sTypeName];
								switch(cfd.FieldTypeId)
								{
									case DBFieldType._lookup:
										switch(cfd.NameLookupTable)
										{
											case "EquipModels":
												if(oItem != DBNull.Value)
												{
													mm = new clsMakesModels();
													mm.iOrgId = 1; // later change
													mm.iModelId = Convert.ToInt32(oItem);
													mm.GetModelMakes();
													dtCustomFields.Rows.Add(new object []{"Make/Model", mm.sMakeName + "/" + mm.sModelName});
												}
												else
													dtCustomFields.Rows.Add(new object []{"Make/Model", ""});
												break;
											case "Departments":
												if(oItem != DBNull.Value)
												{
													dep =  new clsDepartments();
													dep.cAction = "S";
													dep.iOrgId = 1;
													dep.iId = Convert.ToInt32(oItem);
													if(dep.DepartmentDetail() == 0)
													{
														dtCustomFields.Rows.Add(new object []{cfd.NameText, dep.sName.Value});
													}
												}
												else
													dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
												break;
											case "Locations":
												if(oItem != DBNull.Value)
												{
													loc = new clsLocations();
													loc.cAction = "S";
													loc.iOrgId = 1;
													loc.iId = Convert.ToInt32(oItem);
													if(loc.LocationDetail() == 0)
													{
														dtCustomFields.Rows.Add(new object []{cfd.NameText, loc.sName.Value});
													}
												}
												else
													dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
												break;
											default:
												break;
										}
										break;
									case DBFieldType._datetime:
										if(oItem != DBNull.Value)
											dtCustomFields.Rows.Add(new object []{cfd.NameText, Convert.ToDateTime(oItem).ToShortDateString()});
										else
											dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
										break;
									case DBFieldType._bit:
										if(oItem != DBNull.Value)
											if(((SqlBoolean)oItem) == SqlBoolean.True)
												dtCustomFields.Rows.Add(new object []{cfd.NameText, "Yes"});
											else
												dtCustomFields.Rows.Add(new object []{cfd.NameText, "No"});
										else
											dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
										break;
									default:
										if(oItem != DBNull.Value)
											dtCustomFields.Rows.Add(new object []{cfd.NameText, oItem});
										else
											dtCustomFields.Rows.Add(new object []{cfd.NameText, ""});
										break;
								}
								cfd = null;
							}
							((Repeater)e.Item.FindControl("repComponentItem")).DataSource = new DataView(dtCustomFields);
							((Repeater)e.Item.FindControl("repComponentItem")).DataBind();
						}
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
			
			}
		}
		#endregion

		private void lbAddComponent_Click(object sender, System.EventArgs e)
		{
			if(ddlComponentTypes.SelectedValue != "0")
			{
				Response.Redirect("editComponent.aspx?id=0&typeid=" + ddlComponentTypes.SelectedValue, false);
			}
		}

	}
}
