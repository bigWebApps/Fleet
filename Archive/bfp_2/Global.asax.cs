using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;
using System.Web.Security;
using System.Data;
using System.Security;
using System.Security.Principal;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web
{
	public class Global : System.Web.HttpApplication
	{
		private clsUsers user = null;

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
			try
			{
				if(Request.IsAuthenticated)
				{
					string[] roles;
					if ((Request.Cookies["bfp_roles"] == null) || (Request.Cookies["bfp_roles"].Value == "")) 
					{
						user = new clsUsers();
						user.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
						user.iId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
						DataTable dtGroups = user.GetUserGroupsList();
						string roleStr = "";
						foreach (DataRow dr in dtGroups.Rows) 
						{
							roleStr += String.Format("{0};", dr["vchDesc"]);
						}
						roleStr = roleStr.Remove(roleStr.Length - 1, 1);

						FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
							1,                              
							HttpContext.Current.User.Identity.Name,     
							DateTime.Now,                   
							DateTime.Now.AddHours(1),       
							false,                          
							roleStr                         
							);
						roles = roleStr.Split(new Char[] {';'});

						String cookieStr = FormsAuthentication.Encrypt(ticket);

						Response.Cookies["bfp_roles"].Value = cookieStr;
						Response.Cookies["bfp_roles"].Path = "/";
						Response.Cookies["bfp_roles"].Expires = DateTime.Now.AddHours(1);
					}
					else
					{
						FormsAuthenticationTicket ticket = 
							FormsAuthentication.Decrypt(Context.Request.Cookies["bfp_roles"].Value);
						ArrayList userRoles = new ArrayList();
						foreach (String role in ticket.UserData.Split( new char[] {';'} )) 
						{
							userRoles.Add(role);
						}
						roles = (String[]) userRoles.ToArray(typeof(String));
					}
					HttpContext.Current.User = new GenericPrincipal(Context.User.Identity, roles);
				}
			}
			catch(Exception ex)
			{
				_functions.Log("Application error: \n" + ex.ToString());
			}
			finally
			{
				if(user != null)
				{
					user.Dispose();
				}
			}

		}

		private void Global_AuthorizeRequest(object sender, System.EventArgs e)
		{
			try
			{
				if(Request.IsAuthenticated)
				{
					string pageName = Request.FilePath.Remove(0, Request.FilePath.LastIndexOf("/") + 1);
					if((pageName == "default.aspx") || (pageName == "error.aspx") || (pageName.ToLower() == "accessdenied.aspx"))
						return;
					DataView dvPages = (DataView)Context.Cache["userPages"];
					if(dvPages == null)
					{
						user = new clsUsers();
						user.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
						dvPages = new DataView(user.GetPagesList());
						Context.Cache.Insert("userPages", dvPages, null, DateTime.Now.AddHours(12), TimeSpan.Zero);
					}
					dvPages.RowFilter = "vchPageName = '" + pageName + "'";
					if(dvPages.Count > 0)
					{
						foreach(string role in dvPages[0]["vchGroupList"].ToString().Split(new char[] {';'}))
						{
							if(Context.User.IsInRole(role))
							{
								return;
							}
						}
					}
					else
						if(Context.User.IsInRole("Administrators"))
							return;

					Context.RewritePath("accessdenied.aspx");
				}
			}
			catch(Exception ex)
			{
				_functions.Log("Application error: \n" + ex.ToString());
			}
			finally
			{
				if(user != null)
				{
					user.Dispose();
				}
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
		private void InitializeComponent()
		{    
			this.BeginRequest += new System.EventHandler(this.Global_BeginRequest);
			this.AuthorizeRequest += new System.EventHandler(this.Global_AuthorizeRequest);
			this.AuthenticateRequest += new System.EventHandler(this.Application_AuthenticateRequest);

		}
		#endregion

		private void Global_BeginRequest(object sender, System.EventArgs e)
		{
			Response.Cache.SetExpires(DateTime.Now.AddYears(-1));
			Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
			Response.Cache.SetNoStore();
			Response.Cache.SetNoServerCaching();
			Response.Cache.SetCacheability(HttpCacheability.NoCache);
		}

	}
}

