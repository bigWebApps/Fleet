using System;
using System.Data;
using System.Data.SqlClient;
using BWA.BFP.Data;

namespace BWA.BFP.Web.home.equip
{

	public class _view : BFPPage
	{
		protected System.Web.UI.WebControls.Label lbYear;
		protected System.Web.UI.WebControls.Label lbType;
		protected System.Web.UI.WebControls.Label lbMake;
		protected System.Web.UI.WebControls.Label lbModel;
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected System.Web.UI.WebControls.Label lbDept;
		protected System.Web.UI.WebControls.Label lbLoc;
		protected System.Web.UI.WebControls.Label lbVinSerial;
		protected System.Web.UI.WebControls.Label lbAssignedTo;
		protected System.Web.UI.WebControls.LinkButton lnkEditMain;
		
		protected System.Web.UI.WebControls.LinkButton lnkEditMainAlt;
		protected System.Web.UI.WebControls.LinkButton Linkbutton4;
		protected System.Web.UI.WebControls.LinkButton Linkbutton6;
		protected System.Web.UI.WebControls.LinkButton Linkbutton5;
		protected System.Web.UI.WebControls.Label lbStatus;
		protected System.Web.UI.WebControls.Label lbPMSched;
		protected System.Web.UI.WebControls.Label lbInspection;
		protected System.Web.UI.WebControls.Label lbUnits;
		protected System.Web.UI.WebControls.LinkButton lnkEditAquis;
		protected System.Web.UI.WebControls.Label lbDtInService;
		protected System.Web.UI.WebControls.Label lbDtAquired;
		protected System.Web.UI.WebControls.Label lbSmPurAmount;
		protected System.Web.UI.WebControls.Label lbIntPurUnits;
		protected System.Web.UI.WebControls.Label lbVchPurNotes;
		protected System.Web.UI.WebControls.Label lbVchPurOrgContact;

		protected System.Web.UI.WebControls.Label lbDtOutOfService;
		protected System.Web.UI.WebControls.Label lbDtDisposed;
		protected System.Web.UI.WebControls.Label lbVchDispOrgContact;
		protected System.Web.UI.WebControls.Label lbSmDispAmount;
		protected System.Web.UI.WebControls.Label lbIntDispUnits;
		protected System.Web.UI.WebControls.Label lbVchDispNotes;
		protected System.Web.UI.WebControls.Label lbVchDispMethod;
		protected System.Web.UI.WebControls.LinkButton lnkEditDisp;
		protected System.Web.UI.WebControls.Label lbTranMake;
		protected System.Web.UI.WebControls.Label tbTransModel;
		protected System.Web.UI.WebControls.Label lbTranPart;
		protected System.Web.UI.WebControls.Label lbTranSerial;
		protected System.Web.UI.WebControls.Label lbEngineMake;
		protected System.Web.UI.WebControls.Label lbEngineModel;
		protected System.Web.UI.WebControls.Label lbEnginePart;
		protected System.Web.UI.WebControls.Label lbEngineSerial;
		protected System.Web.UI.WebControls.Label lbStrEquipId;
		protected System.Web.UI.WebControls.Label lbFuelCode;
		protected System.Web.UI.WebControls.LinkButton lbEditChasis;
		protected System.Web.UI.WebControls.Label lblChasisMake;
		protected System.Web.UI.WebControls.Label lblChasisNumber;
		
		
		int EquipId;

