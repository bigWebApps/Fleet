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

namespace BWA.BFP.Web.workorder
{
	public class _wo_selectOperator : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Panel pnlVerifyOperator;
		protected System.Web.UI.WebControls.Panel pnlSelectOperator;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Label lblEquipType;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.WebControls.TextBox tbFirstName;
		protected System.Web.UI.WebControls.TextBox tbLastName;
		protected System.Web.UI.WebControls.Button btnSearch;
		protected System.Web.UI.WebControls.Button btnBack;
		protected System.Web.UI.WebControls.Label lblEquipType2;
		protected System.Web.UI.WebControls.Label lblEquipId2;
		protected System.Web.UI.WebControls.Label lblMakeModel;
		protected System.Web.UI.WebControls.Label lblYear;
		protected System.Web.UI.WebControls.Label lblSerial;
		protected System.Web.UI.WebControls.Repeater repOperators;
		protected System.Web.UI.WebControls.DropDownList ddlTech;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvAssignTech;
		protected System.Web.UI.WebControls.LinkButton lbChangeOperator;
		protected System.Web.UI.WebControls.Label lblTempOperator;

		private clsEquipment equip = null;
		private clsWorkOrders order = null;
		private clsUsers user = null;

		private int EquipId;
		private int OrderId;
		private int UserId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_selectOperator.aspx.cs";
				
				this.PageTitle = "Select Operator";
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddBreadCrumb("Select Equipment", "/wo_default.aspx?select=AddRoadside");
				Header.LeftBarHtml = "Select Equipment Operator and Technician for the roadside repair";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = this.ParentPageURL;
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

				if((Request.QueryString["equipid"] == null) || (Request.QueryString["orderid"] == null))
				{
					Session["lastpage"] = "wo_default.aspx?select=AddRoadside";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId = Convert.ToInt32(Request.QueryString["equipid"]);
					OrderId = Convert.ToInt32(Request.QueryString["orderid"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "wo_default.aspx?select=AddRoadside";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				NextBackControl.BackPage = this.ParentPageURL;
				NextBackControl.BackVisible = true;
				NextBackControl.CausesValidation = true;
								
				if(!IsPostBack)
				{
					pnlVerifyOperator.Visible = true;
					
					user = new clsUsers();
					user.iOrgId = OrgId;
					user.iTypeId = (int)UserTypes.Technician;

					ddlTech.DataSource = new DataView(user.GetUserListByType());
					ddlTech.DataBind();

					EquipmentDetails();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_default.aspx?select=AddRoadside";
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


		private void EquipmentDetails()
		{
			try
			{
				if(OrderId != 0)
				{
					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					
					if(order.WorkOrderDetails() == -1)
					{
						Session["lastpage"] = "wo_default.aspx?select=AddRoadside";
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}
					if(ddlTech.Items.FindByValue(order.iTechId.Value.ToString()) != null)
						ddlTech.SelectedValue = order.iTechId.Value.ToString();					
					EquipId = order.iEquipId.Value;
				}

				equip = new clsEquipment();
				equip.iOrgId = OrgId;
				equip.iId = EquipId;
				equip.cAction = "S";
				if(equip.EquipmentDetail() == -1)
				{
					Session["lastpage"] = "wo_default.aspx?select=AddRoadside";
					Session["error"] = _functions.ErrorMessage(102);
					Response.Redirect("error.aspx", false);
					return;
				}
				lblOperator.Text = equip.sEquipOperator.Value;
				lblTempOperator.Text = equip.sTempOperator.Value;
				lblEquipId.Text = equip.sEquipId.Value;
				lblEquipType.Text = equip.sType.Value;
				lblMakeModel.Text = equip.sMakeModelName.Value;
				lblYear.Text = equip.iYear.Value.ToString();
				lblSerial.Text = equip.sVinSerial.Value;
				lblEquipId2.Text = equip.sEquipId.Value;
				lblEquipType2.Text = equip.sType.Value;
			
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
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
			this.NextBackControl.BubbleClick += new EventHandler(this.btNext_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}

		private void InitializeComponent()
		{    
			this.lbChangeOperator.Click += new System.EventHandler(this.btnChangeOperator_Click);
			this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
			this.repOperators.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repOperators_ItemCommand);
			this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnChangeOperator_Click(object sender, System.EventArgs e)
		{
			try
			{
				pnlVerifyOperator.Visible = false;
				pnlSelectOperator.Visible = true;
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_selectOperator.aspx?equipid=" + EquipId.ToString() + "&orderid=" + OrderId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

		private void btnSearch_Click(object sender, System.EventArgs e)
		{
			try
			{
				pnlVerifyOperator.Visible = false;
				pnlSelectOperator.Visible = true;
				user = new clsUsers();
				user.iOrgId = OrgId;
				user.sFirstName = tbFirstName.Text;
				user.sLastName = tbLastName.Text;
				user.sEmail = "";
				user.iGroupId = 0;
				user.iActiveStatus = 0;
				user.iTypeId = (int)UserTypes.All;
				repOperators.DataSource = new DataView(user.GetUserList_Filter());
				repOperators.DataBind();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_selectOperator.aspx?equipid=" + EquipId.ToString() + "&orderid=" + OrderId.ToString();
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

		private void repOperators_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			try
			{
				if(e.CommandName == "Select")
				{
					UserId = Convert.ToInt32(e.CommandArgument);
					// assign operator to equipment
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iId = EquipId;
					equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
					equip.iEquipOperatorId = UserId;
					equip.sNote = "changing old operator to new during Roadside Repair procedure";
					equip.EquipAssignedTo();
					pnlSelectOperator.Visible = false;
					pnlVerifyOperator.Visible = true;
					EquipmentDetails();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_selectOperator.aspx?equipid=" + EquipId.ToString() + "&orderid=" + OrderId.ToString();
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

		private void btnBack_Click(object sender, System.EventArgs e)
		{
			try
			{
				pnlSelectOperator.Visible = false;
				pnlVerifyOperator.Visible = true;
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_selectOperator.aspx?equipid=" + EquipId.ToString() + "&orderid=" + OrderId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}
		

		#region Create Work Order
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			DateTime daCurrentDate;
			try
			{
				UserId = Convert.ToInt32(ddlTech.SelectedValue);
				daCurrentDate = DateTime.Now;
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iEquipId = EquipId;
				order.daCurrentDate = daCurrentDate;
				order.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				order.iId = OrderId;
				order.iTechId = UserId;
				order.SetRoadsideWorkOrder();
				OrderId = order.iId.Value;
				Response.Redirect("wo_selectSpareEquip.aspx?select=AddRoadside&id=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_selectOperator.aspx?equipid=" + EquipId.ToString() + "&orderid=" + OrderId.ToString();
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
	}
}
