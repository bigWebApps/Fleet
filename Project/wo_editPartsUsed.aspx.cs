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
	public class _wo_editPartsUsed : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected System.Web.UI.WebControls.DropDownList ddlRepairCats;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected Micajah.DataGrid.DataGrid_A dgParts;
		protected System.Web.UI.WebControls.TextBox tbStock;
		protected System.Web.UI.WebControls.TextBox tbDesc;
		protected System.Web.UI.WebControls.TextBox tbCost;
		protected System.Web.UI.WebControls.TextBox tbQty;
		protected System.Web.UI.WebControls.Button btnAddPart;
		protected MetaBuilders.WebControls.ListLink ListLink;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.DropDownList ddlRepairItems;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvQty;
		protected System.Web.UI.WebControls.RangeValidator rvQty;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvStock;
		protected System.Web.UI.WebControls.RegularExpressionValidator revCost;
		protected System.Web.UI.WebControls.DataGrid dgSources;
				
		private clsWorkOrders order = null;
		private DataSet dsRepairItemsCats = null;
		private int OrderId;
		private int RepairId;
		private int InspectId;
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				string [,] arrBrdCrumbs;
				
				SourcePageName = "wo_editPartsUsed.aspx.cs";

				if(Request.QueryString["id"] == null || Request.QueryString["repairid"] == null)
				{
					Session["lastpage"] = "main.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
					RepairId = Convert.ToInt32(Request.QueryString["repairid"]);
					if(Request.QueryString["inspectid"] != null)
						InspectId = Convert.ToInt32(Request.QueryString["inspectid"]);
					else
						InspectId = 0;
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "main.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				
				ViewState["OrderId"] = OrderId;
				ViewState["RepairId"] = RepairId;
				ViewState["InspectId"] = InspectId;

				arrBrdCrumbs = ConvertBreadCrumbs(((string[,])Session["BrdCrumbs"]), "wo_viewWorkOrder.aspx?id=" + OrderId.ToString(), "Work Order Detail");
				if(InspectId != 0)
				{
					arrBrdCrumbs = ConvertBreadCrumbs(arrBrdCrumbs, "wo_viewCompleteInspection.aspx?id=" + OrderId.ToString()+ "&inspectid=" + InspectId.ToString(), "The Inspection");
				}

				PageTitle = "Enter Notes and Parts";
				Header.BrdCrumbs = ParseBreadCrumbs(arrBrdCrumbs, PageTitle);
				Header.PageTitle = PageTitle;

				SaveCancelControl.CausesValidation = false;
				SaveCancelControl.ButtonText = " Save ";
				SaveCancelControl.ParentPageURL = ParentPageURL;
				if(ViewState["VisibleCancel"] != null)
				{
					SaveCancelControl.IsCancel = (bool)ViewState["VisibleCancel"];
				}
				if(!IsPostBack)
				{
					order = new clsWorkOrders();
					order.cAction = "S";
					order.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					
					dsRepairItemsCats = order.GetRepairItemsAndCats();

					dsRepairItemsCats.Relations.Add( new DataRelation( "Cats_Items", dsRepairItemsCats.Tables["Table"].Columns["Id"], dsRepairItemsCats.Tables["Table1"].Columns["CatId"] ) );
					
					ddlRepairCats.DataSource = dsRepairItemsCats;
					ddlRepairCats.DataBind();
					
					ddlRepairItems.DataSource = dsRepairItemsCats;
					ddlRepairItems.DataBind();
					
					ListLink.DataBind();

					order.iId = OrderId;
					order.iRepairId = RepairId;

					if(order.RepairCommonDetails() == -1)
					{
						if(InspectId != 0)
							Session["lastpage"] = "wo_viewCompleteInspection.aspx?id=" + OrderId.ToString()+ "&inspectid=" + InspectId.ToString();
						else
							Session["lastpage"] = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();
						Session["error"] = _functions.ErrorMessage(123);
						Response.Redirect("error.aspx", false);
						return;
					}
					if(order.iRepairItemId.Value == 0 && order.sRepairDesc.Value == "")
					{
						SaveCancelControl.IsCancel = false;
						ViewState["VisibleCancel"] = false;
					}
					else
					{
						ViewState["VisibleCancel"] = true;
					}

					ddlRepairCats.SelectedValue =  order.iRepairCatId.Value.ToString();
					ddlRepairItems.SelectedValue = order.iRepairItemId.Value.ToString();
					tbNotes.Text = order.sRepairDesc.Value;
					
					dgSources.DataSource = new DataView(order.GetSourceList());
					dgSources.DataBind();

					dgParts.DataSource = new DataView(order.GetPartsUsedList());
					dgParts.DataBind();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				if(InspectId != 0)
					Session["lastpage"] = "wo_viewCompleteInspection.aspx?id=" + OrderId.ToString()+ "&inspectid=" + InspectId.ToString();
				else
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
			this.dgParts.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgParts_DeleteCommand);
			this.btnAddPart.Click += new System.EventHandler(this.btnAddPart_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region Save Work Order
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			try{
				OrderId = (int)ViewState["OrderId"];
				RepairId = (int)ViewState["RepairId"];
				InspectId = (int)ViewState["InspectId"];

				order = new clsWorkOrders();
				order.cAction = "U";
				order.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				order.iId = OrderId;
				order.iRepairId = RepairId;
				order.sRepairDesc = tbNotes.Text;
				if(ddlRepairItems.SelectedValue != "0")
					order.iRepairItemId = Convert.ToInt32(ddlRepairItems.SelectedValue);
				if(order.RepairCommonDetails() == -1)
				{
					Session["lastpage"] = "wo_editPartsUsed.aspx?id=" + OrderId.ToString() + "&repairid=" + RepairId.ToString() + "&inspectid=" + InspectId.ToString();
					Session["error"] = _functions.ErrorMessage(123);
					Response.Redirect("error.aspx", false);
					return;
				}
				if(InspectId != 0)
					Response.Redirect("wo_viewCompleteInspection.aspx?id=" + OrderId.ToString()+ "&inspectid=" + InspectId.ToString(), false);
				else
					Response.Redirect("wo_viewWorkOrder.aspx?id=" + OrderId.ToString(), false);
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_editPartsUsed.aspx?id=" + OrderId.ToString() + "&repairid=" + RepairId.ToString() + "&inspectid=" + InspectId.ToString();
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
		#endregion

		private void btnAddPart_Click(object sender, System.EventArgs e)
		{
			try
			{
				OrderId = (int)ViewState["OrderId"];
				RepairId = (int)ViewState["RepairId"];
				InspectId = (int)ViewState["InspectId"];

				order = new clsWorkOrders();
				order.cAction = "U";
				order.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				order.iPartUsedId = 0;
				order.iRepairId = RepairId;
				order.iPartUsedQty = Convert.ToInt32(tbQty.Text);
				order.sPartUsedStock = tbStock.Text;
				order.sPartUsedDesc = tbDesc.Text;
				if(tbCost.Text.Length > 0)
					order.dmPartUsedCost = Convert.ToDecimal(tbCost.Text);
				order.PartsUsedDetails();
				tbQty.Text = "";
				tbStock.Text = "";
				tbDesc.Text = "";
				tbCost.Text = "";
				dgParts.DataSource = new DataView(order.GetPartsUsedList());
				dgParts.DataBind();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_editPartsUsed.aspx?id=" + OrderId.ToString() + "&repairid=" + RepairId.ToString() + "&inspectid=" + InspectId.ToString();
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

		private void dgParts_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				if(e.CommandName == "Delete")
				{
					OrderId = (int)ViewState["OrderId"];
					RepairId = (int)ViewState["RepairId"];
					order = new clsWorkOrders();
					order.cAction = "D";
					order.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
					order.iPartUsedId = Convert.ToInt32(e.Item.Cells[0].Text);
					order.iRepairId = RepairId;
					if(order.PartsUsedDetails() == -1)
					{
						Session["lastpage"] = "wo_editPartsUsed.aspx?id=" + OrderId.ToString() + "&repairid=" + RepairId.ToString();
						Session["error"] = _functions.ErrorMessage(125);
						Response.Redirect("error.aspx", false);
						return;
					}			
					dgParts.DataSource = new DataView(order.GetPartsUsedList());
					dgParts.DataBind();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_editPartsUsed.aspx?id=" + OrderId.ToString() + "&repairid=" + RepairId.ToString();
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
