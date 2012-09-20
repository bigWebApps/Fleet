///Code to Implement
///
///protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
///
///[ADD to Page_Load]
///NextBackControl.ParentPageURL=ParentPageURL;
///
///private void InitializeComponent()
///{    
///		[Add line below]
///		this.NextBackControl.BubbleClick += new EventHandler(btNext_FormSubmit);
///}
///private void btNext_FormSubmit(object sender, EventArgs e)
///{
///}
namespace BWA.BFP.Web.Controls.User
{
	using System;
	using BWA.BFP.Data;
	using BWA.BFP.Core;

	public class NextBack : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Label lblBackButton;
		protected System.Web.UI.WebControls.Button btNext;
		public event EventHandler BubbleClick;

		private string m_sNextText;
		private string m_sBackPage;
		private string m_sBackText;
		private string m_sCSSClass;
		private bool m_bIsBack = true;
		private bool m_bNextEnabled = true;
					
		public string sCSSClass
		{
			get
			{
				return m_sCSSClass;
			}
			set
			{
				m_sCSSClass = value;
			}
		}
		public string BackPage
		{
			get
			{
				return m_sBackPage;
			}
			set
			{
				m_sBackPage = value;
			}
		}
		public string BackText
		{
			get
			{
				return m_sBackText;
			}
			set
			{
				m_sBackText = value;
			}
		}
		public bool BackVisible
		{
			get
			{
				return m_bIsBack;
			}
			set
			{
				m_bIsBack = value;
			}
		}
		public string NextText
		{
			get
			{
				return m_sNextText;
			}
			set
			{
				m_sNextText = value; 
			}
		}
		public bool NextEnabled
		{
			get
			{
				return m_bNextEnabled;
			}
			set
			{
				m_bNextEnabled = value;
			}
		}
		public bool CausesValidation
		{
			set
			{
				btNext.CausesValidation = value;
			}
		}
		public string NextClientId
		{
			get
			{
				return btNext.ClientID;
			}
		}
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			btNext.Enabled = m_bNextEnabled;
			if(m_sNextText != null)
				btNext.Text = m_sNextText;
			if(m_sCSSClass != null)
			{
				btNext.CssClass = m_sCSSClass;
				m_sCSSClass = "class=\""+ m_sCSSClass +"\" ";
			}
			else 
				m_sCSSClass = "";

			if(m_sBackText == null)
				m_sBackText = " << Back ";
			if(m_bIsBack)
				lblBackButton.Text = "<input type=\"button\" tabIndex=\"1\" " + m_sCSSClass + "value=\"" + m_sBackText + "\" onclick=\"document.location='" + m_sBackPage + "'\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}

		private void btNext_Click(object sender, System.EventArgs e)
		{
			OnBubbleClick(e);
		}

		protected void OnBubbleClick(EventArgs e)
		{
			if(BubbleClick != null)
			{
				BubbleClick(this, e);
			}
		}       

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
		}
		
		private void InitializeComponent()
		{
			this.btNext.Click += new System.EventHandler(this.btNext_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
