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

namespace BWA.BFP.Web.admin
{
    public partial class admin_integration : BFPPage
    {
        private clsWorkOrders orders = new clsWorkOrders();
        private Warehouse.UserService Client = new Warehouse.UserService();

        protected override void OnLoad(EventArgs e)
        {
            try
            {
                SourcePageName = "admin_integration.aspx.cs";

                Header.MainMenuSelectedItem = "Administration";
                this.PageTitle = "Setup Warehouse Integration";
                Header.AddBreadCrumb("Home", "/selectMode.aspx");
                Header.AddBreadCrumb("Administration", "/admin.aspx");
                Header.LeftBarHtml = "Add/Edit/Delete Instruction Texts";
                base.OnLoad(e);
            }
            catch (Exception ex)
            {
                _functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
                Session["lastpage"] = this.ParentPageURL;
                Session["error"] = ex.Message;
                Session["error_report"] = ex.ToString();
                Response.Redirect("error.aspx", false);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);            
            if (!IsPostBack)
            {
                string key = orders.GetIntegrationKey(this.OrgId);
                MessagePanel.Visible = !string.IsNullOrEmpty(key);
                WarehouseLoginPanel.Visible = string.IsNullOrEmpty(key);
            }
            else
            {
                if (OrganizationList.Items.Count > 0 && ConnectPanel.Visible)
                {
                    DataTable dt = Client.GetInstances(new Guid(OrganizationList.SelectedValue));
                    if (dt.Rows.Count > 0)
                    {
                        InstanceList.DataSource = dt;
                        InstanceList.DataBind();
                    }
                }
            }
        }

        protected void ReConnectButton_Click(object sender, EventArgs e)
        {
            MessagePanel.Visible = false;
            WarehouseLoginPanel.Visible = true;
        }

        protected void lbCancel_Click(object sender, EventArgs e)
        {
            string key = orders.GetIntegrationKey(this.OrgId);
            MessagePanel.Visible = !string.IsNullOrEmpty(key);
            WarehouseLoginPanel.Visible = string.IsNullOrEmpty(key);
            ConnectPanel.Visible = false;
            errorLabel.Visible = false;
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = Client.GetOrganizations(WarehouseLoginTextBox.Text, WarehousePasswordTextBox.Text);
                if (dt.Rows.Count > 0)
                {
                    WarehouseLoginPanel.Visible = false;
                    ConnectPanel.Visible = true;
                    OrganizationList.DataSource = dt;
                    OrganizationList.DataBind();
                    OrganizationList.SelectedIndex = 0;

                    dt = Client.GetInstances(new Guid(OrganizationList.SelectedValue));
                    if (dt.Rows.Count > 0)
                    {
                        InstanceList.DataSource = dt;
                        InstanceList.DataBind();
                    }
                }
            }
            catch
            {
                errorLabel.Visible = true;
            }
        }

        protected void ConnectButton_Click(object sender, EventArgs e)
        {                       
            string key = orders.GetIntegrationKey(OrgId);
            string newkey = Guid.NewGuid().ToString();
            if (string.IsNullOrEmpty(key))
                orders.InsertIntegrationKey(OrgId, newkey);
            else
                orders.UpdateIntegrationKey(OrgId, newkey);

            Guid oldKey = Client.ConnectWithKeyReturn(new Guid(OrganizationList.SelectedValue), new Guid(InstanceList.SelectedValue), "FLEET" + newkey);
            orders.DeleteIntegrationKey(oldKey.ToString());

            MessagePanel.Visible = true;
            ConnectPanel.Visible = false;
        }
    }
}
