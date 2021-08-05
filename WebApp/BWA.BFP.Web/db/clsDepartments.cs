using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;

namespace BWA.BFP.Data
{
	public class clsDepartments : clsDBInteractionBase
	{
		#region Class Member Declarations
		private SqlString		m_cAction;
		private SqlInt32		m_iOrgId;
		private SqlInt32		m_iId;
		private SqlString		m_sName;
		#endregion
		
		public clsDepartments()
		{
		}


		public DataTable GetDepartmentsList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectDepartmentsList]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataTable dtToReturn = new DataTable("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				
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
					throw new Exception("Stored Procedure 'sp_SelectDepartmentsList' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsDepartments::GetDepartmentsList::Error occured.\n" + ex.Message, ex);
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


		public int DepartmentDetail()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_DepartmentDetail]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Default, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Default, m_iId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchName", SqlDbType.NVarChar, 25, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sName));
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
				scmCmdToExecute.ExecuteNonQuery();
				m_iId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
				m_sName = (SqlString)scmCmdToExecute.Parameters["@vchName"].Value;

				if(m_iErrorCode != (int)Error.AllOk)
				{
					// Throw error.
					throw new Exception("Stored Procedure 'sp_DepartmentDetail' reported the ErrorCode: " + m_iErrorCode);
				}

				return (int)scmCmdToExecute.Parameters["ReturnValue"].Value;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsDepartments::DepartmentDetail::Error occured.\n" + ex.Message, ex);
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

		public SqlInt32 iId
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
		
		#endregion
	}
}
