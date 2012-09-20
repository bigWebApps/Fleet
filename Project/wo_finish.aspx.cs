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

namespace BWA.BFP.Web.workorder
{
	public class _wo_finish : BFPPage
	{
		protected System.Web.UI.WebControls.HyperLink hlHome;
		protected System.Web.UI.WebControls.HyperLink hlContinue;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
		protected System.Web.UI.WebControls.HyperLink hlView;
		protected System.Web.UI.WebControls.HyperLink hlPrint;
		protected System.Web.UI.WebControls.Label lblMainText;
		protected System.Web.UI.WebControls.HyperLink hlAdditional;
		
		public BackFinishScreen finish;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_finish.aspx.cs";
				
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}


		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				if(!IsPostBack)
				{
					if(Session["BackFinish"] == null)
					{
						Session["lastpage"] = "main.aspx";
						Session["error"] = _functions.ErrorMessage(130);
						Response.Redirect("error.aspx", false);
						return;
					}

					finish = (BackFinishScreen)Session["BackFinish"];

					lblMainText.Text = finish.sMainText;

					if(finish.bMainMenuVisible)
					{
						hlHome.Text = finish.sMainMenuText;
						hlHome.NavigateUrl = finish.sMainMenuURL;
					}
					else
						tblMain.Rows[1].Visible = false;

					if(finish.bContinueVisible)
					{
						hlContinue.Text = finish.sContinueText;
						hlContinue.NavigateUrl = finish.sContinueURL;
					}
					else
						tblMain.Rows[2].Visible = false;

					if(finish.bViewVisible)
					{
						hlView.Text = finish.sViewText;
						hlView.NavigateUrl = finish.sViewURL;
					}
					else
						tblMain.Rows[3].Visible = false;

					if(finish.bAdditionalVisible)
					{
						hlAdditional.Text = finish.sAdditionalText;
						hlAdditional.NavigateUrl = finish.sAdditionalURL;
					}
					else
						tblMain.Rows[4].Visible = false;

					if(finish.bPrintVisible)
					{
						hlPrint.Text = finish.sPrintText;
						hlPrint.NavigateUrl = finish.sPrintURL;
					}
					else
						tblMain.Rows[5].Visible = false;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_finish.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
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
