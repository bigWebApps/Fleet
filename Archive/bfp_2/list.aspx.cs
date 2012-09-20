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
	/// <summary>
	/// Summary description for WebForm1.
	/// </summary>
	public class _list : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgMainList;
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected System.Web.UI.WebControls.DropDownList ddlEquipType;
		protected BoundColumn _column = null;
		public clsEquipment equip = null;
		public clsMakesModels mm = null;
		public clsDepartments dep = null;
		public clsLocations loc = null;
		public DataTable dtResult = null;
		public DataRow drItem = null;
		public DataTable dtData = null;
		public DataTable dtCustFields = null;
		public DataTable dtEquipTypes = null;
		protected System.Web.UI.WebControls.HyperLink hlAdd;
		public ArrayList arrCFD = null;
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				string [,] arrBrdCrumbs = new string [1,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				PageTitle = "Equipment List";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;

				if(!IsPostBack)
				{
					equip = new clsEquipment();
					
					equip.cAction = "S";
					equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					
					dtEquipTypes = equip.GetEquipTypesList();

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
					
					ShowList();
		
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
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		}

		#region Showing Equipment List
		private void ShowList()
		{
			int i, j;
			clsCustomFieldsDef cfd = null;
			string sTypeName;
			try
			{
				dgMainList.Controls.Clear();
				
				dtResult = new DataTable("Result");

				dtData = equip.GetEquipList();
				
				if(dtData.Rows.Count > 0)
				{
					//arrCFD = _functions.CustomFieldsParse(dtData, Convert.ToInt32(Session["EquipTypeId"]));
					arrCFD = _functions.GetCustomFields(false, equip.iTypeId.Value, HttpContext.Current.User.Identity.Name);
					
					if(arrCFD.Count > 0)
					{
						// adding fixed fields
						dtResult.Columns.Add("id");
					
						// adding variable columns and fields					
						for(i = 0; i < arrCFD.Count; i++)
						{
							cfd = (clsCustomFieldsDef)arrCFD[i];
							dtResult.Columns.Add(cfd.Name);
							_column = new BoundColumn();
							_column.DataField = cfd.Name;
							_column.HeaderText = cfd.NameText;
							dgMainList.Columns.Add( _column);
							if(cfd.NameLookupTable == "EquipModels") // adding make column if model is exist
							{
								_column = null;
								_column = new BoundColumn();
								dtResult.Columns.Add("MakeName");
								_column.DataField = "MakeName";
								_column.HeaderText = "Make";
								dgMainList.Columns.Add( _column);
							}
							cfd = null;
							_column = null;
						}
						// fill fields
						for(i=0; i< dtData.Rows.Count; i++)
						{
							// fill fixed fields
							drItem = dtResult.NewRow();
							drItem["Id"] = dtData.Rows[i]["Id"];

							// fill variable fields
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
												mm = new clsMakesModels();
												mm.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
												mm.iModelId = Convert.ToInt32(dtData.Rows[i][sTypeName]);
												mm.GetModelMakes();
												drItem[cfd.Name] = mm.sModelName; 
												drItem["MakeName"] = mm.sMakeName; 
												break;
											case "Departments":
												dep = new clsDepartments();
												dep.cAction = "S";
												dep.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
												dep.iId = Convert.ToInt32(dtData.Rows[i][sTypeName]);
												if(dep.DepartmentDetail() == 0)
												{
													drItem[cfd.Name] = dep.sName.Value;
												}
												break;
											case "Locations":
												loc = new clsLocations();
												loc.cAction = "S";
												loc.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
												loc.iId = Convert.ToInt32(dtData.Rows[i][sTypeName]);
												if(loc.LocationDetail() == 0)
												{
													drItem[cfd.Name] = loc.sName.Value;
												}
												break;
											default:
												break;
										}
										break;
									case DBFieldType._bit:
										if(((bool)dtData.Rows[i][sTypeName]) == true)
											drItem[cfd.Name] = "Yes";
										else
											drItem[cfd.Name] = "No";
										break;
									default:
										drItem[cfd.Name] = dtData.Rows[i][sTypeName];
										break;
								}
								cfd = null;
							}
							dtResult.Rows.Add(drItem);
						}
					}
					else
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
					}
				}
				dgMainList.DataSource = new DataView(dtResult);
				dgMainList.DataBind();

			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message);
			}
			finally
			{
				if(dtData != null)
				{
					dtData.Dispose();
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
			}
		}
		#endregion
		
		protected void OnItemEditClick(object sender, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			string EquipId = e.Item.Cells[1].Text;
			Response.Redirect("view.aspx?id="+EquipId+"");
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
			this.ddlEquipType.SelectedIndexChanged += new System.EventHandler(this.btnChangeType_Click);
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

				ShowList();			
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
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		}

	}
}
