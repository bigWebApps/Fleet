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
	public class _ok_selectSpareEquip : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Label lblFirstName;
		protected System.Web.UI.WebControls.Label lblEquipType;
		protected System.Web.UI.WebControls.Panel pnlViewQuestion;
		protected System.Web.UI.WebControls.Panel pnlSelectSpare;
		protected System.Web.UI.WebControls.Panel pnlNoSpare;
		protected System.Web.UI.WebControls.Button btnNO;
		protected System.Web.UI.WebControls.Button btnYES;
		protected System.Web.UI.WebControls.Button btnBack;
		protected System.Web.UI.WebControls.Repeater repSpareEquip;
		protected System.Web.UI.WebControls.Button btnBackInt;
	
		private clsEquipment equip = null;
		private OperatorInfo op = null;

		private int OrderId;
		private int EquipId;
		private string Operation;
		private string BackPage;
		private string CurrentPage;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_selectSpareEquip.aspx.cs";

				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + NextBackControl.NextClientId + "');GetFocus('" + btnYES.ClientID + "');";
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

				if(Request.QueryString["op"] == null)
				{
					Operation = "CheckIn";
					BackPage = "ok_addIssues.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					CurrentPage = "ok_selectSpareEquip.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					
				}
				else
				{
					Operation = "CheckOutSpare";
					BackPage = "ok_mainMenu.aspx";
					CurrentPage = "ok_selectSpareEquip.aspx?op=CheckOutSpare&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
				}

				NextBackControl.BackPage = BackPage;
				NextBackControl.sCSSClass = "ok_input_button";

				op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);

				if(!IsPostBack)
				{
					pnlViewQuestion.Visible = true;
					pnlSelectSpare.Visible = false;
					pnlNoSpare.Visible = false;

					lblFirstName.Text = op.FirstName;
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iId = EquipId;
					if(equip.GetEquipInfo() != -1)
						lblEquipType.Text = equip.sType.Value.ToLower();
					else
					{
						Session["lastpage"] = BackPage;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = BackPage;
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

		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			// next screen
			if(Operation == "CheckIn")
				Response.Redirect("ok_editStaying.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
			else
				Response.Redirect(BackPage, false);
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
			this.btnNO.Click += new System.EventHandler(this.btnNO_Click);
			this.btnYES.Click += new System.EventHandler(this.btnYES_Click);
			this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
			this.repSpareEquip.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repSpareEquip_ItemCommand);
			this.btnBackInt.Click += new System.EventHandler(this.btnBackInt_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnBack_Click(object sender, System.EventArgs e)
		{
			Response.Redirect(BackPage, false);
		}

		private void btnNO_Click(object sender, System.EventArgs e)
		{
			// next screen
			if(Operation == "CheckIn")
				Response.Redirect("ok_editStaying.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
			else
				Response.Redirect(BackPage, false);
		}

		private void btnYES_Click(object sender, System.EventArgs e)
		{
			DataTable dtSpareEquip = null;
			try
			{
				equip = new clsEquipment();
				equip.iOrgId = OrgId;
				equip.iId = EquipId;
				dtSpareEquip = equip.GetSpareEquipList();

				if(dtSpareEquip.Rows.Count > 0)
				{ // view spare equipments
					pnlSelectSpare.Visible = true;
					pnlNoSpare.Visible = false;
					pnlViewQuestion.Visible = false;

					repSpareEquip.DataSource = new DataView(dtSpareEquip);
					repSpareEquip.DataBind();
				}
				else
				{
					// no spare
					pnlNoSpare.Visible = true;
					pnlSelectSpare.Visible = false;
					pnlViewQuestion.Visible = false;
					btnBack.Visible = false;

					NextBackControl.sCSSClass = "ok_input_button";
					if(Operation == "CheckIn")
					{
						NextBackControl.BackText = "<< Back";
						NextBackControl.BackPage = BackPage;
						NextBackControl.NextText = "Continue >>";
					}
					else
					{
						NextBackControl.NextText = "Back to Main Menu";
						NextBackControl.BackVisible = false;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = CurrentPage;
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

		private void repSpareEquip_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			try
			{
				if(e.CommandName == "Select")
				{
					// check-out spare eqipment, set NOT staying operator and redirect to Additional Comments screen
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iUserId = op.Id;
					equip.iId = Convert.ToInt32(e.CommandArgument);
					equip.iOrderId = OrderId;
					equip.sNote = "checking out the spare equipment";
					if(equip.EquipSpareTo(true) == -1)
					{
						Session["lastpage"] = CurrentPage;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
					}
					else
					{
						if(Operation == "CheckIn")
							Response.Redirect("ok_editNote.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
						else
							Response.Redirect(BackPage, false);
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = CurrentPage;
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

		private void btnBackInt_Click(object sender, System.EventArgs e)
		{
			try
			{
				pnlViewQuestion.Visible = true;
				pnlSelectSpare.Visible = false;
				pnlNoSpare.Visible = false;

				lblFirstName.Text = op.FirstName;
				equip = new clsEquipment();
				equip.iOrgId = OrgId;
				equip.iId = EquipId;
				if(equip.GetEquipInfo() != -1)
					lblEquipType.Text = equip.sType.Value;
				else
				{
					Session["lastpage"] = CurrentPage;
					Session["error"] = _functions.ErrorMessage(102);
					Response.Redirect("error.aspx", false);
					return;
				}		
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = CurrentPage;
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
	}
}
