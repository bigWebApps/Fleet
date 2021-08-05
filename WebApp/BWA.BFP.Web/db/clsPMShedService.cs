using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;

namespace BWA.BFP.Data
{
	public class clsPMSchedService : clsDBInteractionBase
	{
		#region Class Member Declarations
		private SqlString		m_cAction;
		private SqlInt32		m_iId;
		private SqlInt32		m_iOrgId;
		private SqlString		m_sPMSchedName;
		private SqlInt32		m_iPMSchedId;
		private SqlInt32		m_iInspectItemId;
		private SqlInt32		m_iPMServiceId;
		private SqlInt32		m_iRepairCatId;
		private SqlString		m_sPMServiceName;
		private SqlInt32		m_iPMSchedDetailId;
		private SqlInt32		m_iUnitMeasureId;
		private SqlInt32		m_iDays;
		private SqlDecimal		m_dmUnits;
		#endregion
		
		public clsPMSchedService()
		{
		}

		
		public DataTable GetPMSchedulesList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectPMSchedulesList]";
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

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsPMSchedService::GetPMSchedulesList::Error occured.\n" + ex.Message, ex);
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


		public DataTable GetPMServicesList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectPMServicesList]";
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

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsPMSchedService::GetPMServicesList::Error occured.\n" + ex.Message, ex);
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


		public DataTable GetRepairCatsList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectRepairCatsList]";
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

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsPMSchedService::GetRepairCatsList::Error occured.\n" + ex.Message, ex);
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


		public DataSet GetPMSchedPMServicesList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectPMSchedPMServicesList]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataSet dsToReturn = new DataSet("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectItemId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iInspectItemId));
				
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
				sdaAdapter.Fill(dsToReturn);

				return dsToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsPMSchedService::GetPMSchedPMServicesList::Error occured.\n" + ex.Message, ex);
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


		public DataSet GetPMServicesListForSchedule()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectPMServicesListForSchedule]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataSet dsToReturn = new DataSet("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@PMSchedId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iPMSchedId));
				
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
				sdaAdapter.Fill(dsToReturn);

				return dsToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsPMSchedService::GetPMServicesListForSchedule::Error occured.\n" + ex.Message, ex);
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


		public DataTable GetUnitMeasureList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectMeasuresList]";
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
				throw new Exception("clsPMSchedService::GetUnitMeasureList::Error occured.\n" + ex.Message, ex);
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


		public int PMScheduleDetails()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_PMScheduleDetail]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iPMSchedId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPMSchedName));
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

				m_sPMSchedName = (SqlString)scmCmdToExecute.Parameters["@vchName"].Value ;
				
				return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsPMSchedService::PMScheduleDetails::Error occured.\n" + ex.Message, ex);
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


		public int PMServiceDetails()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_PMServiceDetail]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iPMServiceId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairCatId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iRepairCatId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDesc", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPMServiceName));
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

				m_iRepairCatId = (SqlInt32)scmCmdToExecute.Parameters["@RepairCatId"].Value ;
				m_sPMServiceName = (SqlString)scmCmdToExecute.Parameters["@vchDesc"].Value ;
				
				return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsPMSchedService::PMServiceDetails::Error occured.\n" + ex.Message, ex);
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



		public int PMSchedServiceDetails()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_PMSchedDetailsDetail]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iPMSchedDetailId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@PMSchedId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iPMSchedId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@PMServiceId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iPMServiceId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@UnitMeasureId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iUnitMeasureId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@intDays",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iDays));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@dmUnits",SqlDbType.Decimal, 12,ParameterDirection.InputOutput, true, 19, 8, "",DataRowVersion.Proposed, m_dmUnits));
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

				m_iPMSchedId = (SqlInt32)scmCmdToExecute.Parameters["@PMSchedId"].Value;
				m_iPMServiceId = (SqlInt32)scmCmdToExecute.Parameters["@PMServiceId"].Value;
				m_iUnitMeasureId = (SqlInt32)scmCmdToExecute.Parameters["@UnitMeasureId"].Value;
				m_iDays = (SqlInt32)scmCmdToExecute.Parameters["@intDays"].Value;
				m_dmUnits = (SqlDecimal)scmCmdToExecute.Parameters["@dmUnits"].Value;
				return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsPMSchedService::PMSchedServiceDetails::Error occured.\n" + ex.Message, ex);
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

		public SqlString sPMSchedName
		{
			get
			{
				return m_sPMSchedName;
			}
			set
			{
				m_sPMSchedName = value;
			}
		}
		public SqlInt32	iPMSchedId
		{
			get
			{
				return m_iPMSchedId;
			}
			set
			{
				m_iPMSchedId = value;
			}
		}
		public SqlInt32	iInspectItemId
		{
			get
			{
				return m_iInspectItemId;
			}
			set
			{
				m_iInspectItemId = value;
			}
		}
		public SqlInt32	iPMServiceId
		{
			get
			{
				return m_iPMServiceId;
			}
			set
			{
				m_iPMServiceId = value;
			}
		}
		public SqlInt32	iRepairCatId
		{
			get
			{
				return m_iRepairCatId;
			}
			set
			{
				m_iRepairCatId = value;
			}
		}
		public SqlString sPMServiceName
		{
			get
			{
				return m_sPMServiceName;
			}
			set
			{
				m_sPMServiceName = value;
			}
		}
		public SqlInt32	iPMSchedDetailId
		{
			get
			{
				return m_iPMSchedDetailId;
			}
			set
			{
				m_iPMSchedDetailId = value;
			}
		}
		public SqlInt32	iUnitMeasureId
		{
			get
			{
				return m_iUnitMeasureId;
			}
			set
			{
				m_iUnitMeasureId = value;
			}
		}
		public SqlInt32	iDays
		{
			get
			{
				return m_iDays;
			}
			set
			{
				m_iDays = value;
			}
		}
		public SqlDecimal dmUnits
		{
			get
			{
				return m_dmUnits;
			}
			set
			{
				m_dmUnits = value;
			}
		}
		#endregion

	}
}
