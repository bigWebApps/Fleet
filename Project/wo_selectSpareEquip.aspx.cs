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
	public class _wo_slectSpareEquip : BFPPage
	{
		protected System.Web.UI.WebControls.Button btnFiltration;
		protected System.Web.UI.WebControls.TextBox tbEquipId;
		protected System.Web.UI.WebControls.DropDownList ddlEquipTypes;
		protected System.Web.UI.WebControls.DropDownList ddlDepartments;
		protected System.Web.UI.WebControls.DropDownList ddlLocations;
		protected Micajah.DataGrid.DataGrid_A dgMainList;
		protected BWA.BFP.Web.Controls.User.NextBack NextBackControl;
		protected System.Web.UI.HtmlControls.HtmlTable tblMain;
		protected System.Web.UI.WebControls.LinkButton lbCheckInSpare;
		
		private clsWorkOrders order = null;
		private clsEquipment equip = null;
		private clsLocations loc = null;
		private clsDepartments dep = null;

		private DataTable dtMain = null;
		
		private int OrderId;
		private int EquipId;
		private int SpareId;
		private int UserId;
		
		private string sBack;
		private string m_sLastPage;
		
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "wo_selectSpareEquip.aspx.cs";

				Header.LeftBarHtml = "Check-In or Check-Out the Sapre Equipment";
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
					OrderId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "main.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}

				if(Request.QueryString["equipid"] != null)
					EquipId = Convert.ToInt32(Request.QueryString["equipid"]);
				else
					EquipId = 0;

				if(Request.QueryString["back"] == null)
				{
					tblMain.Rows[0].Visible = false;
					tblMain.Rows[1].Visible = false;
					sBack = "";
					this.PageTitle = "Select Spare Equipment";
					//Header.PageTitle = PageTitle;

					if(Request.QueryString["select"] == null)
					{
						NextBackControl.BackPage = "wo_editAddInfo.aspx?id=" + OrderId.ToString() + "&equipid=0";
						NextBackControl.BackVisible = true;
						NextBackControl.CausesValidation = false;
						m_sLastPage = "wo_editAddInfo.aspx?id=" + OrderId.ToString() + "&equipid=0";
					}
					else
					{
						ViewState["Operation"] = "AddRoadside";
						NextBackControl.BackPage = "wo_selectOperator.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
						NextBackControl.BackVisible = true;
						NextBackControl.CausesValidation = false;
						NextBackControl.NextText = "<< Finish >>";
						m_sLastPage = "wo_selectOperator.aspx?orderid=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
					}
				}
				else
				{
					sBack = Request.QueryString["back"];
                    if (Request.Cookies.Count > 0 && Request.Cookies["bfp_navigate"] != null)
                        Header.BrdCrumbsSerialization = Request.Cookies["bfp_navigate"].Value;
                    switch (sBack)
					{
						case "open":
							// getting the Bread Crumbs from Cookie and add last item
							Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString());
							Header.AddBreadCrumb("Work Order Opening", "/wo_openWorkOrder.aspx?id=" + OrderId.ToString());
							m_sLastPage = "wo_openWorkOrder.aspx?id=" + OrderId.ToString();
							break;
						case "checkin":
							Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString());
							Header.AddBreadCrumb("Check-In Equipment", "/wo_viewCheckIn.aspx?id=" + OrderId.ToString());
							m_sLastPage = "wo_viewCheckIn.aspx?id=" + OrderId.ToString();
							break;
						case "edit":
							Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString());
							Header.AddBreadCrumb("Work Order Edit", "/wo_editWorkOrder.aspx?id=" + OrderId.ToString());
							m_sLastPage = "wo_editWorkOrder.aspx?id=" + OrderId.ToString();
							break;
						default:
							Header.AddBreadCrumb("Work Order Detail", "/wo_viewWorkOrder.aspx?id=" + OrderId.ToString());
							Header.AddBreadCrumb("Work Order Edit", "/wo_editWorkOrder.aspx?id=" + OrderId.ToString());
							m_sLastPage = "wo_editWorkOrder.aspx?id=" + OrderId.ToString();
							break;
					}
					this.PageTitle = "Select Spare Equipment";

					NextBackControl.BackVisible = false;
					NextBackControl.NextText = " Back ";
					NextBackControl.CausesValidation = false;
				}

				if(!IsPostBack)
				{
					equip = new clsEquipment();

					// showing the spare equipment list
					loc = new clsLocations();
					dep = new clsDepartments();
					
					equip.cAction = "S";
					equip.iOrgId = OrgId;

					ddlEquipTypes.DataSource = new DataView(equip.GetEquipTypesList());
					ddlEquipTypes.DataBind();
					ddlEquipTypes.Items.Insert(0, new ListItem("All","0"));
					
					dep.iOrgId = OrgId;
					ddlDepartments.DataSource = new DataView(dep.GetDepartmentsList());
					ddlDepartments.DataBind();
					ddlDepartments.Items.Insert(0, new ListItem("All","0"));
					
					loc.iOrgId = OrgId;
					ddlLocations.DataSource = new DataView(loc.GetLocationsList());
					ddlLocations.DataBind();
					ddlLocations.Items.Insert(0, new ListItem("All","0"));
					
					equip.EnableDefaultFiltration = true;
					equip.iTypeId = Convert.ToInt32(ddlEquipTypes.SelectedValue);
					equip.iDeptId = Convert.ToInt32(ddlDepartments.SelectedValue);
					equip.iLocId = Convert.ToInt32(ddlLocations.SelectedValue);
					equip.iOrderId = OrderId; 
					equip.sEquipId_Filter = _functions.ConvertToSQLFilter(tbEquipId.Text);

					dtMain = equip.GetEquipList_ForSpare();
						
					ddlEquipTypes.SelectedValue = equip.iTypeId.Value.ToString();

					ShowList();
					
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = m_sLastPage;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(loc != null)
					loc.Dispose();
				if(dep != null)
					dep.Dispose();
				if(order != null)
					order.Dispose();
				if(equip != null)
					equip.Dispose();
			}
		}

		#region Showing Equipments List
		private void ShowList()
		{
			try
			{
				DataColumn _BackColumn = new DataColumn("Back");
				_BackColumn.DefaultValue = sBack;
				dtMain.Columns.Add(_BackColumn);
				
				dgMainList.Controls.Clear();
				dgMainList.DataSource = new DataView(dtMain);
				dgMainList.DataBind();
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally
			{
			}
		}
		#endregion

		#region Next Screen
		private void btNext_FormSubmit(object sender, EventArgs e)
		{
			try
			{
				if(ViewState["Operation"] == null)
				{
					switch(sBack)
					{
						case "open":
							Response.Redirect("wo_openWorkOrder.aspx?id=" + OrderId.ToString(), false);
							break;
						case "edit":
							Response.Redirect("wo_editWorkOrder.aspx?id=" + OrderId.ToString(), false);
							break;
						case "checkin":
							Response.Redirect("wo_viewCheckIn.aspx?id=" + OrderId.ToString(), false);
							break;
						default:
							Response.Redirect("wo_addRepairs.aspx?id=" + OrderId.ToString(), false);
							break;
					}
				}
				else
				{
					BackFinishScreen finish = new BackFinishScreen();
					finish.sMainText = "The Roadside Repair Work Order has been created successfully!";
					
					finish.bMainMenuVisible = true;
					finish.sMainMenuText = "[Return to Main Menu]";
					finish.sMainMenuURL = "main.aspx";

					finish.bContinueVisible = true;
					finish.sContinueText = "[Continue to Check-In Equipment by Technician]";
					finish.sContinueURL = "wo_viewCheckIn.aspx?id=" + OrderId.ToString();

					finish.bViewVisible = true;
					finish.sViewText = "[View the Scheduled Work Order]";
					finish.sViewURL = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();

					finish.bAdditionalVisible = true;
					finish.sAdditionalText = "[Create a New Work Order]";
					finish.sAdditionalURL = "wo_default.aspx?select=AddRoadside";

					finish.bPrintVisible = false;

					Session["BackFinish"] = finish;

					Response.Redirect("wo_finish.aspx", false);	
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_selectSpareEquip.aspx?id=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}
		}
		#endregion

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			this.NextBackControl.BubbleClick += new EventHandler(this.btNext_FormSubmit);
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.lbCheckInSpare.Click += new System.EventHandler(this.lbCheckInSpare_Click);
			this.btnFiltration.Click += new System.EventHandler(this.btnFiltration_Click);
			this.dgMainList.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgMainList_ItemCommand);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void btnFiltration_Click(object sender, System.EventArgs e)
		{
			try
			{
				equip = new clsEquipment();
				
				equip.EnableDefaultFiltration = false;
				equip.iOrgId = OrgId;
				equip.iTypeId = Convert.ToInt32(ddlEquipTypes.SelectedValue);
				equip.iDeptId = Convert.ToInt32(ddlDepartments.SelectedValue);
				equip.iLocId = Convert.ToInt32(ddlLocations.SelectedValue);
				equip.iOrderId = OrderId;
				equip.sEquipId_Filter = _functions.ConvertToSQLFilter(tbEquipId.Text);
				dtMain = equip.GetEquipList_ForSpare();
				ShowList();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_selectSpareEquip.aspx?id=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
					equip.Dispose();
			}		
		}

		private void dgMainList_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				if(e.CommandName == "Select")
				{
					SpareId = Convert.ToInt32(e.CommandArgument);

					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
					equip.iId = SpareId;
					equip.iOrderId = OrderId;
					equip.sNote = "checking out the spare equipment";
					if(equip.EquipSpareTo(false) == -1)
					{
						Session["lastpage"] = m_sLastPage;
						Session["error"] = _functions.ErrorMessage(120);
						Response.Redirect("error.aspx", false);
					}
					else
					{
						if(ViewState["Operation"] == null)
						{
							switch(sBack)
							{
								case "open":
									Response.Redirect("wo_openWorkOrder.aspx?id=" + OrderId.ToString(), false);
									break;
								case "edit":
									Response.Redirect("wo_editWorkOrder.aspx?id=" + OrderId.ToString(), false);
									break;
								case "checkin":
									Response.Redirect("wo_viewCheckIn.aspx?id=" + OrderId.ToString(), false);
									break;
								default:
									Response.Redirect("wo_addRepairs.aspx?id=" + OrderId.ToString(), false);
									break;
							}
						}
						else
						{
							BackFinishScreen finish = new BackFinishScreen();
							finish.sMainText = "The Roadside Repair Work Order has been created successfully!";
					
							finish.bMainMenuVisible = true;
							finish.sMainMenuText = "[Return to Main Menu]";
							finish.sMainMenuURL = "main.aspx";

							finish.bContinueVisible = true;
							finish.sContinueText = "[Continue to Check-In Equipment by Technician]";
							finish.sContinueURL = "wo_viewCheckIn.aspx?id=" + OrderId.ToString();

							finish.bViewVisible = true;
							finish.sViewText = "[View the Scheduled Work Order]";
							finish.sViewURL = "wo_viewWorkOrder.aspx?id=" + OrderId.ToString();

							finish.bAdditionalVisible = true;
							finish.sAdditionalText = "[Create a New Work Order]";
							finish.sAdditionalURL = "wo_default.aspx?select=AddRoadside";

							finish.bPrintVisible = false;

							Session["BackFinish"] = finish;

							Response.Redirect("wo_finish.aspx", false);	
						}
					}

				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_selectSpareEquip.aspx?id=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
					equip.Dispose();
			}		
		}

		private void lbCheckInSpare_Click(object sender, System.EventArgs e)
		{
			try
			{
				equip = new clsEquipment();
				equip.iOrgId = OrgId;
				equip.iUserId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, true);
				equip.iId = 0;
				equip.iOrderId = OrderId;
				equip.sNote = "checking in the spare equipment";
				if(equip.EquipSpareTo(false) == -1)
				{
					Session["lastpage"] = m_sLastPage;
					Session["error"] = _functions.ErrorMessage(120);
					Response.Redirect("error.aspx", false);
				}
				else
				{
					switch(sBack)
					{
						case "open":
							Response.Redirect("wo_openWorkOrder.aspx?id=" + OrderId.ToString(), false);
							break;
						case "edit":
							Response.Redirect("wo_editWorkOrder.aspx?id=" + OrderId.ToString(), false);
							break;
						case "checkin":
							Response.Redirect("wo_viewCheckIn.aspx?id=" + OrderId.ToString(), false);
							break;
						default:
							Response.Redirect("wo_addRepairs.aspx?id=" + OrderId.ToString(), false);
							break;
					}
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "wo_selectSpareEquip.aspx?id=" + OrderId.ToString() + "&equipid=" + EquipId.ToString();
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
					equip.Dispose();
			}		
		}
	}
}
