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
	public class _admin_inspections : BFPPage
	{
		protected System.Web.UI.WebControls.TextBox tbInspectionName;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvInspectionName;
		protected Micajah.DataGrid.DataGrid_A dgInspections;
		protected System.Web.UI.WebControls.Button btnAddInspection;

		private clsInspections inspect = null;

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_inspections.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.LeftBarHtml = "Add/Edit/Delete Inspection";
				this.PageTitle = "Inspections Manager";
				
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

				if(!IsPostBack)
				{
					inspect = new clsInspections();
					inspect.iOrgId = OrgId;
					ShowInspections();
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = this.ParentPageURL;
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(inspect != null)
					inspect.Dispose();
			}
		}

		private void ShowInspections()
		{
			try
			{	 
				dgInspections.DataSource = new DataView(inspect.GetInspectionsList());
				dgInspections.DataBind();
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
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
			this.dgInspections.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dgInspections_ItemCommand);
			this.btnAddInspection.Click += new System.EventHandler(this.btnAddInspection_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void dgInspections_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			try
			{
				inspect = new clsInspections();
				inspect.iOrgId = OrgId;
				inspect.iId = Convert.ToInt32(e.Item.Cells[0].Text);
				switch(e.CommandName)
				{
					case "Delete":
						inspect.cAction = "D";
						switch(inspect.InspectionDetails())
						{
							case -1:
								Session["lastpage"] = "admin_inspections.aspx";
								Session["error"] = _functions.ErrorMessage(124);
								Response.Redirect("error.aspx", false);
								return;
							case 1:
								Header.ErrorMessage = _functions.ErrorMessage(154);
								break;
							case 2:
								Header.ErrorMessage = _functions.ErrorMessage(155);
								break;
							case 0:
								dgInspections.EditItemIndex = -1;
								ShowInspections();
								break;
							default:
								break;
						}
						break;
					case "Cancel":
						dgInspections.EditItemIndex = -1;
						ShowInspections();
						break;
					case "Edit":
						dgInspections.EditItemIndex = e.Item.ItemIndex;
						ShowInspections();
						break;
					case "Update":
						inspect.cAction = "U"; 
						inspect.sInspectionName = ((TextBox)e.Item.FindControl("tbNameEdit")).Text;
						if(inspect.InspectionDetails() == -1)
						{
							Session["lastpage"] = "admin_inspections.aspx";
							Session["error"] = _functions.ErrorMessage(124);
							Response.Redirect("error.aspx", false);
							return;
						}
						dgInspections.EditItemIndex = -1;
						ShowInspections();
						break;
					default:
						break;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_inspections.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(inspect != null)
					inspect.Dispose();
			}
		}

		private void btnAddInspection_Click(object sender, System.EventArgs e)
		{
			try
			{
				inspect = new clsInspections();
				inspect.iOrgId = OrgId;
				inspect.iId = 0;
				inspect.cAction = "U"; 
				inspect.sInspectionName = tbInspectionName.Text;
				tbInspectionName.Text = "";
				if(inspect.InspectionDetails() == -1)
				{
					Session["lastpage"] = "admin_inspections.aspx";
					Session["error"] = _functions.ErrorMessage(124);
					Response.Redirect("error.aspx", false);
					return;
				}
				ShowInspections();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_inspections.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(inspect != null)
					inspect.Dispose();
			}		
		}
	}
}
