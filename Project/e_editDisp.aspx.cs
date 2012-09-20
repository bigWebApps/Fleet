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
	public class _e_editDisp : BFPPage
	{
		protected ActiveUp.WebControls.ActiveDateTime adtOutOfService;
		protected ActiveUp.WebControls.ActiveDateTime adtDisposed;

		protected System.Web.UI.WebControls.TextBox tbOrgContact;
		protected System.Web.UI.WebControls.TextBox tbAmount;
		protected System.Web.UI.WebControls.RegularExpressionValidator valAmount;
		protected System.Web.UI.WebControls.TextBox tbUnits;
		protected System.Web.UI.WebControls.RangeValidator valRangeUnits;
		protected System.Web.UI.WebControls.RegularExpressionValidator valRegExpUnits;
		protected System.Web.UI.WebControls.DropDownList ddMethod;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvOrgContact;
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
				SourcePageName = "e_editDisp.aspx.cs";
				
				this.PageTitle  = "Edit Disposal Info";
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
				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "e_list.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
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
				Header.LeftBarHtml = "Edit Disposal Information of Equipment";

				
				SaveCancelControl.ParentPageURL = ParentPageURL;

				if(!IsPostBack)
				{
					equip = new clsEquipment();
					equip.cAction = "S";
					equip.iOrgId = OrgId;
					equip.iId = EquipId;
					
					ddMethod.DataTextField = "vchName";
					ddMethod.DataValueField = "Id";
					ddMethod.DataSource = new DataView(equip.GetEquipDispMethodsList());
					ddMethod.DataBind();
					// getting equipment's data
					if(equip.EquipmentDetail_Disp() != -1)
					{
						if(equip.daDisposed.IsNull)
							adtDisposed.Date = new DateTime(adtDisposed.MinYear, 1, 1);
						else
							adtDisposed.Date = equip.daDisposed.Value;
						if(equip.daOutOfService.IsNull)
							adtOutOfService.Date = new DateTime(adtOutOfService.MinYear, 1, 1);
						else
							adtOutOfService.Date = equip.daOutOfService.Value;
						if(equip.sDispOrgContact.IsNull)
							tbOrgContact.Text = "";
						else
							tbOrgContact.Text = equip.sDispOrgContact.Value;
						if(equip.curDispAmount.IsNull)
							tbAmount.Text = "";
						else
							tbAmount.Text = equip.curDispAmount.Value.ToString("0.00");
						if(equip.dmDispUnits.IsNull)
							tbUnits.Text = "";
						else
							tbUnits.Text = Convert.ToDouble(equip.dmDispUnits.Value).ToString();
						if(equip.sDispNotes.IsNull)
							tbNotes.Text = "";
						else
							tbNotes.Text = equip.sDispNotes.Value;
						if(equip.iDispMethod.IsNull)
							ddMethod.SelectedIndex = 0;
						else
							ddMethod.SelectedValue = equip.iDispMethod.Value.ToString();
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

		#region Save Equipment Disp
		/// <summary>
		/// Update the disposed data for current equipment
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				equip = new clsEquipment();
				equip.cAction = "S";
				equip.iOrgId = OrgId;
				equip.iId = EquipId;
				equip.cAction = "U";
				equip.daDisposed = adtDisposed.Date;
				equip.daOutOfService = adtOutOfService.Date;
				equip.sDispOrgContact = tbOrgContact.Text;
				equip.curDispAmount = Convert.ToDecimal(tbAmount.Text);
				equip.dmDispUnits = Convert.ToDecimal(tbUnits.Text);
				equip.sDispNotes = tbNotes.Text;
				equip.iDispMethod = Convert.ToInt32(ddMethod.SelectedValue);
				if(equip.EquipmentDetail_Disp() != -1)
				{
					Response.Redirect("e_view.aspx?id="+EquipId.ToString(), false);
				}
				else
				{
					Session["lastpage"] = "e_editDisp.aspx?id=" + EquipId.ToString();
					Session["error"] = _functions.ErrorMessage(107);
					Response.Redirect("error.aspx", false);
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "e_editDisp.aspx?id=" + EquipId.ToString();
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
			}	  
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "e_editDisp.aspx?id=" + EquipId.ToString();
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
			this.SaveCancelControl.BubbleClick += new EventHandler(this.btSave_FormSubmit);
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
