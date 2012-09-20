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
	public class _ok_selectEquipment : BFPPage
	{
		protected System.Web.UI.WebControls.Panel pnlOneEquipment;
		protected System.Web.UI.WebControls.Panel pnlManyEquipment;
		protected System.Web.UI.WebControls.Button btnNO1;
		protected System.Web.UI.WebControls.Button btnYES1;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Panel pnlFindEquipment;
		protected System.Web.UI.WebControls.Label lblFirstName1;
		protected System.Web.UI.WebControls.Label lblFirstName2;
		protected System.Web.UI.WebControls.Repeater repEquipments;
		protected System.Web.UI.WebControls.LinkButton lbFindEquipment;
		protected System.Web.UI.WebControls.Label lblFirstName3;
		protected System.Web.UI.WebControls.TextBox tbEquipId;
		protected System.Web.UI.WebControls.Label lblError;
		protected System.Web.UI.WebControls.Label lblEquipType;
		protected System.Web.UI.WebControls.Button btnFind;
		protected System.Web.UI.WebControls.Label lblMakeModel;
		protected System.Web.UI.WebControls.Label lblYear;
		
		private clsEquipment equip = null;
		private clsWorkOrders order = null;
		private DataTable dtEquipments = null;

		private int OrderId;
		private int EquipId;
		private string sBackPage, sBackURL;
		protected System.Web.UI.HtmlControls.HtmlInputButton btnBack;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_selectEquipment.aspx.cs";

				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + btnYES1.ClientID + "');GetFocus('" + tbEquipId.ClientID + "');";
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
				if(Request.QueryString["orderid"] == null)
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId = Convert.ToInt32(Request.QueryString["equipid"]);
					OrderId = Convert.ToInt32(Request.QueryString["orderid"]);
					sBackPage = Request.QueryString["back"];
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				sBackURL = "ok_mainMenu.aspx";
				if(sBackPage == "maindetails")
					sBackURL = "ok_mainDetails.aspx?id=" + OrderId.ToString();
				if(sBackPage == "mainmenu2")
					sBackURL = "ok_mainMenu2.aspx";
				btnBack.Attributes.Add("onclick","javascript:document.location='" + sBackURL + "'");

				if(!IsPostBack)
				{
					OperatorInfo op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);
					lblFirstName1.Text = lblFirstName2.Text = lblFirstName3.Text = op.FirstName;
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iUserId = op.Id; 
					dtEquipments = equip.GetEquipListByOperator();
					if(dtEquipments.Rows.Count < 1)
					{
						// none equipments mode
						pnlFindEquipment.Visible = true;
					}
					else if (dtEquipments.Rows.Count == 1)
					{
						// one equipment mode
						pnlOneEquipment.Visible = true;
						lblEquipId.Text = dtEquipments.Rows[0]["EquipId"].ToString();
						lblEquipType.Text = dtEquipments.Rows[0]["TypeName"].ToString();
						lblMakeModel.Text = dtEquipments.Rows[0]["MakeName"].ToString() + "/" + dtEquipments.Rows[0]["ModelName"].ToString();
						lblYear.Text = dtEquipments.Rows[0]["Year"].ToString();
						ViewState["SelectedEqiupId"] = dtEquipments.Rows[0]["Id"].ToString();
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
						pnlFindEquipment.Visible = false;
						pnlManyEquipment.Visible = false;
						pnlOneEquipment.Visible = true;
						order = new clsWorkOrders();
						order.iOrgId = OrgId;
						order.iId = OrderId;
						if(order.GetEquipInfo() == -1)
						{
							Session["lastpage"] = sBackURL;
							Session["error"] = _functions.ErrorMessage(120);
							Response.Redirect("error.aspx", false);
						}
						else
						{
							lblEquipId.Text = order.sEquipId.Value;
							lblEquipType.Text = order.sEquipTypeName.Value;
							lblMakeModel.Text = order.sEquipMakeModel.Value;
							lblYear.Text = order.sEquipYear.Value;
							ViewState["SelectedEqiupId"] = order.iEquipId.Value.ToString();
						}
					}
					else
					{
						if(EquipId != 0)
						{
							pnlFindEquipment.Visible = false;
							pnlManyEquipment.Visible = false;
							pnlOneEquipment.Visible = true;
							equip.iId = EquipId;
							if(equip.GetEquipInfo() == -1)
							{
								Session["lastpage"] = sBackURL;
								Session["error"] = _functions.ErrorMessage(102);
								Response.Redirect("error.aspx", false);
							}
							else
							{
								lblEquipId.Text = equip.sEquipId.Value;
								lblEquipType.Text = equip.sType.Value;
								lblMakeModel.Text = equip.sMakeModelName.Value;
								lblYear.Text = equip.iYear.Value.ToString();
								ViewState["SelectedEqiupId"] = EquipId.ToString();
							}
						}
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = sBackURL;
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
			this.btnNO1.Click += new System.EventHandler(this.btnNO1_Click);
			this.btnYES1.Click += new System.EventHandler(this.btnYES1_Click);
			this.repEquipments.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repEquipments_ItemCommand);
			this.lbFindEquipment.Click += new System.EventHandler(this.lbFindEquipment_Click);
			this.btnFind.Click += new System.EventHandler(this.btnFind_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void repEquipments_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			int iEquipId;
			string sEquipId;
			try
			{
				if(e.CommandName == "Select")
				{
					iEquipId = Convert.ToInt32(e.CommandArgument);
					ViewState["SelectedEqiupId"] = iEquipId.ToString();
					pnlFindEquipment.Visible = false;
					pnlManyEquipment.Visible = false;
					pnlOneEquipment.Visible = true;
					lblEquipId.Text = ((LinkButton)e.Item.FindControl("lbEquipId")).Text;
					lblEquipType.Text = ((Label)e.Item.FindControl("lbEquipType")).Text;
					lblMakeModel.Text = ((Label)e.Item.FindControl("lbMakeName")).Text + "/" + ((Label)e.Item.FindControl("lbModelName")).Text;
					lblYear.Text = ((Label)e.Item.FindControl("lbYear")).Text;
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
			}
		}

		private void btnFind_Click(object sender, System.EventArgs e)
		{
			try
			{
				equip = new clsEquipment();
				equip.iOrgId = OrgId;
				equip.sEquipId = tbEquipId.Text;
				equip.GetEquipId();
				if(equip.iId.Value == 0)
				{
					lblError.Visible = true;
					tbEquipId.Text = "";
				}
				else
				{
					pnlFindEquipment.Visible = false;
					pnlManyEquipment.Visible = false;
					pnlOneEquipment.Visible = true;
					ViewState["SelectedEqiupId"] = equip.iId.Value.ToString();
					lblEquipId.Text = tbEquipId.Text;
					lblEquipType.Text = equip.sType.Value;
					lblMakeModel.Text = equip.sMakeModelName.Value;
					lblYear.Text = equip.iYear.Value.ToString();
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

		private void btnNO1_Click(object sender, System.EventArgs e)
		{
			try
			{
				ViewState["SelectedEqiupId"] = null;
				pnlFindEquipment.Visible = true;
				pnlManyEquipment.Visible = false;
				pnlOneEquipment.Visible = false;
				lblError.Visible = false;
				tbEquipId.Text = "";
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
			}
		}

		private void btnYES1_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(ViewState["SelectedEqiupId"] != null)
				{
					Response.Redirect("ok_editCurrentUnits.aspx?orderid=" + OrderId.ToString() + "&equipid=" + (string)ViewState["SelectedEqiupId"], false);
				}
				else
				{
					pnlFindEquipment.Visible = true;
					pnlManyEquipment.Visible = false;
					pnlOneEquipment.Visible = false;
					lblError.Visible = true;
					tbEquipId.Text = "";
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
			}		
		}

		private void lbFindEquipment_Click(object sender, System.EventArgs e)
		{
			try
			{
				ViewState["SelectedEqiupId"] = null;
				pnlFindEquipment.Visible = true;
				pnlManyEquipment.Visible = false;
				pnlOneEquipment.Visible = false;
				lblError.Visible = false;
				tbEquipId.Text = "";
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
			}		
		}
	}
}
