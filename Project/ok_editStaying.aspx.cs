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
	public class _ok_editStaying : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblFirstName;
		protected System.Web.UI.WebControls.Button btnNO;
		protected System.Web.UI.WebControls.Button btnYES;
		protected System.Web.UI.WebControls.Button btnBack;

		private clsWorkOrders order = null;
		private OperatorInfo op = null;

		private int OrderId;
		private int EquipId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_editStaying.aspx.cs";

				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + btnYES.ClientID + "');";
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
				
				op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);

				if(!IsPostBack)
				{
					lblFirstName.Text = op.FirstName;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_selectSpareEquip.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
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
		}
		
		private void InitializeComponent()
		{    
			this.btnYES.Click += new System.EventHandler(this.btnYES_Click);
			this.btnNO.Click += new System.EventHandler(this.btnNO_Click);
			this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnNO_Click(object sender, System.EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.bStaying = false;
				if(order.UpdateStayingWorkOrder() == -1)
				{
					Session["lastpage"] = "ok_editStaying.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					Session["error"] = _functions.ErrorMessage(120);
					Response.Redirect("error.aspx", false);
				}
				else
					Response.Redirect("ok_editNote.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);			
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_editStaying.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
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

		private void btnYES_Click(object sender, System.EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.bStaying = true;
				if(order.UpdateStayingWorkOrder() == -1)
				{
					Session["lastpage"] = "ok_editStaying.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					Session["error"] = _functions.ErrorMessage(120);
					Response.Redirect("error.aspx", false);
				}
				else
					Response.Redirect("ok_editNote.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_editStaying.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
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

		private void btnBack_Click(object sender, System.EventArgs e)
		{
			Response.Redirect("ok_selectSpareEquip.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
		}
	}
}
