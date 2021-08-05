using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web.admin
{
	public class _admin_user_detail_edit : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblCreatedDate;
		protected System.Web.UI.WebControls.DataGrid dgGroups;
		protected System.Web.UI.WebControls.TextBox tbFirstName;
		protected System.Web.UI.WebControls.TextBox tbLastName;
		protected System.Web.UI.WebControls.TextBox tbEmail;
		protected System.Web.UI.WebControls.DropDownList ddlType;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvEmail;
		protected System.Web.UI.WebControls.RegularExpressionValidator revEmail;
		protected System.Web.UI.WebControls.DropDownList ddlGroup;
		protected System.Web.UI.WebControls.Button btnAddGroup;
		protected System.Web.UI.WebControls.TextBox tbNewPassword;
		protected System.Web.UI.WebControls.TextBox tbConfirmPassword;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvFirstName;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvLastName;
		protected System.Web.UI.WebControls.TextBox tbInitial;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvInitials;
		protected System.Web.UI.WebControls.RegularExpressionValidator revInitials;
		protected System.Web.UI.WebControls.TextBox tbNewPIN;
		protected System.Web.UI.WebControls.RegularExpressionValidator revPIN;
		protected System.Web.UI.WebControls.TextBox tbConfirmPIN;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvNewPass;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvNewPIN;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvConfirmPassword;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvConfirmPIN;
		protected System.Web.UI.WebControls.Label lblComfirmPassword;
		protected System.Web.UI.WebControls.Label lblConfirmPIN;
		protected System.Web.UI.WebControls.HyperLink hlInactive;
		protected System.Web.UI.WebControls.Label lblUserActivateStatus;
		protected System.Web.UI.WebControls.TextBox tbHourlyRate;
		protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator1;
		protected System.Web.UI.WebControls.RegularExpressionValidator revHourlyRate;
		
		public int UserId;
		private clsUsers user = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_user_detail_edit.aspx.cs";

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

				if(UserId == 0)
				{
					Header.AddBreadCrumb("Home", "/selectMode.aspx");
					Header.AddBreadCrumb("Administration", "/admin.aspx");
					Header.AddBreadCrumb("User Search", "/admin_users.aspx");
				
					this.PageTitle = "Add a New User";
				}
				else
				{
					Header.AddBreadCrumb("Home", "/selectMode.aspx");
					Header.AddBreadCrumb("Administration", "/admin.aspx");
					Header.AddBreadCrumb("User Search", "/admin_users.aspx");
					Header.AddBreadCrumb("User Detail", "/admin_user_detail.aspx?id=" + UserId.ToString());

					this.PageTitle = "User Detail Edit";
				}
				Header.LeftBarHtml = "View User Detail";
				Header.AddJavaScriptFile("/admin_user_detail_edit.js");
				SaveCancelControl.ParentPageURL= this.ParentPageURL;

				if(!IsPostBack)
				{
					user = new clsUsers();
					user.cAction = "S";
					user.iOrgId = OrgId;
					user.iId = UserId;

					if(UserId != 0)
					{
						if(user.UserDetails() == -1)
						{
							Session["lastpage"] = "admin_user_detail.aspx?id=" + UserId.ToString();
							Session["error"] = _functions.ErrorMessage(134);
							Response.Redirect("error.aspx", false);
							return;
						}
						tbFirstName.Text = user.sFirstName.Value;
						tbLastName.Text = user.sLastName.Value;
						tbInitial.Text = user.sInitials.Value.Trim();
						ddlType.SelectedValue = user.sTypeName.Value;
						tbEmail.Text = user.sEmail.Value;
						lblCreatedDate.Text = user.daCreated.Value.ToLongDateString() + " " + user.daCreated.Value.ToLongTimeString();
						tbHourlyRate.Text = user.dmHourlyRate.Value.ToString("F");
						if(user.bActiveStatus.Value)
						{
							lblUserActivateStatus.Text = "Activated";
							hlInactive.Text = "[Deactivate]";
						}
						else
						{
							lblUserActivateStatus.Text = "Deactivated";
							hlInactive.Text = "[Activate]";
						}
						hlInactive.NavigateUrl = "admin_user_detail_active.aspx?id=" + UserId.ToString();
						dgGroups.DataSource = new DataView(user.GetUserGroupsList());
						dgGroups.DataBind();
						ddlGroup.DataSource = new DataView(user.GetGroupsListByNotUser());
						ddlGroup.DataBind();
						if(ddlGroup.Items.Count == 0)
						{
							ddlGroup.Enabled = false;
							btnAddGroup.Enabled = false;
						}
						else
						{
							ddlGroup.Enabled = true;
							btnAddGroup.Enabled = true;
						}
						rfvNewPass.Enabled = false;
						rfvNewPIN.Enabled = false;
						rfvConfirmPassword.Enabled = false;
						rfvConfirmPIN.Enabled = false;
					}
					else
					{
						ddlGroup.DataSource = new DataView(user.GetGroupsListByNotUser());
						ddlGroup.DataBind();

						tblMain.Rows[11].Visible = false;
						tblMain.Rows[12].Visible = false;
						tblMain.Rows[13].Visible = false;
						tblMain.Rows[14].Visible = false;
						tblMain.Rows[15].Visible = false;
						tblMain.Rows[16].Visible = false;
						btnAddGroup.Visible = false;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_user_detail.aspx?id=" + UserId.ToString();
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
			this.dgGroups.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgGroups_DeleteCommand);
			this.btnAddGroup.Click += new System.EventHandler(this.btnAddGroup_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Save User Info
		/// <summary>
		/// Updating the user information
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			bool bSavePassword = false, bSavePIN = false;
			string salt;
			try
			{
				user = new clsUsers();
				user.cAction = "U";
				user.iOrgId = OrgId;
				user.iId = UserId;

				if(tbNewPassword.Text.Length > 0 && tbConfirmPassword.Text.Length > 0)
				{
					if(tbNewPassword.Text != tbConfirmPassword.Text)
					{
						lblComfirmPassword.Visible = true;
						if(tbNewPIN.Text != tbConfirmPIN.Text)
							lblConfirmPIN.Visible = true;
						return;
					}
					else
					{
						bSavePassword = true;
						lblConfirmPIN.Visible = false;
					}
				}
				
				if(tbNewPIN.Text.Length > 0 && tbConfirmPIN.Text.Length > 0)
				{
					if(tbNewPIN.Text != tbConfirmPIN.Text)
					{
						lblConfirmPIN.Visible = true;
						return;
					}
					else
					{
						bSavePIN = true;
						lblConfirmPIN.Visible = false;
					}
				}
				
				user.sFirstName = tbFirstName.Text;
				user.sLastName = tbLastName.Text;
				user.sInitials = tbInitial.Text.ToUpper();
				user.sTypeName = ddlType.SelectedValue;
				user.sEmail = tbEmail.Text;
				user.iLoginId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				user.daCreated = DateTime.Now;
				user.dmHourlyRate = Convert.ToDecimal(tbHourlyRate.Text);
				if(user.UserDetails() == -1)
				{
					Session["lastpage"] = "admin_user_detail_edit.aspx?id=" + UserId.ToString();
					Session["error"] = _functions.ErrorMessage(134);
					Response.Redirect("error.aspx", false);
					return;
				}

				if(bSavePassword || UserId == 0)
				{
					// set a new password
					salt = _functions.CreateSalt(5);
					string passwordHash = _functions.CreatePasswordHash(tbNewPassword.Text, salt);

					user.sPass = passwordHash;
					user.sSalt = salt; 
					if(user.SetPassword() == -1)
					{
						Header.ErrorMessage = _functions.ErrorMessage(134);
						return;
					}
				}

				if(bSavePIN || UserId == 0)
				{
					// set a new PIN code
					user.sPIN = tbNewPIN.Text;
					if(user.SetPIN() == -1)
					{
						Header.ErrorMessage = _functions.ErrorMessage(134);
						return;
					}
				}
		
				bool bRedirect = false;
				string sText = "";

				if(UserId == 0)
				{
					bRedirect = true;
					sText = "A new user has been added successfully!";
					// adding group to user 
					user.cAction = "I";
					user.iGroupId = Convert.ToInt32(ddlGroup.SelectedValue);
					if(user.UsersGroupsDetail() == -1)
					{
						Session["lastpage"] = "admin_user_detail_edit.aspx?id=" + UserId.ToString();
						Session["error"] = _functions.ErrorMessage(117);
						Response.Redirect("error.aspx", false);
						return;
					}
				}
				else
				{
					if(bSavePassword || bSavePIN)
					{
						bRedirect = true;
						if(bSavePassword && bSavePIN)
							sText = "The user's password and PIN Code have been sucessfully updated.";
						else if(bSavePassword && !bSavePIN)
							sText = "The user's password have been sucessfully updated.";
						else if(!bSavePassword && bSavePIN)
							sText = "The PIN Code have been sucessfully updated.";
					}
					else bRedirect = false;
				}
				if(bRedirect)
				{
					// redirect to the finish screen
					BackFinishScreen finish = new BackFinishScreen();
						
					finish.sMainText = sText;

					finish.bMainMenuVisible = true;
					finish.sMainMenuText = "[Return to Main Menu]";
					finish.sMainMenuURL = "selectMode.aspx";

					finish.bContinueVisible = false;
					
					finish.bViewVisible = true;
					finish.sViewText = "[View the User Detail]";
					finish.sViewURL = "admin_user_detail.aspx?id=" + user.iId.Value.ToString();
					
					finish.bAdditionalVisible = false;
					
					finish.bPrintVisible = false;
					
					Session["BackFinish"] = finish;

					Response.Redirect("wo_finish.aspx", false);
				}
				else
					Response.Redirect("admin_user_detail.aspx?id=" + user.iId.Value.ToString(), false);
			}
			catch(FormatException fex)
			{
				Header.ErrorMessage = _functions.ErrorMessage(108);
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
			}			
		}
		#endregion

		/// <summary>
		/// Removing current user from selected group
		/// </summary>
		/// <param name="source"></param>
		/// <param name="e"></param>
		private void dgGroups_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				user = new clsUsers();
				user.cAction = "D";
				user.iId = UserId;
				user.iOrgId = OrgId;
				user.iGroupId = Convert.ToInt32(e.Item.Cells[0].Text);
				if(user.UsersGroupsDetail() == -1)
				{
					Session["lastpage"] = "admin_user_detail_edit.aspx?id=" + UserId.ToString();
					Session["error"] = _functions.ErrorMessage(117);
					Response.Redirect("error.aspx", false);
					return;
				}
				// showing group list after delete
				dgGroups.DataSource = new DataView(user.GetUserGroupsList());
				dgGroups.DataBind();
				ddlGroup.DataSource = new DataView(user.GetGroupsListByNotUser());
				ddlGroup.DataBind();
				if(ddlGroup.Items.Count == 0)
				{
					ddlGroup.Enabled = false;
					btnAddGroup.Enabled = false;
				}
				else
				{
					ddlGroup.Enabled = true;
					btnAddGroup.Enabled = true;
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
			}			
		}

		/// <summary>
		/// Adding the user to selected group
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btnAddGroup_Click(object sender, System.EventArgs e)
		{
			try
			{

				user = new clsUsers();
				user.cAction = "I";
				user.iId = UserId;
				user.iOrgId = OrgId;
				user.iGroupId = Convert.ToInt32(ddlGroup.SelectedValue);
				if(user.UsersGroupsDetail() == -1)
				{
					Session["lastpage"] = "admin_user_detail_edit.aspx?id=" + UserId.ToString();
					Session["error"] = _functions.ErrorMessage(117);
					Response.Redirect("error.aspx", false);
					return;
				}
				// showing the groups after adding
				dgGroups.DataSource = new DataView(user.GetUserGroupsList());
				dgGroups.DataBind();
				ddlGroup.DataSource = new DataView(user.GetGroupsListByNotUser());
				ddlGroup.DataBind();
				if(ddlGroup.Items.Count == 0)
				{
					ddlGroup.Enabled = false;
					btnAddGroup.Enabled = false;
				}
				else
				{
					ddlGroup.Enabled = true;
					btnAddGroup.Enabled = true;
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
			}
		}
	}
}
