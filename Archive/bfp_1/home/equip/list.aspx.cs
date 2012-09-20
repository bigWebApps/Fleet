using System;
using System.Data;
using System.Data.SqlClient;
using BWA.BFP.Data;

namespace BWA.BFP.Web.home.equip
{
	/// <summary>
	/// Summary description for list.
	/// </summary>
	public class _list : BFPPage
	{
		protected BWA.BFP.Web.Controls.User.Header Header;
		protected Micajah.DataGrid.DataGrid_A DataGrid1;
		#region Page_Load
		private void Page_Load(object sender, System.EventArgs e)
		{
			string [,] arrBrdCrumbs = new string [1,2];
			arrBrdCrumbs[0,0]="../default.aspx";
			arrBrdCrumbs[0,1]="Home";
			PageTitle = "Equipment List";
			Header.BrdCrumbs=ParseBreadCrumbs(arrBrdCrumbs,PageTitle);
			Header.PageTitle=PageTitle;

			if(!Page.IsPostBack){
				BindData();
				}
		}
		#endregion
		#region BindData
		private void BindData()
		{
			SqlParameter[] parameters = {
				new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Input,false,0,0,null,DataRowVersion.Default,OrgId)
			};
			DbObject dbobj1 = new DbObject();
			dbobj1.CntOpen();

			DataGrid1.DataSource=dbobj1.drRunProcedure("sp_SelectEquipList",parameters);
			DataGrid1.DataBind();
			
			dbobj1.CntClose();
		}
		#endregion
		#region OnItemEditClick
		protected void OnItemEditClick(object sender, System.Web.UI.WebControls.DataGridCommandEventArgs e)
		{
			string EquipId = e.Item.Cells[1].Text;
			Response.Redirect("view.aspx?id="+EquipId+"");
		}
		#endregion
		private void DataGrid1_SelectedIndexChanged(object sender, System.EventArgs e)
		{
		
		}
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e) {
			base.OnInit(e);
			InitializeComponent();
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent() {    
			this.DataGrid1.SelectedIndexChanged += new System.EventHandler(this.DataGrid1_SelectedIndexChanged);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
