using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;

namespace BWA.BFP.Data
{
	public class clsCustFields : clsDBInteractionBase
	{
		#region Class Member Declarations
		private SqlString		m_cAction;
		private SqlInt32		m_iId;
		private SqlInt32		m_iOrgId;
		private SqlInt32		m_iDataTypeId;
		private SqlInt32		m_iComponentTypeID;
		private SqlInt32		m_iNumberColumn;
		private SqlString		m_sName;
		private SqlString		m_sNameText;
		private SqlString		m_sNameLookupTable;
		private SqlString		m_sNameFieldLookup;
		private SqlBoolean		m_bitRequired;
		private SqlInt32		m_iFieldTypeId;
		private SqlString		m_sDefault;
		private SqlString		m_sHelp;
		#endregion

		public clsCustFields()
		{
		}

	
		public int CustFieldsEquipment()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_CustFieldEquipments]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Default, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Default, m_iId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@DataTypeId", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Default, m_iDataTypeId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@ComponentTypeID",SqlDbType.Int, 4,ParameterDirection.InputOutput, false, 10, 0, "",DataRowVersion.Default, m_iComponentTypeID));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@NumberColumn",SqlDbType.Int, 4,ParameterDirection.InputOutput, false, 10, 0, "",DataRowVersion.Default, m_iNumberColumn));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchName", SqlDbType.NVarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sName));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchNameText", SqlDbType.NVarChar, 100, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sNameText));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchNameLookupTable", SqlDbType.NVarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sNameLookupTable));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchNameFieldLookup", SqlDbType.NVarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sNameFieldLookup));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@btRequired", SqlDbType.Bit, 1, ParameterDirection.InputOutput, true, 1, 0, "", DataRowVersion.Default, m_bitRequired));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@FieldTypeId",SqlDbType.Int, 4,ParameterDirection.InputOutput, false, 10, 0, "",DataRowVersion.Default, m_iFieldTypeId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDefault", SqlDbType.NVarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sDefault));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchHelp", SqlDbType.NVarChar, 1024, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sHelp));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@ErrorCode", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iErrorCode));

				if(m_bMainConnectionIsCreatedLocal)
				{
					// Open connection.
					m_scoMainConnection.Open();
				}
				else
				{
					if(m_cpMainConnectionProvider.bIsTransactionPending)
					{
						scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
					}
				}

				// Execute query.
				scmCmdToExecute.ExecuteNonQuery();
				m_iId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
				m_iDataTypeId = (SqlInt32)scmCmdToExecute.Parameters["@DataTypeId"].Value;
				m_iComponentTypeID = (SqlInt32)scmCmdToExecute.Parameters["@ComponentTypeID"].Value;
				m_iNumberColumn = (SqlInt32)scmCmdToExecute.Parameters["@NumberColumn"].Value;
				m_sName = (SqlString)scmCmdToExecute.Parameters["@vchName"].Value;
				m_sNameText = (SqlString)scmCmdToExecute.Parameters["@vchNameText"].Value;
				m_sNameLookupTable = (SqlString)scmCmdToExecute.Parameters["@vchNameLookupTable"].Value;
				m_sNameFieldLookup = (SqlString)scmCmdToExecute.Parameters["@vchNameFieldLookup"].Value;
				m_bitRequired = (SqlBoolean)scmCmdToExecute.Parameters["@btRequired"].Value;
				m_iFieldTypeId = (SqlInt32)scmCmdToExecute.Parameters["@FieldTypeId"].Value;
				m_sDefault = (SqlString)scmCmdToExecute.Parameters["@vchDefault"].Value;
				m_iErrorCode = (SqlInt32)scmCmdToExecute.Parameters["@ErrorCode"].Value;

				if(m_iErrorCode != (int)Error.AllOk)
				{
					// Throw error.
					throw new Exception("Stored Procedure 'sp_CustFieldEquipments' reported the ErrorCode: " + m_iErrorCode);
				}

				return (int)m_iId;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsCustFields::CustFieldsEquipment::Error occured.\n" + ex.Message, ex);
			}
			finally
			{
				if(m_bMainConnectionIsCreatedLocal)
				{
					// Close connection.
					m_scoMainConnection.Close();
				}
				scmCmdToExecute.Dispose();
			}
		}


		public DataTable GetCustFields()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectCustFieldDef]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataTable dtToReturn = new DataTable("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@DataTypeId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iDataTypeId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@ComponentTypeID",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iComponentTypeID));
				scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));
				
				if(m_bMainConnectionIsCreatedLocal)
				{
					// Open connection.
					m_scoMainConnection.Open();
				}
				else
				{
					if(m_cpMainConnectionProvider.bIsTransactionPending)
					{
						scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
					}
				}

				// Execute query.
				sdaAdapter.Fill(dtToReturn);
				m_iErrorCode = 0;

				if(m_iErrorCode != (int)Error.AllOk)
				{
					// Throw error.
					throw new Exception("Stored Procedure 'sp_SelectCustFieldDef' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsCustFields::GetCustFields::Error occured.\n" + ex.Message, ex);
			}
			finally
			{
				if(m_bMainConnectionIsCreatedLocal)
				{
					// Close connection.
					m_scoMainConnection.Close();
				}
				scmCmdToExecute.Dispose();
				sdaAdapter.Dispose();
			}
		}

		
		#region Class Property Declarations
		public SqlString cAction
		{
			get
			{
				return m_cAction;
			}
			set
			{
				m_cAction = value;
			}
		}
		public SqlInt32	iId
		{
			get
			{
				return m_iId;
			}
			set
			{
				m_iId = value;
			}
		}

		public SqlInt32 iOrgId
		{
			get
			{
				return m_iOrgId;
			}
			set
			{
				m_iOrgId = value;
			}
		}

		public SqlInt32	iDataTypeId
		{
			get
			{
				return m_iDataTypeId;
			}
			set
			{
				m_iDataTypeId = value;
			}
		}
		public SqlInt32 iComponentTypeID
		{
			get
			{
				return m_iComponentTypeID;
			}
			set
			{
				m_iComponentTypeID = value;
			}
		}

		public SqlInt32	iNumberColumn
		{
			get
			{
				return m_iNumberColumn;
			}
			set
			{
				m_iNumberColumn = value;
			}
		}

		public SqlString sName
		{
			get
			{
				return m_sName;
			}
			set
			{
				m_sName = value;
			}
		}
		public SqlString sNameText
		{
			get
			{
				return m_sNameText;
			}
			set
			{
				m_sNameText = value;
			}
		}
		public SqlString sNameLookupTable
		{
			get
			{
				return m_sNameLookupTable;
			}
			set
			{
				m_sNameLookupTable = value;
			}
		}
		public SqlString sNameFieldLookup
		{
			get
			{
				return m_sNameFieldLookup;
			}
			set
			{
				m_sNameFieldLookup = value;
			}
		}
		public SqlBoolean bitRequired
		{
			get
			{
				return m_bitRequired;
			}
			set
			{
				m_bitRequired = value;
			}
		}
		public SqlInt32 iFieldTypeId
		{
			get
			{
				return m_iFieldTypeId;
			}
			set
			{
				m_iFieldTypeId = value;
			}
		}
		public SqlString sDefault
		{
			get
			{
				return m_sDefault;
			}
			set
			{
				m_sDefault = value;
			}
		}
		public SqlString sHelp
		{
			get
			{
				return m_sHelp;
			}
			set
			{
				m_sHelp = value;
			}
		}
		#endregion

	}
}
