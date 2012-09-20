using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using BWA.BFP.Data;
using BWA.BFP.Core;

namespace BWA.BFP.Web.workorder
{
	public class _wo_viewCheckIn : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Signature Signature;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Label lblWorkOrderId;
		protected System.Web.UI.WebControls.HyperLink hlSpareEquipId;
		protected System.Web.UI.WebControls.HyperLink hlChangeSpare;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.WebControls.RadioButtonList rblStaying;
		protected System.Web.UI.WebControls.TextBox tbDroppedOffBy;
		protected System.Web.UI.WebControls.TextBox tbMileage;
		protected System.Web.UI.WebControls.Label lblMeasure;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvMileage;
		protected System.Web.UI.WebControls.RangeValidator valRangeUnits;
		protected System.Web.UI.WebControls.RegularExpressionValidator revMiles;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected System.Web.UI.WebControls.HyperLink hlEquipId;

		private clsWorkOrders order = null;
		private clsEquipment equip = null;
		protected ActiveUp.WebControls.ActiveDateTime adtCheckIn;
		
		private int OrderId;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_viewCheckIn.aspx.cs";

				this.PageTitle = "Check-In Equipment";
				Header.LeftBarHtml = "Enter Information for Check-In operation and Sign It";
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
					Session["lastpage"] = "main.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "main.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				
				// getting the Bread Crumbs from Cookie and add last item
                if (Request.Cookies.Count > 0 && Request.Cookies["bfp_navigate"] != null)
                    Header.BrdCrumbsSerialization = Request.Cookies["bfp_navigate"].Value;
                Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString());

				SaveCancelControl.ParentPageURL = this.ParentPageURL;
				SaveCancelControl.IsCancel = true;
				SaveCancelControl.CausesValidation = true;
				SaveCancelControl.ButtonText = "  Check-In/Sign  ";
				
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;
					
					if(order.WorkOrderDetails() == -1)
					{
						Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}

					WorkOrderStatus status = (WorkOrderStatus)order.iStatusId.Value;
					WorkOrderOperatorStatus opstatus = order.iOperatorStatusId.IsNull?WorkOrderOperatorStatus.Null:(WorkOrderOperatorStatus)order.iOperatorStatusId.Value;

					if(status != WorkOrderStatus.Scheduled && opstatus != WorkOrderOperatorStatus.Null)
					{
						Signature.sError = _functions.ErrorMessage(136);
						tbDroppedOffBy.Enabled = false;
						tbMileage.Enabled = false;
						tbNotes.Enabled = false;
						rblStaying.Enabled = false;
						Signature.Enabled = false;
						SaveCancelControl.EnableSave = false;
					}
					lblWorkOrderId.Text = order.daCreated.Value.ToString("yyyy-MM-dd") + "-" + order.iWorkOrderNumber.Value.ToString();
					hlEquipId.Text = order.sEquipId.Value;
					hlEquipId.NavigateUrl = "e_view.aspx?id=" + order.iEquipId.Value.ToString();
					hlSpareEquipId.Text = order.sSpareEquipId.Value;
					hlChangeSpare.NavigateUrl = "wo_selectSpareEquip.aspx?id=" + OrderId.ToString() + "&back=checkin";
					if(order.iOperatorId.Value == 6)
						hlChangeSpare.Enabled = false;
					if(order.iSpareEquipId.Value > 0)
						hlSpareEquipId.NavigateUrl = "e_view.aspx?id=" + order.iSpareEquipId.Value.ToString();
					lblOperator.Text = order.sOperatorName.Value;
					if(order.bStaying.Value)
						rblStaying.SelectedValue = "True";
					else
						rblStaying.SelectedValue = "False";
					tbDroppedOffBy.Text = order.sDropedOffBy.Value;
					adtCheckIn.Date = DateTime.Now;
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iId = order.iEquipId;
					if(equip.GetEquipInfo() == -1)
					{
						Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(102);
						Response.Redirect("error.aspx", false);
						return;
					}
					tbMileage.Text = equip.dmCurrentUnits.Value.ToString("F");
					valRangeUnits.MinimumValue = equip.dmCurrentUnits.Value.ToString();
					valRangeUnits.ErrorMessage = "Value must be greater than was " + equip.dmCurrentUnits.Value.ToString("F") + "<br>";
					lblMeasure.Text = equip.sMeasure.Value;
											
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(order != null)
					order.Dispose();
				if(equip != null)
					equip.Dispose();
			}	
		}

		#region Check-In Equipment
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			DateTime daCurrentDate;
			try
			{
				daCurrentDate = DateTime.Now;
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				order.sInitials = Signature.sInitials;
				order.sPIN = Signature.sPIN;
				order.dmMileage = Convert.ToDecimal(tbMileage.Text);
				order.bStaying = Convert.ToBoolean(rblStaying.SelectedValue);
				order.sDropedOffBy = tbDroppedOffBy.Text;
				order.daCurrentDate = _functions.CorrectDate(adtCheckIn.Date);
				if(order.SigningEquipmentCheckIn() == -1)
				{
					Signature.sError = _functions.ErrorMessage(140);
				}
				else
				{
					order.cAction = "U";
					order.iNoteId = 0;
					order.iItemId = OrderId;
					order.daCreated = daCurrentDate;

					if(tbNotes.Text.Length > 0)
					{
						order.iNoteTypeId = (int)NoteTypes.OperatorNote;
						order.sNote = tbNotes.Text;
						order.NoteDetails();
					}

					// redirect to the finish screen
					BackFinishScreen finish = new BackFinishScreen();
						
					finish.sMainText = "The Equipment has been checked-in successfully!";

					finish.bMainMenuVisible = true;
					finish.sMainMenuText = "[Return to Main Menu]";
					finish.sMainMenuURL = "main.aspx";

					finish.bContinueVisible = true;
					finish.sContinueText = "[Continue to Open Work Order]";
					finish.sContinueURL = "wo_openWorkOrder.aspx?id=" + OrderId.ToString();

					finish.bViewVisible = true;
					finish.sViewText = "[Return to Work Order Detail]";
					finish.sViewURL = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
					
					finish.bAdditionalVisible = false;
					
					finish.bPrintVisible = false;

					Session["BackFinish"] = finish;

					Response.Redirect("wo_finish.aspx", false);
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_viewCheckIn.aspx?id=" + OrderId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(order != null)
					order.Dispose();
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
