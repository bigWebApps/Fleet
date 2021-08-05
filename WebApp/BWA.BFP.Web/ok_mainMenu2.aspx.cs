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
	public class _ok_mainMenu2 : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblFirstName;
		protected System.Web.UI.WebControls.Repeater repEquipments;
		protected System.Web.UI.WebControls.TextBox tbEquipmentId;
		protected System.Web.UI.WebControls.Button btnFind;
	
		private clsEquipment equip = null;
		private clsWorkOrders order = null;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_mainMenu.aspx.cs";

				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + tbEquipmentId.ClientID + "');";
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
					
				if(!IsPostBack)
				{
					OperatorInfo op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);
					lblFirstName.Text = op.FirstName;
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iUserId = op.Id; 
					repEquipments.DataSource = new DataView(equip.GetEquipListByOperator2());
					repEquipments.DataBind();
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
				if(equip != null)
					equip.Dispose();
			}

		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.btnFind.Click += new System.EventHandler(this.btnFind_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnFind_Click(object sender, System.EventArgs e)
		{
			int EquipId, OrderId;
			DataView dwOrders;
			try
			{
				equip = new clsEquipment();
				equip.iOrgId = OrgId;
				equip.sEquipId = tbEquipmentId.Text;
				if(equip.SearchEquipId() == 0)
				{
					Header.ErrorMessage = "<span style='FONT-SIZE:12pt;'>The specified equipment could not be located</span>";
					tbEquipmentId.Text = "";
				}
				else
				{
					EquipId = equip.iId.Value;
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.daCurrentDate = DateTime.Now;
					dwOrders = new DataView(order.GetActivityWorkOrder());
					dwOrders.RowFilter = "EquipId = " + EquipId.ToString();
					if(dwOrders.Count > 0)
					{
						dwOrders.Sort = "StatusColor desc, OperatorStatusName asc";
						OrderId = Convert.ToInt32(dwOrders[0]["Id"].ToString());
						Response.Redirect("ok_mainDetails.aspx?id=" + OrderId.ToString() + "&back=mainmenu2", false);
					}
					else
						Response.Redirect("ok_selectEquipment.aspx?orderid=0&equipid=" + EquipId.ToString() + "&back=mainmenu2", false);
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_mainMenu2.aspx";
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
	}
}
