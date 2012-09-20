namespace BWA.BFP.Web.Controls.User
{
	using System;
	using System.Data;
	using System.Data.SqlTypes;
	using System.Drawing;
	using System.Web;
	using System.Web.UI;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using BWA.BFP.Data;
	using BWA.BFP.Core;

	public class MakesModels : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.DropDownList ddlMakes;
		protected System.Web.UI.WebControls.DropDownList ddlModels;
		protected MetaBuilders.WebControls.ListLink ListLink;
		protected System.Web.UI.WebControls.Literal Literal;
		
		private SqlBoolean m_bitIsComponent;
		private SqlInt32 m_iTypeId;
		private SqlInt32 m_iModelId;
		private clsMakesModels mm = null;
		private string m_sCtlName;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvModels;
		protected System.Web.UI.WebControls.RequiredFieldValidator rfvMakes;
		
		public DataSet dsMMList;

		public override bool Visible
		{
			set
			{
				if(value)
				{
					ddlMakes.Visible = true;
					ddlModels.Visible = true;
					ListLink.Visible = true;
					rfvMakes.Enabled = true;
					rfvModels.Enabled = true;
				}
				else
				{
					ddlMakes.Visible = false;
					ddlModels.Visible = false;
					ListLink.Visible = false;
					rfvMakes.Enabled = false;
					rfvModels.Enabled = false;
				}
			}
		}
				
		public bool IsComponent
		{
			get
			{
				if(m_bitIsComponent == SqlBoolean.True)
					return true;
				else
					return false;
			}
			set
			{
				if(value)
					m_bitIsComponent = SqlBoolean.True;
				else
					m_bitIsComponent = SqlBoolean.False;
			}
		}

		public int TypeId
		{
			get
			{
				return m_iTypeId.Value;
			}
			set
			{
				if(value == 0)
					m_iTypeId = SqlInt32.Null;
				else
					m_iTypeId = value;

			}
		}

		public string ControlName
		{
			set
			{
				m_sCtlName = value;
			}
		}

		public int ModelId
		{
			get
			{
				return Convert.ToInt32(Page.Request.Form[this.ClientID + ":ddlModels"]);
				//return Convert.ToInt32(((DropDownList)this.FindControl("ddlModels")).SelectedValue);
			}
			set
			{
				if(value == 0)
					m_iModelId = SqlInt32.Null;
				else
					m_iModelId = value;
			}
		}
		

		private void Page_Load(object sender, System.EventArgs e)
		{
			this.EnableViewState = false;
		}

		public override void DataBind()
		{
			try
			{
					if(!m_bitIsComponent.IsNull)
					{
						mm = new clsMakesModels();
						mm.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
						mm.bitIsComponent = m_bitIsComponent;
						mm.iTypeId = m_iTypeId;
						dsMMList = mm.GetModelMakesList();
					
						dsMMList.Relations.Add( new DataRelation( "Makes_Models", dsMMList.Tables["Table"].Columns["Id"], dsMMList.Tables["Table1"].Columns["MakeId"] ) );
				
						ddlMakes.EnableViewState = false;
						ddlMakes.DataSource = dsMMList;
						ddlMakes.DataMember = "Table";
						ddlMakes.DataValueField = "Id";
						ddlMakes.DataTextField = "vchMakeName";
						ddlMakes.DataBind();
						ddlMakes.Items.Insert(0, "");
						//ddlMakes.AutoPostBack = true;

						ddlModels.EnableViewState = false;
						ddlModels.DataSource = dsMMList;
						ddlModels.DataMember = "Table1";
						ddlModels.DataValueField = "Id";
						ddlModels.DataTextField = "vchModelName";
						ddlModels.DataBind();
						ddlModels.Items.Insert(0, "");
						//ddlModels.AutoPostBack = true;

						ListLink.ParentList="ddlMakes"; 
						ListLink.ChildList="ddlModels";
						ListLink.DataRelation = "Makes_Models";
						ListLink.EnableViewState = false;
						ListLink.LockFirstItem=true;
					
						if(!m_iModelId.IsNull)
						{
							mm.iModelId = m_iModelId;
							// getting MakeId
							mm.GetModelMakes();
							ddlMakes.SelectedValue = mm.iMakeId.Value.ToString();
							ddlModels.SelectedValue = m_iModelId.Value.ToString();
						}
						Literal.Text = "/";

						rfvMakes.ErrorMessage = "Makes is required";
						rfvMakes.ControlToValidate = "ddlMakes";
						rfvMakes.Display = ValidatorDisplay.Dynamic;
						
						rfvModels.ErrorMessage = "Models is required";
						rfvModels.ControlToValidate = "ddlModels";
						rfvModels.Display = ValidatorDisplay.Dynamic;

						Controls.Clear();
						
						Controls.Add(ddlMakes); 
						Controls.Add(Literal);
						Controls.Add(ddlModels);
						Controls.Add(ListLink);
						
						Literal.Text = "&nbsp;";

						Controls.Add(Literal);
						Controls.Add(rfvMakes);
						Controls.Add(Literal);
						Controls.Add(rfvModels);
						
						ListLink.DataBind();
					
					}
					else
					{
						Controls.Clear();
					}
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally
			{
				if(mm != null)
				{
					mm.Dispose();
				}
			}		
		}

		
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
		}
		
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

	}
}
