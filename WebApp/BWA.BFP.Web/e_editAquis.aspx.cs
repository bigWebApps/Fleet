using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.SqlTypes;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web.equip
{
	public class _e_editAquis : BFPPage
	{
		protected ActiveUp.WebControls.ActiveDateTime adtInService;
		protected ActiveUp.WebControls.ActiveDateTime adtAquired;
		protected System.Web.UI.WebControls.TextBox tbOrgContact;
		protected System.Web.UI.WebControls.TextBox tbAmount;
		protected System.Web.UI.WebControls.RegularExpressionValidator valAmount;
		protected System.Web.UI.WebControls.TextBox tbUnits;
		protected System.Web.UI.WebControls.RangeValidator valRangeUnits;
		protected System.Web.UI.WebControls.RegularExpressionValidator valRegExpUnits;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected System.Web.UI.WebControls.Label lblError;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvContact;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvAmount;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvUnits;
		protected System.Web.UI.HtmlControls.HtmlAnchor A1;
		protected System.Web.UI.HtmlControls.HtmlAnchor A2;
		
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;

		public clsEquipment equip = null;
		public int EquipId;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "e_editAquis.aspx.cs";

				this.PageTitle  = "Edit Aquisition Info";
				Header.AddJavaScriptFile("/OpenWindows.js");
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "e_list.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "e_list.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
			
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddBreadCrumb("Equipment List", "/e_list.aspx");
				Header.AddBreadCrumb("Equipment Detail", "/e_view.aspx?id="+EquipId.ToString());
				Header.LeftBarHtml = "Edit Aquisition Information of Equipment";

				SaveCancelControl.ParentPageURL = this.ParentPageURL;

				if(!IsPostBack)
				{
					equip = new clsEquipment();
					equip.cAction = "S";
					equip.iOrgId = OrgId;
					equip.iId = EquipId;
					// getting equipment's data
					if(equip.EquipmentDetail_Aquis() != -1)
					{
						if(equip.daInService.IsNull)
							adtInService.Date = new DateTime(adtInService.MinYear, 1, 1);
						else
							adtInService.Date=equip.daInService.Value;
						if(equip.daAquired.IsNull)
							adtAquired.Date = new DateTime(adtAquired.MinYear, 1, 1);
						else
							adtAquired.Date=equip.daAquired.Value;
						if(equip.curPurAmount.IsNull)
							tbAmount.Text= "";
						else
							tbAmount.Text=String.Format("{0:0.00}", equip.curPurAmount.Value);
						if(equip.dmPurUnits.IsNull)
							tbUnits.Text="";
						else
							tbUnits.Text = Convert.ToDouble(equip.dmPurUnits.Value).ToString();
						if(equip.sPurOrgContact.IsNull)
							tbOrgContact.Text = "";
						else
							tbOrgContact.Text = equip.sPurOrgContact.Value;
						if(equip.sPurNotes.IsNull)
							tbNotes.Text = "";
						else
							tbNotes.Text = equip.sPurNotes.Value;
					}
					else
					{
						Session["lastpage"] = ParentPageURL;
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = this.ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		
		}

		#region Save Equipment Aquis
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				equip = new clsEquipment();
				equip.cAction = "U";
				equip.iOrgId = OrgId;
				equip.iId = EquipId;
				equip.daInService = adtInService.Date;
				equip.daAquired = adtAquired.Date;
				equip.curPurAmount = Convert.ToDecimal(tbAmount.Text);
				equip.sPurOrgContact = tbOrgContact.Text;
				equip.sPurNotes = tbNotes.Text;
				equip.dmPurUnits = Convert.ToDecimal(tbUnits.Text);
				if(equip.EquipmentDetail_Aquis() != -1)
				{
					Response.Redirect("e_view.aspx?id=" + EquipId.ToString(), false);
					return;
				}
				else
				{
					Session["lastpage"] = "e_editAquis.aspx?id=" + EquipId.ToString();
					Session["error"] = _functions.ErrorMessage(102);
					Response.Redirect("error.aspx", false);
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "e_editAquis.aspx?id=" + EquipId.ToString();
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_editAquis.aspx?id=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
				{
					equip.Dispose();
				}
			}
		}
		#endregion

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			SaveCancelControl.BubbleClick += new EventHandler(btSave_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
