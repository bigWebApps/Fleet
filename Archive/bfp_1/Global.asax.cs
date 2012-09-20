using System;
using System.Web;
using System.Web.Security;
using System.Security.Principal;


namespace bfp 
{
	/// <summary>
	/// Summary description for Global.
	/// </summary>
	public class Global : System.Web.HttpApplication
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		public Global()
		{
			InitializeComponent();
		}	
		
		protected void Application_Start(Object sender, EventArgs e)
		{

		}
 
		protected void Session_Start(Object sender, EventArgs e)
		{

		}

		protected void Application_BeginRequest(Object sender, EventArgs e)
		{

		}

		protected void Application_EndRequest(Object sender, EventArgs e)
		{

		}

		protected void Application_AuthenticateRequest(Object sender, EventArgs e)
		{
			//Check to make sure the request has been authenticated
			if(Request.IsAuthenticated)
			{
				//Parse Roles from forms auth ticket
				string userData;
				int tempPosStart=0;
				string parsedRoles="";

				// Get Forms Identity From Current User	
				FormsIdentity id = (FormsIdentity)HttpContext.Current.User.Identity;
				// Get Forms Ticket From Identity object
				FormsAuthenticationTicket ticket = id.Ticket;
				//Retrive the User Data
				userData = ticket.UserData;

				//userData = ((FormsIdentity)Context.User.Identity).Ticket.UserData.ToString();
				//userData = ((FormsIdentity)Context.User.Identity).Ticket.UserData.ToString();
				//HttpContext.Current.User.Identity.Ticket.UserData.ToString();
				
				tempPosStart=userData.IndexOf("~15~");
				parsedRoles=userData.Substring(0,tempPosStart-1);
				
				string[] roles = parsedRoles.Split(';');

				//Create new Principal
				GenericPrincipal newPrincipal = new GenericPrincipal(Context.User.Identity, roles);

				Context.User = newPrincipal;
			}
		}

		protected void Application_Error(Object sender, EventArgs e)
		{

		}

		protected void Session_End(Object sender, EventArgs e)
		{

		}

		protected void Application_End(Object sender, EventArgs e)
		{

		}
			
		#region Web Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.components = new System.ComponentModel.Container();
		}
		#endregion
	}
}

