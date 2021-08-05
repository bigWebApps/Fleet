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

namespace BWA.BFP.Web.operatorkiosk
{
	public class _ok_addIssues : BFPPage
	{
		protected System.Web.UI.WebControls.Repeater repIssues;
		protected System.Web.UI.WebControls.Label lblFirstName;
		protected System.Web.UI.WebControls.Button btnNO;
		protected System.Web.UI.WebControls.Button btnYES;
		protected System.Web.UI.WebControls.Panel pnlViewIssues;
		protected System.Web.UI.WebControls.Panel pnlSelectCategory;
		protected System.Web.UI.WebControls.Panel pnlEnterIssue;
		protected System.Web.UI.WebControls.Button btnBack;
		protected System.Web.UI.WebControls.DataList repCategories;
		protected System.Web.UI.WebControls.LinkButton lbSelectCategory;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected System.Web.UI.WebControls.Button btnSaveNote;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvNotes;
		protected System.Web.UI.WebControls.Button btnBack1;
		protected System.Web.UI.WebControls.Button btnBack2;
		protected System.Web.UI.WebControls.Label lblEquipType;
		protected System.Web.UI.WebControls.Label lblEquipId;
		protected System.Web.UI.HtmlControls.HtmlTable html_tblNoneIssues;
		
		private clsWorkOrders order = null;
		private OperatorInfo op = null;

		private int OrderId;
		private int EquipId;

		private string Operation;
		private string BackPage;
		private string CurrentPage;

		private DataTable dtIssues = null;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "ok_addIssues.aspx.cs";

