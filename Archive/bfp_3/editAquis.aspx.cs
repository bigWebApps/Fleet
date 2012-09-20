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
	/// <summary>
	/// Summary description for editAquis.
	/// </summary>
	public class _editAquis : BFPPage
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
	
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected BWA.BFP.Web.Controls.User.Header Header;
	
		public clsEquipment equip = null;
		protected System.Web.UI.WebControls.Label lblError;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvContact;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvAmount;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvUnits;
		public int EquipId;
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{

				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId=Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
			
				string [,] arrBrdCrumbs = new string [3,2];
				arrBrdCrumbs[0,0]="main.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="list.aspx";
				arrBrdCrumbs[1,1]="Equipment List";
				arrBrdCrumbs[2,0]="view.aspx?id="+EquipId+"";
				arrBrdCrumbs[2,1]="Equipment Detail";
				PageTitle = "Equipment-Edit Aquisition Info";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;
				SaveCancelControl.ParentPageURL=ParentPageURL;
				SourcePageName = "editAquis.aspx.cs";
				if(!IsPostBack)
				{
					equip = new clsEquipment();
					equip.cAction = "S";
					equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
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
						if(equip.iPurUnits.IsNull)
							tbUnits.Text="";
						else
							tbUnits.Text=equip.iPurUnits.Value.ToString();
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
				Session["lastpage"] = ParentPageURL;
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
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					EquipId=Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "list.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				equip = new clsEquipment();
				equip.cAction = "U";
				equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				equip.iId = EquipId;
				equip.daInService = adtInService.Date;
				equip.daAquired = adtAquired.Date;
				equip.curPurAmount = Convert.ToDecimal(tbAmount.Text);
				equip.sPurOrgContact = tbOrgContact.Text;
				equip.sPurNotes = tbNotes.Text;
				equip.iPurUnits = Convert.ToInt32(tbUnits.Text);
				if(equip.EquipmentDetail_Aquis() != -1)
				{
					Response.Redirect("view.aspx?id="+EquipId+"", false);
					return;
				}
				else
				{
					Session["lastpage"] = "editAquis.aspx?id=" + EquipId.ToString();
					Session["error"] = _functions.ErrorMessage(102);
					Response.Redirect("error.aspx", false);
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "editAquis.aspx?id=" + EquipId.ToString();
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "editAquis.aspx?id=" + EquipId.ToString();
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
