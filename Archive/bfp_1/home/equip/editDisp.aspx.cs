using System;
using System.Data;
using System.Data.SqlClient;
using BWA.BFP.Data;

namespace BWA.BFP.Web.home.equip
{
	public class _editDisp : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;
		protected System.Web.UI.WebControls.TextBox tbAmount;
		protected System.Web.UI.WebControls.TextBox tbUnits;
		protected System.Web.UI.WebControls.TextBox tbNotes;
		protected System.Web.UI.WebControls.RegularExpressionValidator valAmount;
		protected System.Web.UI.WebControls.RangeValidator valRangeUnits;
		protected System.Web.UI.WebControls.RegularExpressionValidator valRegExpUnits;
		int EquipId;
		protected System.Web.UI.WebControls.TextBox tbOrgContact;
		protected ActiveUp.WebControls.ActiveDateTime adtOutOfService;
		protected ActiveUp.WebControls.ActiveDateTime adtDisposed;
		protected System.Web.UI.WebControls.DropDownList ddMethod;
		DbObject dbobj = new DbObject();
		
		#region Page_Load
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
			PageTitle = "Equipment-Edit Disposal Info";
			Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
			Header.PageTitle=PageTitle;
			SaveCancelControl.ParentPageURL=ParentPageURL;

			#region If Not Postback
			if(!Page.IsPostBack)//Not Postback
			{	
				if(EquipId!=0) //Look up existing values
				{
					
					SqlParameter[] parameters = 
					{
						new SqlParameter("@Action",SqlDbType.Char,1,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,"S"),
						new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
						new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
						new SqlParameter("@dtOutOfService",SqlDbType.SmallDateTime,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@dtDisposed",SqlDbType.SmallDateTime,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@vchOrgContact",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@smAmount",SqlDbType.SmallMoney,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@intUnits",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@vchNotes",SqlDbType.VarChar,250,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
						new SqlParameter("@intMethod",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null)
					};
					
					int returnValue;
					SqlCommand cmd;
					DataSet dsobj = dbobj.dsRunProcedure("sp_EquipDispDetail",parameters,out returnValue,"Disp",out cmd);
					
					if(returnValue!=-1){
						if(!System.DBNull.Value.Equals(cmd.Parameters["@dtOutOfService"].Value)){
							adtOutOfService.Date=System.DateTime.Parse(cmd.Parameters["@dtOutOfService"].Value.ToString());
							}
						if(!System.DBNull.Value.Equals(cmd.Parameters["@dtDisposed"].Value)){
							adtDisposed.Date=System.DateTime.Parse(cmd.Parameters["@dtDisposed"].Value.ToString());
							}
						tbAmount.Text=String.Format("{0:0.00}",cmd.Parameters["@smAmount"].Value);
						tbUnits.Text=cmd.Parameters["@intUnits"].Value.ToString();
						tbOrgContact.Text=cmd.Parameters["@vchOrgContact"].Value.ToString();
						tbNotes.Text=cmd.Parameters["@vchNotes"].Value.ToString();

						ddMethod.DataSource = dsobj;
						ddMethod.DataMember = "Disp";
						ddMethod.DataValueField = "id";
						ddMethod.DataTextField = "vchName";
						ddMethod.DataBind();
						ddMethod.Items.Insert(0,"");
						ddMethod.SelectedValue=cmd.Parameters["@intMethod"].Value.ToString();

						}
					else { //record not found
						Response.Redirect("list.aspx?id=0");
						}
				} 
			}//End Not Postback
			#endregion
		} //End Page_Load
		#endregion
		#region btSave_FormSubmit
		private void btSave_FormSubmit(object sender, EventArgs e)
		{
			SqlParameter ParamDtOutOfService = new SqlParameter("@dtOutOfService",SqlDbType.SmallDateTime);
				if(adtOutOfService.Date.Year==1){
					ParamDtOutOfService.Value=null;}
				else{
					ParamDtOutOfService.Value=adtOutOfService.Date;}
			SqlParameter ParamDtDisposed = new SqlParameter("@dtDisposed",SqlDbType.SmallDateTime);
				if(adtDisposed.Date.Year==1){
					ParamDtDisposed.Value=null;}
				else{
					ParamDtDisposed.Value=adtDisposed.Date;}
			SqlParameter ParamSmAmount = new SqlParameter("@smAmount",SqlDbType.SmallMoney);
				if(tbAmount.Text==""){
					ParamSmAmount.Value=null;}
				else {
					ParamSmAmount.Value=tbAmount.Text;}
			SqlParameter ParamIntUnits = new SqlParameter("@intUnits",SqlDbType.Int);
				if(tbUnits.Text==""){
					ParamIntUnits.Value=System.DBNull.Value;
					}
				else {
					ParamIntUnits.Value=tbUnits.Text;
					}
			SqlParameter ParamIntMethod = new SqlParameter("@intMethod",SqlDbType.Int);
				if(ddMethod.SelectedValue==""){
					ParamIntMethod.Value=System.DBNull.Value;			
				}
				else{
					ParamIntMethod.Value=ddMethod.SelectedValue;
				}
			SqlParameter[] parameters = 
			{
				new SqlParameter("@Action",SqlDbType.Char,1,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,"U"),
				new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
				new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
				ParamDtOutOfService,
				ParamDtDisposed,
				new SqlParameter("@vchOrgContact",SqlDbType.VarChar,50,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbOrgContact.Text),
				ParamSmAmount,
				ParamIntUnits,
				new SqlParameter("@vchNotes",SqlDbType.VarChar,250,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbNotes.Text),
				ParamIntMethod
				
			};

			dbobj.RunProcedure("sp_EquipDispDetail",parameters);
			
			
			Response.Redirect("view.aspx?id="+EquipId+"");
		}
		#endregion	
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e){
			base.OnInit(e);
			InitializeComponent();
			SaveCancelControl.BubbleClick += new EventHandler(btSave_FormSubmit);
			}
		private void InitializeComponent(){    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