				Header.MainMenuVisible = false;
				Header.AddJavaScriptFile("Focus.js");
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
					BackPage = "ok_editCurrentUnits.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					CurrentPage = "ok_addIssues.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					
				}
				else
				{
					if(Request.QueryString["op"] == "AddIssue")
					{
						Operation = "AddIssue";
						BackPage = "ok_mainMenu.aspx";
						CurrentPage = "ok_addIssues.aspx?op=AddIssue&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					}
					else if(Request.QueryString["op"] == "AddIssueReOpen")
					{
						Operation = "AddIssueReOpen";
						BackPage = "ok_reopenWorkOrder.aspx?id=" + OrderId.ToString();
						CurrentPage = "ok_addIssues.aspx?op=AddIssueReOpen&orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					}
				}
				
				op = new OperatorInfo(Request.Cookies["bfp_operator"].Value);

				if(!IsPostBack)
				{
					
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					
					if(Operation == "AddIssueReOpen")
					{
						pnlSelectCategory.Visible = true;
						pnlEnterIssue.Visible = false;
						pnlViewIssues.Visible = false;
						repCategories.DataSource = new DataView(order.GetCategoryList());
						repCategories.DataBind();
					}
					else
					{
						pnlViewIssues.Visible = true;
						pnlEnterIssue.Visible = false;
						pnlSelectCategory.Visible = false;
						lblFirstName.Text = op.FirstName;

						if(order.GetEquipInfo() != -1)
						{
							lblEquipId.Text = order.sEquipId.Value;
							lblEquipType.Text = order.sEquipTypeName.Value;
						}
						else
						{
							Session["lastpage"] = BackPage;
							Session["error"] = _functions.ErrorMessage(102);
							Response.Redirect("error.aspx", false);
							return;
						}
					
						dtIssues = order.GetReportedIssueListsOperatorKiosk();
						if(dtIssues.Rows.Count > 0)
						{
							html_tblNoneIssues.Visible = false;
							repIssues.DataSource = new DataView(dtIssues);
							repIssues.DataBind();
						}
						else
							html_tblNoneIssues.Visible = true;
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
				if(order != null)
					order.Dispose();
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
            this.repCategories.RepeatDirection = RepeatDirection.Vertical;
            this.repCategories.RepeatLayout = RepeatLayout.Table;
            this.repCategories.CellPadding = 5;
            this.repCategories.BorderWidth = Unit.Point(0);
            this.repCategories.ItemCommand += new DataListCommandEventHandler(repCategories_ItemCommand);
                //new RepeaterCommandEventHandler(repCategories_ItemCommand);
			this.btnBack1.Click += new System.EventHandler(this.btnBack1_Click);
			this.btnSaveNote.Click += new System.EventHandler(this.btnSaveNote_Click);
			this.btnBack2.Click += new System.EventHandler(this.btnBack2_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}

		#endregion

		private void btnBack_Click(object sender, System.EventArgs e)
		{
			Response.Redirect(BackPage, false);
		}

		private void btnNO_Click(object sender, System.EventArgs e)
		{
			try
			{
				// next screen
				if(Operation == "CheckIn")
					Response.Redirect("ok_selectSpareEquip.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString(), false);
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
			}		
		}

		private void btnYES_Click(object sender, System.EventArgs e)
		{
			try
			{
				pnlSelectCategory.Visible = true;
				pnlEnterIssue.Visible = false;
				pnlViewIssues.Visible = false;
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				repCategories.DataSource = new DataView(order.GetCategoryList());
				repCategories.DataBind();
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

		//private void repCategories_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        protected void repCategories_ItemCommand(object source, DataListCommandEventArgs e)
		{
			try
			{
				if(e.CommandName == "Select")
				{
					ViewState["CatId"] = e.CommandArgument;
					pnlEnterIssue.Visible = true;
					pnlSelectCategory.Visible = false;
					pnlViewIssues.Visible = false;
					tbNotes.Text = "";
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
			}		
		}

		private void btnSaveNote_Click(object sender, System.EventArgs e)
		{
			try
			{
				if(ViewState["CatId"] != null && tbNotes.Text.Length != 0)
				{
					order = new clsWorkOrders();
					order.cAction = "U";
					order.iOrgId = OrgId;
					order.iReportedIssueId = 0;
					order.iRepairCatId = Convert.ToInt32(ViewState["CatId"]);
					order.sReportDesc = tbNotes.Text;
					order.iId = OrderId;
					order.iServiceResultId = SqlInt32.Null;
					order.iServiceCheckId = SqlInt32.Null;
					order.iRepairMultId = SqlInt32.Null;
					if(order.WorkOrderReportedIssuesDetail() == -1)
					{
						Session["lastpage"] = CurrentPage;
						Session["error"] = _functions.ErrorMessage(121);
						Response.Redirect("error.aspx", false);
						return;
					}
					else
					{
						if(Operation == "AddIssueReOpen")
						{
							Response.Redirect(BackPage + "&op=AddIssueReOpen", false);
							return;
						}
						else
						{
							pnlViewIssues.Visible = true;
							pnlEnterIssue.Visible = false;
							pnlSelectCategory.Visible = false;
							lblFirstName.Text = op.FirstName;
							order.iEquipId = EquipId;
							dtIssues = order.GetReportedIssueListsOperatorKiosk();
							if(dtIssues.Rows.Count > 0)
							{
								html_tblNoneIssues.Visible = false;
								repIssues.DataSource = new DataView(dtIssues);
								repIssues.DataBind();
							}
							else
								html_tblNoneIssues.Visible = true;
						}
					}
				}
				else
					rfvNotes.Visible = true;
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
				if(Operation == "AddIssueReOpen")
				{
					Response.Redirect(BackPage, false);
				}
				else
				{
					pnlViewIssues.Visible = true;
					pnlEnterIssue.Visible = false;
					pnlSelectCategory.Visible = false;
					lblFirstName.Text = op.FirstName;
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iId = OrderId;
					order.iEquipId = EquipId;
					dtIssues = order.GetReportedIssueListsOperatorKiosk();
					if(dtIssues.Rows.Count > 0)
					{
						html_tblNoneIssues.Visible = false;
						repIssues.DataSource = new DataView(dtIssues);
						repIssues.DataBind();
					}
					else
						html_tblNoneIssues.Visible = true;
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

		private void btnBack2_Click(object sender, System.EventArgs e)
		{
			try
			{
				pnlSelectCategory.Visible = true;
				pnlEnterIssue.Visible = false;
				pnlViewIssues.Visible = false;
				order = new clsWorkOrders();
				order.iOrgId = OrgId;
				repCategories.DataSource = new DataView(order.GetCategoryList());
				repCategories.DataBind();
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
	}
}
