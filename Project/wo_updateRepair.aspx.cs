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

namespace BWA.BFP.Web.workorder
{
    public class _wo_updateRepair : BFPPage
    {
        protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
        protected System.Web.UI.WebControls.DropDownList ddlRepairCats;
        protected System.Web.UI.WebControls.DropDownList ddlRepairItems;
        protected MetaBuilders.WebControls.ListLink ListLink;
        protected System.Web.UI.WebControls.TextBox tbNotes;
        protected System.Web.UI.WebControls.TextBox tbQty;
        protected System.Web.UI.WebControls.TextBox tbStock;
        protected System.Web.UI.WebControls.TextBox tbDesc;
        protected System.Web.UI.WebControls.TextBox tbCost;
        protected System.Web.UI.WebControls.Button btnAddPart;
        protected System.Web.UI.WebControls.RequiredFieldValidator rfvQty;
        protected System.Web.UI.WebControls.RegularExpressionValidator revCost;
        protected System.Web.UI.WebControls.RangeValidator rvQty;
        protected System.Web.UI.WebControls.LinkButton lbAddRepair;
        protected System.Web.UI.WebControls.Repeater repRepairs;
        protected System.Web.UI.WebControls.Repeater repParts;
        protected System.Web.UI.WebControls.Label lblTableFooter;
        protected System.Web.UI.WebControls.Label lblSourceType;
        protected System.Web.UI.WebControls.Label lblRepairCategory;
        protected System.Web.UI.WebControls.Label lblIssue;
        protected System.Web.UI.HtmlControls.HtmlTable tblSource;
        protected System.Web.UI.WebControls.Label lblTableTitle;
        protected System.Web.UI.WebControls.RequiredFieldValidator rfvDesc;
        protected System.Web.UI.WebControls.Label lblValidatorCategory;
        protected System.Web.UI.WebControls.Label lblValidatorItem;
        protected System.Web.UI.HtmlControls.HtmlInputCheckBox html_chNewRepair;
        protected System.Web.UI.WebControls.RegularExpressionValidator revQty;
        protected System.Web.UI.WebControls.Repeater repReportedIssues;
        protected System.Web.UI.WebControls.RegularExpressionValidator revMinutes;
        protected System.Web.UI.WebControls.RegularExpressionValidator revHours;
        protected System.Web.UI.WebControls.TextBox tbMinutes;
        protected System.Web.UI.WebControls.TextBox tbHours;
        protected System.Web.UI.WebControls.LinkButton lbAddLog;
        protected System.Web.UI.WebControls.Panel WarehousePanel;
        protected System.Web.UI.WebControls.LinkButton WarehouseLink;
        protected System.Web.UI.WebControls.Panel RepairLogsLinksPanel;        

        private clsWorkOrders order = null;
        private clsUsers user = null;

        private DataSet dsRepairItemsCats = null;
        private DataTable dtParts = null;
        private DataView dwParts = null;

        private int OrderId;
        private int preRepairId;
        private int RepairId;
        private int InspectId;
        private int ItemId;
        private string sType;
        private string ServiceResult;
        private string sLastPage, sCurrentPage;

        private bool openWindow = false;
        private bool Mode = false; // false - Edit mode / true - Add mode

        protected override void OnLoad(EventArgs e)
        {
            try
            {
                SourcePageName = "wo_updateRepair.aspx.cs";

                Header.LeftBarHtml = "Enter Repair Category and Description to a Order Issue";
                base.OnLoad(e);
            }
            catch (Exception ex)
            {
                _functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
            }
        }

        protected void WarehouseLink_Click(object sender, EventArgs e)
        {
            if (RepairId > 0)
                UpdateRepair();
            else
                UpdateRepair(true); // create new repair

            Response.Redirect(string.Format("./wo_updateRepair.aspx?mode=Edit&inspectid={0}&type={1}&itemid={2}&op={3}&id={4}&repairid={5}", InspectId.ToString(), sType, ItemId.ToString(), ServiceResult, OrderId.ToString(), RepairId > 0 ? RepairId.ToString() : preRepairId.ToString()));
        }

