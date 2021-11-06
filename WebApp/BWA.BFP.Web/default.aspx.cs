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
using System.Security;
using System.Security.Principal;
using System.Security.Cryptography;
using System.Text;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web
{
	public class _default : BFPPage
	{
		protected System.Web.UI.WebControls.Label lbErr;
		protected System.Web.UI.WebControls.RequiredFieldValidator LoginEmailValidator;
		protected System.Web.UI.WebControls.RegularExpressionValidator LoginEmailRegExp;
		protected System.Web.UI.WebControls.TextBox tbPassword;
		protected System.Web.UI.WebControls.RequiredFieldValidator PasswordValidator;
		protected System.Web.UI.WebControls.RegularExpressionValidator PasswordRegExp;
		protected System.Web.UI.WebControls.Button btLogin;
		protected System.Web.UI.WebControls.TextBox tbEmail;
		protected System.Web.UI.HtmlControls.HtmlTable tblLogin;
		protected System.Web.UI.WebControls.DataGrid dgOrgs;
		
		private clsUsers user = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "default.aspx.cs";
			
				base.OnLoad(e);
				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + tbEmail.ClientID + "');";
			}
			catch(Exception ex)
			{
				_functions.Log(ex, "", SourcePageName);
				lbErr.Visible = true;
				lbErr.Text = ex.Message;
			}
		}
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			string sMode;
			try
			{
				HttpContext.Current.Cache.Remove("userPages");

				if(!IsPostBack)
				{
					tblLogin.Rows[1].Visible = false;
					
					Session.RemoveAll();

					if(Request.IsAuthenticated)
					{

						if(Request.Cookies["bfp_mode"] == null)
							sMode = "";
						else
							sMode = Request.Cookies["bfp_mode"].Value;

						switch(sMode)
						{
							case "OperatorKiosk":
								Response.Redirect("ok_mainMenu.aspx", false);
								return;
							case "TechnicianMode":
								Response.Redirect("main.aspx", false);
								return;
							default:
								break;
						}
					}

					Response.Cookies["bfp_navigate"].Value = null;
					Response.Cookies["bfp_navigate"].Path = "/";
					Response.Cookies["bfp_navigate"].Expires = DateTime.Now.AddYears(-1);

					Response.Cookies["bfp_logo"].Value = null;
					Response.Cookies["bfp_logo"].Path = "/";
					Response.Cookies["bfp_logo"].Expires = DateTime.Now.AddYears(-1);

					Response.Cookies["bfp_roles"].Value = null;
					Response.Cookies["bfp_roles"].Expires = DateTime.Now.AddYears(-1);
					Response.Cookies["bfp_roles"].Path = "/";

					Response.Cookies["bfp_mode"].Value = null;
					Response.Cookies["bfp_mode"].Path = "/";
					Response.Cookies["bfp_mode"].Expires = DateTime.Now.AddYears(-1);

					FormsAuthentication.SignOut();

				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, "", SourcePageName);
				lbErr.Visible = true;
				lbErr.Text = ex.Message;
			}
			finally
			{
				if(user != null)
				{
					user.Dispose();
				}
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
			this.dgOrgs.SelectedIndexChanged += new System.EventHandler(this.dgOrgs_SelectedIndexChanged);
			this.btLogin.Click += new System.EventHandler(this.btLogin_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		/// <summary>
		/// Login
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btLogin_Click(object sender, System.EventArgs e)
		{
			string sUserData;
			string[] roles;
			string roleStr = "";  
			DataTable dtGroups = null;
			int iReturn;
			try
			{
				lbErr.Visible = false;
				user = new clsUsers();
				user.sEmail = tbEmail.Text;
				// User authenticating
				if(user.Authenticate() == -1)
				{
					lbErr.Visible = true;
				}
				else
				{
					if(!user.bActiveStatus.Value)
					{
						lbErr.Visible = true;
						lbErr.Text = _functions.ErrorMessage(202);
						return;
					}
					string dbPasswordHash = user.sPass.Value;
					string salt = user.sSalt.Value;
					// Now take the salt and the password entered by the user
					// and concatenate them together.
					string passwordAndSalt = String.Concat(tbPassword.Text, salt);
					// Now hash them
					string hashedPasswordAndSalt =       
						FormsAuthentication.HashPasswordForStoringInConfigFile(
						passwordAndSalt,
						"SHA1");
					// Now verify them. Returns true if they are equal
					if(!hashedPasswordAndSalt.Equals(dbPasswordHash))
					{
						lbErr.Visible = true;
					}
					else
					{
						// Getting info about user
						iReturn = user.LoginInfo();
						switch(iReturn)
						{
							case 0:
								Response.Cookies["bfp_logo"].Value = user.sLogo.Value;
								Response.Cookies["bfp_logo"].Path = "/";
								Response.Cookies["bfp_logo"].Expires = DateTime.Now.AddYears(1);

								// The authenticate was done successfully
								lbErr.Visible = false;
								// Creating the user's identifying string
								sUserData = user.iId.Value.ToString() + ":" + user.iOrgId.Value.ToString();

								// creating the roles's string for user from groups list
								dtGroups = user.GetUserGroupsList();

								foreach (DataRow dr in dtGroups.Rows) 
								{
									roleStr += String.Format("{0};", dr["vchDesc"]);
								}
								roleStr = roleStr.Remove(roleStr.Length - 1, 1);

								// creating a ticket for user with his roles
								FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
									1,
									sUserData,
									DateTime.Now,
									DateTime.Now.AddYears(1),
									false,
									roleStr
									);

								roles = roleStr.Split(new char[] {';'});

								// encrypting ticket for setting to cookie
								string cookieStr = FormsAuthentication.Encrypt(ticket);

								Response.Cookies["bfp_roles"].Value = cookieStr;
								Response.Cookies["bfp_roles"].Path = "/";
								Response.Cookies["bfp_roles"].Expires = DateTime.Now.AddYears(1);

								// setting the user's identifying string to cookie 
								FormsAuthentication.SetAuthCookie(sUserData, true);
						
								if(Request.QueryString["ReturnUrl"] != null)
									Response.Redirect(Request.QueryString["ReturnUrl"], false);
								else
									Response.Redirect("selectMode.aspx", false);
								break;
							case 1:
								// if there are many organization for current user then we are showing they on screen for choosing
								tblLogin.Rows[0].Visible = true;
								tblLogin.Rows[1].Visible = true;
								tblLogin.Rows[2].Visible = false;
								tblLogin.Rows[3].Visible = false;
								tblLogin.Rows[4].Visible = false;
								ViewState["UserId"] = user.iId.Value;
								dgOrgs.DataSource = new DataView(user.GetOrgListFromUser());
								dgOrgs.DataBind();
								lbErr.Visible = false;
								break;
							case -1:
								lbErr.Visible = true;
								break;
							default:
								lbErr.Visible = true;
								break;
						}
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, "", SourcePageName);
				lbErr.Visible = true;
				lbErr.Text = ex.Message;
			}
			finally
			{
				if(user != null)
				{
					user.Dispose();
				}
			}
		}


		/// <summary>
		/// Choosing the organization for user
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void dgOrgs_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			string sUserData;
			string[] roles;
			string roleStr = "";  
			DataTable dtGroups = null;
			string sOrg;
			string sLogo;
			try
			{
				lbErr.Visible = false;
				sLogo = ((LinkButton)dgOrgs.SelectedItem.FindControl("lbSelect")).CommandArgument;
				sOrg = ((Label)dgOrgs.SelectedItem.FindControl("lblOrgId")).Text;
				
				Response.Cookies["bfp_logo"].Value =  sLogo;
				Response.Cookies["bfp_logo"].Path = "/";
				Response.Cookies["bfp_logo"].Expires = DateTime.Now.AddYears(1);
						
				sUserData = ((int)ViewState["UserId"]).ToString() + ":" + sOrg;
				
				user = new clsUsers();
				user.iOrgId = Convert.ToInt32(sOrg);
				user.iId = (int)ViewState["UserId"];
				dtGroups = user.GetUserGroupsList();

				foreach (DataRow dr in dtGroups.Rows) 
				{
					roleStr += String.Format("{0};", dr["vchDesc"]);
				}
				roleStr = roleStr.Remove(roleStr.Length - 1, 1);

				FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
					1,
					sUserData,
					DateTime.Now,
					DateTime.Now.AddHours(1),
					false,
					roleStr
					);

				roles = roleStr.Split(new char[] {';'});

				string cookieStr = FormsAuthentication.Encrypt(ticket);

				Response.Cookies["bfp_roles"].Value = cookieStr;
				Response.Cookies["bfp_roles"].Path = "/";
				Response.Cookies["bfp_roles"].Expires = DateTime.Now.AddYears(1);

				FormsAuthentication.SetAuthCookie(sUserData, true);
				if(Request.QueryString["ReturnUrl"] != null && Request.QueryString["ReturnUrl"] != "/" && Request.QueryString["ReturnUrl"] != "%2f")
					Response.Redirect(Request.QueryString["ReturnUrl"], false);
				else
					Response.Redirect("selectMode.aspx", false);
			}
			catch(Exception ex)
			{
				lbErr.Visible = true;
				_functions.Log(ex, "", SourcePageName);
				lbErr.Text = ex.Message;
			}
			finally
			{
				if(user != null)
				{
					user.Dispose();
				}
			}
		}
	}
}
