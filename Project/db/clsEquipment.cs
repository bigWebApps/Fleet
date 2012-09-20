using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;


namespace BWA.BFP.Data
{

    public class clsEquipment : clsDBInteractionBase
    {
        #region Class Member Declarations
        private SqlString m_cAction;
        private SqlInt32 m_iId;
        private SqlInt32 m_iOrgId;
        private SqlString m_sType;
        private SqlInt32 m_iTypeId;
        private SqlString m_sEquipOperator;
        private SqlInt32 m_iEquipOperatorId;
        private SqlString m_sTempOperator;
        private SqlInt32 m_iTempOperatorId;
        private SqlInt32 m_iUserId;
        private SqlString m_sStatus;
        private SqlInt32 m_iStatusId;
        private SqlString m_sPMSched;
        private SqlInt32 m_iPMSched;
        private SqlString m_sInspect;
        private SqlInt32 m_iInspectId;
        private SqlString m_sInspectSchedule;
        private SqlInt32 m_iInspectScheduleId;
        private SqlDecimal m_dmCurrentUnits;
        private SqlDateTime m_daInService;
        private SqlDateTime m_daAquired;
        private SqlString m_sPurOrgContact;
        private SqlMoney m_curPurAmount;
        private SqlDecimal m_dmPurUnits;
        private SqlString m_sPurNotes;
        private SqlDateTime m_daOutOfService;
        private SqlDateTime m_daDisposed;
        private SqlString m_sDispOrgContact;
        private SqlMoney m_curDispAmount;
        private SqlDecimal m_dmDispUnits;
        private SqlString m_sDispNotes;
        private SqlString m_sDispMethod;
        private SqlInt32 m_iDispMethod;
        private SqlString m_sNote;
        private SqlInt32 m_iModelId;
        private SqlString m_sMakeModelName;
        private SqlInt32 m_iYear;
        private SqlInt32 m_iDeptId;
        private SqlString m_sDeptName;
        private SqlInt32 m_iLocId;
        private SqlString m_sLocName;
        private SqlBoolean m_bSpare;
        private SqlInt32 m_iIsSpare;
        private SqlString m_sFuelCode;
        private SqlString m_sEquipId;
        private SqlString m_sVinSerial;
        private SqlString m_sPlateNumber;
        private SqlString m_sCreatedBy;
        private SqlDateTime m_daCreated;
        private SqlString m_sUpdatedBy;
        private SqlDateTime m_daUpdated;
        private SqlString m_sEquipId_Filter;
        private SqlInt32 m_iOrderId;
        private SqlBoolean m_bEnableDefaultFiltration;
        private SqlBoolean m_bSelect;
        private SqlString m_sMeasure;
        private SqlString m_sLink;
        private SqlDateTime m_daMinDate;
        private SqlDateTime m_daMaxDate;
        #endregion

        public clsEquipment()
        {
        }


