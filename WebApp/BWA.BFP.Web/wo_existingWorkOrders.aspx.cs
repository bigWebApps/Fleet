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
	public class _wo_existingWorkOrders : BFPPage
	{
		protected Micajah.DataGrid.DataGrid_A dgMainList;
		protected System.Web.UI.WebControls.HyperLink hlNewOrder;

		private clsWorkOrders order = null;
		private DataTable dtOrders = null;
		private int EquipId;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_existingWorkOrders.aspx.cs";

				this.PageTitle = "Create New or Select Existing Work Order";
				Header.AddBreadCrumb("Home", "/main.aspx");
				Header.AddBreadCrumb("Select Equipment", "/wo_default.aspx?select=AddOrder");
				Header.LeftBarHtml = "Create New or Select Existing Work Order";
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
					EquipId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "main.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				
				hlNewOrder.NavigateUrl = "wo_editAddInfo.aspx?id=0&equipid=" + EquipId.ToString();

				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.iOrgId = OrgId;
					order.iEquipId = EquipId;
					dtOrders = order.GetWOListFromEquip();
					if(dtOrders.Rows.Count > 0)
					{
						dgMainList.DataSource = new DataView(dtOrders);
						dgMainList.DataBind();
					}
					else
					{
						Response.Redirect("wo_editAddInfo.aspx?id=0&equipid=" + EquipId.ToString(), false);
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_existingWorkOrders.aspx?id=" + EquipId.ToString();
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
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
