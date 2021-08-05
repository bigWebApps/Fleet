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

namespace BWA.BFP.Web.operatorkiosk
{
	public class _ok_viewNotes : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.WebControls.Repeater repTechNotes;
	
		private clsWorkOrders order = null;
		private int OrderId;
		private OperatorInfo op;
		private string m_sBack;
		private DataTable dtNotes;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_viewNotes.aspx.cs";

				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + NextBackControl.NextClientId + "');";
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
					Session["lastpage"] = "ok_selectWorkOrder.aspx";
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
					Session["lastpage"] = "ok_selectWorkOrder.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				if(Request.UrlReferrer != null)
				{
					m_sBack = Request.UrlReferrer.AbsoluteUri;
					m_sBack = m_sBack.Remove(0, m_sBack.LastIndexOf("/") + 1);
				}
				else
					m_sBack = "ok_updateSpare.aspx?id=" + OrderId.ToString();

				NextBackControl.BackText = "<< Back";
				NextBackControl.BackPage = m_sBack;
				NextBackControl.NextText = "Continue >>";
				NextBackControl.sCSSClass = "ok_input_button";

				op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);

				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iItemId = OrderId;
					order.iNoteTypeId = (int)NoteTypes.CheckOutNote;
					dtNotes = order.GetNotesList();
					if(dtNotes.Rows.Count > 0)
					{
						repTechNotes.DataSource = new DataView(dtNotes);
						repTechNotes.DataBind();
					}
					else
					{
						order.iId = OrderId;
						CheckOutEquipment();
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sBack;
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

		private void CheckOutEquipment()
		{
			try
			{
				order.daCurrentDate = DateTime.Now;
				order.iUserId = op.Id;
				if(order.UpdateCheckOutWorkOrder() == -1)
				{
					Session["lastpage"] = "ok_viewNotes.aspx?id=" + OrderId.ToString();
					Session["error"] = _functions.ErrorMessage(120);
					Response.Redirect("error.aspx", false);
					return;
				}
				else
					Response.Redirect("ok_viewCheckOut.aspx?id=" + OrderId.ToString(), false);
				
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}

		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				order.iId = OrderId;
				CheckOutEquipment();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "ok_viewNotes.aspx?id=" + OrderId.ToString();
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

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			this.NextBackControl.BubbleClick += new EventHandler(this.btNext_FormSubmit);
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