        public DataTable GetEquipList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipList]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTypeId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipList::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetSpareEquipList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectSpareEquipListByType]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetSpareEquipList::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetEquipList_Filter(bool bShowUnassigned)
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipList_Filter]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTypeId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@DepId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iDeptId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@LocId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iLocId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@IsSpare", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iIsSpare));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchLink", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sLink));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@bitShowUnassigned", SqlDbType.Bit, 1, ParameterDirection.Input, false, 1, 0, "", DataRowVersion.Proposed, (SqlBoolean)bShowUnassigned));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipID_Filter", SqlDbType.VarChar, 255, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sEquipId_Filter));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipList_Filter::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetEquipInspectList_Filter()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipInspectList_Filter]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTypeId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@DepId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iDeptId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@LocId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iLocId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@IsSpare", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iIsSpare));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipID_Filter", SqlDbType.VarChar, 255, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sEquipId_Filter));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipInspectList_Filter::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetEquipList_ForSpare()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipListForSpare]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@bitDefaultFiltration", SqlDbType.Bit, 1, ParameterDirection.Input, false, 1, 0, "", DataRowVersion.Proposed, m_bEnableDefaultFiltration));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrderId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iTypeId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@DepId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iDeptId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@LocId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iLocId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipID_Filter", SqlDbType.VarChar, 255, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sEquipId_Filter));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                m_iTypeId = (SqlInt32)scmCmdToExecute.Parameters["@TypeId"].Value;

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipList_ForSpare::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
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
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipStatusList]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);
                m_iErrorCode = 0;

                if (m_iErrorCode != (int)Error.AllOk)
                {
                    // Throw error.
                    throw new Exception("Stored Procedure 'sp_SelectEquipStatusList' reported the ErrorCode: " + m_iErrorCode);
                }

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipStatusList::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
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
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectDispMethodsList]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);
                m_iErrorCode = 0;

                if (m_iErrorCode != (int)Error.AllOk)
                {
                    // Throw error.
                    throw new Exception("Stored Procedure 'GetEquipDispMethodsList' reported the ErrorCode: " + m_iErrorCode);
                }

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipDispMethodsList::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataSet GetReportedIssueLists()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectReportedIssueListsForEquipment]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataSet dsToReturn = new DataSet("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dsToReturn);

                return dsToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetReportedIssueLists::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
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
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_EquipmentDetail_Main]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iTypeId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchTypeName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sType));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ModelId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iModelId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchMakeModelName", SqlDbType.VarChar, 101, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sMakeModelName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intYear", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iYear));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipOperatorId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iEquipOperatorId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TempOperatorId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iTempOperatorId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipOperator", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipOperator));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchTempOperator", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sTempOperator));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@DeptId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iDeptId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDeptName", SqlDbType.VarChar, 25, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDeptName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@LocId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iLocId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchLocName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sLocName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@bitSpare", SqlDbType.Bit, 1, ParameterDirection.InputOutput, true, 1, 0, "", DataRowVersion.Proposed, m_bSpare));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchFuelCode", SqlDbType.VarChar, 20, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sFuelCode));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchVinSerial", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sVinSerial));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPlateNumber", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPlateNumber));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmCurrentUnits", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 19, 8, "", DataRowVersion.Proposed, m_dmCurrentUnits));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intCreatedBy", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchCreatedBy", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sCreatedBy));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCreated", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daCreated));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intUpdatedBy", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchUpdatedBy", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sUpdatedBy));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtUpdated", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daUpdated));
                scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
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
                m_iEquipOperatorId = (SqlInt32)scmCmdToExecute.Parameters["@EquipOperatorId"].Value;
                m_iTempOperatorId = (SqlInt32)scmCmdToExecute.Parameters["@TempOperatorId"].Value;
                m_sEquipOperator = (SqlString)scmCmdToExecute.Parameters["@vchEquipOperator"].Value;
                m_sTempOperator = (SqlString)scmCmdToExecute.Parameters["@vchTempOperator"].Value;
                m_iDeptId = (SqlInt32)scmCmdToExecute.Parameters["@DeptId"].Value;
                m_sDeptName = (SqlString)scmCmdToExecute.Parameters["@vchDeptName"].Value;
                m_iLocId = (SqlInt32)scmCmdToExecute.Parameters["@LocId"].Value;
                m_sLocName = (SqlString)scmCmdToExecute.Parameters["@vchLocName"].Value;
                m_bSpare = (SqlBoolean)scmCmdToExecute.Parameters["@bitSpare"].Value;
                m_sFuelCode = (SqlString)scmCmdToExecute.Parameters["@vchFuelCode"].Value;
                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;
                m_sVinSerial = (SqlString)scmCmdToExecute.Parameters["@vchVinSerial"].Value;
                m_sPlateNumber = (SqlString)scmCmdToExecute.Parameters["@vchPlateNumber"].Value;
                m_dmCurrentUnits = (SqlDecimal)scmCmdToExecute.Parameters["@dmCurrentUnits"].Value;
                m_iUserId = (SqlInt32)scmCmdToExecute.Parameters["@intUpdatedBy"].Value;
                m_sCreatedBy = (SqlString)scmCmdToExecute.Parameters["@vchCreatedBy"].Value;
                m_daCreated = (SqlDateTime)scmCmdToExecute.Parameters["@dtCreated"].Value;
                m_sUpdatedBy = (SqlString)scmCmdToExecute.Parameters["@vchUpdatedBy"].Value;
                m_daUpdated = (SqlDateTime)scmCmdToExecute.Parameters["@dtUpdated"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::EquipmentDetail::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public int EquipmentDetail_Alt()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_EquipmentDetail_Alt]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@PMScheduleId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iPMSched));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPMSchedName", SqlDbType.VarChar, 25, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPMSched));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectScheduleId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iInspectScheduleId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchInspectScheduleName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sInspectSchedule));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmCurrentUnits", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 19, 8, "", DataRowVersion.Proposed, m_dmCurrentUnits));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intUpdatedBy", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                scmCmdToExecute.ExecuteNonQuery();

                m_iPMSched = (SqlInt32)scmCmdToExecute.Parameters["@PMScheduleId"].Value;
                m_sPMSched = (SqlString)scmCmdToExecute.Parameters["@vchPMSchedName"].Value;
                m_iInspectScheduleId = (SqlInt32)scmCmdToExecute.Parameters["@InspectScheduleId"].Value;
                m_sInspectSchedule = (SqlString)scmCmdToExecute.Parameters["@vchInspectScheduleName"].Value;
                m_dmCurrentUnits = (SqlDecimal)scmCmdToExecute.Parameters["@dmCurrentUnits"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::EquipmentDetail_Alt::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public int EquipmentDetail_Aquis()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_EquipmentDetail_Aquis]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtInService", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daInService));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtAquired", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daAquired));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPurOrgContact", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPurOrgContact));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@smPurAmount", SqlDbType.Money, 8, ParameterDirection.InputOutput, true, 19, 4, "", DataRowVersion.Proposed, m_curPurAmount));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmPurUnits", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 19, 8, "", DataRowVersion.Proposed, m_dmPurUnits));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPurNotes", SqlDbType.VarChar, 250, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPurNotes));
                scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
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
                m_dmPurUnits = (SqlDecimal)scmCmdToExecute.Parameters["@dmPurUnits"].Value;
                m_sPurNotes = (SqlString)scmCmdToExecute.Parameters["@vchPurNotes"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::EquipmentDetail_Aquis::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public int EquipmentDetail_Disp()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_EquipmentDetail_Disp]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtOutService", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daOutOfService));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtDisposed", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daDisposed));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDispOrgContact", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDispOrgContact));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmDispUnits", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 19, 8, "", DataRowVersion.Proposed, m_dmDispUnits));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@smDispAmount", SqlDbType.Money, 8, ParameterDirection.InputOutput, true, 19, 4, "", DataRowVersion.Proposed, m_curDispAmount));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDispNotes", SqlDbType.VarChar, 250, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDispNotes));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intDispMethod", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iDispMethod));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDispMethod", SqlDbType.VarChar, 25, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDispMethod));
                scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                scmCmdToExecute.ExecuteNonQuery();

                m_daOutOfService = (SqlDateTime)scmCmdToExecute.Parameters["@dtOutService"].Value;
                m_daDisposed = (SqlDateTime)scmCmdToExecute.Parameters["@dtDisposed"].Value;
                m_sDispOrgContact = (SqlString)scmCmdToExecute.Parameters["@vchDispOrgContact"].Value;
                m_dmDispUnits = (SqlDecimal)scmCmdToExecute.Parameters["@dmDispUnits"].Value;
                m_curDispAmount = (SqlMoney)scmCmdToExecute.Parameters["@smDispAmount"].Value;
                m_sDispNotes = (SqlString)scmCmdToExecute.Parameters["@vchDispNotes"].Value;
                m_iDispMethod = (SqlInt32)scmCmdToExecute.Parameters["@intDispMethod"].Value;
                m_sDispMethod = (SqlString)scmCmdToExecute.Parameters["@vchDispMethod"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::EquipmentDetail_Disp::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public void EquipAssignedTo()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateEquipAssignedTo]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipOperatorId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iEquipOperatorId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchNote", SqlDbType.VarChar, 250, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sNote));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                scmCmdToExecute.ExecuteNonQuery();

                if (m_iErrorCode != (int)Error.AllOk)
                {
                    // Throw error.
                    throw new Exception("Stored Procedure 'sp_UpdateEquipAssignedTo' reported the ErrorCode: " + m_iErrorCode);
                }
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::EquipAssignedTo::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public void EquipAssignedTempTo()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateEquipAssignedTempTo]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TempOperatorId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTempOperatorId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchNote", SqlDbType.VarChar, 250, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sNote));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                scmCmdToExecute.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::EquipAssignedTempTo::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public int EquipSpareTo(bool IsOperator)
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateEquipSpare]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrderId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@SpareEquipId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchNote", SqlDbType.VarChar, 250, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sNote));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, DateTime.Now));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@IsOperator", SqlDbType.Bit, 1, ParameterDirection.Input, false, 1, 0, "", DataRowVersion.Proposed, IsOperator));
                scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                scmCmdToExecute.ExecuteNonQuery();

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::EquipSpareTo::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public void GetEquipId()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetEquipId]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Output, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipType", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sType));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchMakeModelName", SqlDbType.VarChar, 101, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sMakeModelName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intYear", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iYear));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                scmCmdToExecute.ExecuteNonQuery();

                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@EquipId"].Value;
                m_sType = (SqlString)scmCmdToExecute.Parameters["@vchEquipType"].Value;
                m_sMakeModelName = (SqlString)scmCmdToExecute.Parameters["@vchMakeModelName"].Value;
                m_iYear = (SqlInt32)scmCmdToExecute.Parameters["@intYear"].Value;

                return;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipId::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public int SearchEquipId()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetEquipSearch]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Output, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                scmCmdToExecute.ExecuteNonQuery();

                int miId = 0;

                if (scmCmdToExecute.Parameters["@EquipId"].Value != null)
                {
                    int.TryParse(scmCmdToExecute.Parameters["@EquipId"].Value.ToString(), out miId);
                    m_iId = SqlInt32.Parse(scmCmdToExecute.Parameters["@EquipId"].Value.ToString());
                }
                return miId;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::sp_GetEquipSearch::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public int GetEquipInfo()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetEquipInfo_Alt]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipType", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sType));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchMakeModelName", SqlDbType.VarChar, 101, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sMakeModelName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intYear", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iYear));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmCurrentUnits", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 19, 8, "", DataRowVersion.Proposed, m_dmCurrentUnits));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchMeasureName", SqlDbType.VarChar, 255, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sMeasure));
                scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                scmCmdToExecute.ExecuteNonQuery();

                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;
                m_sType = (SqlString)scmCmdToExecute.Parameters["@vchEquipType"].Value;
                m_sMakeModelName = (SqlString)scmCmdToExecute.Parameters["@vchMakeModelName"].Value;
                m_iYear = (SqlInt32)scmCmdToExecute.Parameters["@intYear"].Value;
                m_dmCurrentUnits = (SqlDecimal)scmCmdToExecute.Parameters["@dmCurrentUnits"].Value;
                m_sMeasure = (SqlString)scmCmdToExecute.Parameters["@vchMeasureName"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipInfo::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public int GetSpareEquip()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetSpareEquip]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrderId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@SpareEquipId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchSpareEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchSpareEquipType", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sType));
                scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                scmCmdToExecute.ExecuteNonQuery();

                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@SpareEquipId"].Value;
                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchSpareEquipId"].Value;
                m_sType = (SqlString)scmCmdToExecute.Parameters["@vchSpareEquipType"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipInfo::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
            }
        }


        public DataTable GetEquipAssignTo()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipAssignTo]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                m_iErrorCode = 0;

                if (m_iErrorCode != (int)Error.AllOk)
                {
                    // Throw error.
                    throw new Exception("Stored Procedure 'sp_SelectEquipAssignTo' reported the ErrorCode: " + m_iErrorCode);
                }

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipAssignTo::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetEquipListByUser()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipListByUser]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipListByUser::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetEquipListByOperator()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipListByOperator]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipListByOperator::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetEquipListByOperator2()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipListByOperator2]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, DateTime.Now));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipListByOperator::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetEquipListByOperatorActivate()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipListByOperatorActivate]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipListByOperatorActivate::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetEquipListForCheckOut()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipListForCheckOut]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipListForCheckOut::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
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
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_EquipmentDetail_CustomFields]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iTypeId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Default, null));

                if (parameters != null)
                {
                    foreach (SqlParameter parameter in parameters)
                    {
                        scmCmdToExecute.Parameters.Add(parameter);
                    }
                }
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);
                m_iId = (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
                m_iErrorCode = 0;

                if (m_iErrorCode != (int)Error.AllOk)
                {
                    // Throw error.
                    throw new Exception("Stored Procedure 'sp_EquipmentDetail_CustomFields' reported the ErrorCode: " + m_iErrorCode);
                }

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::EquipmentDetail_CustomFields::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
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
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipTypeList]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);
                m_iErrorCode = 0;
                if (m_iErrorCode != (int)Error.AllOk)
                {
                    // Throw error.
                    throw new Exception("Stored Procedure 'sp_SelectEquipTypeList' reported the ErrorCode: " + m_iErrorCode);
                }

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipTypesList::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetTempOperatorsAssignmentList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectTempOperatorsAssignment]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtMinDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daMinDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtMaxDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daMaxDate));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetTempOperatorsAssignmentList::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetEquipmentAssignmentList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipmentAssignment]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtMinDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daMinDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtMaxDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daMaxDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetEquipmentAssignmentList::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Close connection.
                    m_scoMainConnection.Close();
                }
                scmCmdToExecute.Dispose();
                sdaAdapter.Dispose();
            }
        }


        public DataTable GetOrderListByTechnicianActivate()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderListForTech]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TechId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));

                if (m_bMainConnectionIsCreatedLocal)
                {
                    // Open connection.
                    m_scoMainConnection.Open();
                }
                else
                {
                    if (m_cpMainConnectionProvider.bIsTransactionPending)
                    {
                        scmCmdToExecute.Transaction = m_cpMainConnectionProvider.stCurrentTransaction;
                    }
                }

                // Execute query.
                sdaAdapter.Fill(dtToReturn);

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsEquipment::GetOrderListByTechnicianActivate::Error occured.\n" + ex.Message, ex);
            }
            finally
            {
                if (m_bMainConnectionIsCreatedLocal)
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

        public SqlInt32 iTypeId
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
        public SqlString sEquipOperator
        {
            get
            {
                return m_sEquipOperator;
            }
            set
            {
                m_sEquipOperator = value;
            }
        }
        public SqlInt32 iEquipOperatorId
        {
            get
            {
                return m_iEquipOperatorId;
            }
            set
            {
                m_iEquipOperatorId = value;
            }
        }
        public SqlString sTempOperator
        {
            get
            {
                return m_sTempOperator;
            }
            set
            {
                m_sTempOperator = value;
            }
        }
        public SqlInt32 iTempOperatorId
        {
            get
            {
                return m_iTempOperatorId;
            }
            set
            {
                m_iTempOperatorId = value;
            }
        }
        public SqlInt32 iUserId
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
        public SqlInt32 iStatusId
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
        public SqlInt32 iPMSched
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
        public SqlString sInspectSchedule
        {
            get
            {
                return m_sInspectSchedule;
            }
            set
            {
                m_sInspectSchedule = value;
            }
        }
        public SqlInt32 iInspectScheduleId
        {
            get
            {
                return m_iInspectScheduleId;
            }
            set
            {
                m_iInspectScheduleId = value;
            }
        }
        public SqlDecimal dmCurrentUnits
        {
            get
            {
                return m_dmCurrentUnits;
            }
            set
            {
                m_dmCurrentUnits = value;
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
        public SqlDecimal dmPurUnits
        {
            get
            {
                return m_dmPurUnits;
            }
            set
            {
                m_dmPurUnits = value;
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
        public SqlDecimal dmDispUnits
        {
            get
            {
                return m_dmDispUnits;
            }
            set
            {
                m_dmDispUnits = value;
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

        public SqlInt32 iDispMethod
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

        public SqlInt32 iModelId
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
                return m_sMakeModelName;
            }
            set
            {
                m_sMakeModelName = value;
            }
        }
        public SqlInt32 iYear
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
        public SqlInt32 iDeptId
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
        public SqlInt32 iLocId
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
        public SqlBoolean bSpare
        {
            get
            {
                return m_bSpare;
            }
            set
            {
                m_bSpare = value;
            }
        }
        public SqlInt32 iIsSpare
        {
            get
            {
                return m_iIsSpare;
            }
            set
            {
                m_iIsSpare = value;
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
                m_sVinSerial = value;
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
        public SqlString sEquipId_Filter
        {
            get
            {
                return m_sEquipId_Filter;
            }
            set
            {
                m_sEquipId_Filter = value;
            }
        }
        public SqlInt32 iOrderId
        {
            get
            {
                return m_iOrderId;
            }
            set
            {
                m_iOrderId = value;
            }
        }
        public SqlBoolean EnableDefaultFiltration
        {
            get
            {
                return m_bEnableDefaultFiltration;
            }
            set
            {
                m_bEnableDefaultFiltration = value;
            }
        }
        public SqlBoolean bSelect
        {
            get
            {
                return m_bSelect;
            }
            set
            {
                m_bSelect = value;
            }
        }
        public SqlString sMeasure
        {
            get
            {
                return m_sMeasure;
            }
            set
            {
                m_sMeasure = value;
            }
        }
        public SqlString sLink
        {
            get
            {
                return m_sLink;
            }
            set
            {
                m_sLink = value;
            }
        }
        public SqlDateTime daMinDate
        {
            get
            {
                return m_daMinDate;
            }
            set
            {
                m_daMinDate = value;
            }
        }
        public SqlDateTime daMaxDate
        {
            get
            {
                return m_daMaxDate;
            }
            set
            {
                m_daMaxDate = value;
            }
        }
        #endregion
    }
}
