using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;

namespace BWA.BFP.Data
{
	public class clsComponents : clsDBInteractionBase
	{
		#region Class Member Declarations
		private SqlString		m_cAction;
		private SqlInt32		m_iId;
		private SqlInt32		m_iOrgId;
		private SqlInt32		m_iEquipId;
		private SqlString		m_sType;
		private SqlInt32		m_iTypeId;
		private SqlInt32		m_iUserId;
		private SqlBoolean		m_bitActive;
		#endregion
		
		public clsComponents()
		{
		}

		
		public DataTable GetComponentsList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectComponentList]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataTable dtToReturn = new DataTable("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iEquipId));

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
					throw new Exception("Stored Procedure 'sp_SelectComponentList' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsComponents::GetComponentsList::Error occured.\n" + ex.Message, ex);
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

		
		public DataTable ComponentDetail_CustomFields(SqlParameter[] parameters)
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_ComponentDetail_CustomFields]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataTable dtToReturn = new DataTable("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iEquipId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4,ParameterDirection.Input, true, 10, 0, "",DataRowVersion.Proposed, m_iUserId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4,ParameterDirection.Input, true, 10, 0, "",DataRowVersion.Proposed, m_iTypeId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@btActive", SqlDbType.Bit, 1, ParameterDirection.Input, true, 1, 0, "", DataRowVersion.Proposed, m_bitActive));
				scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));
				
				if(parameters != null)
				{
					foreach (SqlParameter parameter in parameters)
					{
						scmCmdToExecute.Parameters.Add( parameter );
					}
				}
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
				m_iId = (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
				m_iErrorCode = 0;

				if(m_iErrorCode != (int)Error.AllOk)
				{
					// Throw error.
					throw new Exception("Stored Procedure 'sp_ComponentDetail_CustomFields' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsComponents::ComponentDetail_CustomFields::Error occured.\n" + ex.Message, ex);
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


		public DataTable GetComponentTypeList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectComponentTypeList]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataTable dtToReturn = new DataTable("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iEquipId));
				
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
					throw new Exception("Stored Procedure 'sp_SelectComponentTypeList' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsComponents::GetComponentTypeList::Error occured.\n" + ex.Message, ex);
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

		public void DeleteComponent()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_DeleteComponentFromEquipment]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iId));
				
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

				m_iErrorCode = 0;
				if(m_iErrorCode != (int)Error.AllOk)
				{
					// Throw error.
					throw new Exception("Stored Procedure 'sp_DeleteComponentFromEquipment' reported the ErrorCode: " + m_iErrorCode);
				}
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsComponents::DeleteComponent::Error occured.\n" + ex.Message, ex);
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

		public SqlInt32	iEquipId
		{
			get
			{
				return m_iEquipId;
			}
			set
			{
				m_iEquipId = value;
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

		public SqlString sType
		{
			get
			{
				return m_sType;
			}
			set
			{
				m_sType = value;
			}
		}
		
		public SqlInt32	iTypeId
		{
			get
			{
				return m_iTypeId;
			}
			set
			{
				m_iTypeId = value;
			}
		}
		public SqlInt32	iUserId
		{
			get
			{
				return m_iUserId;
			}
			set
			{
				m_iUserId = value;
			}
		}
		public SqlBoolean bitActive
		{
			get
			{
				return m_bitActive;
			}
			set
			{
				m_bitActive = value;
			}
		}
		#endregion
	}
}
