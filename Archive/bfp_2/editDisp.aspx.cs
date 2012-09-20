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

namespace BWA.BFP.Web.home.equip
{
	public class _editDisp : BFPPage
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
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected BWA.BFP.Web.Controls.User.Header Header;

		public clsEquipment equip = null;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvOrgContact;
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
				PageTitle = "Equipment-Edit Disposal Info";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;
				
				SaveCancelControl.ParentPageURL=ParentPageURL;

				if(!IsPostBack)
				{
					equip = new clsEquipment();
					equip.cAction = "S";
					equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					equip.iId = EquipId;
					
					ddMethod.DataTextField = "vchName";
					ddMethod.DataValueField = "Id";
					ddMethod.DataSource = new DataView(equip.GetEquipDispMethodsList());
					ddMethod.DataBind();
					// getting equipment's data
					if(equip.EquipmentDetail() != -1)
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
						if(equip.iDispUnits.IsNull)
							tbUnits.Text = "";
						else
							tbUnits.Text = equip.iDispUnits.Value.ToString();
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
				_functions.Log("Application error: \n" + ex.ToString());
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
				equip.cAction = "S";
				equip.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				equip.iId = EquipId;
				if(equip.EquipmentDetail() != -1)
				{
					equip.cAction = "U";
					equip.daDisposed = adtDisposed.Date;
					equip.daOutOfService = adtOutOfService.Date;
					equip.sDispOrgContact = tbOrgContact.Text;
					equip.curDispAmount = Convert.ToDecimal(tbAmount.Text);
					equip.iDispUnits = Convert.ToInt32(tbUnits.Text);
					equip.sDispNotes = tbNotes.Text;
					equip.iDispMethod = Convert.ToInt32(ddMethod.SelectedValue);
					switch(equip.EquipmentDetail())
					{
						case -1:
							Session["lastpage"] = "editDisp.aspx?id=" + EquipId.ToString();
							Session["error"] = _functions.ErrorMessage(107);
							Response.Redirect("error.aspx", false);
							return;
						case 1:
							Session["lastpage"] = "editDisp.aspx?id=" + EquipId.ToString();
							Session["error"] = _functions.ErrorMessage(109);
							Response.Redirect("error.aspx", false);
							return;
						default:
							Response.Redirect("view.aspx?id="+EquipId+"", false);
							return;
					}
				}
				else
				{
					Session["lastpage"] = "editDisp.aspx?id=" + EquipId.ToString();
					Session["error"] = _functions.ErrorMessage(108);
					Response.Redirect("error.aspx", false);
					return;
				}
			}
			catch(FormatException fex)
			{
				Session["lastpage"] = "editDisp.aspx?id=" + EquipId.ToString();
				Session["error"] = _functions.ErrorMessage(108);
				Response.Redirect("error.aspx", false);
			}	  
			catch(Exception ex)
			{
				_functions.Log("Application error: \n" + ex.ToString());
				Session["lastpage"] = "editDisp.aspx?id=" + EquipId.ToString();
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
