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

namespace BWA.BFP.Web.equip
{
	public class _e_selectTempOperator : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Label lblEquipType;
		protected System.Web.UI.WebControls.Label lblMakeModel;
		protected System.Web.UI.WebControls.Label lblYear;
		protected System.Web.UI.WebControls.Label lblSerial;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.WebControls.LinkButton lbChangeOperator;
		protected System.Web.UI.WebControls.Panel pnlVerifyOperator;
		protected System.Web.UI.WebControls.TextBox tbFirstName;
		protected System.Web.UI.WebControls.TextBox tbLastName;
		protected System.Web.UI.WebControls.Button btnSearch;
		protected System.Web.UI.WebControls.Repeater repOperators;
		protected System.Web.UI.WebControls.Button btnBack;
		protected System.Web.UI.WebControls.Panel pnlSelectOperator;
		protected System.Web.UI.WebControls.Label lblTempOperator;
		protected System.Web.UI.WebControls.TextBox tbNote;
		protected System.Web.UI.WebControls.Label lblNewTempOperator;
		protected System.Web.UI.WebControls.LinkButton lbUnassign;
		
		private clsEquipment equip = null;
		private clsUsers user = null;

		private int EquipId;
		private int UserId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "e_selectTempOperator.aspx.cs";
				
				this.PageTitle  = "Change Temporary Operator";
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddBreadCrumb("Select Equipment", "/wo_default.aspx?select=ChangeTempOper");
				Header.LeftBarHtml = "Change Temporary Operator of Equipment";
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

				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "wo_default.aspx?select=ChangeTempOper";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "wo_default.aspx?select=ChangeTempOper";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				SaveCancelControl.ParentPageURL = ParentPageURL;

				if(!IsPostBack)
				{
					pnlVerifyOperator.Visible = false;
					pnlSelectOperator.Visible = true;

					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iId = EquipId;
					equip.cAction = "S";
					if(equip.EquipmentDetail() == -1)
					{
						Session["lastpage"] = "wo_default.aspx?select=ChangeTempOper";
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblOperator.Text = equip.sEquipOperator.Value.Length>0?equip.sEquipOperator.Value:"Nobody";
					lblTempOperator.Text = equip.sTempOperator.Value.Length>0?equip.sTempOperator.Value:"Nobody";
					lblEquipId.Text = equip.sEquipId.Value;
					lblEquipType.Text = equip.sType.Value;
					lblMakeModel.Text = equip.sMakeModelName.Value;
					lblYear.Text = equip.iYear.Value.ToString();
					lblSerial.Text = equip.sVinSerial.Value;

				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_default.aspx?select=ChangeTempOper";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}
		}

		#region Change Temp Operator
		/// <summary>
		/// Procedure is changin the Temporary Operator
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				equip = new clsEquipment();
				equip.iOrgId = OrgId;
				equip.iId = EquipId;
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				equip.iTempOperatorId = Convert.ToInt32(ViewState["TempOpId"]);
				equip.sNote = tbNote.Text;
				equip.EquipAssignedTempTo();
				Response.Redirect("e_view.aspx?id=" + EquipId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_selectTempOperator.aspx?id=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		}
		#endregion


		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			this.SaveCancelControl.BubbleClick += new EventHandler(this.btSave_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.lbChangeOperator.Click += new System.EventHandler(this.lbChangeOperator_Click);
			this.lbUnassign.Click += new System.EventHandler(this.lbUnassign_Click);
			this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
			this.repOperators.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repOperators_ItemCommand);
			this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnBack_Click(object sender, System.EventArgs e)
		{
			if(ViewState["TempOpId"] == null)
				Response.Redirect("wo_default.aspx?select=ChangeTempOper", false);
			else
				pnlVerifyOperator.Visible = true;
				pnlSelectOperator.Visible = false;

		}

		private void lbChangeOperator_Click(object sender, System.EventArgs e)
		{
			pnlVerifyOperator.Visible = false;
			pnlSelectOperator.Visible = true;
		}

		private void repOperators_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			try
			{
				if(e.CommandName == "Select")
				{
					UserId = Convert.ToInt32(e.CommandArgument);
					ViewState["TempOpId"] = UserId;
					lblNewTempOperator.Text = ((Label)e.Item.FindControl("lblLastName")).Text + ", " + ((Label)e.Item.FindControl("lblFirstName")).Text;
					pnlVerifyOperator.Visible = true;
					pnlSelectOperator.Visible = false;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_selectTempOperator.aspx?id=" + EquipId.ToString();
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
				Session["lastpage"] = "e_selectTempOperator.aspx?id=" + EquipId.ToString();
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

		private void lbUnassign_Click(object sender, System.EventArgs e)
		{
			ViewState["TempOpId"] = 0;
			pnlVerifyOperator.Visible = true;
			pnlSelectOperator.Visible = false;
			lblNewTempOperator.Text = "Nobody";
		}
		
	}
}
