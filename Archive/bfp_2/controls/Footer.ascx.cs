namespace BWA.BFP.Web.Controls.User
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using System.Text;

	/// <summary>
	///		Summary description for Footer.
	/// </summary>
	/// BWA.BFP.Web.BFPPage
	public abstract class Footer : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Label FooterLabel;

		string rightMenuSelected="0";

		public string RightMenuSelected
		{
			set 
			{
				rightMenuSelected = value;
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			StringBuilder temp1 = new StringBuilder("",500);
			
			//End Main Body
			temp1.Append("</td>");
			//Right Bar
			if(rightMenuSelected!="0"){temp1.Append("<td rowspan=2 valign=top>Right Bar</td></tr>");}
			//Footer
			temp1.Append("<tr><td align=center height=10px>Copyright &copy; 2003-2004 bigWebApps, Inc. All rights reserved.</td></tr></table></body></html>");

			FooterLabel.Text=temp1.ToString();



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
