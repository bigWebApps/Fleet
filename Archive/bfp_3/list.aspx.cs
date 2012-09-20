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
				SourcePageName = "list.aspx.cs";

				if(!IsPostBack)
				{
					equip = new clsEquipment();
					
					equip.cAction = "S";
					equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					
					dtEquipTypes = equip.GetEquipTypesList();

					ddlEquipType.DataSource = new DataView(dtEquipTypes);
					ddlEquipType.DataBind();
					ddlEquipType.Items.Insert(0, new ListItem("All","0"));
					
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
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
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
			try
			{
				dgMainList.Controls.Clear();
				
				
				dtData = equip.GetEquipList();
				
				dgMainList.DataSource = new DataView(dtData);
				dgMainList.DataBind();

			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
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
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
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
