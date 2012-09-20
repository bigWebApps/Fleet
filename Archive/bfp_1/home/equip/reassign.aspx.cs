using System;
using System.Data;
using System.Data.SqlClient;
using BWA.BFP.Data;

namespace BWA.BFP.Web.home.equip
{
	public class _reassign : BFPPage
	{
		protected System.Web.UI.WebControls.Label lbEquipId;
		protected System.Web.UI.WebControls.Label lbTypeMakeModel;
		protected System.Web.UI.WebControls.Label lbYear;
		protected System.Web.UI.WebControls.Label lbAssignFrom;
		protected System.Web.UI.WebControls.DropDownList ddAssignTo;
		protected System.Web.UI.WebControls.TextBox tbNote;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvNote;
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		int EquipId;

		#region PageLoad
		private void Page_Load(object sender, System.EventArgs e)
		{	
			EquipId=Convert.ToInt32(Request.QueryString["id"]);
			
			PageTitle = "Reassign Equipment";
			string [,] arrBrdCrumbs = new string [3,2];
			arrBrdCrumbs[0,0]="../default.aspx";
			arrBrdCrumbs[0,1]="Home";
			arrBrdCrumbs[1,0]="list.aspx";
			arrBrdCrumbs[1,1]="Equipment List";
			arrBrdCrumbs[2,0]="view.aspx?id="+EquipId;
			arrBrdCrumbs[2,1]="Equipment Detail";
			Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
			Header.PageTitle="Reassign Equipment";
			SaveCancelControl.ParentPageURL=ParentPageURL;

			#region If Not Postback
			if(!Page.IsPostBack){
				LoadData();
				}
			#endregion	
		}
		#endregion
		private void LoadData()
		{
			int returnValue;
			SqlCommand cmd;

			SqlParameter[] parameters = 
			{
				new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
				new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
				new SqlParameter("@vchEquipId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@intYear",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchType",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchMake",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchModel",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchAssignedTo",SqlDbType.VarChar,100,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null)
			};
			DbObject dbobj = new DbObject();
			cmd = dbobj.cmdRunProcedure("sp_SelectEquipView",parameters,out returnValue);
			if(returnValue!=-1)
			{
				lbEquipId.Text=cmd.Parameters["@vchEquipId"].Value.ToString();
				lbTypeMakeModel.Text=cmd.Parameters["@vchType"].Value.ToString()+"/"+cmd.Parameters["@vchMake"].Value.ToString()+"/"+cmd.Parameters["@vchModel"].Value.ToString();
				lbYear.Text=cmd.Parameters["@intYear"].Value.ToString();
				lbAssignFrom.Text=cmd.Parameters["@vchAssignedTo"].Value.ToString();	
			}
			SqlParameter[] parameters2 = 
			{
				new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
				new SqlParameter("@EquipId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId)
			};
			DataSet dsobj=dbobj.dsRunProcedure("sp_SelectEquipAssignTo",parameters2,"Names");
			
			ddAssignTo.DataSource = dsobj;
			ddAssignTo.DataMember = "Names";
			ddAssignTo.DataValueField = "id";
			ddAssignTo.DataTextField = "vchName";
			ddAssignTo.DataBind();
			ddAssignTo.Items.Insert(0,new System.Web.UI.WebControls.ListItem("","0"));
		}
		
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			Trace.Write("btSave-UserId", UId.ToString());
			Trace.Write("btSave-SelectedValue",ddAssignTo.SelectedValue);

			SqlParameter[] parameters = 
			{
				new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
				new SqlParameter("@UID",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,UId),
				new SqlParameter("@EquipId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
				new SqlParameter("@intAssignedTo",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,ddAssignTo.SelectedValue),
				new SqlParameter("@vchNote",SqlDbType.VarChar,250,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbNote.Text)
			};
			DbObject dbobj1 = new DbObject();
			dbobj1.intRunProcedure("sp_UpdateEquipAssignedTo",parameters);

			Response.Redirect(ParentPageURL);
		}
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			base.OnInit(e);
			InitializeComponent();	
		}
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
			SaveCancelControl.BubbleClick += new EventHandler(btSave_FormSubmit);
		}
		#endregion
		
	}
}
