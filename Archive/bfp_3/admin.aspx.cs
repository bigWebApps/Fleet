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
	public class _admin : BFPPage
	{
		protected System.Web.UI.WebControls.HyperLink hlPermission;
		protected System.Web.UI.WebControls.HyperLink hlGroups;
		protected BWA.BFP.Web.Controls.User.Header Header;

		private void Page_Load(object sender, System.EventArgs e)
		{
			string [,] arrBrdCrumbs = new string [1,2];
			arrBrdCrumbs[0,0]="main.aspx";
			arrBrdCrumbs[0,1]="Home";
			PageTitle = "Administration";
			Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
			Header.PageTitle=PageTitle;
			SourcePageName = "admin.aspx.cs";
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
