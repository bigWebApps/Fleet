namespace BWA.BFP.Web.Controls.User
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using System.Text;
	using BWA.BFP.Core;
	
	public abstract class Header : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Label HtmlHeadAttr;
		protected System.Web.UI.WebControls.Label HeaderLabel;
		protected System.Web.UI.WebControls.Label HtmlHeadJavaScript;
		protected System.Web.UI.WebControls.Label HtmlHeadMeta;
		
		string topMenuSelected="0";
		string subTopMenuSelected="0";
		string leftMenuSelected="0";
		string rightMenuSelected="0";
		string brdCrumbs;
		string pageTitle;
		string sOrgLogo;
		private bool m_bEnableJavaScript;
		private string m_sJavaScriptFileName;
		private string m_sOnLoadFunctionName;

		public string MetaTag
		{
			get
			{
				return HtmlHeadMeta.Text;
			}
			set
			{
				HtmlHeadMeta.Text = value;
			}
		}
		public bool EnableJavaScript
		{
			set
			{
				m_bEnableJavaScript = value;
			}
		}

		public string JavaScriptFileName
		{
			set
			{
				m_sJavaScriptFileName = value;
			}
		}
		public string OnLoadFunctionName
		{
			set
			{
				m_sOnLoadFunctionName = value;
			}
		}
		
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

		public void Render()
		{
			try
			{
				HtmlHeadAttr.Text="<link href='global.css' type=\"text/css\" rel=\"stylesheet\">";
				if(m_bEnableJavaScript)
				{
					HtmlHeadJavaScript.Text = "<script language=\"JavaScript\" type=\"text/javascript\" src=\"" + m_sJavaScriptFileName + "\"></script>";
				}

				if(Request.Cookies["bfp_logo"] != null)
					if(Request.Cookies["bfp_logo"].Value != null)
						sOrgLogo = "<img src=\"images/" + Request.Cookies["bfp_logo"].Value + "\"/>";
					else
						sOrgLogo = "";
				else
					sOrgLogo = "";

				//Determine RowSpan on the banner and top menus
				int colSpan=1;
				if(leftMenuSelected!="0"){colSpan=colSpan+1;}
				if(rightMenuSelected!="0"){colSpan=colSpan+1;}

				StringBuilder temp1 = new StringBuilder("",500);

				if(m_bEnableJavaScript)
				{
					if (m_sOnLoadFunctionName != null) 
					{
						temp1.Append("<body onload=\"" + m_sOnLoadFunctionName + "\">");
					}
					else 
					{
						temp1.Append("<body>");
					}
				}
				else
				{
					temp1.Append("<body>");
				}
			
			
				//Body
				temp1.Append("<table border=1 width=\"100%\" height=\"100%\">");
				//Banner
				temp1.Append("<tr><td colspan="+colSpan+" height=45px><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"left\">" + sOrgLogo + "</td><td align=\"right\"><img src=\"images/bigFleetPro.jpg\"/></td></tr></table></td></tr>");
				//TopMenu
				if(topMenuSelected!="0")
				{
					string sResultTopString;
					BFPPage tmpBFPPage = new BFPPage();
					sResultTopString = "<tr><td colspan="+colSpan+" height=20px><table width=\"100%\"><tr><td>TOP BAR ";
					if(Request.Cookies["bfp_mode"] == null)
					{
						if(tmpBFPPage.CheckPermission("admin.aspx"))
							sResultTopString += "| <a href=\"admin.aspx\">Administration</a> ";
						if(tmpBFPPage.CheckPermission("error_report.aspx"))
							sResultTopString += "| <a href=\"error_report.aspx\">Error Reports</a>";
						if(tmpBFPPage.CheckPermission("main.aspx"))
							sResultTopString += "| <a href=\"main.aspx\">Setup Technician Terminal</a>";
						if(tmpBFPPage.CheckPermission("ok_mainMenu.aspx"))
							sResultTopString += "| <a href=\"ok_mainMenu.aspx\">Setup Operator Kiosk Terminal</a>";
						sResultTopString += "</td><td align=\"right\"><a href=\"default.aspx\">Logoff</a>";
					}
					else
					{
						switch(Request.Cookies["bfp_mode"].Value)
						{
							case "TechnicianMode":
								if(tmpBFPPage.CheckPermission("selectMode.aspx"))
									sResultTopString += "| <a href=\"selectMode.aspx\">Deactivate Technician Terminal</a>";
								break;
							case "OperatorKiosk":
								if(tmpBFPPage.CheckPermission("selectMode.aspx"))
									sResultTopString += "| <a href=\"selectMode.aspx\">Deactivate Operator Kiosk Terminal</a>";
								break;
							default:
								break;
						}
					}

					sResultTopString += "</td></tr></table></td></tr><tr>";
					temp1.Append(sResultTopString);
				}
				//Left Menu Bar
				if(leftMenuSelected!="0")
				{
					temp1.Append("<td rowspan=2 valign=top>LeftBar<br>LeftBar<br>LeftBar<br>LeftBar<br>LeftBar<br>LeftBar<br>LeftBar<br>LeftBar<br></td>");
				}
				//Start Main Section
				temp1.Append("<td valign=top class=MainBody>");
				//Bread Crumbs
				if(brdCrumbs!=null)
				{
					temp1.Append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"><tr><td align=\"left\">" + brdCrumbs + "</td></tr></table><br>");
				}
				//Page Title
				if(pageTitle!=null){temp1.Append("<span class=text10>"+pageTitle+"</span><br><br>");};
			
				HeaderLabel.Text=temp1.ToString();
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally {}
		}
	

		private void Page_Load(object sender, System.EventArgs e)
		{
			Render();
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
