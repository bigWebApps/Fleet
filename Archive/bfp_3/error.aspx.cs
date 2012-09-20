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
	public class _error : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblError;
		protected System.Web.UI.WebControls.Button btnSendReport;
		protected System.Web.UI.WebControls.Button btnBack;
		protected System.Web.UI.WebControls.Label lblBack;
		protected BWA.BFP.Web.Controls.User.Header Header;

		private string sLastPage;
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				PageTitle = "Equipment Detail";
				string [,] arrBrdCrumbs = new string [1,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				PageTitle = "Error screen";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;

				if(!IsPostBack)
				{
					if(Session["lastpage"] == null)
					{
						sLastPage = ParentPageURL;
					}
					else
					{
						sLastPage = Session["lastpage"].ToString();
						ViewState["lastpage"] = sLastPage;
						Session["lastpage"] = null;
					}
				
					btnSendReport.CommandArgument = sLastPage;
					lblBack.Text = "<input type=button value=\" Back to the Last Screen \" onclick=\"document.location='"+ sLastPage + "'\">";

					if(Session["error"] == null)
					{
						lblError.Text = "Unknown error";
					}
					else
					{
						lblError.Text = Session["error"].ToString();
						Session["error"] = null;
					}
					if(Session["error_report"] == null)
					{
						btnSendReport.Enabled = false;
					}
					else{
						btnSendReport.Enabled = true;
						ViewState["error_report"] = Session["error_report"];
						Session["error_report"] = null;
					}
					if(((string)_functions.GetValueFromConfig("Report.Enabled")).ToLower() != "true")
					{
						btnSendReport.ToolTip = "Sorry, the Report service is disabled";
						btnSendReport.Enabled = false;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, "error.aspx.cs");
			}
			finally
			{
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
			this.btnSendReport.Click += new System.EventHandler(this.btnSendReport_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnSendReport_Click(object sender, System.EventArgs e)
		{
			string sText, sEmail, sSubj;
			clsUsers user = null;
			try
			{
				user = new clsUsers(); 
				user.cAction = "S";
				user.iId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				user.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				user.UserDetails();
				sText = "The Error Report from " + user.sFirstName.Value + " " + user.sLastName.Value + " [" + user.sEmail.Value + "] at " + DateTime.Now.ToUniversalTime()  + " GMT <br>"; 
				sText += "Error Description:<br>";
				sText += "-------------------------------------------------------------<br>";
				sText += ViewState["error_report"].ToString();
				sSubj = "The Error Report from FleetPro Application";
				sEmail = _functions.GetValueFromConfig("Report.DevEmail");
				if(!_functions.SendEmail(sEmail, sSubj, sText))
				{
					Session["lastpage"] = ViewState["lastpage"];
					Session["error"] = _functions.ErrorMessage(113);
					Response.Redirect("error.aspx", false);
				}
				else
				{
					Response.Redirect(btnSendReport.CommandArgument, false);
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, "error.aspx.cs");
				Session["lastpage"] = ViewState["lastpage"];
				Session["error"] = _functions.ErrorMessage(112);
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user != null)
				{
					user.Dispose();
				}
			}
		}
	}
}
