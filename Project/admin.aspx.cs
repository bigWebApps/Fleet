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

namespace BWA.BFP.Web.admin
{
	public class _admin : BWA.BFP.Web.BFPPage
	{
		protected System.Web.UI.WebControls.HyperLink hlPermission;
		protected System.Web.UI.WebControls.HyperLink hlGroups;
		protected System.Web.UI.WebControls.HyperLink hlUsers;
		protected System.Web.UI.WebControls.HyperLink hlHolidays;
		protected System.Web.UI.WebControls.HyperLink hlInspections;
		protected System.Web.UI.WebControls.HyperLink hlKioskInstructionTexts;
		protected System.Web.UI.WebControls.HyperLink hlPMItems;
		protected System.Web.UI.WebControls.HyperLink hlPMSchedules;
		protected System.Web.UI.WebControls.HyperLink hlInspectSchedules;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				this.PageTitle  = "Administration";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.LeftBarHtml = "Administartion Menu";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = this.ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
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
