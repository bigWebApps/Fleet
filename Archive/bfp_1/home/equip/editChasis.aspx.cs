using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using BWA.BFP.Data;


namespace BWA.BFP.Web.home.equip
{
	/// <summary>
	/// Summary description for editChasis.
	/// </summary>
	public class editChasis : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected BWA.BFP.Web.Controls.User.SaveCancel SaveCancelControl;

		protected System.Web.UI.WebControls.DropDownList ddChasisMake;
		protected System.Web.UI.WebControls.TextBox tbChasisNum;
		protected System.Web.UI.WebControls.Label lbLastUpdate;

		DbObject dbobj = new DbObject();

		public int EquipId;
	
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
			PageTitle = "Chasis-Edit Engine";
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
													new SqlParameter("@ChasisMakeId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
													new SqlParameter("@vchChasisNumber",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
													new SqlParameter("@vchChasisUpdatedBy",SqlDbType.VarChar,100,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
													new SqlParameter("@dtChasisUpdated",SqlDbType.DateTime,8,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null)
												};
					int returnValue;
					SqlCommand cmd;
					DataSet dsobj=dbobj.dsRunProcedure("sp_EquipChasisDetail",parameters,out returnValue,"Chasis",out cmd);
					
					if(returnValue!=-1) 
					{
						tbChasisNum.Text=cmd.Parameters["@vchChasisNumber"].Value.ToString();
						lbLastUpdate.Text=cmd.Parameters["@vchChasisUpdatedBy"].Value.ToString()+" "+cmd.Parameters["@dtChasisUpdated"].Value.ToString()+" UTC";

						ddChasisMake.DataSource = dsobj;
						ddChasisMake.DataMember = "Chasis";
						
						ddChasisMake.DataValueField = "id";
						ddChasisMake.DataTextField = "vchName";
						ddChasisMake.DataBind();
						ddChasisMake.Items.Insert(0,"");
						ddChasisMake.SelectedValue=cmd.Parameters["@ChasisMakeId"].Value.ToString();

						//I think that the ListLink is needless here because we have one tables - EquipChasisMakes


					}
					else 
					{ //record not found
						//Response.Redirect("list.aspx");
					}
				}
			}//End Not Postback
			#endregion
		}
		#endregion	
		#region btSave_FormSubmit
		private void btSave_FormSubmit(object sender, EventArgs e) 
		{
			
			SqlParameter ParamMakeId = new SqlParameter("@ChasisMakeId",SqlDbType.Int);
			if(ddChasisMake.SelectedIndex==0)
			{
				ParamMakeId.Value=null;}
			else
			{
				ParamMakeId.Value=ddChasisMake.SelectedValue;}

			SqlParameter[] parameters = {
											new SqlParameter("@Action",SqlDbType.Char,1,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,"U"),
											new SqlParameter("@UId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,UId),
											new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
											new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
											ParamMakeId,
											new SqlParameter("@vchChasisNumber",SqlDbType.VarChar,25,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,tbChasisNum.Text),
										};

			dbobj.RunProcedure("sp_EquipChasisDetail",parameters);
			
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
