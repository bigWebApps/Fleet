using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web
{
	/// <summary>
	/// Summary description for BFPPage.
	/// </summary>
	public class BFPPage : System.Web.UI.Page
	{
		protected int OrgId; //Read from authentication ticket.
		public string ParentPageURL;
		public string ParentPageTitle;
		public string PageTitle;
		public int UId;
		public BFPPage()
		{
			
		}
		protected override void OnInit(EventArgs e) 
		{
			base.OnInit(e);
			this.Load += new System.EventHandler(this.BFPPage_Load);
			//Trace.IsEnabled=true;
		}
		private void BFPPage_Load(object sender, System.EventArgs e)
		{
			//TODO: Place any code that will take place before the Page_Load even in the regular page
			//UId=Convert.ToInt32(HttpContext.Current.User.Identity.Name);
			//ParseUserData();
		}
		protected string ParseBreadCrumbs(string [,] fxarrBrdCrumbs, string fxPageTitle)
		{
			string fxStrTemp = "";
			int i = 0;
			if(fxarrBrdCrumbs!=null)
			{
				for(i=0; i<fxarrBrdCrumbs.GetLength(0);i++)
				{
					fxStrTemp+="<a href='"+fxarrBrdCrumbs[i,0]+"'>"+fxarrBrdCrumbs[i,1]+"</a> \\ ";
					if(i==fxarrBrdCrumbs.GetLength(0)-1)
					{
						ParentPageURL=fxarrBrdCrumbs[i,0];
						ParentPageTitle=fxarrBrdCrumbs[i,1];	
					}
				}
				fxStrTemp+=fxPageTitle;
			}
			return fxStrTemp;
		}
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
	}
}



