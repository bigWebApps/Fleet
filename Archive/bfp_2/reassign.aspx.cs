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

namespace BWA.BFP.Web.home.equip
{
	public class _reassign : BFPPage
	{

		protected System.Web.UI.WebControls.Label lbAssignFrom;
		protected System.Web.UI.WebControls.DropDownList ddAssignTo;
		protected System.Web.UI.WebControls.TextBox tbNote;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvNote;
		protected System.Web.UI.WebControls.Repeater repCustomFields;

		protected BWA.BFP.Web.Controls.User.Header Header;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;

		public clsEquipment equip = null;
		public clsMakesModels mm = null;
		public clsDepartments dep = null;
		public clsLocations loc = null;

		public int EquipId;
		public DataTable dtUsers;
		public DataTable dtCustomFields = null;
		public DataTable dtCustomFieldsFromDB = null;
		public ArrayList arrCFD = null;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvAssign;
		public clsCustomFieldsDef cfd = null;
						
		private void Page_Load(object sender, System.EventArgs e)
		{
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
			
				PageTitle = "Reassign Equipment";
				string [,] arrBrdCrumbs = new string [3,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="list.aspx";
				arrBrdCrumbs[1,1]="Equipment List";
				arrBrdCrumbs[2,0]="view.aspx?id="+EquipId;
				arrBrdCrumbs[2,1]="Equipment Detail";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle="Reassign Equipment";
				SaveCancelControl.ParentPageURL=ParentPageURL;

				if(!IsPostBack)
				{
					ViewState["EquipId"] = EquipId;
					
					equip = new clsEquipment();
					dtCustomFields = new DataTable();
					dtCustomFields.Columns.Add("ValueName");
					dtCustomFields.Columns.Add("Value");
					
					equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					equip.iId = EquipId;
					equip.cAction = "S";
					
					dtUsers = equip.GetEquipAssignTo();
					if(dtUsers.Rows.Count < 1)
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(111);
						Response.Redirect("error.aspx", false);
						return;
					}
					ddAssignTo.DataTextField = "vchName";
					ddAssignTo.DataValueField = "id";
					ddAssignTo.DataSource = new DataView(dtUsers);
					ddAssignTo.DataBind();
					ddAssignTo.Items.Insert(0, "");

					// getting equipment's data
					dtCustomFieldsFromDB = equip.EquipmentDetail_CustomFields(null);

					if(dtCustomFieldsFromDB.Rows.Count > 0)
					{

						if(dtCustomFieldsFromDB.Rows[0]["UserName"] == DBNull.Value)
							lbAssignFrom.Text = "";
						else
							lbAssignFrom.Text = dtCustomFieldsFromDB.Rows[0]["UserName"].ToString();
					
					
						dtCustomFields.Rows.Add(new object []{"Type", dtCustomFieldsFromDB.Rows[0]["TypeName"]});
					
						// getting the custom fields in the DataList control
						arrCFD = _functions.GetCustomFields(false, Convert.ToInt32(Session["EquipTypeId"]), HttpContext.Current.User.Identity.Name);
						if(arrCFD.Count > 0)
						{
							// fill custom fields
							for(int j = 0; j < arrCFD.Count; j++)
							{
								cfd = (clsCustomFieldsDef)arrCFD[j];
								if(cfd.FieldTypeId == DBFieldType._lookup)
								{
									switch(cfd.NameLookupTable)
									{
										case "EquipModels":
											mm = new clsMakesModels();
											mm.iOrgId = 1; // later change
											mm.iModelId = Convert.ToInt32(dtCustomFieldsFromDB.Rows[0][_functions.GetFieldTypeText(cfd.FieldTypeId) + cfd.NumberColumn.ToString()]);
											mm.GetModelMakes();
											dtCustomFields.Rows.Add(new object []{"Make/Model", mm.sMakeName + "/" + mm.sModelName});
											break;
										case "Departments":
											dep =  new clsDepartments();
											dep.cAction = "S";
											dep.iOrgId = 1;
											dep.iId = Convert.ToInt32(dtCustomFieldsFromDB.Rows[0][_functions.GetFieldTypeText(cfd.FieldTypeId) + cfd.NumberColumn.ToString()]);
											if(dep.DepartmentDetail() == 0)
											{
												dtCustomFields.Rows.Add(new object []{cfd.NameText, dep.sName.Value});
											}
											break;
										case "Locations":
											loc = new clsLocations();
											loc.cAction = "S";
											loc.iOrgId = 1;
											loc.iId = Convert.ToInt32(dtCustomFieldsFromDB.Rows[0][_functions.GetFieldTypeText(cfd.FieldTypeId) + cfd.NumberColumn.ToString()]);
											if(loc.LocationDetail() == 0)
											{
												dtCustomFields.Rows.Add(new object []{cfd.NameText, loc.sName.Value});
											}
											break;
										default:
											break;
									}
								}
								else
								{
									dtCustomFields.Rows.Add(new object []{cfd.NameText, dtCustomFieldsFromDB.Rows[0][_functions.GetFieldTypeText(cfd.FieldTypeId) + cfd.NumberColumn.ToString()]});
								}
								cfd = null;
							}
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
		#region Save Equipment
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
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
				equip = new clsEquipment();
				equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				equip.iId = EquipId;
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				equip.iAssignedTo = Convert.ToInt32(ddAssignTo.SelectedValue);
				equip.sNote = tbNote.Text;
				equip.EquipAssignedTo();
				Response.Redirect(ParentPageURL, false);
			}
			catch(Exception ex)
			{
				_functions.Log("Application error: \n" + ex.ToString());
				Session["lastpage"] = "reassign.aspx?id=" + EquipId.ToString();
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
		
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
