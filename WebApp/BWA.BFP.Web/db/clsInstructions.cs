using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using System.Collections;

namespace BWA.BFP.Data
{
	public class clsInstructions : clsDBInteractionBase
	{
		#region Class Member Declarations
		private SqlString		m_cAction;
		private SqlInt32		m_iId;
		private SqlString		m_sInstructionText;
		private SqlInt32		m_iOrgId;
		private SqlInt32		m_iTypeId;
		private SqlString		m_sTypeName;
		#endregion
		
		public clsInstructions()
		{
		}


		public DataTable GetInstructionList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectInstructions]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataTable dtToReturn = new DataTable("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				
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

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsInstructions::GetInstructionList::Error occured.\n" + ex.Message, ex);
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


		public DataTable GetInstructionTypeList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectInstructionTypes]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataTable dtToReturn = new DataTable("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
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

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsInstructions::GetInstructionTypeList::Error occured.\n" + ex.Message, ex);
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


		public int InstructionDetail()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_OperatorInstructionsDetail]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Default, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.InputOutput, false, 10, 0, "",DataRowVersion.Default, m_iId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Default, m_iTypeId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchNote", SqlDbType.VarChar, 8000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Default, m_sInstructionText));
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
				m_iTypeId = (SqlInt32)scmCmdToExecute.Parameters["@TypeId"].Value;
				m_sInstructionText = (SqlString)scmCmdToExecute.Parameters["@vchNote"].Value;

				return (int)scmCmdToExecute.Parameters["ReturnValue"].Value;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsInstructions::InstructionDetail::Error occured.\n" + ex.Message, ex);
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
		public SqlString sInstructionText
		{
			get
			{
				return m_sInstructionText;
			}
			set
			{
				m_sInstructionText = value;
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
		public SqlString sTypeName
		{
			get
			{
				return m_sTypeName;
			}
			set
			{
				m_sTypeName = value;
			}
		}
		#endregion
	}
}
