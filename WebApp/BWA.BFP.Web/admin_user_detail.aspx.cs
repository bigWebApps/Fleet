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
	public class _admin_user_detail : BFPPage
	{
		protected System.Web.UI.WebControls.HyperLink hlUserEdit;
		protected System.Web.UI.WebControls.Label lblFirstName;
		protected System.Web.UI.WebControls.Label lblLastName;
		protected System.Web.UI.WebControls.Label lblEmail;
		protected System.Web.UI.WebControls.Label lblType;
		protected System.Web.UI.WebControls.DataGrid dgGroups;
		protected System.Web.UI.WebControls.Label lblCreatedDate;
		protected System.Web.UI.WebControls.Label lblBack;
		protected System.Web.UI.WebControls.Label lblUserActivateStatus;
		protected System.Web.UI.WebControls.DataGrid dgEquipments;
		protected System.Web.UI.WebControls.Label lblHourlyRate;

		public int UserId;
		private clsUsers user = null;
		private clsEquipment equip = null;
	
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				SourcePageName = "admin_user_detail.aspx.cs";

				Header.MainMenuSelectedItem = "Administration";
				Header.AddBreadCrumb("Home", "/selectMode.aspx");
				Header.AddBreadCrumb("Administration", "/admin.aspx");
				Header.AddBreadCrumb("User Search", "/admin_users.aspx");
				this.PageTitle = "User Detail";
				Header.LeftBarHtml = "View User Detail";

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
			string sBackPage;
			try
			{
				OrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);

				if(Request.QueryString["id"] == null)
				{
					Session["lastpage"] = "admin_users.aspx";
					Session["error"] = _functions.ErrorMessage(104);
					Response.Redirect("error.aspx", false);
					return;
				}
				try
				{
					UserId = Convert.ToInt32(Request.QueryString["id"]);
				}
				catch(FormatException fex)
				{
					Session["lastpage"] = "admin_users.aspx";
					Session["error"] = _functions.ErrorMessage(105);
					Response.Redirect("error.aspx", false);
					return;
				}
				lblBack.Text = "<input type=button value=\" Back \" onclick=\"document.location='admin_users.aspx'\">";
				if(!IsPostBack)
				{
					hlUserEdit.NavigateUrl = "admin_user_detail_edit.aspx?id=" + UserId.ToString();
					user = new clsUsers();
					user.cAction = "S";
					user.iOrgId = OrgId;
					user.iId = UserId;
					if(user.UserDetails() == -1)
					{
						Session["lastpage"] = "admin_user_detail.aspx?id=" + UserId.ToString();
						Session["error"] = _functions.ErrorMessage(134);
						Response.Redirect("error.aspx", false);
						return;
					}
					lblFirstName.Text = user.sFirstName.Value;
					lblLastName.Text = user.sLastName.Value;
					lblType.Text = user.sTypeName.Value;
					lblEmail.Text = user.sEmail.Value;
					lblHourlyRate.Text = user.dmHourlyRate.Value.ToString("C");
					lblCreatedDate.Text = user.daCreated.Value.ToLongDateString() + " " + user.daCreated.Value.ToLongTimeString();
					if(user.bActiveStatus.Value)
					{
						lblUserActivateStatus.Text = "Activated";
					}
					else
					{
						lblUserActivateStatus.Text = "Deactivated";
					}
					dgGroups.DataSource = new DataView(user.GetUserGroupsList());
					dgGroups.DataBind();
					equip = new clsEquipment();
					equip.iOrgId = OrgId;
					equip.iUserId = UserId;
					dgEquipments.DataSource = new DataView(equip.GetEquipListByUser());
					dgEquipments.DataBind();
				}
				
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
				Session["lastpage"] = "admin_users.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
				if(equip != null)
					equip.Dispose();
				if(user != null)
					user.Dispose();
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
