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

namespace BWA.BFP.Web.workorder
{

	public class _wo_create1 : BFPPage
	{
		protected System.Web.UI.WebControls.DropDownList ddlDepartments;
		protected System.Web.UI.WebControls.DropDownList ddlDrivers;
		protected System.Web.UI.WebControls.Button btnFiltration;
		protected Micajah.DataGrid.DataGrid_A dgMainList;
		protected System.Web.UI.WebControls.DropDownList ddlEquipTypes;
		protected System.Web.UI.WebControls.DropDownList ddlLocations;
	
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
				SourcePageName = "wo_create1.aspx.cs";

//				if(!IsPostBack)
//				{
//				}
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

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
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
