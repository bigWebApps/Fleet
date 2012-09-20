using System;
using System.Data;
using System.Data.SqlClient;
using BWA.BFP.Data;

namespace BWA.BFP.Web.home.equip
{
	/// <summary>
	/// Summary description for _default.
	/// </summary>
	public class _edit : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected MetaBuilders.WebControls.ListLink ListLink1;
		protected MetaBuilders.WebControls.ListLink ListLink2;
		protected System.Web.UI.WebControls.DropDownList ddTypeId;
		protected System.Web.UI.WebControls.DropDownList ddMakeId;
		protected System.Web.UI.WebControls.DropDownList ddModelId;
		protected System.Web.UI.WebControls.DropDownList ddDeptId;
		protected System.Web.UI.WebControls.DropDownList ddLocationId;
		protected System.Web.UI.WebControls.TextBox tbYear;
		protected System.Web.UI.WebControls.TextBox tbEquipId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvEquipId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvTypeId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvMakeId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvModelId;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvYear;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvDepartment;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvLocation;
		protected System.Web.UI.WebControls.Label lbAssignedTo;
		protected System.Web.UI.WebControls.TextBox tbVinSerial;
		protected System.Web.UI.WebControls.CheckBox ckReassign;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.TextBox tbFuelCode;
		protected System.Web.UI.WebControls.Label lbAssignedToCap;
		protected System.Web.UI.WebControls.Label lbReassignCap;
		protected System.Web.UI.WebControls.Label lbReassignHelp;
		int EquipId;
		
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			EquipId=Convert.ToInt32(Request.QueryString["id"]);
			
