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
	public class _wo_viewDates : BFPPage
	{
		protected System.Web.UI.WebControls.Label lblDateCreated;
		protected System.Web.UI.WebControls.Label lblArrivalDate;
		protected System.Web.UI.WebControls.Label lblDateScheduled;
		protected System.Web.UI.WebControls.Label lblDateOpened;
		protected System.Web.UI.WebControls.Label lblDateClosed;
		protected System.Web.UI.WebControls.Label lblDepartureDate;
	
		private int OrderId;
		private clsWorkOrders order = null;

		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				SourcePageName = "wo_viewDates.aspx.cs";

				Header.MainMenuVisible = false;
				Header.Visible = false;

				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				OrderId = Convert.ToInt32(Request.QueryString["id"]);
				
				order = new clsWorkOrders();
				order.cAction = "S";
				order.iOrgId = OrgId;
				order.iId = OrderId;
				if(order.WorkOrderDetails() != -1)
				{
					lblDateCreated.Text = order.daCreated.Value.ToLongDateString();
					lblArrivalDate.Text = order.daArrival.IsNull?"":order.daArrival.Value.ToLongDateString();
					lblDateScheduled.Text = order.daScheduled.IsNull?"":order.daScheduled.Value.ToLongDateString() + " " + order.daScheduled.Value.ToLongTimeString();
					lblDateOpened.Text = order.daOpened.IsNull?"":order.daOpened.Value.ToLongDateString();
					lblDateClosed.Text = order.daClosed.IsNull?"":order.daClosed.Value.ToLongDateString();
					lblDepartureDate.Text = order.daDeparture.IsNull?"":order.daDeparture.Value.ToLongDateString();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
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
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
