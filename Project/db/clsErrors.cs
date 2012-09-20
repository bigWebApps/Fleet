using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;

namespace BWA.BFP.Data
{
	public class clsErrors : clsDBInteractionBase
	{
		#region Class Member Declarations
		private SqlString		m_cAction;
		private SqlInt32		m_iOrgId;
		private SqlInt32		m_iId;
		private SqlString		m_sErrorName;
		private SqlInt32		m_iUserId;
		private SqlString		m_sUserName;
		private SqlString		m_sOrgName;
		private SqlString		m_sPageName;
		private SqlDateTime		m_daCreated;
		private SqlString		m_sDesc;
		private SqlDateTime		m_daStartDate;
		private SqlDateTime		m_daFinishDate;
		private SqlInt32		m_iPageNumber;
		#endregion
		
		public clsErrors()
		{
		}


		public DataTable GetErrorsList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectErrorsList]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataTable dtToReturn = new DataTable("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@dtStartDate",SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "",DataRowVersion.Proposed, m_daStartDate));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@dtFinishDate",SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "",DataRowVersion.Proposed, m_daFinishDate));
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
					throw new Exception("Stored Procedure 'sp_SelectErrorsList' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsErrors::GetErrorsList::Error occured.\n" + ex.Message, ex);
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


		public int ErrorDetail()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_ErrorDetail]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Default, m_iId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Default, m_iUserId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchUserName", SqlDbType.NVarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sUserName));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@UserOrgId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Default, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchOrgName", SqlDbType.NVarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sOrgName));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchErrorName", SqlDbType.NVarChar, 1024, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sErrorName));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPageName", SqlDbType.NVarChar, 150, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sPageName));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCreated",SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "",DataRowVersion.Default, m_daCreated));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDesc", SqlDbType.NVarChar, 4000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sDesc));
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
				m_iUserId = (SqlInt32)scmCmdToExecute.Parameters["@UserId"].Value;
				m_sUserName = (SqlString)scmCmdToExecute.Parameters["@vchUserName"].Value;
				m_iOrgId = (SqlInt32)scmCmdToExecute.Parameters["@UserOrgId"].Value;
				m_sOrgName = (SqlString)scmCmdToExecute.Parameters["@vchOrgName"].Value;
				m_sErrorName = (SqlString)scmCmdToExecute.Parameters["@vchErrorName"].Value;
				m_sPageName = (SqlString)scmCmdToExecute.Parameters["@vchPageName"].Value;
				m_daCreated = (SqlDateTime)scmCmdToExecute.Parameters["@dtCreated"].Value;
				m_sDesc = (SqlString)scmCmdToExecute.Parameters["@vchDesc"].Value;
				
				if(m_iErrorCode != (int)Error.AllOk)
				{
					// Throw error.
					throw new Exception("Stored Procedure 'sp_ErrorDetail' reported the ErrorCode: " + m_iErrorCode);
				}

				return (int)scmCmdToExecute.Parameters["ReturnValue"].Value;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsErrors::ErrorDetail::Error occured.\n" + ex.Message, ex);
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
		public SqlString sErrorName
		{
			get
			{
				return m_sErrorName;
			}
			set
			{
				m_sErrorName = value;
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
		public SqlString sUserName
		{
			get
			{
				return m_sUserName;
			}
			set
			{
				m_sUserName = value;
			}
		}
		public SqlString sOrgName
		{
			get
			{
				return m_sOrgName;
			}
			set
			{
				m_sOrgName = value;
			}
		}
		public SqlString sPageName
		{
			get
			{
				return m_sPageName;
			}
			set
			{
				m_sPageName = value;
			}
		}
		public SqlDateTime daCreated
		{
			get
			{
				return m_daCreated;
			}
			set
			{
				m_daCreated = value;
			}
		}
		public SqlString sDesc
		{
			get
			{
				return m_sDesc;
			}
			set
			{
				m_sDesc = value;
			}
		}
		public SqlDateTime daStartDate
		{
			get
			{
				return m_daStartDate;
			}
			set
			{
				m_daStartDate = value;
			}
		}
		public SqlDateTime daFinishDate
		{
			get
			{
				return m_daFinishDate;
			}
			set
			{
				m_daFinishDate = value;
			}
		}
		public SqlInt32	iPageNumber
		{
			get
			{
				return m_iPageNumber;
			}
			set
			{
				m_iPageNumber = value;
			}
		}
		#endregion
		}
}