        private void Page_Load(object sender, System.EventArgs e)
        {
            try
            {
                OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
                if (Request.QueryString["repairid"] != null && !string.IsNullOrEmpty(Request.QueryString["repairid"]))
                    RepairId = Convert.ToInt32(Request.QueryString["repairid"]);
                if (Request.QueryString["mode"] == null || Request.QueryString["id"] == null || Request.QueryString["repairid"] == null)
                {
                    Session["lastpage"] = "main.aspx";
                    Session["error"] = _functions.ErrorMessage(104);
                    Response.Redirect("error.aspx", false);
                    return;
                }
                try
                {
                    if (Request.QueryString["mode"] == "Add")
                        Mode = true;
                    else
                        Mode = false;
                    OrderId = Convert.ToInt32(Request.QueryString["id"]);

                    if (Request.QueryString["inspectid"] != null)
                        InspectId = Convert.ToInt32(Request.QueryString["inspectid"]);
                    else
                        InspectId = 0;
                    if (Request.QueryString["itemid"] != null)
                        ItemId = Convert.ToInt32(Request.QueryString["itemid"]);
                    else
                        ItemId = 0;
                    if (Request.QueryString["type"] != null)
                        sType = Request.QueryString["type"]; //RI, PMI, II, FREE
                    else
                        sType = "";
                    if (Request.QueryString["op"] != null)
                        ServiceResult = Request.QueryString["op"]; //Repair, Replace
                    else
                        ServiceResult = "";
                    sCurrentPage = "wo_updateRepair.aspx?mode=" + (Mode ? "Add" : "Edit") + "&id=" + OrderId.ToString() + "&repairid=" + RepairId.ToString() + "&inspectid=" + InspectId.ToString() + "&itemid=" + ItemId.ToString() + "&type=" + sType + "&op=" + ServiceResult;
                }
                catch (FormatException fex)
                {
                    Session["lastpage"] = "main.aspx";
                    Session["error"] = _functions.ErrorMessage(105);
                    Response.Redirect("error.aspx", false);
                    return;
                }
                // getting the Bread Crumbs from Cookie and add last item
                if (Request.Cookies.Count > 0 && Request.Cookies["bfp_navigate"] != null)
                    Header.BrdCrumbsSerialization = Request.Cookies["bfp_navigate"].Value;
                Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "&#Repairs");

                if (sType == "II") // if came from Inspetion screen
                {
                    Header.AddBreadCrumb("Inspection Detail", "/wo_viewCompleteInspection.aspx?id=" + OrderId.ToString() + "&inspectid=" + InspectId.ToString());
                    sLastPage = "wo_viewCompleteInspection.aspx?id=" + OrderId.ToString() + "&inspectid=" + InspectId.ToString();
                }
                else
                    sLastPage = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString() + "&#Repairs";

                if (Mode)
                    this.PageTitle = "Update Repair";
                else if (sType == "FREE")
                    this.PageTitle = "Add Repair";
                else
                    this.PageTitle = "Edit Repair";
                Header.AddJavaScriptFile("/wo_updateRepair.js");
                Header.BodyOnloadScript = "javascript:CheckEditMode();";

                SaveCancelControl.CausesValidation = false;
                SaveCancelControl.ButtonText = " Save & Back ";
                SaveCancelControl.IsCancel = false;

                ddlRepairCats.Attributes.Add("onchange", "javascript:ValidRepairItems();");
                ddlRepairItems.Attributes.Add("onchange", "javascript:ValidRepairItems();");

                clsWorkOrders orders = new clsWorkOrders();
                string key = orders.GetIntegrationKey(this.OrgId);

                clsUsers user = new clsUsers();
                user.cAction = "S";
                user.iOrgId = OrgId;
                user.iId = _functions.GetUserOrgId(Context.User.Identity.Name, true);
                user.UserDetails();

                if (RepairId == 0)
                {
                    preRepairId = orders.GetRepairPreId();
                    preRepairId++;
                }

                if (string.IsNullOrEmpty(key))
                    WarehousePanel.Visible = false;
                else
                {
                    string url = String.Format(_functions.GetValueFromConfig("WarehouseListnerPage") + "?action=create&key={0}&app=fleet&roid={1}&riid={2}&rufn={3}&ruln={4}&rue={5}&ron={6}&rofn={7}&shipto={8}&shiploc={9}", key, RepairId > 0 ? RepairId.ToString() : preRepairId.ToString(), string.Empty, user.sFirstName.Value, user.sLastName.Value, user.sEmail.Value, "Work Order", OrderId.ToString(), user.sFirstName.Value + " " + user.sLastName.Value, string.Empty);
                    string windowOpenScript = "function openWindow() { window.open('" + url + "','Warehouse','height=600,width=900,toolbar=0,status=1,location=0,menubar=0,scrollbars=1,resizable=1'); }";

                    if (!Page.ClientScript.IsClientScriptBlockRegistered("openWindow"))
                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "openWindow", windowOpenScript, true);
                }

