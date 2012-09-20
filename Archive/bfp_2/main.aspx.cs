using System;
using System.Web.Security;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web.home
{
	/// <summary>
	/// Summary description for _main.
	/// </summary>
	public class _main : BFPPage
	{
		protected System.Web.UI.WebControls.HyperLink hlAdd;
		protected System.Web.UI.WebControls.HyperLink hlLogoff;
		protected System.Web.UI.WebControls.HyperLink hlViewList;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			base.OnInit(e);
			InitializeComponent();
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