			if(EquipId==0){ //Add New
				string [,] arrBrdCrumbs = new string [2,2];
				arrBrdCrumbs[0,0]="../default.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="list.aspx";
				arrBrdCrumbs[1,1]="Equipment List";
				PageTitle = "Add Equipment";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;

				ckReassign.Visible=false;
				lbAssignedToCap.Visible=false;
				lbReassignCap.Visible=false;
				lbReassignHelp.Visible=false;

			}else{
				string [,] arrBrdCrumbs = new string [3,2];
				arrBrdCrumbs[0,0]="../default.aspx";
				arrBrdCrumbs[0,1]="Home";
				arrBrdCrumbs[1,0]="list.aspx";
				arrBrdCrumbs[1,1]="Equipment List";
				arrBrdCrumbs[2,0]="view.aspx?id="+EquipId+"";
				arrBrdCrumbs[2,1]="Equipment Detail";
				PageTitle = "Equipment-Edit Main";
				Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
				Header.PageTitle=PageTitle;
			}
			SaveCancelControl.ParentPageURL=ParentPageURL;
			#region Not Postback
			if(!Page.IsPostBack)//Not Postback
			{	
				DbObject dbobj1 = new DbObject();
				if(EquipId!=0) //Look up existing values
				{
					//Lookup current DB values
					
					
					SqlParameter[] parameters = 
					{
						new SqlParameter("@Action",SqlDbType.Char,1,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,"S"),
						new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
						new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
						new SqlParameter("@TypeId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@MakeId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@ModelId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@vchEquipId",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@intYear",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@DeptId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@LocId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@vchAssignedTo",SqlDbType.VarChar,100,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@vchVinSerial",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@vchFuelCode",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null)
					};
					int returnValue;
					//SqlCommand cmd = dbobj1.cmdRunProcedure("sp_SelectEquipDetail",parameters,out returnValue);
					SqlCommand cmd = dbobj1.cmdRunProcedure("sp_EquipEditDetail",parameters,out returnValue);
					
					if(returnValue!=-1)
					{
						ddTypeId.SelectedValue=cmd.Parameters["@TypeId"].Value.ToString();
						ddMakeId.SelectedValue=cmd.Parameters["@MakeId"].Value.ToString();
						ddModelId.SelectedValue=cmd.Parameters["@ModelId"].Value.ToString();
						tbEquipId.Text=cmd.Parameters["@vchEquipId"].Value.ToString();
						tbYear.Text=cmd.Parameters["@intYear"].Value.ToString();
						ddDeptId.SelectedValue=cmd.Parameters["@DeptId"].Value.ToString();
						ddLocationId.SelectedValue=cmd.Parameters["@LocId"].Value.ToString();
						lbAssignedTo.Text=cmd.Parameters["@vchAssignedTo"].Value.ToString();
						tbVinSerial.Text=cmd.Parameters["@vchVinSerial"].Value.ToString();
						tbFuelCode.Text=cmd.Parameters["@vchFuelCode"].Value.ToString();
					}
					else //record not found
					{
						Response.Redirect("list.aspx");
					}
				} //End looking up current values
				BindData(dbobj1);
			}//End Not Postback
			#endregion
		} //End Page_Load
		#region btSave_FormSubmit
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			EquipId=Convert.ToInt32(Request.QueryString["id"]);
			bool AddNew=false;
			if(EquipId==0){
				AddNew=true;
			}
			DbObject dbobj1 = new DbObject();
			SqlParameter[] parameters = 
			{
				new SqlParameter("@Action",SqlDbType.Char,1,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,"U"),
				new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
				new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
				new SqlParameter("@TypeId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,ddTypeId.SelectedValue),
				new SqlParameter("@MakeId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,ddMakeId.SelectedValue),
				new SqlParameter("@ModelId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,ddModelId.SelectedValue),
				new SqlParameter("@DeptId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,ddDeptId.SelectedValue),
				new SqlParameter("@LocId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,ddLocationId.SelectedValue),
				new SqlParameter("@intYear",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbYear.Text),
				new SqlParameter("@vchEquipId",SqlDbType.VarChar,25,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbEquipId.Text),
				new SqlParameter("@vchVinSerial",SqlDbType.VarChar,50,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbVinSerial.Text),
				new SqlParameter("@vchFuelCode",SqlDbType.VarChar,25,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbFuelCode.Text)
			};
			
			EquipId = dbobj1.intRunProcedure("sp_EquipEditDetail",parameters);
			
			if(ckReassign.Checked | AddNew==true){
				Response.Redirect("reassign.aspx?id="+EquipId+"");
				}
			else{
				Response.Redirect("view.aspx?id="+EquipId+"");
				}
		}
		#endregion
		#region BindData
		private void BindData(DbObject dbobj)
		{
			DataSet dsobj = new DataSet();

			SqlParameter[] parameters2 = {	
				new SqlParameter("@OrgId",SqlDbType.Int)
				};
			parameters2[0].Value = OrgId;

			dsobj=dbobj.dsRunProcedure("sp_SelectEquipTypesMakesModels",parameters2,"Types");
		
			dsobj.Relations.Add( new DataRelation( "Types_Makes", dsobj.Tables["Types"].Columns["Id"], dsobj.Tables["Types1"].Columns["TypeId"] ) );
			dsobj.Relations.Add( new DataRelation( "Makes_Models", dsobj.Tables["Types1"].Columns["Id"], dsobj.Tables["Types2"].Columns["MakeId"] ) );

			ddTypeId.DataSource = dsobj;
			ddTypeId.DataMember = "Types";
			ddTypeId.DataValueField = "id";
			ddTypeId.DataTextField = "vchName";
			ddTypeId.DataBind();
			ddTypeId.Items.Insert(0,"");

			ddMakeId.DataSource = dsobj;
			ddMakeId.DataMember = "Types1";
			ddMakeId.DataValueField = "id";
			ddMakeId.DataTextField = "vchMakeName";
			ddMakeId.DataBind();
			ddMakeId.Items.Insert(0,"");

			ddModelId.DataSource = dsobj;
			ddModelId.DataMember = "Types2";
			ddModelId.DataValueField = "id";
			ddModelId.DataTextField = "vchModelName";
			ddModelId.DataBind();
			ddModelId.Items.Insert(0,"");

			ddDeptId.DataSource = dsobj;
			ddDeptId.DataMember = "Types3";
			ddDeptId.DataValueField = "id";
			ddDeptId.DataTextField = "vchName";
			ddDeptId.DataBind();
			ddDeptId.Items.Insert(0,"");

			ddLocationId.DataSource = dsobj;
			ddLocationId.DataMember = "Types4";
			ddLocationId.DataValueField = "id";
			ddLocationId.DataTextField = "vchName";
			ddLocationId.DataBind();
			ddLocationId.Items.Insert(0,"");
			
			ListLink1.DataBind();
			ListLink2.DataBind();

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
