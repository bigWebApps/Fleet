using System;
using System.Web;
using System.Web.Security;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web
{
	public class _selectMode : BFPPage
	{
		protected System.Web.UI.WebControls.HyperLink hlAdmin;
		protected System.Web.UI.WebControls.HyperLink hlErrors;
		protected System.Web.UI.WebControls.HyperLink hlTM;
		protected System.Web.UI.WebControls.HyperLink hlLogoff;
		protected System.Web.UI.WebControls.HyperLink hlOK;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "selectMode.aspx.cs";
				Response.Cookies["bfp_mode"].Value = null;
				Response.Cookies["bfp_mode"].Path = "/";
				Response.Cookies["bfp_mode"].Expires = DateTime.Now.AddYears(-1);
				//Response.Cookies.Set(new HttpCookie("bfp_mode", null));
				Header.MainMenuSelectedItem = "Home";
				this.PageTitle = "Home";

				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "default.aspx";
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
