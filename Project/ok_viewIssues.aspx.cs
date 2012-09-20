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

namespace BWA.BFP.Web.operatorkiosk
{
	public class _ok_viewIssues : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Repeater repIssues;
	
		private clsWorkOrders order = null;
		
		private DataTable dtIssues;
		
		private int OrderId;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_viewIssues.aspx.cs";

				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + NextBackControl.NextClientId + "');";
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
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "ok_selectWorkOrder.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "ok_selectWorkOrder.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				NextBackControl.BackText = "<< Back";
				NextBackControl.BackPage = "ok_viewServices.aspx?id=" + OrderId.ToString();
				NextBackControl.NextText = "Continue >>";
				NextBackControl.sCSSClass = "ok_input_button";

				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					dtIssues = order.GetReportedIssueLists().Tables[1];
					if(dtIssues.Rows.Count > 0)
					{
						repIssues.DataSource = new DataView(dtIssues);
						repIssues.DataBind();
					}
					else
					{
						Response.Redirect("ok_updateSpare.aspx?id=" + OrderId.ToString() ,false);
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_viewServices.aspx?id=" + OrderId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}
		}

		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			Response.Redirect("ok_updateSpare.aspx?id=" + OrderId.ToString() ,false);
			// or 
			//Response.Redirect("ok_viewNotes.aspx?id=" + OrderId.ToString() ,false);
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			this.NextBackControl.BubbleClick += new EventHandler(this.btNext_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
		}
		
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