                if (!IsPostBack)
                {
                    order = new clsWorkOrders();
                    order.cAction = "S";
                    order.iOrgId = OrgId;
                    order.iId = OrderId;
                    order.iRepairId = RepairId;

                    dsRepairItemsCats = order.GetRepairItemsAndCats();

                    dsRepairItemsCats.Relations.Add(new DataRelation("Cats_Items", dsRepairItemsCats.Tables["Table"].Columns["Id"], dsRepairItemsCats.Tables["Table1"].Columns["CatId"]));

                    ddlRepairCats.DataSource = dsRepairItemsCats;
                    ddlRepairCats.DataBind();

                    ddlRepairItems.DataSource = dsRepairItemsCats;
                    ddlRepairItems.DataBind();

                    ListLink.DataBind();

                    if (Mode) // Add Mode
                    {
                        order.sTypeService = sType;
                        order.iItemId = ItemId;

                        if (sType == "II")
                        {
                            lblTableTitle.Text = "Please check the following to update any reported issues associated with this Inspection item";
                            DataTable dtReportedIssues = order.GetReportedIssuesListUpdate();
                            if (dtReportedIssues.Rows.Count > 0)
                            {
                                repReportedIssues.DataSource = new DataView(dtReportedIssues);
                                repReportedIssues.DataBind();
                            }
                            else
                            {
                                lblTableTitle.Text = "Serviced Repairs";
                                repReportedIssues.Visible = false;
                            }
                        }
                        else
                        {
                            lblTableTitle.Text = "Serviced Repairs";
                            repReportedIssues.Visible = false;
                        }

                        // showing all repaires with associations
                        repRepairs.DataSource = new DataView(order.GetRepairsListUpdate());
                        repRepairs.DataBind();

                        order.GetIssueInfo();

                        lblSourceType.Text = order.sTypeService.Value;
                        lblRepairCategory.Text = order.sRepairCatName.Value;
                        lblIssue.Text = order.sServiceName.Value;
                    }
                    else // Edit Mode
                    {
                        // hidding the controls for Edit mode
                        tblSource.Visible = false;
                        lblTableTitle.Text = "Repair";
                        repRepairs.Visible = false;
                        html_chNewRepair.Visible = false;
                        lblTableFooter.Visible = false;
                        RepairLogsLinksPanel.Visible = false;

                        // getting repair's info
                        order.RepairCommonDetails();
                        ddlRepairCats.SelectedValue = order.iRepairCatId.Value.ToString();
                        ddlRepairItems.SelectedValue = order.iRepairItemId.Value.ToString();
                        tbNotes.Text = order.sRepairDesc.Value;
                    }
                    dtParts = order.GetPartsUsedList();
                    ViewState["PartsUsed"] = dtParts;
                    dwParts = new DataView(dtParts);
                    dwParts.RowFilter = "IsDeleted=0";
                    repParts.DataSource = dwParts;
                    repParts.DataBind();
                }
            }
            catch (Exception ex)
            {
                _functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
                Session["lastpage"] = sLastPage;
                Session["error"] = ex.Message;
                Session["error_report"] = ex.ToString();
                Response.Redirect("error.aspx", false);
            }
            finally
            {
                if (order != null)
                    order.Dispose();
            }
        }


        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            this.SaveCancelControl.BubbleClick += new EventHandler(this.btSave_FormSubmit);
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            this.repRepairs.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repRepairs_ItemCommand);
            this.lbAddRepair.Click += new System.EventHandler(this.lbAddRepair_Click);
            this.lbAddLog.Click += new System.EventHandler(this.lbAddLog_Click);
            this.repParts.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.repParts_ItemCommand);
            this.btnAddPart.Click += new System.EventHandler(this.btnAddPart_Click);
            this.Load += new System.EventHandler(this.Page_Load);

        }
        #endregion

        #region Save Associations
        /// <summary>
        /// the common procedure of saving for all associations in the Add mode in database
        /// </summary>
        private void SaveAssociations()
        {
            try
            {
                order = new clsWorkOrders();
                order.iOrgId = OrgId;
                order.iId = OrderId;
                order.sTypeService = sType;
                order.iItemId = ItemId;
                if (ServiceResult == "Repair")
                    order.iServiceResultId = (int)ServiceResults._Repaired;
                else
                    order.iServiceResultId = (int)ServiceResults._Replaced;
                foreach (RepeaterItem item in repRepairs.Items)
                {
                    order.iRepairId = Convert.ToInt32(((LinkButton)item.FindControl("lbEditRepair")).CommandArgument);
                    order.bChecked = ((CheckBox)item.FindControl("cbRepair")).Checked;
                    order.SetAssociationsRepair();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
            finally
            {
                if (order != null)
                    order.Dispose();
            }
        }
        #endregion

        private void UpdateRepair()
        {
            UpdateRepair(false);
        }

        #region Create or Save Repair
        /// <summary>
        /// The common procedure what will save filled Repair 
        // and his used parts both Add mode and Edit mode.
        /// </summary>
        private void UpdateRepair(bool newRepair)
        {
            double Hours = 0.0;
            try
            {
                //				if(tbNotes.Text.Length > 0)
                //				{
                if (tbMinutes.Text.Length > 0 && Convert.ToDouble(tbMinutes.Text) >= 60)
                {
                    Header.ErrorMessage = _functions.ErrorMessage(206);
                    return;
                }
                if (tbHours.Text.Length > 0 || tbMinutes.Text.Length > 0)
                {
                    if (tbHours.Text.Length > 0) Hours += Convert.ToDouble(tbHours.Text);
                    if (tbMinutes.Text.Length > 0) Hours += Convert.ToDouble(tbMinutes.Text) / 60;
                }
                if (Hours >= 1000)
                {
                    Header.ErrorMessage = _functions.ErrorMessage(203);
                    return;
                }
                order = new clsWorkOrders();
                order.iOrgId = OrgId;
                order.iId = OrderId;
                order.sTypeService = sType;
                order.iItemId = ItemId;
                if (ServiceResult == "Repair")
                    order.iServiceResultId = (int)ServiceResults._Repaired;
                else
                    order.iServiceResultId = (int)ServiceResults._Replaced;
                if (Mode) // Add mode
                {
                    order.iRepairId = 0;
                }
                else // Edit mode
                    order.iRepairId = RepairId;

                if (RepairId == 0 && newRepair)
                {
                    order.iRepairId = preRepairId;
                    order.iInsert = true;
                }

                order.sRepairDesc = tbNotes.Text;
                order.iRepairItemId = Convert.ToInt32(ddlRepairItems.SelectedValue);
                order.iRepairCatId = Convert.ToInt32(ddlRepairCats.SelectedValue);
                if (order.UpdateRepair() == -1)
                {
                    Session["lastpage"] = sCurrentPage;
                    Session["error"] = _functions.ErrorMessage(128);
                    Response.Redirect("error.aspx", false);
                    return;
                }
                RepairId = order.iRepairId.Value;
                // saving the parts for entered repair
                dtParts = (DataTable)ViewState["PartsUsed"];
                foreach (DataRow item in dtParts.Rows)
                {
                    if ((int)item["IsNew"] == 1)
                    {
                        order.cAction = "U";
                        order.iPartUsedId = 0;
                        order.iPartUsedQty = (int)item["Qty"];
                        order.sPartUsedStock = (string)item["Stock"];
                        order.sPartUsedDesc = (string)item["Desc"];
                        order.dmPartUsedCost = (decimal)item["Cost"];
                        order.PartsUsedDetails();
                    }
                    if ((int)item["IsDeleted"] == 1)
                    {
                        order.cAction = "D";
                        order.iPartUsedId = (int)item["Id"];
                        if (order.PartsUsedDetails() == -1)
                        {
                            Session["lastpage"] = sCurrentPage;
                            Session["error"] = _functions.ErrorMessage(125);
                            Response.Redirect("error.aspx", false);
                            return;
                        }
                    }
                }
                if (Mode && html_chNewRepair.Checked && sType == "II")
                {
                    order.iInspectItemId = ItemId;
                    foreach (RepeaterItem item in repReportedIssues.Items)
                    {
                        CheckBox cbTmp = (CheckBox)item.FindControl("cbIssue");
                        if (cbTmp.Checked && cbTmp.Enabled)
                        {
                            order.iReportedIssueId = Convert.ToInt32(cbTmp.Attributes["CommandArgument"]);
                            order.SetAssociationsIssue();
                        }
                    }
                }
                if (Hours > 0.0)
                {
                    user = new clsUsers();
                    user.iOrgId = OrgId;
                    user.iOrderId = OrderId;
                    if (user.GetTechnicianInfo() != -1)
                    {
                        order.cAction = "U";
                        order.iTimeLogId = 0;
                        order.iTechId = user.iId;
                        order.daStartTime = SqlDateTime.Null;
                        order.daStopTime = SqlDateTime.Null;
                        order.dmHours = Convert.ToDecimal(Hours);
                        order.dmHourlyRate = user.dmHourlyRate;
                        order.sNote = tbNotes.Text;
                        order.TimeLogDetails();
                    }
                }
                //				}
                //				else
                //					lblRequestor.Visible = true;
            }
            catch (FormatException fex)
            {
                Header.ErrorMessage = _functions.ErrorMessage(205);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
            finally
            {
                if (user != null)
                    user.Dispose();
                if (order != null)
                    order.Dispose();
            }

        }
        #endregion

        #region Save Repair
        private void btSave_FormSubmit(object sender, EventArgs e)
        {
            try
            {
                if (Mode) // Add mode
                {
                    SaveAssociations();

                    if (html_chNewRepair.Checked)
                    {
                        // add a current repair
                        UpdateRepair();
                        Response.Redirect(sLastPage, false);
                        return;
                    }
                    else
                        Response.Redirect(sLastPage, false);
                }
                else // Edit mode
                {
                    UpdateRepair();
                    Response.Redirect(sLastPage, false);
                    return;
                }
            }
            catch (Exception ex)
            {
                _functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
                Session["lastpage"] = sCurrentPage;
                Session["error"] = ex.Message;
                Session["error_report"] = ex.ToString();
                Response.Redirect("error.aspx", false);
            }
            finally
            {
                if (order != null)
                    order.Dispose();
            }
        }
        #endregion

        private void lbAddRepair_Click(object sender, System.EventArgs e)
        {
            try
            {
                if (Mode) // Add mode
                {
                    SaveAssociations();
                    if (html_chNewRepair.Checked)
                    {
                        // add a current repair
                        UpdateRepair();
                        Response.Redirect("wo_updateRepair.aspx?mode=Add&id=" + OrderId.ToString() + "&repairid=" + RepairId.ToString() + "&inspectid=" + InspectId.ToString() + "&itemid=" + ItemId.ToString() + "&type=" + sType + "&op=" + ServiceResult, false);
                        return;
                    }
                    else
                        Response.Redirect("wo_updateRepair.aspx?mode=Add&id=" + OrderId.ToString() + "&repairid=" + RepairId.ToString() + "&inspectid=" + InspectId.ToString() + "&itemid=" + ItemId.ToString() + "&type=" + sType + "&op=" + ServiceResult, false);
                }
                else
                {
                    Session["lastpage"] = sCurrentPage;
                    Session["error"] = _functions.ErrorMessage(135);
                    Response.Redirect("error.aspx", false);
                    return;
                }
            }
            catch (Exception ex)
            {
                _functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
                Session["lastpage"] = sCurrentPage;
                Session["error"] = ex.Message;
                Session["error_report"] = ex.ToString();
                Response.Redirect("error.aspx", false);
            }
            finally
            {
                if (order != null)
                    order.Dispose();
            }
        }

        private void btnAddPart_Click(object sender, System.EventArgs e)
        {
            DataRow myRow;
            int index;
            try
            {
                // adding the part to ViewState
                dtParts = (DataTable)ViewState["PartsUsed"];

                index = dtParts.Rows.Count;
                if (index > 0)
                    index = (int)dtParts.Rows[index - 1]["Id"] + 1;

                myRow = dtParts.NewRow();
                myRow["Id"] = index;
                myRow["Qty"] = Convert.ToInt32(tbQty.Text);
                myRow["Stock"] = tbStock.Text;
                myRow["Desc"] = tbDesc.Text;
                myRow["IsNew"] = 1;
                myRow["IsDeleted"] = 0;
                if (tbCost.Text.Length > 0)
                    myRow["Cost"] = Convert.ToDecimal(tbCost.Text);
                else
                    myRow["Cost"] = 0.0;
                dtParts.Rows.Add(myRow);

                ViewState["PartsUsed"] = dtParts;
                dwParts = new DataView(dtParts);
                dwParts.RowFilter = "IsDeleted=0";
                repParts.DataSource = dwParts;
                repParts.DataBind();
                tbQty.Text = "";
                tbStock.Text = "";
                tbDesc.Text = "";
                tbCost.Text = "";
                //lblRequestor.Visible = false;
            }
            catch (Exception ex)
            {
                _functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
                Session["lastpage"] = sCurrentPage;
                Session["error"] = ex.Message;
                Session["error_report"] = ex.ToString();
                Response.Redirect("error.aspx", false);
            }
            finally
            {
                if (order != null)
                    order.Dispose();
            }
        }

        private void repParts_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            int index;
            try
            {
                if (e.CommandName == "Delete")
                {
                    index = Convert.ToInt32(e.CommandArgument);
                    dtParts = (DataTable)ViewState["PartsUsed"];

                    foreach (DataRow item in dtParts.Rows)
                    {
                        if ((int)item["Id"] == index)
                        {
                            if ((int)item["IsNew"] == 1)
                                item.Delete();
                            else
                                item["IsDeleted"] = 1;
                            break;
                        }
                    }
                    // delete parts from ViewState

                    ViewState["PartsUsed"] = dtParts;

                    dwParts = new DataView(dtParts);
                    dwParts.RowFilter = "IsDeleted=0";
                    repParts.DataSource = dwParts;
                    repParts.DataBind();
                    tbQty.Text = "";
                    tbStock.Text = "";
                    tbDesc.Text = "";
                    tbCost.Text = "";
                    //lblRequestor.Visible = false;
                }
            }
            catch (Exception ex)
            {
                _functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
                Session["lastpage"] = sCurrentPage;
                Session["error"] = ex.Message;
                Session["error_report"] = ex.ToString();
                Response.Redirect("error.aspx", false);
            }
            finally
            {
                if (order != null)
                    order.Dispose();
            }
        }

        private void repRepairs_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "DirectEdit")
                {
                    if (Mode) // Add mode
                    {
                        SaveAssociations();
                        Response.Redirect("wo_updateRepair.aspx?mode=Edit&id=" + OrderId.ToString() + "&repairid=" + e.CommandArgument + "&inspectid=" + InspectId.ToString() + "&itemid=" + ItemId.ToString() + "&type=" + sType + "&op=" + ServiceResult, false);
                    }
                    else
                    {
                        Session["lastpage"] = sCurrentPage;
                        Session["error"] = _functions.ErrorMessage(135);
                        Response.Redirect("error.aspx", false);
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                _functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
                Session["lastpage"] = sCurrentPage;
                Session["error"] = ex.Message;
                Session["error_report"] = ex.ToString();
                Response.Redirect("error.aspx", false);
            }
            finally
            {
                if (order != null)
                    order.Dispose();
            }
        }

        private void lbAddLog_Click(object sender, System.EventArgs e)
        {
            try
            {
                string sTimeLogFile;
                sTimeLogFile = "wo_updateTimeLog.aspx?id=" + OrderId.ToString();
                if (Mode) // Add mode
                {
                    SaveAssociations();

                    if (html_chNewRepair.Checked)
                    {
                        // add a current repair
                        UpdateRepair();
                        Response.Redirect(sTimeLogFile + "&repairid=" + RepairId.ToString(), false);
                        return;
                    }
                    else
                        Response.Redirect(sTimeLogFile + "&repairid=" + RepairId.ToString(), false);
                }
                else // Edit mode
                {
                    UpdateRepair();
                    Response.Redirect(sTimeLogFile + "&repairid=" + RepairId.ToString(), false);
                    return;
                }
            }
            catch (Exception ex)
            {
                _functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
                Session["lastpage"] = sCurrentPage;
                Session["error"] = ex.Message;
                Session["error_report"] = ex.ToString();
                Response.Redirect("error.aspx", false);
            }
            finally
            {
                if (order != null)
                    order.Dispose();
            }
        }
    }
}
