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
				// Is user authenticated?
				if(Request.IsAuthenticated)
				{
					string[] roles;
					// `if roles in cookies isn't existing then to create a new else getting roles from cookies
					if ((Request.Cookies["bfp_roles"] == null) || (Request.Cookies["bfp_roles"].Value == "")) 
					{
						// geting the user's groups for current user from database 
						user = new clsUsers();
						user.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
						user.iId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
						DataTable dtGroups = user.GetUserGroupsList();
						
						// creating the roles's string for user from groups list
						string roleStr = "";
						foreach (DataRow dr in dtGroups.Rows) 
						{
							roleStr += String.Format("{0};", dr["vchDesc"]);
						}
						roleStr = roleStr.Remove(roleStr.Length - 1, 1);

						// creating a ticket for user with his roles
						FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
							1,                              
							HttpContext.Current.User.Identity.Name,     
							DateTime.Now,                   
							DateTime.Now.AddYears(1),
							false,
							roleStr
							);
						// convert roles to string array
						roles = roleStr.Split(new Char[] {';'});

						// encrypting ticket for setting to cookie
						String cookieStr = FormsAuthentication.Encrypt(ticket);

						Response.Cookies["bfp_roles"].Value = cookieStr;
						Response.Cookies["bfp_roles"].Path = "/";
						Response.Cookies["bfp_roles"].Expires = DateTime.Now.AddYears(1);
					}
					else
					{	
						// getting and decrypt the ticket from cookies
						FormsAuthenticationTicket ticket = 
							FormsAuthentication.Decrypt(Context.Request.Cookies["bfp_roles"].Value);
						// getting and convert roles to string array
						ArrayList userRoles = new ArrayList();
						foreach (String role in ticket.UserData.Split( new char[] {';'} )) 
						{
							userRoles.Add(role);
						}
						roles = (String[]) userRoles.ToArray(typeof(String));
					}
					// set the roles to current user
					HttpContext.Current.User = new GenericPrincipal(Context.User.Identity, roles);
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, "Global.asax.cs");
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
			string sMode; 
			try
			{
				// Is user authenticated?
				if(Request.IsAuthenticated)
				{
					// getting the current page from the Request Object
					string pageName = Request.FilePath.Remove(0, Request.FilePath.LastIndexOf("/") + 1);
					// if page is avaible then skip it 
					if((pageName.ToLower() == "default.aspx") || 
                        (pageName == "error.aspx") || 
                        (pageName.ToLower() == "accessdenied.aspx"))
						return;

                    if (!pageName.Contains(".aspx"))
                        return;

					// getting a mode from cookies
					if(Request.Cookies["bfp_mode"] == null)
						sMode = "";
					else
						sMode = Request.Cookies["bfp_mode"].Value;

					switch(sMode)
					{
						case "OperatorKiosk":
							if(pageName.Substring(0, 3) == "ok_" || pageName == "ReportViewer.aspx" || pageName == "selectMode.aspx")
								break;
							else
							{
								Context.RewritePath("accessdenied.aspx");
								return;
							}
						case "TechnicianMode":
							if(pageName.Substring(0, 5) == "admin_" || pageName.Substring(0, 6) == "error_")
							{
								Context.RewritePath("accessdenied.aspx");
								return;
							}
							break;
						default:
							if(pageName == "ok_mainMenu.aspx")
								break;
							else if(pageName.Substring(0, 3) != "ok_")
								break;
							else
							{
								Context.RewritePath("accessdenied.aspx");
								return;
							}
					}

					if(Request.Cookies["bfp_operator"] == null)
					{
						if(pageName.Substring(0, 3) == "ok_" && pageName != "ok_mainMenu.aspx" && pageName != "ok_authCredentials.aspx")
						{
							Context.RewritePath("accessdenied.aspx");
							return;
						}
					}

					// getting the pages and groups for them from cache
					DataView dvPages = (DataView)Context.Cache["userPages"];
					// if pages isn't existing then we create a new
					if(dvPages == null)
					{
						// getting the pages from database
						user = new clsUsers();
						user.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
						dvPages = new DataView(user.GetPagesList());
						// insert pages to cache
						Context.Cache.Insert("userPages", dvPages, null, DateTime.Now.AddHours(12), TimeSpan.Zero);
					}
					// filter pages for current page
					dvPages.RowFilter = "vchPageName = '" + pageName + "'";
					// if the page is there in pages list 
					if(dvPages.Count > 0)
					{
						// to see roles for current groups of this page
						foreach(string role in dvPages[0]["vchGroupList"].ToString().Split(new char[] {';'}))
						{
							// if the current user have current role then we give an access for current page
							if(Context.User.IsInRole(role))
							{
								return;
							}
						}
					}
					else // if current user is administrator then we give all access for every page
						if(Context.User.IsInRole("Administrators"))
							return;

					// if we come here then current user hasn't access to current page 
					Context.RewritePath("accessdenied.aspx");
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, "Global.asax.cs");
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
			// cleaning the user's cache fully
			Response.Cache.SetExpires(DateTime.Now.AddYears(-1));
			Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
			Response.Cache.SetNoStore();
			Response.Cache.SetNoServerCaching();
			Response.Cache.SetCacheability(HttpCacheability.NoCache);
		}

	}
}

