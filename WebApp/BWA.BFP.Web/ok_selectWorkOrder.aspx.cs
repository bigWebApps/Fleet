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
	public class _ok_selectWorkOrder : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblFirstName1;
		protected System.Web.UI.WebControls.Label lblEquipType;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Panel pnlOneEquipment;
		protected System.Web.UI.WebControls.Label lblFirstName2;
		protected System.Web.UI.WebControls.Repeater repEquipments;
		protected System.Web.UI.WebControls.Button btnNO;
		protected System.Web.UI.WebControls.Button btnYES;
		protected System.Web.UI.WebControls.Label lblFirstName3;
		protected System.Web.UI.WebControls.Panel pnlNoneEquipment;
		protected System.Web.UI.WebControls.Panel pnlManyEquipment;
	
		private clsEquipment equip = null;
		private clsWorkOrders order = null;
		private DataTable dtEquipments = null;
		private OperatorInfo op;

		private int OrderId;
	

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_selectWorkOrder.aspx.cs";

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
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				
				op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);
				
				if(!IsPostBack)
				{
					lblFirstName1.Text = lblFirstName2.Text = lblFirstName3.Text = op.FirstName;
				
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iUserId = op.Id; 
					dtEquipments = equip.GetEquipListForCheckOut();
					if(dtEquipments.Rows.Count < 1)
					{
						// none equipments mode
						pnlNoneEquipment.Visible = true;
					}
					else if (dtEquipments.Rows.Count == 1)
					{
						// one equipment mode
						pnlOneEquipment.Visible = true;
						lblEquipId.Text = dtEquipments.Rows[0]["EquipId"].ToString();
						lblEquipType.Text = dtEquipments.Rows[0]["TypeName"].ToString();
						ViewState["SelectedWorkOrderId"] = dtEquipments.Rows[0]["Id"].ToString();
					}
					else if(dtEquipments.Rows.Count > 1)
					{
						// manu equipments mode
						pnlManyEquipment.Visible = true;
						repEquipments.DataSource = new DataView(dtEquipments);
						repEquipments.DataBind();
					}
					if(OrderId != 0)
					{	
						pnlNoneEquipment.Visible = false;
						pnlManyEquipment.Visible = false;
						pnlOneEquipment.Visible = true;
						order = new clsWorkOrders();
						order.iOrgId = OrgId;
						order.iId = OrderId;
						if(order.GetEquipInfo() == -1)
						{
							Session["lastpage"] = "ok_authCredentials.aspx?op=CheckOut&orderid=" + OrderId.ToString();
							Session["error"] = _functions.ErrorMessage(120);
							Response.Redirect("error.aspx", false);
						}
						else
						{
							lblEquipId.Text = order.sEquipId.Value;
							lblEquipType.Text = order.sEquipTypeName.Value;
							ViewState["SelectedWorkOrderId"] = OrderId.ToString();
						}
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_authCredentials.aspx?op=CheckOut&orderid=" + OrderId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(order != null)
					order.Dispose();
				if(equip != null)
					equip.Dispose();
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
			this.btnNO.Click += new System.EventHandler(this.btnNO_Click);
			this.btnYES.Click += new System.EventHandler(this.btnYES_Click);
			this.repEquipments.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repEquipments_ItemCommand);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnNO_Click(object sender, System.EventArgs e)
		{
			try
			{
				ViewState["SelectedWorkOrderId"] = null;
				pnlNoneEquipment.Visible = false;
				pnlOneEquipment.Visible = false;
				pnlManyEquipment.Visible = true;

				equip = new clsEquipment();
				equip.iOrgId = OrgId;
				equip.iUserId = 6; //op.Id; 

				dtEquipments = equip.GetEquipListForCheckOut();
				repEquipments.DataSource = new DataView(dtEquipments);
				repEquipments.DataBind();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_selectWorkOrder.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
					equip.Dispose();
			}
		}

		private void btnYES_Click(object sender, System.EventArgs e)
		{
			if(ViewState["SelectedWorkOrderId"] != null)
			{
				Response.Redirect("ok_viewServices.aspx?id=" + (string)ViewState["SelectedWorkOrderId"], false);
			}

		}

		private void repEquipments_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			try
			{
				if(e.CommandName == "Select")
				{
					ViewState["SelectedWorkOrderId"] = e.CommandArgument.ToString();
					pnlNoneEquipment.Visible = false;
					pnlManyEquipment.Visible = false;
					pnlOneEquipment.Visible = true;
					lblEquipId.Text = ((LinkButton)e.Item.FindControl("lbEquipId")).Text;
					lblEquipType.Text = ((Label)e.Item.FindControl("lbEquipType")).Text;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_selectWorkOrder.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}
		}
	}
}
