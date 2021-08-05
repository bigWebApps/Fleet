using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Collections;
using BWA.BFP.Data;
using BWA.BFP.Core;
using Micajah.Common;
using Micajah.Common.Menu;

namespace BWA.BFP.Web
{

	/// <summary>
	/// Summary description for BFPPage.
	/// </summary>
	public class BFPPage : MenuPageBase
	{
		protected int OrgId; //Read from authentication ticket.
		protected string Navigate;
		public string ParentPageTitle;
		public string SourcePageName;
		public int UId;
		//private ArrayList CurrBrdCrumbs;

		protected override void OnLoad(EventArgs e) 
		{
			try
			{
				base.OnLoad(e);
				//this.Page.Trace.Write("MITS_Trace","BFPPage_Load");

				Micajah.Common.Menu.Project.CompanyName="bigWebApps, Inc";
				Micajah.Common.Menu.Project.CopyrightStartYear="2000";
		
				//Header.AddStyleSheet("style.asp");
				Header.DiagnosticTableBoders = false;

				ProcessMenus();
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);				
			}
		}

		
		/// <summary>
		/// Function is returning an access for input page.
		/// </summary>
		/// <param name="pageName">Input page</param>
		/// <returns>The access for input page, false - not permission, true - yes</returns>
		public bool CheckPermission(string pageName)
		{
			bool bResult = false;
			DataView dvPages = null;
			clsUsers user = null;
			try
			{
				if((pageName.ToLower() != "default.aspx") && (pageName.ToLower() != "error.aspx") && (pageName.ToLower() != "accessdenied.aspx"))
				{
					dvPages = (DataView)Context.Cache["userPages"];
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
								bResult = true;
							}
						}
					}
					else
						if(Context.User.IsInRole("Administrators"))
							bResult = true;
				}
				else
				{
					bResult = true;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, "BFPPage.cs");
			}
			finally
			{
				if(user != null)
				{
					user.Dispose();
				}
			}
			return bResult;
		}

		
		/// <summary>
		/// The function is checking all links on input page, 
		/// if for current user the access to pages containing in links isn't permitted 
		/// then the function is hiding these links on page
		/// </summary>
		/// <param name="_page">Current Page object</param>
		protected void CheckLinks(System.Web.UI.Page _page)
		{
			System.Web.UI.WebControls.HyperLink hlItem;
			string pageName;
			DataView dvPages = null;
			clsUsers user = null;
			try
			{
				foreach(System.Web.UI.Control _MainControl in _page.Controls)
				{
					if(_MainControl.GetType().FullName == "System.Web.UI.HtmlControls.HtmlForm")
					{
						foreach(System.Web.UI.Control _control in _MainControl.Controls)
						{
							if(_control.GetType().FullName == "System.Web.UI.WebControls.HyperLink")
							{
								hlItem = (System.Web.UI.WebControls.HyperLink)_control;
								hlItem.Visible = false;
								pageName = _functions.GetFileNameFromURL(hlItem.NavigateUrl);
								if((pageName != "") && (pageName.ToLower() != "default.aspx") && (pageName.ToLower() != "error.aspx") && (pageName.ToLower() != "accessdenied.aspx"))
								{
									dvPages = (DataView)Context.Cache["userPages"];
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
												hlItem.Visible = true;
											}
										}
									}
									else
										if(Context.User.IsInRole("Administrators"))
											hlItem.Visible = true;
								}
								else
								{
									hlItem.Visible = true;
								}
							}
						}
						return;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, "BFPPage.cs");
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
		/// Adding Menu to Header
		/// </summary>
		protected override void ProcessMenus()
		{
			try
			{
				Footer.SoftwareLogo = "/images/BFS.gif";
				if(Request.Cookies["bfp_logo"] != null)
					if(Request.Cookies["bfp_logo"].Value != null)
						Header.ClientLogo = "/images/" + Request.Cookies["bfp_logo"].Value;
					else
						Header.ClientLogo = "";
				else
					Header.ClientLogo = "";

				Link.Help.Instance.Visible = false;
				Link.MyProfile.Instance.Visible = false;
				Link.Support.Instance.Visible = false;
				Link.LogOff.Instance.Visible = false;
				
				//Header.DisableGlobalNav = true;
				Header.ShowLeftBar=false;
				Header.ShowRightBar=false;
				Header.ShowSubMenuOnLeft = false;
				Header.ShowPageTitle = true;
				Footer.VisibleLinks = false;

				if(Request.IsAuthenticated && Header.MainMenuVisible)
				{
					bool IsMode = false;
					if(Request.Cookies["bfp_mode"] != null)
						if(Request.Cookies["bfp_mode"].Value != null)
							if(Request.Cookies["bfp_mode"].Value.Length > 0)
								IsMode = true;

					if(IsMode && 
						Header.MainMenuSelectedItem == "Home" && 
						(Request.Cookies["bfp_mode"].Value == "OperatorKiosk" || 
						Request.Cookies["bfp_mode"].Value == "TechnicianMode"))
						IsMode = false;
					if(IsMode)
					{
						if(Request.Cookies["bfp_mode"].Value == "TechnicianMode")
						{
							Link.LogOff.Instance.Visible = false;
//							Link.LogOff.Instance.AltText = "Deactivate Technician Terminal";
//							Link.LogOff.Instance.Name = "Deactivate Technician Terminal";
//							Link.LogOff.Instance.Path = "/selectMode.aspx";

							Header.MainMenuVisible = false;
							if(Header.MainMenuSelectedItem != "&nbsp;Home&nbsp;")
							{
								Header.ShowLeftBar = true;
								Header.ShowRightBar = true;
								Header.ShowSubMenuOnLeft = true;
								Micajah.Common.StandardColor myColor;
						
								myColor = new StandardColor(Micajah.Common.StandardColorScheme.White);
								Header.SubMenuBGColor = myColor;
								//Header.AddSubMenuItem("Home", "/main.aspx", true);
								Header.AddSubMenuItem("Work Orders", "", true);
								Header.AddSubMenuItem("Create New Work Order", "/wo_default.aspx?select=AddOrder");
								Header.AddSubMenuItem("Roadside Repair", "/wo_default.aspx?select=AddRoadside");
								Header.AddSubMenuItem("Create Future Inspections", "/wo_showEquipsForInspect.aspx");
								Header.AddSubMenuItem("Create Past Work Order", "/wo_default.aspx?select=AddPastOrder");
								Header.AddSubMenuItem("View Work Orders", "", false);
								Header.AddSubMenuItem("<nobr>Next 7 Days + Overdue</nobr>", "/wo_showOrdersForToday.aspx");
								Header.AddSubMenuItem("Daily", "/wo_showOrdersForDaily.aspx");
								Header.AddSubMenuItem("Weekly", "/wo_showOrdersForWeekly.aspx");
								Header.AddSubMenuItem("Monthly", "/wo_showOrdersForMonthly.aspx");
								Header.AddSubMenuItem("Service Completed", "/wo_showCompletedOrders.aspx");
								Header.AddSubMenuItem("Scheduled", "/wo_showUnassignedOrders.aspx");
								Header.AddSubMenuItemDivider();
								Header.AddSubMenuItem("Equipments", "", true);
								Header.AddSubMenuItem("View Equipment List", "/e_list.aspx");
								Header.AddSubMenuItem("Add New Equipment", "/e_addEquip.aspx");
								Header.AddSubMenuItem("Manage Reported Issues", "/wo_default.aspx?select=AddIssue");
								Header.AddSubMenuItem("Change Temporary Operator", "/wo_default.aspx?select=ChangeTempOper");
								Header.AddSubMenuItemDivider();
								Header.AddSubMenuItem("Reports", "", true);
								Header.AddSubMenuItem("Temporary Operator Assigment Report", "/e_viewTempOperatorReport.aspx");
								Header.AddSubMenuItem("Equipment Work Order Report", "/wo_viewEquipWorkOrderReport.aspx");
								Header.AddSubMenuItemDivider();
								Header.AddSubMenuItem("Training", "", true);
								Header.AddSubMenuItem("Adding PM and Inspections to a Work Order", "/t_OpenWorkOrder.htm");
								Header.AddSubMenuItemDivider();
								Header.AddSubMenuItem("Logoff", "", true);
								Header.AddSubMenuItem("Deactivate Technician Terminal", "/selectMode.aspx");
							}
						}
					}
					else
					{
						if(Header.MainMenuSelectedItem != "Deactivate Operator Kiosk Terminal")
						{
							Link.LogOff.Instance.Visible = true;
							Link.LogOff.Instance.AltText = "Logoff";
							Link.LogOff.Instance.Name = "Logoff";
							Link.LogOff.Instance.Path = "/default.aspx";
							
							if(CheckPermission("selectMode.aspx"))
								Header.AddMainMenuItem("Home","/selectMode.aspx");
							if(CheckPermission("admin.aspx"))
								Header.AddMainMenuItem("Administration","/admin.aspx");
//							if(CheckPermission("error_report.aspx"))
//								Header.AddMainMenuItem("Error Reports","/error_report.aspx");
//							if(CheckPermission("main.aspx"))
//								Header.AddMainMenuItem("Setup Technician Terminal","/main.aspx");
//							if(CheckPermission("ok_mainMenu.aspx"))
//								Header.AddMainMenuItem("Setup Operator Kiosk Terminal","/ok_mainMenu.aspx");
//							Header.AddMainMenuItem("Logoff","/default.aspx");

							switch(Header.MainMenuSelectedItem)
							{
								case "Home":
									break;
								case "Administration":
									Header.ShowLeftBar = true;
									Header.ShowRightBar = true;
									Header.ShowSubMenuOnLeft = true;
									Micajah.Common.StandardColor myColor;
						
									myColor = new StandardColor(Micajah.Common.StandardColorScheme.White);
									Header.SubMenuBGColor = myColor;

									Header.AddSubMenuItem("Inspections", "", true);
									if(CheckPermission("admin_inspections.aspx"))Header.AddSubMenuItem("Inspections Manager", "/admin_inspections.aspx");
									if(CheckPermission("admin_inspectschedules.aspx"))Header.AddSubMenuItem("Inspections Schedules Manager", "/admin_inspectschedules.aspx");
									Header.AddSubMenuItemDivider();
									Header.AddSubMenuItem("Preventive Maintenances", "", true);
									if(CheckPermission("admin_pmitems.aspx"))Header.AddSubMenuItem("PM Services Manager", "/admin_pmitems.aspx");
									if(CheckPermission("admin_pmschedules.aspx"))Header.AddSubMenuItem("PM Schedules Manager", "/admin_pmschedules.aspx");
									Header.AddSubMenuItemDivider();
									Header.AddSubMenuItem("Security", "", true);
									if(CheckPermission("admin_permissions.aspx"))Header.AddSubMenuItem("Permissions Manager", "/admin_permissions.aspx");
									if(CheckPermission("admin_groups.aspx"))Header.AddSubMenuItem("Groups Manager", "/admin_groups.aspx");
									if(CheckPermission("admin_users.aspx"))Header.AddSubMenuItem("Users Manager", "/admin_users.aspx");
									Header.AddSubMenuItemDivider();
									Header.AddSubMenuItem("Others", "", true);
									if(CheckPermission("admin_holidays.aspx"))Header.AddSubMenuItem("<nobr>Holidays Date Manager</nobr>", "/admin_holidays.aspx");
									if(CheckPermission("admin_kiosk_customtext.aspx"))Header.AddSubMenuItem("Kiosk Instruction Texts Manager", "/admin_kiosk_customtext.aspx");
									break;
								case "Error Reports":
									break;
								default:
									Link.LogOff.Instance.Visible = false;
									Header.ClientLogo = "";
									break;
							}
						}
					}
				}
				else
					Header.MainMenuVisible = false;
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}


	}
}



