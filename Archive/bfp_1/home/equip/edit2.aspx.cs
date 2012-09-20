using System;
using System.Data;
using System.Data.SqlClient;
using BWA.BFP.Data;

namespace BWA.BFP.Web.home.equip
{
	/// <summary>
	/// Summary description for _default.
	/// </summary>
	public class _edit2 : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		int EquipId;
		protected System.Web.UI.WebControls.DropDownList ddStatusId;
		protected System.Web.UI.WebControls.TextBox tbCurrentUnits;
		protected System.Web.UI.WebControls.DropDownList ddPMScheduleId;
		protected System.Web.UI.WebControls.DropDownList ddInspectionId;
		DbObject dbobj1 = new DbObject();
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			EquipId=Convert.ToInt32(Request.QueryString["id"]);
			
			string [,] arrBrdCrumbs = new string [3,2];
			arrBrdCrumbs[0,0]="../default.aspx";
			arrBrdCrumbs[0,1]="Home";
			arrBrdCrumbs[1,0]="list.aspx";
			arrBrdCrumbs[1,1]="Equipment List";
			arrBrdCrumbs[2,0]="view.aspx?id="+EquipId+"";
			arrBrdCrumbs[2,1]="Equipment Detail";
			PageTitle = "Equipment-Edit Alt";
			Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
			Header.PageTitle=PageTitle;
			SaveCancelControl.ParentPageURL=ParentPageURL;

			if(!Page.IsPostBack)//Not Postback
			{	
				if(EquipId!=0) //Look up existing values
				{
					BindData(dbobj1);
					
					SqlParameter[] parameters = 
					{
						new SqlParameter("@Action",SqlDbType.Char,1,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,"S"),
						new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
						new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
						new SqlParameter("@StatusId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@PMScheduleId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@InspectionId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@intCurrentUnits",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null)
					};
					int returnValue;
					SqlCommand cmd = dbobj1.cmdRunProcedure("sp_EquipAltDetail",parameters,out returnValue);
					if(returnValue!=-1)
					{
						ddStatusId.SelectedValue=cmd.Parameters["@StatusId"].Value.ToString();
						ddPMScheduleId.SelectedValue=cmd.Parameters["@PMScheduleId"].Value.ToString();
						ddInspectionId.SelectedValue=cmd.Parameters["@InspectionId"].Value.ToString();
						tbCurrentUnits.Text=cmd.Parameters["@intCurrentUnits"].Value.ToString();
					}
					else //record not found
					{
						Response.Redirect("edit.aspx?id=0");
					}
				} //End looking up current values or setting current values to 0.
			}//End Not Postback
		
			
		} //End Page_Load
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			
			SqlParameter[] parameters = 
			{
				new SqlParameter("@Action",SqlDbType.Char,1,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,"U"),
				new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
				new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
				new SqlParameter("@StatusId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,ddStatusId.SelectedValue),
				new SqlParameter("@PMScheduleId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,ddPMScheduleId.SelectedValue),
				new SqlParameter("@InspectionId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,ddInspectionId.SelectedValue),
				new SqlParameter("@intCurrentUnits",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbCurrentUnits.Text)
			};
			dbobj1.intRunProcedure("sp_EquipAltDetail",parameters);
			
			Response.Redirect("view.aspx?id="+EquipId+"");
			
		}
		private void BindData(DbObject dbobj)
		{
			DataSet dsobj = new DataSet();

			SqlParameter[] parameters2 = 
			{	
				new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
			};
			dsobj=dbobj.dsRunProcedure("sp_SelectEquipAltLists",parameters2,"Lists");
		
			ddStatusId.DataSource = dsobj;
			ddStatusId.DataMember = "Lists";
			ddStatusId.DataValueField = "id";
			ddStatusId.DataTextField = "vchName";
			ddStatusId.DataBind();
			
			ddPMScheduleId.DataSource = dsobj;
			ddPMScheduleId.DataMember = "Lists1";
			ddPMScheduleId.DataValueField = "id";
			ddPMScheduleId.DataTextField = "vchName";
			ddPMScheduleId.DataBind();
			ddPMScheduleId.Items.Insert(0,"");

			ddInspectionId.DataSource = dsobj;
			ddInspectionId.DataMember = "Lists2";
			ddInspectionId.DataValueField = "id";
			ddInspectionId.DataTextField = "vchName";
			ddInspectionId.DataBind();
			ddInspectionId.Items.Insert(0,"");


		}
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			base.OnInit(e);
			InitializeComponent();
			SaveCancelControl.BubbleClick += new EventHandler(btSave_FormSubmit);
		}
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
