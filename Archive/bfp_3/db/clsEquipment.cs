using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;


namespace BWA.BFP.Data
{

	public class clsEquipment : clsDBInteractionBase
	{
		#region Class Member Declarations
		private SqlString		m_cAction;
		private SqlInt32		m_iId;
		private SqlInt32		m_iOrgId;
		private SqlString		m_sType;
		private SqlInt32		m_iTypeId;
		private SqlString		m_sAssignedTo;
		private SqlInt32		m_iAssignedTo;
		private SqlInt32		m_iUserId;
		private SqlString		m_sStatus;
		private SqlInt32		m_iStatusId;
		private SqlString		m_sPMSched;
		private SqlInt32		m_iPMSched;
		private SqlString		m_sInspect;
		private SqlInt32		m_iInspectId;
		private SqlInt32		m_iCurrentUnits;
		private SqlDateTime		m_daInService;
		private SqlDateTime		m_daAquired;
		private SqlString		m_sPurOrgContact;
		private SqlMoney		m_curPurAmount;
		private SqlInt32		m_iPurUnits;
		private SqlString		m_sPurNotes;
		private SqlDateTime		m_daOutOfService;
		private SqlDateTime		m_daDisposed;
		private SqlString		m_sDispOrgContact;
		private SqlMoney		m_curDispAmount;
		private SqlInt32		m_iDispUnits;
		private SqlString		m_sDispNotes;
		private SqlString		m_sDispMethod;
		private SqlInt32		m_iDispMethod;
		private SqlString		m_sNote;
		private SqlInt32		m_iModelId;
		private SqlString		m_sMakeModelName;
		private SqlInt32		m_iYear;
		private SqlInt32		m_iDeptId;
		private SqlString		m_sDeptName;
		private SqlInt32		m_iLocId;
		private SqlString		m_sLocName;
		private SqlBoolean		m_bShare;
		private SqlString		m_sFuelCode;
		private SqlString		m_sEquipId;
		private SqlString		m_sVinSerial;
		private SqlString		m_sPlateNumber;
		private SqlString		m_sCreatedBy;
		private SqlDateTime		m_daCreated;
		private SqlString		m_sUpdatedBy;
		private SqlDateTime		m_daUpdated;
		#endregion
		
		public clsEquipment()
		{
		}


		public DataTable GetEquipList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipList]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataTable dtToReturn = new DataTable("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iTypeId));
			
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
				throw new Exception("clsEquipment::GetEquipList::Error occured.\n" + ex.Message, ex);
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


		public DataTable GetEquipStatusList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipStatusList]";
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
				m_iErrorCode = 0;

				if(m_iErrorCode != (int)Error.AllOk)
				{
					// Throw error.
					throw new Exception("Stored Procedure 'sp_SelectEquipStatusList' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsEquipment::GetEquipStatusList::Error occured.\n" + ex.Message, ex);
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


		public DataTable GetEquipDispMethodsList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectDispMethodsList]";
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
					throw new Exception("Stored Procedure 'GetEquipDispMethodsList' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsEquipment::GetEquipDispMethodsList::Error occured.\n" + ex.Message, ex);
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


