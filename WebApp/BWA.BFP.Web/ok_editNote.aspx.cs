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
	public class _ok_editNote : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblFirstName;
		protected System.Web.UI.WebControls.Button btnNO;
		protected System.Web.UI.WebControls.Button btnYES;
		protected System.Web.UI.WebControls.Button btnBack;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvNotes;
		protected System.Web.UI.WebControls.Button btnSaveNote;
		protected System.Web.UI.WebControls.Panel pnlEnterNote;
		protected System.Web.UI.WebControls.Panel pnlViewQuestion;
		protected System.Web.UI.WebControls.Button btnBack1;
		
		private clsWorkOrders order = null;
		private OperatorInfo op = null;

		private int OrderId;
		private int EquipId;

		private string Operation;
		private string BackPage;
		private string CurrentPage;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_editNote.aspx.cs";

				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("/Focus.js");
				Header.BodyOnloadScript = "javascript:GetFocus('" + btnYES.ClientID + "');GetFocus('" + tbNotes.ClientID + "');";
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
				if((Request.QueryString["equipid"] == null) && (Request.QueryString["orderid"] == null))
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["orderid"]);
					EquipId = Convert.ToInt32(Request.QueryString["equipid"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "ok_mainMenu.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				if(Request.QueryString["op"] == null)
				{
					Operation = "CheckIn";
					BackPage = "ok_editStaying.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					CurrentPage = "ok_editNote.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					
				}
				else
				{
					Operation = "AddCommentReOpen";
					BackPage = "ok_reopenWorkOrder.aspx?id=" + OrderId.ToString();
					CurrentPage = "ok_editNote.aspx?op=AddCommentReOpen&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
				}
				op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);

				if(!IsPostBack)
				{
					if(Operation == "AddCommentReOpen")
					{
						pnlEnterNote.Visible = true;
						pnlViewQuestion.Visible = false;
						tbNotes.Text = "";
					}
					else
					{
						pnlViewQuestion.Visible = true;
						pnlEnterNote.Visible = false;
						lblFirstName.Text = op.FirstName;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = BackPage;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
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
			this.btnYES.Click += new System.EventHandler(this.btnYES_Click);
			this.btnNO.Click += new System.EventHandler(this.btnNO_Click);
			this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
			this.btnSaveNote.Click += new System.EventHandler(this.btnSaveNote_Click);
			this.btnBack1.Click += new System.EventHandler(this.btnBack1_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnNO_Click(object sender, System.EventArgs e)
		{
			try
			{
				// check-in the current equipment into curreòå work order 
				// next screen
				if(Operation == "CheckIn")
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					order.daCurrentDate = DateTime.Now;
					order.iUserId = op.Id;
					if(order.UpdateCheckInWorkOrder() == -1)
					{
						Session["lastpage"] = CurrentPage;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}
					else
						Response.Redirect("ok_viewCheckIn.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
				}
				else
					Response.Redirect(BackPage, false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = CurrentPage;
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

		private void btnBack_Click(object sender, System.EventArgs e)
		{
			Response.Redirect(BackPage, false);
		}

		private void btnYES_Click(object sender, System.EventArgs e)
		{
			try
			{
				pnlEnterNote.Visible = true;
				pnlViewQuestion.Visible = false;
				tbNotes.Text = "";
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = CurrentPage;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}		
		}

		private void btnSaveNote_Click(object sender, System.EventArgs e)
		{
			DateTime daCurrentDate;
			try
			{
				daCurrentDate = DateTime.Now;
				order = new clsWorkOrders();
				order.cAction = "U";
				order.iOrgId = OrgId;
				order.iNoteId = 0;
				order.iNoteTypeId = (int)NoteTypes.OperatorNote;
				order.iItemId = OrderId;
				order.iUserId = op.Id;
				order.daCreated = daCurrentDate;
				order.sNote = tbNotes.Text;
				order.NoteDetails();
				
				if(Operation == "CheckIn")
				{
					order.iId = OrderId;
					order.daCurrentDate = daCurrentDate;
					order.iUserId = op.Id;
					if(order.UpdateCheckInWorkOrder() == -1)
					{
						Session["lastpage"] = CurrentPage;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
						return;
					}
					else
						Response.Redirect("ok_viewCheckIn.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
				}
				else
				{
					if(Operation == "AddCommentReOpen")
						Response.Redirect(BackPage + "&op=AddCommentReOpen", false);
					else
						Response.Redirect(BackPage, false);
				}

				
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = CurrentPage;
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

		private void btnBack1_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(Operation == "AddCommentReOpen")
					Response.Redirect(BackPage + "&op=AddCommentReOpen", false);
				else
				{
					pnlViewQuestion.Visible = true;
					pnlEnterNote.Visible = false;
					lblFirstName.Text = op.FirstName;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = CurrentPage;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}
	}
}
