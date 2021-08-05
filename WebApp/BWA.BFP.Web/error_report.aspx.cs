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

namespace BWA.BFP.Web.error
{
	public class _error_report : BFPPage
	{
		protected ActiveUp.WebControls.ActiveDateTime adtReportFrom;
		protected ActiveUp.WebControls.ActiveDateTime adtReportTo;
		protected Micajah.DataGrid.DataGrid_A dgErrorsList;
		protected System.Web.UI.WebControls.Button btnShow;
		
		private clsErrors error = null;
		private DataTable dtErrors = null;
		
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "error_report.aspx.cs";

				Header.MainMenuSelectedItem = "Error Reports";
				this.PageTitle  = "Error Reports";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
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
			try
			{
				if(!IsPostBack)
				{
					if(Session["dtErrors"] == null)
					{
						adtReportTo.Date = DateTime.Now.AddDays(1);
						adtReportFrom.Date = DateTime.Now.AddDays(-1);
					}
					else
					{
						adtReportTo.Date = (DateTime)Session["adtReportTo"];
						adtReportFrom.Date = (DateTime)Session["adtReportFrom"];
						dtErrors = (DataTable)Session["dtErrors"];
						dgErrorsList.DataSource = new DataView(dtErrors);
						dgErrorsList.DataBind();
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
			this.btnShow.Click += new System.EventHandler(this.btnShow_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnShow_Click(object sender, System.EventArgs e)
		{
			try
			{
				error = new clsErrors();
				error.daStartDate = adtReportFrom.Date;
				error.daFinishDate = adtReportTo.Date;
				dtErrors = error.GetErrorsList();
				Session["dtErrors"] = dtErrors;
				Session["adtReportFrom"] = adtReportFrom.Date;
				Session["adtReportTo"] = adtReportTo.Date;
				dgErrorsList.DataSource = new DataView(dtErrors);
				dgErrorsList.DataBind();		
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, "error_report.aspx.cs");
				Session["lastpage"] = ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(error != null)
				{
					error.Dispose();
				}
			}

		}
	}
}