		public int EquipmentDetail()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_EquipmentDetail_Main]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iTypeId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchTypeName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sType));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@ModelId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iModelId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchMakeModelName", SqlDbType.VarChar, 101, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sMakeModelName));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@intYear",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iYear));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@AssignedTo",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iAssignedTo));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchAssignedTo", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sAssignedTo));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@DeptId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iDeptId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDeptName", SqlDbType.VarChar, 25, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDeptName));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@LocId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iLocId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchLocName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sLocName));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@btShare",SqlDbType.Bit, 1, ParameterDirection.InputOutput, true, 1, 0, "", DataRowVersion.Proposed, m_bShare));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchFuelCode", SqlDbType.VarChar, 20, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sFuelCode));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchVinSerial", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sVinSerial));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPlateNumber", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPlateNumber));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@intCreatedBy",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iUserId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchCreatedBy", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sCreatedBy));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCreated",SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "",DataRowVersion.Proposed, m_daCreated));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@intUpdatedBy",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iUserId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchUpdatedBy", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sUpdatedBy));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@dtUpdated", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "",DataRowVersion.Proposed, m_daUpdated));
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

				m_sType = (SqlString)scmCmdToExecute.Parameters["@vchTypeName"].Value;
				m_iTypeId = (SqlInt32)scmCmdToExecute.Parameters["@TypeId"].Value;
				m_iModelId = (SqlInt32)scmCmdToExecute.Parameters["@ModelId"].Value;
				m_sMakeModelName = (SqlString)scmCmdToExecute.Parameters["@vchMakeModelName"].Value;
				m_iYear = (SqlInt32)scmCmdToExecute.Parameters["@intYear"].Value;
				m_iAssignedTo = (SqlInt32)scmCmdToExecute.Parameters["@AssignedTo"].Value;
				m_sAssignedTo = (SqlString)scmCmdToExecute.Parameters["@vchAssignedTo"].Value;
				m_iDeptId = (SqlInt32)scmCmdToExecute.Parameters["@DeptId"].Value;
				m_sDeptName = (SqlString)scmCmdToExecute.Parameters["@vchDeptName"].Value;
				m_iLocId = (SqlInt32)scmCmdToExecute.Parameters["@LocId"].Value;
				m_sLocName = (SqlString)scmCmdToExecute.Parameters["@vchLocName"].Value;
				m_bShare = (SqlBoolean)scmCmdToExecute.Parameters["@btShare"].Value;
				m_sFuelCode = (SqlString)scmCmdToExecute.Parameters["@vchFuelCode"].Value;
				m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;
				m_sVinSerial = (SqlString)scmCmdToExecute.Parameters["@vchVinSerial"].Value;
				m_sPlateNumber = (SqlString)scmCmdToExecute.Parameters["@vchPlateNumber"].Value;
				m_iUserId = (SqlInt32)scmCmdToExecute.Parameters["@intUpdatedBy"].Value;
				m_sCreatedBy = (SqlString)scmCmdToExecute.Parameters["@vchCreatedBy"].Value;
				m_daCreated = (SqlDateTime)scmCmdToExecute.Parameters["@dtCreated"].Value;
				m_sUpdatedBy = (SqlString)scmCmdToExecute.Parameters["@vchUpdatedBy"].Value;
				m_daUpdated = (SqlDateTime)scmCmdToExecute.Parameters["@dtUpdated"].Value;
				
				return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsEquipment::EquipmentDetail::Error occured.\n" + ex.Message, ex);
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


		public int EquipmentDetail_Alt()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_EquipmentDetail_Alt]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@PMScheduleId", SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iPMSched));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPMSchedName", SqlDbType.VarChar, 25, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPMSched));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectId",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iInspectId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchInspectName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sInspect));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@intCurrentUnits",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iCurrentUnits));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@intUpdatedBy",SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iUserId));
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

				m_iPMSched = (SqlInt32)scmCmdToExecute.Parameters["@PMScheduleId"].Value;
				m_sPMSched = (SqlString)scmCmdToExecute.Parameters["@vchPMSchedName"].Value;
				m_iInspectId = (SqlInt32)scmCmdToExecute.Parameters["@InspectId"].Value;
				m_sInspect = (SqlString)scmCmdToExecute.Parameters["@vchInspectName"].Value;
				m_iCurrentUnits = (SqlInt32)scmCmdToExecute.Parameters["@intCurrentUnits"].Value;
				
				return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsEquipment::EquipmentDetail_Alt::Error occured.\n" + ex.Message, ex);
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


		public int EquipmentDetail_Aquis()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_EquipmentDetail_Aquis]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@dtInService",SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "",DataRowVersion.Proposed, m_daInService));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@dtAquired",SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "",DataRowVersion.Proposed, m_daAquired));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPurOrgContact", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPurOrgContact));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@smPurAmount", SqlDbType.Money, 8, ParameterDirection.InputOutput, true, 19, 4, "", DataRowVersion.Proposed, m_curPurAmount));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@intPurUnits", SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iPurUnits));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPurNotes", SqlDbType.VarChar, 250, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPurNotes));
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

				m_daInService = (SqlDateTime)scmCmdToExecute.Parameters["@dtInService"].Value;
				m_daAquired = (SqlDateTime)scmCmdToExecute.Parameters["@dtAquired"].Value;
				m_sPurOrgContact = (SqlString)scmCmdToExecute.Parameters["@vchPurOrgContact"].Value;
				m_curPurAmount = (SqlMoney)scmCmdToExecute.Parameters["@smPurAmount"].Value;
				m_iPurUnits = (SqlInt32)scmCmdToExecute.Parameters["@intPurUnits"].Value;
				m_sPurNotes = (SqlString)scmCmdToExecute.Parameters["@vchPurNotes"].Value;
				
				return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsEquipment::EquipmentDetail_Aquis::Error occured.\n" + ex.Message, ex);
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


		public int EquipmentDetail_Disp()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_EquipmentDetail_Disp]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@Id",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@dtOutService",SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "",DataRowVersion.Proposed, m_daOutOfService));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@dtDisposed",SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "",DataRowVersion.Proposed, m_daDisposed));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDispOrgContact", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDispOrgContact));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@intDispUnits", SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iDispUnits));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@smDispAmount", SqlDbType.Money, 8, ParameterDirection.InputOutput, true, 19, 4, "", DataRowVersion.Proposed, m_curDispAmount));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDispNotes", SqlDbType.VarChar, 250, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDispNotes));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@intDispMethod", SqlDbType.Int, 4,ParameterDirection.InputOutput, true, 10, 0, "",DataRowVersion.Proposed, m_iDispMethod));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDispMethod", SqlDbType.VarChar, 25, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDispMethod));
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

				m_daOutOfService = (SqlDateTime)scmCmdToExecute.Parameters["@dtOutService"].Value;
				m_daDisposed = (SqlDateTime)scmCmdToExecute.Parameters["@dtDisposed"].Value;
				m_sDispOrgContact = (SqlString)scmCmdToExecute.Parameters["@vchDispOrgContact"].Value;
				m_iDispUnits = (SqlInt32)scmCmdToExecute.Parameters["@intDispUnits"].Value;
				m_curDispAmount = (SqlMoney)scmCmdToExecute.Parameters["@smDispAmount"].Value;
				m_sDispNotes = (SqlString)scmCmdToExecute.Parameters["@vchDispNotes"].Value;
				m_iDispMethod = (SqlInt32)scmCmdToExecute.Parameters["@intDispMethod"].Value;
				m_sDispMethod = (SqlString)scmCmdToExecute.Parameters["@vchDispMethod"].Value;
				
				return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsEquipment::EquipmentDetail_Disp::Error occured.\n" + ex.Message, ex);
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


		public void EquipAssignedTo()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_UpdateEquipAssignedTo]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			
			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@UId",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iUserId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@intAssignedTo",SqlDbType.Int, 4,ParameterDirection.Input, false, 10, 0, "",DataRowVersion.Proposed, m_iAssignedTo));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@vchNote", SqlDbType.VarChar, 250, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sNote));
				
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

				if(m_iErrorCode != (int)Error.AllOk)
				{
					// Throw error.
					throw new Exception("Stored Procedure 'sp_UpdateEquipAssignedTo' reported the ErrorCode: " + m_iErrorCode);
				}
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsEquipment::EquipAssignedTo::Error occured.\n" + ex.Message, ex);
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


		public DataTable GetEquipAssignTo()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipAssignTo]";
			scmCmdToExecute.CommandType = CommandType.StoredProcedure;
			DataTable dtToReturn = new DataTable("Result");
			SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

			// Use base class' connection object
			scmCmdToExecute.Connection = m_scoMainConnection;
			try
			{
				scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iOrgId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId",SqlDbType.Int, 4,ParameterDirection.Input,false, 10, 0, "",DataRowVersion.Proposed, m_iId));
				
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
					throw new Exception("Stored Procedure 'sp_SelectEquipAssignTo' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsEquipment::GetEquipAssignTo::Error occured.\n" + ex.Message, ex);
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


		public DataTable EquipmentDetail_CustomFields(SqlParameter[] parameters)
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_EquipmentDetail_CustomFields]";
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
				scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4,ParameterDirection.Input, true, 10, 0, "",DataRowVersion.Proposed, m_iUserId));
				scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4,ParameterDirection.Input, true, 10, 0, "",DataRowVersion.Proposed, m_iTypeId));
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
					throw new Exception("Stored Procedure 'sp_EquipmentDetail_CustomFields' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsEquipment::EquipmentDetail_CustomFields::Error occured.\n" + ex.Message, ex);
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


		public DataTable GetEquipTypesList()
		{
			SqlCommand	scmCmdToExecute = new SqlCommand();
			scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipTypeList]";
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
					throw new Exception("Stored Procedure 'sp_SelectEquipTypeList' reported the ErrorCode: " + m_iErrorCode);
				}

				return dtToReturn;
			}
			catch(Exception ex)
			{
				// some error occured. Bubble it to caller and encapsulate Exception object
				throw new Exception("clsEquipment::GetEquipTypesList::Error occured.\n" + ex.Message, ex);
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
		public SqlString sAssignedTo
		{
			get
			{
				return m_sAssignedTo;
			}
			set
			{
				m_sAssignedTo = value;
			}
		}
		public SqlInt32 iAssignedTo
		{
			get
			{
				return m_iAssignedTo;
			}
			set
			{
				m_iAssignedTo = value;
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
		
		public SqlString sStatus
		{
			get
			{
				return m_sStatus;
			}
			set
			{
				m_sStatus = value;
			}
		}
		public SqlInt32	iStatusId
		{
			get
			{
				return m_iStatusId;
			}
			set
			{
				m_iStatusId = value;
			}
		}
		public SqlString sPMSched
		{
			get
			{
				return m_sPMSched;
			}
			set
			{
				m_sPMSched = value;
			}
		}
		public SqlInt32	iPMSched
		{
			get
			{
				return m_iPMSched;
			}
			set
			{
				m_iPMSched = value;
			}
		}
		public SqlString sInspect
		{
			get
			{
				return m_sInspect;
			}
			set
			{
				m_sInspect = value;
			}
		}
		public SqlInt32 iInspectId
		{
			get
			{
				return m_iInspectId;
			}
			set
			{
				m_iInspectId = value;
			}
		}
		public SqlInt32	iCurrentUnits
		{
			get
			{
				return m_iCurrentUnits;
			}
			set
			{
				m_iCurrentUnits = value;
			}
		}
		public SqlDateTime daInService
		{
			get
			{
				return m_daInService;
			}
			set
			{
				m_daInService = value;
			}
		}
		public SqlDateTime daAquired
		{
			get
			{
				return m_daAquired;
			}
			set
			{
				m_daAquired = value;
			}
		}
		public SqlString sPurOrgContact
		{
			get
			{
				return m_sPurOrgContact;
			}
			set
			{
				m_sPurOrgContact = value;
			}
		}
		public SqlMoney curPurAmount
		{
			get
			{
				return m_curPurAmount;
			}
			set
			{
				m_curPurAmount = value;
			}
		}
		public SqlInt32 iPurUnits
		{
			get
			{
				return m_iPurUnits;
			}
			set
			{
				m_iPurUnits = value;
			}
		}
		public SqlString sPurNotes
		{
			get
			{
				return m_sPurNotes;
			}
			set
			{
				m_sPurNotes = value;
			}
		}
		public SqlDateTime daOutOfService
		{
			get
			{
				return m_daOutOfService;
			}
			set
			{
				m_daOutOfService = value;
			}
		}
		public SqlDateTime daDisposed
		{
			get
			{
				return m_daDisposed;
			}
			set
			{
				m_daDisposed = value;
			}
		}
		public SqlString sDispOrgContact
		{
			get
			{
				return m_sDispOrgContact;
			}
			set
			{
				m_sDispOrgContact = value;
			}
		}
		public SqlMoney curDispAmount
		{
			get
			{
				return m_curDispAmount;
			}
			set
			{
				m_curDispAmount = value;
			}
		}
		public SqlInt32 iDispUnits
		{
			get
			{
				return m_iDispUnits;
			}
			set
			{
				m_iDispUnits = value;
			}
		}
		public SqlString sDispNotes
		{
			get
			{
				return m_sDispNotes;
			}
			set
			{
				m_sDispNotes = value;
			}
		}
		public SqlString sDispMethod
		{
			get
			{
				return m_sDispMethod;
			}
			set
			{
				m_sDispMethod = value;
			}
		}
		
		public SqlInt32	iDispMethod
		{
			get
			{
				return m_iDispMethod;
			}
			set
			{
				m_iDispMethod = value;
			}
		}
		public SqlString sNote
		{
			get
			{
				return m_sNote;
			}
			set
			{
				m_sNote = value;
			}
		}
		
		public SqlInt32	iModelId
		{
			get
			{
				return m_iModelId;
			}
			set
			{
				m_iModelId = value;
			}
		}
		public SqlString sMakeModelName
		{
			get
			{
				return  m_sMakeModelName;
			}
			set
			{
				m_sMakeModelName = value;
			}
		}
		public SqlInt32	iYear
		{
			get
			{
				return m_iYear;
			}
			set
			{
				m_iYear = value;
			}
		}
		public SqlInt32	iDeptId
		{
			get
			{
				return m_iDeptId;
			}
			set
			{
				m_iDeptId = value;
			}
		}
		public SqlString sDeptName
		{
			get
			{
				return m_sDeptName;
			}
			set
			{
				m_sDeptName = value;
			}
		}
		public SqlInt32	iLocId
		{
			get
			{
				return m_iLocId;
			}
			set
			{
				m_iLocId = value;
			}
		}
		public SqlString sLocName
		{
			get
			{
				return m_sLocName;
			}
			set
			{
				m_sLocName = value;
			}
		}
		public SqlBoolean bShare
		{
			get
			{
				return m_bShare;
			}
			set
			{
				m_bShare = value;
			}
		}
		public SqlString sFuelCode
		{
			get
			{
				return m_sFuelCode;
			}
			set
			{
				m_sFuelCode = value;
			}
		}
		public SqlString sEquipId
		{
			get
			{
				return m_sEquipId;
			}
			set
			{
				m_sEquipId = value;
			}
		}
		public SqlString sVinSerial
		{
			get
			{
				return m_sVinSerial;
			}
			set
			{
				m_sVinSerial =value;
			}
		}
		public SqlString sPlateNumber
		{
			get
			{
				return m_sPlateNumber;
			}
			set
			{
				m_sPlateNumber = value;
			}
		}
		public SqlString sCreatedBy
		{
			get
			{
				return m_sCreatedBy;
			}
			set
			{
				m_sCreatedBy = value;
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
		public SqlString sUpdatedBy
		{
			get
			{
				return m_sUpdatedBy;
			}
			set
			{
				m_sUpdatedBy = value;
			}
		}
		public SqlDateTime daUpdated
		{
			get
			{
				return m_daUpdated;
			}
			set
			{
				m_daUpdated = value;
			}
		}
		#endregion
	}
}
