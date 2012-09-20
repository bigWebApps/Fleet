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
	public class _ok_viewReOpen : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Label lblFirstName;
		protected System.Web.UI.WebControls.Label lblEquipType;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Repeater repInstructions;

		private clsWorkOrders order = null;
		private OperatorInfo op = null;

		private DataTable dtInstructions = null;
		private int OrderId;
		private string m_sBack;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_viewReOpen.aspx.cs";
		
				Header.MainMenuVisible = false;
				Header.AddMetaTag("<META HTTP-EQUIV=\"REFRESH\" CONTENT=\"120;url=ok_mainMenu.aspx\">");
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
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
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
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				NextBackControl.BackText = "<< Back";
				NextBackControl.BackPage = "ok_reopenWorkOrder.aspx?id=" + OrderId.ToString() + "&op=Issue";
				NextBackControl.NextText = "  Finish  ";
				NextBackControl.sCSSClass = "ok_input_button";

				op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);

				if(!IsPostBack)
				{
					lblFirstName.Text = op.FirstName;
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					if(order.GetEquipInfo() != -1)
					{
						lblEquipId.Text = order.sEquipId.Value;
						lblEquipType.Text = order.sEquipTypeName.Value;

						dtInstructions = order.GetInstructionByReOpen();
						repInstructions.DataSource = new DataView(dtInstructions);
						repInstructions.DataBind();
					}
					else
					{
						Session["lastpage"] = "ok_reopenWorkOrder.aspx?id=" + OrderId.ToString() + "&op=Issue";
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_reopenWorkOrder.aspx?id=" + OrderId.ToString() + "&op=Issue";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(order != null)
					order.Dispose();
			}
		}

		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			Response.Redirect("ok_mainMenu.aspx", false);
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
