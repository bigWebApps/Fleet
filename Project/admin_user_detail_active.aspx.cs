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

namespace BWA.BFP.Web.admin
{
	public class _admin_user_detail_active : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Label lblFirstName;
		protected System.Web.UI.WebControls.Label lblLastName;
		protected System.Web.UI.WebControls.Label lblEmail;
		protected System.Web.UI.WebControls.Label lblType;
		protected System.Web.UI.WebControls.Label lblCreatedDate;
		protected System.Web.UI.WebControls.Label lblUserActivateStatus;
		protected System.Web.UI.WebControls.Repeater repOperatorEquipments;
		protected System.Web.UI.WebControls.Repeater repWorkOrders;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
	
		private int UserId;
		private DataTable dtOperators = null;
		private DataTable dtTechnicians = null;
		private clsUsers user = null;
		private clsEquipment equip = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_user_detail_active.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
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

				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "admin_users.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					UserId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "admin_users.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("User Search", "/admin_users.aspx");
				Header.AddBreadCrumb("User Detail", "/admin_user_detail.aspx?id=" + UserId.ToString());
				Header.AddBreadCrumb("User Detail Edit", "/admin_user_detail_edit.aspx?id=" + UserId.ToString());

				this.PageTitle = "User Detail Activate";
				Header.LeftBarHtml = "User Activating/Deactivating";
				
				SaveCancelControl.ParentPageURL= this.ParentPageURL;

