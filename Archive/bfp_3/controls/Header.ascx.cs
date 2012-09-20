namespace BWA.BFP.Web.Controls.User
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using System.Text;
	
	public abstract class Header : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Label HtmlHeadAttr;
		protected System.Web.UI.WebControls.Label HeaderLabel;
		string focusOnLoad=null;
		string topMenuSelected="0";
		string subTopMenuSelected="0";
		string leftMenuSelected="0";
		string rightMenuSelected="0";
		string brdCrumbs;
		string pageTitle;
		
		

		public string BrdCrumbs
		{
			set
			{
				brdCrumbs=value;
			}
		}
		
		public string PageTitle
		{
			set 
			{
				pageTitle = value;
			}
		}
		public string FocusOnLoad
		{
			set 
			{
				focusOnLoad = value;
			}
		}
		public string TopMenuSelected
		{
			set 
			{
				topMenuSelected = value;
			}
		}
		public string SubTopMenuSelected
		{
			set 
			{
				subTopMenuSelected = value;
			}
		}
		public string LeftMenuSelected
		{
			set 
			{
				leftMenuSelected = value;
			}
		}
		public string RightMenuSelected
		{
			set 
			{
				rightMenuSelected = value;
			}
		}


		private void Page_Load(object sender, System.EventArgs e)
		{
			HtmlHeadAttr.Text="<link href='global.css' type=\"text/css\" rel=\"stylesheet\">";

			//Determine RowSpan on the banner and top menus
			int colSpan=1;
			if(leftMenuSelected!="0"){colSpan=colSpan+1;}
			if(rightMenuSelected!="0"){colSpan=colSpan+1;}

			StringBuilder temp1 = new StringBuilder("",500);

			focusOnLoad = null;
			if (focusOnLoad!=null) 
			{
				temp1.Append("<body onload=\"document.forms[0].elements['" + focusOnLoad + "'].focus()\">");
			}
			else 
			{
				temp1.Append("<body>");
			}
			
			//Body
			temp1.Append("<table border=1 width=\"100%\" height=\"100%\">");
			//Banner
			temp1.Append("<tr><td colspan="+colSpan+" height=45px>Banner</td></tr>");
			//TopMenu
			if(topMenuSelected!="0")
			{
				temp1.Append("<tr><td colspan="+colSpan+" height=20px><table width=\"100%\"><tr><td>TOP BAR</td></tr></table></td></tr><tr>");
			}
			//Left Menu Bar
			if(leftMenuSelected!="0")
			{
				temp1.Append("<td rowspan=2 valign=top>LeftBar<br>LeftBar<br>LeftBar<br>LeftBar<br>LeftBar<br>LeftBar<br>LeftBar<br>LeftBar<br></td>");
			}
			//Start Main Section
			temp1.Append("<td valign=top class=MainBody>");
			//Bread Crumbs
			if(brdCrumbs!=null){
				temp1.Append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"><tr><td align=\"left\">" + brdCrumbs + "</td><td align=\"right\"><a href=\"default.aspx?logoff\">Logoff</a></td></tr></table><br>");
			}
			//Page Title
			if(pageTitle!=null){temp1.Append("<span class=text10>"+pageTitle+"</span><br><br>");};
			
			HeaderLabel.Text=temp1.ToString();
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
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
