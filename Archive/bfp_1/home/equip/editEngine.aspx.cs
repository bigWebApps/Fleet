using System;
using System.Data;
using System.Data.SqlClient;
using BWA.BFP.Data;

namespace BWA.BFP.Web.home.equip
{
	public class editEngine : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.DropDownList ddMake;
		protected System.Web.UI.WebControls.DropDownList ddModel;
		protected System.Web.UI.WebControls.TextBox tbPartNum;
		protected System.Web.UI.WebControls.TextBox tbSerialNum;
		int EquipId;
		protected MetaBuilders.WebControls.ListLink ListLink1;
		protected System.Web.UI.WebControls.Label lbLastUpdate;
		DbObject dbobj = new DbObject();

		#region PageLoad
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
			PageTitle = "Equipment-Edit Engine";
			Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
			Header.PageTitle=PageTitle;
			SaveCancelControl.ParentPageURL=ParentPageURL;

			#region If Not Postback
			if(!Page.IsPostBack)//Not Postback
			{	
				if(EquipId!=0) //Look up existing values
				{
					SqlParameter[] parameters = {
						new SqlParameter("@Action",SqlDbType.Char,1,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,"S"),
						new SqlParameter("@UId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,UId),
						new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
						new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
						new SqlParameter("@MakeId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@ModelId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@vchPart",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@vchSerial",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@vchUpdatedBy",SqlDbType.VarChar,100,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@dtUpdated",SqlDbType.DateTime,8,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null)
					};
					int returnValue;
					SqlCommand cmd;
					DataSet dsobj=dbobj.dsRunProcedure("sp_EquipEngineDetail",parameters,out returnValue,"Engine",out cmd);
					
					if(returnValue!=-1) {
						tbPartNum.Text=cmd.Parameters["@vchPart"].Value.ToString();
						tbSerialNum.Text=cmd.Parameters["@vchSerial"].Value.ToString();
						lbLastUpdate.Text=cmd.Parameters["@vchUpdatedBy"].Value.ToString()+" "+cmd.Parameters["@dtUpdated"].Value.ToString()+" UTC";

						dsobj.Relations.Add(new DataRelation("Makes_Models", dsobj.Tables["Engine"].Columns["Id"],dsobj.Tables["Engine1"].Columns["MakeId"] ) );

						ddMake.DataSource = dsobj;
						ddMake.DataMember = "Engine";
						ddMake.DataValueField = "id";
						ddMake.DataTextField = "vchName";
						ddMake.DataBind();
						ddMake.Items.Insert(0,"");
						ddMake.SelectedValue=cmd.Parameters["@MakeId"].Value.ToString();
						
						ddModel.DataSource = dsobj;
						ddModel.DataMember = "Engine1";
						ddModel.DataValueField = "id";
						ddModel.DataTextField = "vchName";
						ddModel.DataBind();
						ddModel.Items.Insert(0,"");
						ddModel.SelectedValue=cmd.Parameters["@ModelId"].Value.ToString();

						ListLink1.DataBind();

					}
					else { //record not found
						//Response.Redirect("list.aspx");
					}
				} 
			}//End Not Postback
			#endregion
		}
		#endregion
		#region btSave_FormSubmit
		private void btSave_FormSubmit(object sender, EventArgs e) {
			
			SqlParameter ParamModelId = new SqlParameter("@ModelId",SqlDbType.Int);
			if(ddModel.SelectedIndex==0){
				ParamModelId.Value=null;}
			else{
				ParamModelId.Value=ddModel.SelectedValue;}

			SqlParameter[] parameters = {
				new SqlParameter("@Action",SqlDbType.Char,1,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,"U"),
				new SqlParameter("@UId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,UId),
				new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
				new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
				ParamModelId,
				new SqlParameter("@vchPart",SqlDbType.VarChar,25,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbPartNum.Text),
				new SqlParameter("@vchSerial",SqlDbType.VarChar,25,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbSerialNum.Text)
			};

			dbobj.RunProcedure("sp_EquipEngineDetail",parameters);
			
			Response.Redirect("view.aspx?id="+EquipId+"");
		}
		#endregion	
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
