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
	public class _ok_editCurrentUnits : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblCurrentUnits;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvUnis;
		protected System.Web.UI.WebControls.RangeValidator rvUnits;
		protected System.Web.UI.WebControls.RegularExpressionValidator revUnits;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Label lblMeasure;
		protected System.Web.UI.WebControls.TextBox tbUnits;
		protected System.Web.UI.WebControls.Label lblEquipType;
		protected System.Web.UI.WebControls.Label lblMeasure2;
		protected System.Web.UI.WebControls.Label lblMeasure3;
		
		private clsWorkOrders order = null;
		private clsEquipment equip = null;
		private OperatorInfo op = null;
	
		private int OrderId;
		private int EquipId;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_editCurrentUnits.aspx.cs";

				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + tbUnits.ClientID + "');";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}
		private void Page_Load(object sender, System.EventArgs e)
		{
			int l_iMileage;
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
				NextBackControl.BackPage = "ok_selectEquipment.aspx?orderid=" + OrderId.ToString();
				NextBackControl.NextText = "Continue >>";
				NextBackControl.sCSSClass = "ok_input_button";
				
				op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);
					
				if(!IsPostBack)
				{
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iId = EquipId;
					
					if(equip.GetEquipInfo() != -1)
					{	
						if(0 == Decimal.Compare(Decimal.Floor(equip.dmCurrentUnits.Value), equip.dmCurrentUnits.Value))
							lblCurrentUnits.Text = Decimal.Floor(equip.dmCurrentUnits.Value).ToString() + " " + equip.sMeasure.Value;
						else
							lblCurrentUnits.Text = equip.dmCurrentUnits.Value.ToString("F") + " " + equip.sMeasure.Value;
						//mileage
						lblMeasure.Text = equip.sMeasure.Value;
						lblMeasure2.Text = equip.sMeasure.Value;
						lblMeasure3.Text = equip.sMeasure.Value;
						lblEquipId.Text = equip.sEquipId.Value;
						lblEquipType.Text = equip.sType.Value;
						rvUnits.MinimumValue = equip.dmCurrentUnits.Value.ToString();
						rvUnits.ErrorMessage = "Value must be greater than was " + equip.dmCurrentUnits.Value.ToString("F");
					}
					else
					{
						Session["lastpage"] ="ok_selectEquipment.aspx?orderid=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_selectEquipment.aspx?orderid=" + OrderId.ToString();
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

		#region Next Screen
		/// <summary>
		/// Selecting or creating of the Work Order for 
		/// current Equipment if for current equipment there aren't 
		/// the scheduled work order then it will be created. 
		/// If there are one work order then select him. 
		/// If them more than one then we are selecting the one that has 
		/// the scheduled time by closer to the current moment.
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.iEquipId = EquipId;
				order.daCurrentDate = DateTime.Now;
				order.dmMileage = Convert.ToDecimal(tbUnits.Text);
				order.iUserId = op.Id;
				order.SelectWorkOrder();
				Response.Redirect("ok_addIssues.aspx?orderid=" + order.iId.Value.ToString() + "&equipid=" + EquipId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_editCurrentUnits.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
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