				if(!IsPostBack)
				{
					user = new clsUsers();
					user.cAction = "S";
					user.iOrgId = OrgId;
					user.iId = UserId;

					if(user.UserDetails() == -1)
					{
						Session["lastpage"] = "admin_user_detail.aspx?id=" + UserId.ToString();
						Session["error"] = _functions.ErrorMessage(134);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblFirstName.Text = user.sFirstName.Value;
					lblLastName.Text = user.sLastName.Value;
					lblEmail.Text = user.sEmail.Value;
					lblType.Text = user.sTypeName.Value;
					lblCreatedDate.Text = user.daCreated.Value.ToLongDateString() + " " + user.daCreated.Value.ToLongTimeString();
					if(user.bActiveStatus.Value)
					{
						ViewState["Active"] = false;
						lblUserActivateStatus.Text = "Activated";
						SaveCancelControl.ButtonText = "Deactivate";
						user.iTypeId = (int)UserTypes.Operator;
						dtOperators = user.GetUserListByType();
						ViewState["Operators"] = dtOperators;
						user.iTypeId = (int)UserTypes.Technician;
						dtTechnicians = user.GetUserListByType();
						ViewState["Technicians"] = dtTechnicians;
						equip = new clsEquipment();
						equip.iOrgId = OrgId;
						equip.iUserId = UserId;
						DataTable dtEquipOrders = equip.GetEquipListByOperatorActivate();
						if(dtEquipOrders.Rows.Count > 0)
						{
							repOperatorEquipments.DataSource = new DataView(dtEquipOrders);
							repOperatorEquipments.DataBind();
						}
						else
						{
							tblMain.Rows[8].Visible = false;
							tblMain.Rows[9].Visible = false;
							tblMain.Rows[10].Visible = false;
						}
						DataTable dtTechOrders = equip.GetOrderListByTechnicianActivate();
						if(dtTechOrders.Rows.Count > 0)
						{
							repWorkOrders.DataSource = new DataView(dtTechOrders);
							repWorkOrders.DataBind();
						}
						else
						{
							tblMain.Rows[11].Visible = false;
							tblMain.Rows[12].Visible = false;
							tblMain.Rows[13].Visible = false;
						}
					}
					else
					{
						ViewState["Active"] = true;
						lblUserActivateStatus.Text = "Deactivated";
						SaveCancelControl.ButtonText = "Activate";
						tblMain.Rows[8].Visible = false;
						tblMain.Rows[9].Visible = false;
						tblMain.Rows[10].Visible = false;
						tblMain.Rows[11].Visible = false;
						tblMain.Rows[12].Visible = false;
						tblMain.Rows[13].Visible = false;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_user_detail_edit.aspx?id=" + UserId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user != null)
					user.Dispose();
				if(equip != null)
					equip.Dispose();
			}	
		}


		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			this.SaveCancelControl.BubbleClick += new EventHandler(this.btSave_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
		}
		
		private void InitializeComponent()
		{    
			this.repOperatorEquipments.ItemDataBound += new System.Web.UI.WebControls.RepeaterItemEventHandler(this.repOperatorEquipments_ItemDataBound);
			this.repWorkOrders.ItemDataBound += new System.Web.UI.WebControls.RepeaterItemEventHandler(this.repWorkOrders_ItemDataBound);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Save User Info
		/// <summary>
		/// Activating/Inactivating the user account
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				equip = new clsEquipment();
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				foreach(RepeaterItem _item in repOperatorEquipments.Items)
				{
					DropDownList ddlOperators = (DropDownList)_item.FindControl("ddlOperators");
					bool IsNobody = Convert.ToBoolean(ddlOperators.Attributes["IsNobody"]);
					if(!IsNobody && ddlOperators.SelectedValue == "0")
					{
						Header.ErrorMessage = "Operator is required";
						return;
					}
					equip.iOrgId = OrgId;
					equip.iId = Convert.ToInt32(ddlOperators.Attributes["EquipId"]);
					equip.iEquipOperatorId = Convert.ToInt32(ddlOperators.SelectedValue);
					equip.sNote = "Deactivated Operator - Reassigned New Operator";
					equip.EquipAssignedTo();
				}
				user = new clsUsers();
				user.iOrgId = OrgId;
				user.daCreated = DateTime.Now;
				user.iLoginId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				foreach(RepeaterItem _item in repWorkOrders.Items)
				{
					DropDownList ddlTechs = (DropDownList)_item.FindControl("ddlTechs");
					bool IsNobody = Convert.ToBoolean(ddlTechs.Attributes["IsNobody"]);
					if(!IsNobody && ddlTechs.SelectedValue == "0")
					{
						Header.ErrorMessage = "Technician is required";
						return;
					}
					user.iOrderId = Convert.ToInt32(ddlTechs.Attributes["OrderId"]);
					user.iId = Convert.ToInt32(ddlTechs.SelectedValue);
					user.SetNewTechToWorkOrder();
				}
				user = new clsUsers();
				user.iOrgId = OrgId;
				user.iId = UserId;
				user.bActiveStatus = (bool)ViewState["Active"];
				if(user.UserActive() == -1)
				{
					Session["lastpage"] = "admin_user_detail_active.aspx?id=" + UserId.ToString();
					Session["error"] = _functions.ErrorMessage(134);
					Response.Redirect("error.aspx", false);
					return;
				}
				if(UserId == _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true))
					Response.Redirect("default.aspx", false);
				else
				{
					// redirect to the finish screen
					BackFinishScreen finish = new BackFinishScreen();
					if(((bool)ViewState["Active"]))
						finish.sMainText = "The user has been activated successfully";
					else
						finish.sMainText = "The user has been deactivated successfully";

					finish.bMainMenuVisible = true;
					finish.sMainMenuText = "[Return to Main Menu]";
					finish.sMainMenuURL = "selectMode.aspx";

					finish.bContinueVisible = false;
					
					finish.bViewVisible = true;
					finish.sViewText = "[View the User Detail]";
					finish.sViewURL = "admin_user_detail.aspx?id=" + UserId.ToString();
					
					finish.bAdditionalVisible = false;
					
					finish.bPrintVisible = false;
					
					Session["BackFinish"] = finish;

					Response.Redirect("wo_finish.aspx", false);
				}
			}
		
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_user_detail_active.aspx?id=" + UserId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user != null)
					user.Dispose();
				if(equip != null)
					equip.Dispose();
			}			
		}
		#endregion

		private void repOperatorEquipments_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
		{
			try
			{
				if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
				{
					System.Web.UI.WebControls.DropDownList ddlOperators = (System.Web.UI.WebControls.DropDownList)e.Item.FindControl("ddlOperators");
					dtOperators = (DataTable)ViewState["Operators"];
					DataView dwOperators = new DataView(dtOperators);
					bool IsNobody = Convert.ToBoolean(ddlOperators.Attributes["IsNobody"]);
					if(IsNobody)
					{
						dwOperators[0]["vchName"] = "Nobody";
						dwOperators.RowFilter = "Id <> " + UserId.ToString();
					}
					else
					{
						dwOperators[0]["Id"] = "0";
						dwOperators[0]["vchName"] = "";
						dwOperators.RowFilter = "Id <> " + UserId.ToString();
						System.Web.UI.WebControls.RequiredFieldValidator rfvItem = new RequiredFieldValidator();
						rfvItem.InitialValue = "0";
						rfvItem.ControlToValidate = ddlOperators.ID;
						rfvItem.EnableClientScript = true;
						rfvItem.Display = ValidatorDisplay.Dynamic;
						rfvItem.ErrorMessage = "Operator is Required";
						e.Item.FindControl("rfvItem").Controls.Add(rfvItem);
						//e.Item.Controls.Add(rfvItem);
					}
					ddlOperators.DataSource = dwOperators;
					ddlOperators.DataBind();
				}
			}		
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_user_detail_edit.aspx?id=" + UserId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}			
		}


		private void repWorkOrders_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
		{
			try
			{
				if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
				{		
					System.Web.UI.WebControls.DropDownList ddlTechs = (System.Web.UI.WebControls.DropDownList)e.Item.FindControl("ddlTechs");
					dtTechnicians = (DataTable)ViewState["Technicians"];
					DataView dwTech = new DataView(dtTechnicians);
					bool IsNobody = Convert.ToBoolean(ddlTechs.Attributes["IsNobody"]);
					if(IsNobody)
					{
						dwTech[0]["vchName"] = "Nobody";
						dwTech.RowFilter = "Id <> " + UserId.ToString();
					}
					else
					{
						dwTech[0]["Id"] = "0";
						dwTech[0]["vchName"] = "";
						dwTech.RowFilter = "Id <> " + UserId.ToString();
						System.Web.UI.WebControls.RequiredFieldValidator rfvItem = new RequiredFieldValidator();
						rfvItem.InitialValue = "0";
						rfvItem.ControlToValidate = ddlTechs.ID;
						rfvItem.EnableClientScript = true;
						rfvItem.Display = ValidatorDisplay.Dynamic;
						rfvItem.ErrorMessage = "Technician is Required";
						e.Item.FindControl("rfvItem").Controls.Add(rfvItem);

					}
					ddlTechs.DataSource = dwTech;
					ddlTechs.DataBind();
				}
			}		
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_user_detail_edit.aspx?id=" + UserId.ToString();
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
