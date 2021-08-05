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
	public class _ok_authCredentials : BFPPage
	{
		protected System.Web.UI.WebControls.TextBox tbLastName;
		protected System.Web.UI.WebControls.TextBox tbPIN;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvPIN;
		protected System.Web.UI.WebControls.RegularExpressionValidator revPIN;
		protected System.Web.UI.WebControls.Label lblError;
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Label lblType;
		protected System.Web.UI.WebControls.Label lblEquipId;

		private clsUsers user = null;
		private clsWorkOrders order = null;

		private string m_sOperation;
		private int OrderId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvLastName;
		private int EquipId;
				
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_authCredentials.aspx.cs";
				Header.MainMenuVisible = false;
				Header.AddMetaTag("<META HTTP-EQUIV=\"REFRESH\" CONTENT=\"300;url=ok_mainMenu.aspx\">");
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + tbPIN.ClientID + "');";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_mainMenu.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				if(Request.QueryString["orderid"] == null)
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["orderid"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				NextBackControl.BackText = "<< Back";
				NextBackControl.BackPage = "ok_mainMenu.aspx";
				NextBackControl.NextText = "Continue >>";
				NextBackControl.sCSSClass = "ok_input_button";
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					if(order.GetEquipInfo() == -1)
					{
						Session["lastpage"] = "ok_mainMenu.aspx";
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
					}
					else
					{
						if(order.sOperatorName.Value.Length > 0)
						{
							tbLastName.Text = order.sOperatorName.Value;
							tbLastName.Enabled = false;
						}
						else
						{
							Header.BodyOnloadScript = "javascript:GetFocus('" + tbLastName.ClientID + "');";
						}
						lblEquipId.Text = order.sEquipId.Value;
						lblType.Text = order.sEquipTypeName.Value;
					}
				}

			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_mainMenu.aspx";
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

		#region Next Screen
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				user = new clsUsers();
				user.iOrgId = OrgId;
				user.sLastName = tbLastName.Text;
				user.sPIN = tbPIN.Text;
				if(user.AuthOperator() != 0)
				{
					if(!user.bActiveStatus.Value)
					{
						lblError.Text = "<ul><li>" + _functions.ErrorMessage(202) + "</li></ul>";
					}
					else
					{
						Response.Cookies["bfp_operator"].Value =  (new OperatorInfo(user.iId.Value, user.sFirstName.Value)).ToString();
						Response.Cookies["bfp_operator"].Path = "/";
						Response.Cookies["bfp_operator"].Expires = DateTime.Now.AddYears(1);

						Response.Redirect("ok_mainDetails.aspx?id=" + OrderId.ToString() + "&back=authcredentials", false);
					}
//					switch(m_sOperation)
//					{
//						case "CheckIn":
//							Response.Redirect("ok_selectEquipment.aspx?orderid=" + OrderId.ToString(), false);
//							break;
//						case "CheckOut":
//							Response.Redirect("ok_selectWorkOrder.aspx?id=" + OrderId.ToString(), false);
//							break;
//						case "CheckOutSpare":
//							Response.Redirect("ok_selectSpareEquip.aspx?op=CheckOutSpare&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
//							break;
//						case "AddIssue":
//							Response.Redirect("ok_addIssues.aspx?op=AddIssue&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
//							break;
//						default:
//							Response.Redirect("ok_selectEquipment.aspx?orderid=" + OrderId.ToString(), false);
//							break;
//					}
				}
				else
				{
					lblError.Text = "<ul><li>The PIN code is incorrect</li></ul>";
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_authCredentials.aspx?orderid=" + OrderId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user != null)
					user.Dispose();
			}
		}
		#endregion

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
