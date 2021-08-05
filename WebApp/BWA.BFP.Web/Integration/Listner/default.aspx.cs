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
using BWA.BFP.Web;
using System.Globalization;

namespace BWA.BFP.Web
{
    public class Listner : BFPPage
    {
        private clsWorkOrders order = new clsWorkOrders();
        private clsUsers user = null;
        //private Warehouse.UserService Client = new Warehouse.UserService();

        protected override void OnLoad(EventArgs e)
        {
            try
            {
                SourcePageName = "/listner/default.aspx.cs";
                base.OnLoad(e);
            }
            catch (Exception ex)
            {
                _functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
            }
        }

        private void Page_Load(object sender, System.EventArgs e)
        {
            try
            {
                OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
                string key = order.GetIntegrationKey(this.OrgId);

                if (!string.IsNullOrEmpty(Request.QueryString["orderIds"]) && !string.IsNullOrEmpty(key))
                {
                    string[] OrderIds = Request.QueryString["orderIds"].Split(',');
                    string description;
                    string partNumber;
                    int ticketId;
                    int qty;
                    decimal cost = 0.0M;
                    Guid externalPartId;
                    Guid externalOrderId;
                    DataSet ds;

                    //foreach (string orderId in OrderIds)
                    //{
                    //    externalOrderId = new Guid(orderId);
                    //    ds = Client.GetOrderDetails(externalOrderId, "FLEET" + key);
                    //    foreach (DataRow dr in ds.Tables["Order"].Rows)
                    //    {
                    //        description = dr["name"].ToString();
                    //        partNumber = dr["PartNumber"].ToString();
                    //        int.TryParse(dr["qty"].ToString(), out qty);
                    //        cost = Convert.ToDecimal(dr["cost"].ToString(), CultureInfo.InvariantCulture);
                    //        if (dr["itemId"] != null && !string.IsNullOrEmpty(dr["itemId"].ToString()))
                    //            externalPartId = new Guid(dr["itemId"].ToString());
                    //        int.TryParse(dr["ticketId"].ToString(), out ticketId);

                    //        order = new clsWorkOrders();
                    //        order.cAction = "U";
                    //        order.iPartUsedId = 0;
                    //        order.iPartUsedQty = qty;
                    //        order.iOrgId = OrgId;
                    //        order.sPartUsedStock = partNumber;
                    //        order.sPartUsedDesc = description;
                    //        order.dmPartUsedCost = cost;
                    //        order.iRepairId = ticketId;
                    //        order.PartsUsedDetails();
                    //    }
                    //}
                }
            }
            catch { }
            finally
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "closeWindow", "window.opener.location.href = window.opener.location.href;window.close();", true);
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
            this.Load += new System.EventHandler(this.Page_Load);
        }

        #endregion
    }
}