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
	public class _wo_viewCheckOut : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Signature Signature;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.Label lblWorkOrderId;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.WebControls.Label lblSpareEquipId;
		protected System.Web.UI.WebControls.Label lblTech;
		protected System.Web.UI.WebControls.Label lblOperator;
		protected System.Web.UI.WebControls.Label lblDroppedOffBy;
		protected System.Web.UI.WebControls.TextBox tbReleasedTo;
		protected System.Web.UI.WebControls.Label lblCleanliness;
		protected System.Web.UI.WebControls.Label lblScheduledDate;
		protected System.Web.UI.WebControls.Repeater repCheckOutNotes;
		protected System.Web.UI.HtmlControls.HtmlTable tableMain;
		
		private int OrderId;

		private clsWorkOrders order = null;
		protected ActiveUp.WebControls.ActiveDateTime adtCheckOut;
		private clsEquipment equip = null;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_viewCheckOut.aspx.cs";

				this.PageTitle = "Check-Out Equipment";
				Header.LeftBarHtml = "Sign the Check-Out Operation";
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

				SaveCancelControl.ParentPageURL = ParentPageURL;
				SaveCancelControl.IsCancel = true;
				SaveCancelControl.CausesValidation = true;
				SaveCancelControl.ButtonText = "  Check-Out/Sign  ";
				
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = OrgId;
					order.iId = OrderId;

					if(order.WorkOrderDetails() == -1)
					{
						Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}
					
					if(order.iStatusId.Value != (int)WorkOrderStatus.Closed)
					{
						Signature.sError = _functions.ErrorMessage(138);
						Signature.Enabled = false;
						tbReleasedTo.Enabled = false;
						SaveCancelControl.EnableSave = false;
					}
					lblWorkOrderId.Text = order.daCreated.Value.ToString("yyyy-MM-dd") + "-" + order.iWorkOrderNumber.Value.ToString();
					lblEquipId.Text = order.sEquipId.Value;
					lblSpareEquipId.Text = order.sSpareEquipId.Value;
					lblTech.Text = order.sTechName.Value;
					lblOperator.Text = order.sOperatorName.Value;
					lblDroppedOffBy.Text = order.sDropedOffBy.Value;
					tbReleasedTo.Text = order.sReleasedTo.Value;
					lblCleanliness.Text = order.sCleanliness.Value;
					lblScheduledDate.Text = order.daScheduled.IsNull?"":order.daScheduled.Value.ToLongDateString();
					if(order.daDeparture.IsNull)
						adtCheckOut.Date = DateTime.Now;
					else
						adtCheckOut.Date = order.daDeparture.Value;
					
					order.iItemId = OrderId;
					order.iNoteTypeId = (int)NoteTypes.CheckOutNote;
					
					repCheckOutNotes.DataSource = new DataView(order.GetNotesList());
					repCheckOutNotes.DataBind();
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
			}	

		}

		#region Close Work Order
		/// <summary>
		/// Procedure close the work order detail
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
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
				order.sReleasedTo = tbReleasedTo.Text;
				order.daCurrentDate = _functions.CorrectDate(adtCheckOut.Date);
				// signing the Check-Out of Equipment by Technician
				if(order.SigningEquipmentCheckOut() == -1)
				{
					Signature.sError = _functions.ErrorMessage(140);
				}
				else
				{	
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iUserId = order.iUserId;
					equip.iOrderId = OrderId;
					equip.iId = System.Data.SqlTypes.SqlInt32.Null;
					equip.sNote = "";
					equip.EquipSpareTo(false);

					// redirect to the finish screen
					BackFinishScreen finish = new BackFinishScreen();
						
					finish.sMainText = "The Equipment has been checked-out successfully!";

					finish.bMainMenuVisible = true;
					finish.sMainMenuText = "[Return to Main Menu]";
					finish.sMainMenuURL = "main.aspx";

					finish.bContinueVisible = false;
					
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
				Session["lastpage"] = "wo_viewCheckOut.aspx?id=" + OrderId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
					equip.Dispose();
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
