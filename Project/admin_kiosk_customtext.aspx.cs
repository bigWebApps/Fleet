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
using Micajah.Common;

namespace BWA.BFP.Web.admin
{
	public class _admin_kiosk_customtext : BFPPage
	{
		protected Micajah.Common.DataGridEx dgInstructions;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvInstructionName;
		protected System.Web.UI.WebControls.Button btnAddGroup;
		protected System.Web.UI.WebControls.DropDownList ddlInstructionTypes;
		protected System.Web.UI.WebControls.TextBox tbInstructionText;
		protected System.Web.UI.WebControls.Button btnAddInstruction;
		
		private clsInstructions instruct = null;
		private DataTable dtTypes = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_kiosk_customtext.aspx.cs";
				
				Header.MainMenuSelectedItem = "Administration";
				this.PageTitle  = "Kiosk Instruction Texts Manager";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.LeftBarHtml = "Add/Edit/Delete Instruction Texts";
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

				if(!IsPostBack)
				{
					instruct = new clsInstructions();
					instruct.iOrgId = OrgId;
					dtTypes = instruct.GetInstructionTypeList();
					ddlInstructionTypes.DataSource = new DataView(dtTypes);
					ddlInstructionTypes.DataBind();
					ViewState["InstructionTypes"] = dtTypes;
					dgInstructions.DataSource = instruct.GetInstructionList();
					dgInstructions.DataBind();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = ParentPageURL;
				Session["error"] = ex.Message; 
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(instruct != null)
					instruct.Dispose();
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
			this.dgInstructions.EditCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgInstructions_EditCommand);
			this.dgInstructions.CancelCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgInstructions_CancelCommand);
			this.dgInstructions.UpdateCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgInstructions_UpdateCommand);
			this.dgInstructions.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgInstructions_DeleteCommand);
			this.dgInstructions.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.dgInstructions_ItemDataBound);
			this.btnAddInstruction.Click += new System.EventHandler(this.btnAddInstruction_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void dgInstructions_EditCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				instruct = new clsInstructions();
				instruct.iOrgId = OrgId;
				dgInstructions.EditItemIndex = e.Item.ItemIndex;
				dgInstructions.DataSource = new DataView(instruct.GetInstructionList());
				dgInstructions.DataBind();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_kiosk_customtext.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(instruct != null)
					instruct.Dispose();
			}
		}

		private void dgInstructions_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				instruct = new clsInstructions();
				instruct.iOrgId = OrgId;
				dgInstructions.EditItemIndex = -1;
				dgInstructions.DataSource = new DataView(instruct.GetInstructionList());
				dgInstructions.DataBind();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_kiosk_customtext.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(instruct != null)
					instruct.Dispose();
			}
		}

		private void dgInstructions_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				instruct = new clsInstructions();
				instruct.iOrgId = OrgId;
				instruct.cAction = "D";
				instruct.iId = Convert.ToInt32(e.CommandArgument);
				if(instruct.InstructionDetail() == -1)
				{
					Header.ErrorMessage = _functions.ErrorMessage(168);
				}
				else
				{
					dgInstructions.EditItemIndex = -1;
					dgInstructions.DataSource = new DataView(instruct.GetInstructionList());
					dgInstructions.DataBind();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_kiosk_customtext.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(instruct != null)
					instruct.Dispose();
			}
		}

		private void dgInstructions_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				instruct = new clsInstructions();
				instruct.iOrgId = OrgId;
				instruct.cAction = "U";
				instruct.iId = Convert.ToInt32(e.CommandArgument);
				instruct.iTypeId = Convert.ToInt32(((DropDownList)e.Item.FindControl("dg_ddlInstructionTypes")).SelectedValue);
				instruct.sInstructionText = ((TextBox)e.Item.FindControl("dg_tbInstructionText")).Text;
				if(instruct.InstructionDetail() == -1)
				{
					Header.ErrorMessage = _functions.ErrorMessage(168);
				}
				else
				{
					dgInstructions.EditItemIndex = -1;
					dgInstructions.DataSource = new DataView(instruct.GetInstructionList());
					dgInstructions.DataBind();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_kiosk_customtext.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(instruct != null)
					instruct.Dispose();
			}
		}

		private void btnAddInstruction_Click(object sender, System.EventArgs e)
		{
			try
			{
				instruct = new clsInstructions();
				instruct.iOrgId = OrgId;
				instruct.cAction = "U";
				instruct.iId = 0;
				instruct.iTypeId = Convert.ToInt32(ddlInstructionTypes.SelectedValue);
				instruct.sInstructionText = tbInstructionText.Text;
				instruct.InstructionDetail();
				dgInstructions.EditItemIndex = -1;
				dgInstructions.DataSource = new DataView(instruct.GetInstructionList());
				dgInstructions.DataBind();
				tbInstructionText.Text = "";
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_kiosk_customtext.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(instruct != null)
					instruct.Dispose();
			}
		}

		private void dgInstructions_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
		{
			try
			{
				if(e.Item.ItemType == ListItemType.EditItem)
				{
					dtTypes = (DataTable)ViewState["InstructionTypes"];
					DropDownList dg_ddlInstructionTypes = ((DropDownList)e.Item.FindControl("dg_ddlInstructionTypes"));
					dg_ddlInstructionTypes.DataSource = new DataView(dtTypes);
					dg_ddlInstructionTypes.DataBind();
					dg_ddlInstructionTypes.SelectedValue = dg_ddlInstructionTypes.Attributes["SelectedValueEx"];
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_kiosk_customtext.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

	}
}
