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
	public class SaveCancel : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Button btSave;
		protected System.Web.UI.WebControls.Label lbCancelButton;
		public event EventHandler BubbleClick;

		private string parentPageURL;
		
		public string ParentPageURL
		{
			set
			{
				parentPageURL=value;
			}
		}
		private void Page_Load(object sender, System.EventArgs e)
		{
			///Used to retreive directly from parent page. Keep around in case need in the future.
			//BFPPage bp = (BFPPage)this.Page;
			//lbCancelButton.Text = "<input type=button value=\" Cancel \" onclick=\"document.location='"+bp.ParentPageURL+"'\">";
			///Used the ParentPageURL Public Property
			lbCancelButton.Text = "<input type=button value=\" Cancel \" onclick=\"document.location='"+parentPageURL+"'\">";
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
