using System;
using System.Web;
using System.Web.UI;
using System.Web.Security;

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
			UId=Convert.ToInt32(HttpContext.Current.User.Identity.Name);
			ParseUserData();
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
		protected void ParseUserData()
		{
			string userData="";
			userData = ((FormsIdentity)Context.User.Identity).Ticket.UserData.ToString();

			int tempPosStart=0;
			int tempPosStop=0;
			int tempLength=0;
			string parsedOrgId="";
			
			//Parse orgId
			tempPosStart=userData.IndexOf("~15~")+4; //Start past this delimeter
			tempPosStop=userData.IndexOf("~16~");
			tempLength=tempPosStop-tempPosStart;
			parsedOrgId=userData.Substring(tempPosStart,tempLength);
			OrgId=Convert.ToInt32(parsedOrgId);
		}
	}
}