		private void Page_Load(object sender, System.EventArgs e)
		{
			EquipId=Convert.ToInt32(Request.QueryString["id"]);

			PageTitle = "Equipment Detail";
			string [,] arrBrdCrumbs = new string [2,2];
			arrBrdCrumbs[0,0]="../default.aspx";
			arrBrdCrumbs[0,1]="Home";
			arrBrdCrumbs[1,0]="list.aspx";
			arrBrdCrumbs[1,1]="Equipment List";
			Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
			Header.PageTitle=PageTitle;
			
			DbObject dbobj1 = new DbObject();

			SqlParameter[] parameters = 
			{
				new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId),
				new SqlParameter("@Id",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,EquipId),
				new SqlParameter("@vchEquipId",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@intYear",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchType",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchMake",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchModel",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchDept",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchLocation",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchAssignedTo",SqlDbType.VarChar,100,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchVinSerial",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchStatus",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchPMSched",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchInspect",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@intCurrentUnits",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@dtInService",SqlDbType.SmallDateTime,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@dtAquired",SqlDbType.SmallDateTime,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchPurOrgContact",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@smPurAmount",SqlDbType.SmallMoney,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@intPurUnits",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchPurNotes",SqlDbType.VarChar,250,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@dtOutOfService",SqlDbType.SmallDateTime,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@dtDisposed",SqlDbType.SmallDateTime,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchDispOrgContact",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@smDispAmount",SqlDbType.SmallMoney,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@intDispUnits",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchDispNotes",SqlDbType.VarChar,250,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchDispMethod",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),

				new SqlParameter("@vchTransMake",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchTransModel",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchTransPart",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchTransSerial",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),

				new SqlParameter("@vchEngineMake",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchEngineModel",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchEnginePart",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchEngineSerial",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),

				new SqlParameter("@vchChasisMake",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),
				new SqlParameter("@vchChasisNumber",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null),

				new SqlParameter("@vchFuelCode",SqlDbType.VarChar,25,ParameterDirection.Output,false,0,0,null,DataRowVersion.Default,null)
			};
			int returnValue;
			SqlCommand cmd = dbobj1.cmdRunProcedure("sp_SelectEquipView",parameters,out returnValue);
			
			
			lbYear.Text=cmd.Parameters["@intYear"].Value.ToString();
			lbDept.Text=cmd.Parameters["@vchDept"].Value.ToString();
			lbLoc.Text=cmd.Parameters["@vchLocation"].Value.ToString();
			lbVinSerial.Text=cmd.Parameters["@vchVinSerial"].Value.ToString();
			lbAssignedTo.Text=cmd.Parameters["@vchAssignedTo"].Value.ToString();

			lbStrEquipId.Text=cmd.Parameters["@vchEquipId"].Value.ToString();
			lbMake.Text=cmd.Parameters["@vchMake"].Value.ToString();
			lbModel.Text=cmd.Parameters["@vchModel"].Value.ToString();;
			lbType.Text=cmd.Parameters["@vchType"].Value.ToString();

			lbStatus.Text=cmd.Parameters["@vchStatus"].Value.ToString();
			lbPMSched.Text=cmd.Parameters["@vchPMSched"].Value.ToString();
			lbInspection.Text=cmd.Parameters["@vchInspect"].Value.ToString();
			lbUnits.Text=cmd.Parameters["@intCurrentUnits"].Value.ToString();

			
			lbDtInService.Text=String.Format("{0:d}",cmd.Parameters["@dtInService"].Value);
			lbDtAquired.Text=String.Format("{0:d}",cmd.Parameters["@dtAquired"].Value);
			lbVchPurOrgContact.Text=cmd.Parameters["@vchPurOrgContact"].Value.ToString();
			lbSmPurAmount.Text=String.Format("{0:0.00}",cmd.Parameters["@smPurAmount"].Value);
			lbIntPurUnits.Text=cmd.Parameters["@intPurUnits"].Value.ToString();
			lbVchPurNotes.Text=cmd.Parameters["@vchPurNotes"].Value.ToString();

			lbDtOutOfService.Text=String.Format("{0:d}",cmd.Parameters["@dtOutOfService"].Value);;
			lbDtDisposed.Text=String.Format("{0:d}",cmd.Parameters["@dtDisposed"].Value);;
			lbVchDispOrgContact.Text=cmd.Parameters["@vchDispOrgContact"].Value.ToString();;
			lbSmDispAmount.Text=String.Format("{0:0.00}",cmd.Parameters["@smDispAmount"].Value);;
			lbIntDispUnits.Text=cmd.Parameters["@intDispUnits"].Value.ToString();;
			lbVchDispNotes.Text=cmd.Parameters["@vchDispNotes"].Value.ToString();
			lbVchDispMethod.Text=cmd.Parameters["@vchDispMethod"].Value.ToString();

			lbTranMake.Text=cmd.Parameters["@vchTransMake"].Value.ToString();
			tbTransModel.Text=cmd.Parameters["@vchTransModel"].Value.ToString();
			lbTranPart.Text=cmd.Parameters["@vchTransPart"].Value.ToString();
			lbTranSerial.Text=cmd.Parameters["@vchTransSerial"].Value.ToString();

			lbEngineMake.Text=cmd.Parameters["@vchEngineMake"].Value.ToString();
			lbEngineModel.Text=cmd.Parameters["@vchEngineModel"].Value.ToString();
			lbEnginePart.Text=cmd.Parameters["@vchEnginePart"].Value.ToString();
			lbEngineSerial.Text=cmd.Parameters["@vchEngineSerial"].Value.ToString();

			lblChasisMake.Text = cmd.Parameters["@vchChasisMake"].Value.ToString();
			lblChasisNumber.Text = cmd.Parameters["@vchChasisNumber"].Value.ToString();

			lbFuelCode.Text=cmd.Parameters["@vchFuelCode"].Value.ToString();

			
		} //End Page_Load


		public void OnEditMainClick(object sender,EventArgs e){
			Response.Redirect("edit.aspx?id="+EquipId+"");
			}
		public void OnEditMainAltClick(object sender,EventArgs e){
			Response.Redirect("edit2.aspx?id="+EquipId+"");
			}
		public void OnEditAquisClick(object sender,EventArgs e){
			Response.Redirect("editAquis.aspx?id="+EquipId+"");
			}
		public void OnEditDispClick(object sender,EventArgs e) {
			Response.Redirect("editDisp.aspx?id="+EquipId+"");
			}
		public void OnEditTransClick(object sender,EventArgs e) {
			Response.Redirect("editTrans.aspx?id="+EquipId+"");
		}
		public void OnEditEngineClick(object sender,EventArgs e) {
			Response.Redirect("editEngine.aspx?id="+EquipId+"");
		}
		public void OnEditChasisClick(object sender,EventArgs e){
			Response.Redirect("editChasis.aspx?id="+EquipId+"");
		}
		
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			base.OnInit(e);
			InitializeComponent();
			
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
