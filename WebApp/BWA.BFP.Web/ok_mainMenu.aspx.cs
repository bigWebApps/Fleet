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
using Micajah.Common.Menu;

namespace BWA.BFP.Web.operatorkiosk
{
	public class _ok_mainMenu : BFPPage
	{
		protected System.Web.UI.WebControls.HyperLink hlCheckInHelp;
		protected System.Web.UI.WebControls.HyperLink hlCheckOutHelp;
		protected System.Web.UI.WebControls.Repeater repOrders;
		protected System.Web.UI.WebControls.HyperLink hlOperation;
		protected System.Web.UI.WebControls.Label lblWelcome;
		protected System.Web.UI.WebControls.TextBox tbLastName;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvLastName;
		protected System.Web.UI.WebControls.TextBox tbPIN;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvPIN;
		protected System.Web.UI.WebControls.RegularExpressionValidator revPIN;
		protected System.Web.UI.WebControls.Button btnLogin;

		private clsWorkOrders order = null;
		private clsUsers user = null;
		protected System.Web.UI.WebControls.HyperLink hlDeactivate;
		private DataTable dtOrders = null;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_mainMenu.aspx.cs";

				Response.Cookies["bfp_operator"].Value = null;
				Response.Cookies["bfp_operator"].Path = "/";
				Response.Cookies["bfp_operator"].Expires = DateTime.Now.AddYears(-1);

				Response.Cookies["bfp_mode"].Value = "OperatorKiosk";
				Response.Cookies["bfp_mode"].Path = "/";
				Response.Cookies["bfp_mode"].Expires = DateTime.Now.AddYears(1);

				Header.MainMenuVisible = false;
				Header.MainMenuSelectedItem = "Deactivate Operator Kiosk Terminal";
				Header.AddMetaTag("<META HTTP-EQUIV=\"REFRESH\" CONTENT=\"180\">");
				Header.AddJavaScriptFile("/Focus.js");
				base.OnLoad(e);
				Link.LogOff.Instance.Visible = false;
//				Link.LogOff.Instance.AltText = "Deactivate Operator Kiosk Terminal";
//				Link.LogOff.Instance.Name = "Deactivate Operator Kiosk Terminal";
//				Link.LogOff.Instance.Path = "/selectMode.aspx";
//				Header.AddMainMenuItem("<nobr>Deactivate Operator Kiosk Terminal</nobr>", "/selectMode.aspx");
//				Header.AddMainMenuItem("Arrival Check-In", "/ok_authCredentials.aspx?op=CheckIn");
//				Header.AddMainMenuItem("Departure Check-Out", "/ok_authCredentials.aspx?op=CheckOut");
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "selectMode.aspx";
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

				if(tbLastName.Text.Length > 0)
					Header.BodyOnloadScript = "javascript:GetFocus('" + tbPIN.ClientID + "');";
				else
					Header.BodyOnloadScript = "javascript:GetFocus('" + tbLastName.ClientID + "');";

				if(!IsPostBack)
				{
					user = new clsUsers();
					user.cAction = "S";
					user.iOrgId = OrgId;
					user.OrgDetails();
					lblWelcome.Text = "Welcome to the " + user.sOrgName.Value + " Operator Kiosk";

					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.daCurrentDate = DateTime.Now;

					dtOrders = order.GetActivityWorkOrder();
					ViewState["ActivityOrders"] = dtOrders;
					repOrders.DataSource = new DataView(dtOrders);
					repOrders.DataBind();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "selectMode.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user != null)
					user.Dispose();
				if(order != null)
					order.Dispose();
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
			this.btnLogin.Click += new System.EventHandler(this.btnLogin_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnLogin_Click(object sender, System.EventArgs e)
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
						Header.ErrorMessage =  "<font size=3>" + _functions.ErrorMessage(202) + "</font>";
						return;
					}

					Response.Cookies["bfp_operator"].Value =  (new OperatorInfo(user.iId.Value, user.sFirstName.Value)).ToString();
					Response.Cookies["bfp_operator"].Path = "/";
					Response.Cookies["bfp_operator"].Expires = DateTime.Now.AddYears(1);

//					 scenario:
//					 0 - if operator hasn't assigned the redirect to ok_selectEquipment.aspx
//					 1 - if operator has only one assigned equipment
//						1.1 - if this equipment is active (i.e. it exists in active table of equipments)
//						then redirect to screen where operator select operation for this equipment ok_mainDetails.aspx?id=OrderId
//						1.2 - if equipment is not activety then redirect to ok_selectEquipment.aspx?equipid=EquipId
//					 2 - If operator has many assigned equipment then redirect to ok_mainMenu2.aspx
//					 There over, operator select equipment what he will be processing
//					during selecting, if he select not active equipment then repeat the point 1.2 
//					if active then 1.1 
					switch(user.GetUserInfoForKiosk())
					{
						case 0:
							Response.Redirect("ok_selectEquipment.aspx?orderid=0&back=mainmenu", false);
							break;
						case 1:
							dtOrders = (DataTable)ViewState["ActivityOrders"];
							DataView dwOrders = new DataView(dtOrders);
							dwOrders.RowFilter = "EquipId=" + user.iEquipId.Value.ToString();
							if(dwOrders.Count == 0)
								Response.Redirect("ok_selectEquipment.aspx?orderid=0&equipid=" + user.iEquipId.Value.ToString() + "&back=mainmenu", false);
							if(dwOrders.Count == 1)
								Response.Redirect("ok_mainDetails.aspx?id=" + dwOrders[0]["Id"].ToString() + "&back=mainmenu", false);
							if(dwOrders.Count > 1)
								Header.ErrorMessage = "<font size=3>" + _functions.ErrorMessage(165) + "</font>";
							break;
						case 2:
							Response.Redirect("ok_mainMenu2.aspx", false);
							break;
						default:
							break;
					}
				}
				else
				{
					Header.ErrorMessage = "<font size=3>" + _functions.ErrorMessage(201) + "</font>";
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
				if(user != null)
					user.Dispose();
			}
		}
	}
}
