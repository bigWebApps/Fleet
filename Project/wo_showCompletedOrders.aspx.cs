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
	public class _wo_showCompletedOrders : BFPPage
	{
		protected System.Web.UI.WebControls.Button btnFiltration;
		protected System.Web.UI.WebControls.TextBox tbEquipId;
		protected System.Web.UI.WebControls.DropDownList ddlDrivers;
		protected Micajah.DataGrid.DataGrid_A dgCompletedWorkOrders;
		protected System.Web.UI.HtmlControls.HtmlTable tableMain;
		
		private clsWorkOrders order = null;
		private clsUsers user = null;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_showCompletedOrders.aspx.cs";

				this.PageTitle = "Completed Work Orders";
				this.PageTitle = "Create Future Work Order with Inspection";
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.LeftBarHtml = "View the Completed Work Orders";
				base.OnLoad(e);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = this.ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			DataView dwUsers = null;
			try
			{
				tableMain.Rows[0].Visible = false;
				tableMain.Rows[1].Visible = false;

				Session["PathToViewOrder"] = "Completed";
				
				if(!IsPostBack)
				{
					//user = new clsUsers();
//					user.iOrgId = _functions.GetUserOrgId(Context.User.Identity.Name, false);
//					dwUsers = new DataView(user.GetUserList());
//					DataRowView drv = dwUsers.AddNew();
//					drv[0] = 0;
//					drv[1] = "All";
//					drv.EndEdit();
//					dwUsers.Sort = "[Id] asc";
//					ddlDrivers.DataSource = dwUsers;
//					ddlDrivers.DataBind();
//					ddlDrivers.SelectedValue = _functions.GetUserOrgId(Context.User.Identity.Name, true).ToString();
//					
					ShowCompletedOrders();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "main.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(user != null)
					user.Dispose();
			}
		}

		/// <summary>
		/// Procedure is showing completed work orders on screen
		/// </summary>
		private void ShowCompletedOrders()
		{
			try
			{
				order = new clsWorkOrders();
				order.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				order.sEquipId = ""; //tbEquipId.Text;
				order.iOperatorId = 0; //Convert.ToInt32(ddlDrivers.SelectedValue);
				dgCompletedWorkOrders.DataSource = new DataView(order.GetWOCompletedList());
				dgCompletedWorkOrders.DataBind();
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
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
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.btnFiltration.Click += new System.EventHandler(this.btnFiltration_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnFiltration_Click(object sender, System.EventArgs e)
		{
			try
			{
				ShowCompletedOrders();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_showCompletedOrders.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
		}
	}
}
