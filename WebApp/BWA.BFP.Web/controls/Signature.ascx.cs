namespace BWA.BFP.Web.Controls.User
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using BWA.BFP.Data;
	using BWA.BFP.Core;

	public class Signature : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.TextBox tbPIN;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvPIN;
		protected System.Web.UI.WebControls.RegularExpressionValidator revPIN;
		protected System.Web.UI.WebControls.TextBox tbInitial;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvInitials;
		protected System.Web.UI.WebControls.RegularExpressionValidator revInitials;
		protected System.Web.UI.WebControls.Label lblError;
		protected System.Web.UI.HtmlControls.HtmlTable htmlTabel;

		private string m_sInitials;
		private string m_sPIN;
		private string m_sError;

		public string sInitials
		{
			get
			{
				return tbInitial.Text;
			}
			set
			{
				tbInitial.Text = value;
			}
		}
		public string sPIN
		{
			get
			{
				return tbPIN.Text;
			}
			set
			{
				tbPIN.Text = value;
			}
		}
		public string sError
		{
			get
			{
				return lblError.Text;
			}
			set
			{
				lblError.Text = value;
			}
		}
		public bool Enabled
		{
			get
			{
				return tbInitial.Enabled;
			}
			set
			{
				tbInitial.Enabled = value;
				tbPIN.Enabled = value;
			}
		}
		

		private void Page_Load(object sender, System.EventArgs e)
		{
		
		}

		
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
		}
		
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
