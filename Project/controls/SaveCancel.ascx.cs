///Code to Implement
///
///protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
///
///[ADD to Page_Load]
///SaveCancelControl.ParentPageURL=ParentPageURL;
///
///private void InitializeComponent()
///{    
///		[Add line below]
///		SaveCancelControl.BubbleClick += new EventHandler(btSave_FormSubmit);
///}
///private void btSave_FormSubmit(object sender, EventArgs e)
///{
///}
namespace BWA.BFP.Web.Controls.User
{
	using System;
	using BWA.BFP.Data;
	using BWA.BFP.Core;

	public class SaveCancel : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Button btSave;
		protected System.Web.UI.WebControls.Label lbCancelButton;
		protected System.Web.UI.HtmlControls.HtmlGenericControl Validator;
		public event EventHandler BubbleClick;

		private string m_parentPageURL;
		private string m_sButtonText;
		private string m_sCancelText;
		private bool m_bIsCancel = true;
		private bool m_bEnableSave = true;
		
		public string SaveOnClick
		{
			set
			{
				if(value.Length > 0)
					Validator.Attributes.Add("onclick", value);
				else
					Validator.Attributes.Remove("onclick");
			}
		}
		public string ParentPageURL
		{
			set
			{
				m_parentPageURL = value;
			}
		}
		public string ButtonText
		{
			set
			{
				m_sButtonText = value; 
			}
		}
		public bool CausesValidation
		{
			set
			{
				btSave.CausesValidation = value;
			}
		}
		public bool IsCancel
		{
			set
			{
				m_bIsCancel = value;
			}
		}
		public bool EnableSave
		{
			set
			{
				m_bEnableSave = value;
			}
		}
		public string CancelText
		{
			set
			{
				m_sCancelText = value;
			}
		}
		public string SaveClientId
		{
			get
			{
				return btSave.ClientID;
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			///Used to retreive directly from parent page. Keep around in case need in the future.
			//BFPPage bp = (BFPPage)this.Page;
			//lbCancelButton.Text = "<input type=button value=\" Cancel \" onclick=\"document.location='"+bp.ParentPageURL+"'\">";
			///Used the ParentPageURL Public Property
			if(m_sButtonText != null)
				btSave.Text = m_sButtonText;
			if(m_sCancelText == null)
				m_sCancelText = "Cancel";
			if(m_bIsCancel)
				lbCancelButton.Text = "<input type=button value=\" " + m_sCancelText + " \" onclick=\"document.location='" + m_parentPageURL + "'\">";
			btSave.Enabled = m_bEnableSave;
		}
		private void btSave_OnClick(object sender, System.EventArgs e)
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
			this.btSave.Click += new System.EventHandler(this.btSave_OnClick);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
