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
	public class _ok_viewCheckIn : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Label lblFirstName;
		protected System.Web.UI.WebControls.Label lblEquipType;
		protected System.Web.UI.WebControls.Repeater repInstructions;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.HyperLink hlPrint;
	
		private clsWorkOrders order = null;
		private clsEquipment equip = null;
		private OperatorInfo op = null;

		private int OrderId;
		private int EquipId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_viewCheckIn.aspx.cs";

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
				if((Request.QueryString["equipid"] == null) && (Request.QueryString["orderid"] == null))
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["orderid"]);
					EquipId = Convert.ToInt32(Request.QueryString["equipid"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				
				NextBackControl.BackText = "<< Back";
				NextBackControl.BackPage = "ok_editNote.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
				NextBackControl.NextText = "  Finish  ";
				NextBackControl.sCSSClass = "ok_input_button";

				op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);

				if(!IsPostBack)
				{
					lblFirstName.Text = op.FirstName;
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iId = EquipId;
					if(equip.GetEquipInfo() != -1)
					{
						lblEquipId.Text = equip.sEquipId.Value;
						lblEquipType.Text = equip.sType.Value;
					}
					else
					{
						Session["lastpage"] = "ok_editNote.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					repInstructions.DataSource = new DataView(order.GetInstructionByCheckIn());
					repInstructions.DataBind();

					if(order.bPrint.Value)
					{
						hlPrint.Visible = true;
						string Url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")).Replace("/", "%2f");
						Url = Url.Replace(":", "%3a");
						hlPrint.Attributes.Add("onclick", "javascript:window.open('ReportViewer.aspx?Report=" + _functions.GetValueFromConfig("SQLRS.Folder") + "%2fCheckInReceipt&OrderId=" + OrderId.ToString() + "&OrgId=" + OrgId.ToString() + "&URL=" + Url + "', 'popupcal', 'toolbars=0');");
					}
					else
						hlPrint.Visible = false;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_editNote.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
					equip.Dispose();
				if(order != null)
					order.Dispose();
			}
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


		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			Response.Redirect("ok_mainMenu.aspx", false);
		}
	}
}
