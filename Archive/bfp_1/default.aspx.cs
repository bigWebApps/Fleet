using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using BWA.BFP.Data;
using System.Text;


namespace BWA.BFP.Web
{
	/// <summary>
	/// 
	/// </summary>
	public class _Login : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.Label lbErr;
		protected System.Web.UI.WebControls.TextBox tbLoginEmail;
		protected System.Web.UI.WebControls.TextBox tbPassword;
		protected System.Web.UI.WebControls.RequiredFieldValidator LoginEmailValidator;
		protected System.Web.UI.WebControls.RegularExpressionValidator LoginEmailRegExp;
		protected System.Web.UI.WebControls.RequiredFieldValidator PasswordValidator;
		protected System.Web.UI.WebControls.RegularExpressionValidator PasswordRegExp;
		protected System.Web.UI.WebControls.Button btLogin;
	
		private void Page_Load(object sender, System.EventArgs e){
			// Put user code to initialize the page here
		}
		protected void btLogin_Click(object sender, System.EventArgs e)
		{
			int orgId;
			string firstName;
			int userId;

			BWA.WebModules.ICredentialStore credentialstore = new BWA.WebModules.DBAuthentication();
			if (credentialstore.Authenticate(tbLoginEmail.Text,tbPassword.Text,out orgId, out firstName, out userId)){
				//Get users roles
				string[] roles = credentialstore.GetRoles(userId);
				StringBuilder rolesString = new StringBuilder();
				foreach(string role in roles){
					rolesString.Append(role);
					rolesString.Append(@";");
					}

				//Build UserData String. Seperators "roles~15~OrgId~16~"
				string userData="";
				userData=rolesString.ToString()+"~15~"+orgId+"~16~";

				FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
					1,
					userId.ToString(),
					DateTime.Now,
					DateTime.Now.AddHours(3),
					false,
					userData
					);

				//Encrypt the ticket
				string encryptedTicket = FormsAuthentication.Encrypt(ticket);

				//Create a cookie
				HttpCookie authenticationCookie = new HttpCookie(FormsAuthentication.FormsCookieName,encryptedTicket);

				//write the cookie to the response
				Response.Cookies.Add(authenticationCookie);

				//redirect the user back to their original URL
				//Response.Redirect(FormsAuthentication.GetRedirectUrl(tbLoginEmail.Text,false));
				//FormsAuthentication.GetRedirectUrl(tbLoginEmail.Text,false);
				//FormsAuthentication.SetAuthCookie(tbLoginEmail.Text,false);
				Response.Redirect("home/default.aspx");
				}
			else{
				lbErr.Visible=true;
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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
