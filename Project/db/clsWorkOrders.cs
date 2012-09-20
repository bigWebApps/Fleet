using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using System.Collections;
using System.Xml;


namespace BWA.BFP.Data
{
    public class clsWorkOrders : clsDBInteractionBase
    {
        #region Class Member Declarations
        private SqlString m_cAction;
        private SqlInt32 m_iId;
        private SqlInt32 m_iOrgId;
        private SqlInt32 m_iEquipId;
        private SqlString m_sEquipId;
        private SqlInt32 m_iWorkOrderNumber;
        private SqlString m_sEquipTypeName;
        private SqlString m_sEquipMakeModel;
        private SqlString m_sEquipYear;
        private SqlString m_sEquipVinSerial;
        private SqlInt32 m_iSpareEquipId;
        private SqlString m_sSpareEquipId;
        private SqlInt32 m_iTypeId;
        private SqlString m_sType;
        private SqlInt32 m_iStatusId;
        private SqlString m_sStatusId;
        private SqlInt32 m_iOperatorStatusId;
        private SqlString m_sOperatorStatus;
        private SqlInt32 m_iDataId;
        private SqlBoolean m_bActive;
        private SqlString m_sDecs;
        private SqlInt32 m_iOperatorId;
        private SqlString m_sOperatorName;
        private SqlInt32 m_iTechId;
        private SqlString m_sTechName;
        private SqlDecimal m_dmMileage;
        private SqlBoolean m_bStaying;
        private SqlBoolean m_bSpare;
        private SqlBoolean m_bPrint;
        private SqlString m_sDropedOffBy;
        private SqlString m_sReleasedTo;
        private SqlString m_sCleanliness;
        private SqlDateTime m_daScheduled;
        private SqlDateTime m_daArrival;
        private SqlDateTime m_daOpened;
        private SqlDateTime m_daCompleted;
        private SqlDateTime m_daClosed;
        private SqlDateTime m_daDeparture;
        private SqlInt32 m_iUserId;
        private SqlString m_sCreatedBy;
        private SqlDateTime m_daCreated;
        private SqlString m_sUpdatedBy;
        private SqlDateTime m_daUpdated;
        private SqlString m_sMeasure;
        private SqlInt32 m_iSchedDetailId;
        private SqlString m_sServiceName;
        private SqlInt32 m_iPMHistoryId;
        private SqlDateTime m_daDateHistory;
        private SqlDecimal m_dmUnitsHistory;
        private SqlInt32 m_iPMStatus;
        private SqlInt32 m_iPMItemId;
        private SqlInt32 m_iWOPMItemId;
        private SqlBoolean m_bChecked;
        private SqlBoolean m_bIsProcessed;
        private SqlInt32 m_iServiceResultId;
        private SqlInt32 m_iServiceCheckId;
        private SqlDateTime m_daReportDate;
        private SqlInt32 m_iInspectHistoryId;
        private SqlInt32 m_iInspectionId;
        private SqlString m_sInspectionName;
        private SqlString m_sInspectSchedule;
        private SqlInt32 m_iInspectScheduleId;
        private SqlInt32 m_iInspectSchedDetailId;
        private SqlInt32 m_iInspectTargetDays;
        private SqlString m_sEquipMake;
        private SqlString m_sEquipModel;
        private SqlInt32 m_iWOInspectItemId;
        private SqlInt32 m_iInspectItemId;
        private SqlInt32 m_iWOInspectionId;
        private SqlString m_sWorkOrderId;
        private SqlString m_sWODetails;
        private SqlString m_sEquipDetails;
        private SqlString m_sInitials;
        private SqlString m_sPIN;
        private SqlString m_sTypeService;
        private SqlInt32 m_iItemId;
        private SqlBoolean m_bWizardUpdate;
        private SqlInt32 m_iNoteId;
        private SqlInt32 m_iNoteTypeId;
        private SqlString m_sNote;
        private SqlInt32 m_iReOpenCategoryId;

        // begin repairs bloc
        private SqlInt32 m_iReportedIssueId;
        private SqlString m_sReportDesc;
        private SqlInt32 m_iLastWorkOrderId;
        private SqlInt32 m_iRepairCatId;
        private SqlBoolean m_Insert = false;
        private SqlString m_sRepairCatName;
        private SqlString m_sRepairCatDesc;
        private SqlInt32 m_iRepairId;
        private SqlString m_sRepairDesc;
        private SqlInt32 m_iRepairItemId;
        private SqlString m_sRepairItemDesc;
        private SqlInt32 m_iRepairReasonId;
        private SqlString m_sRepairReasonDesc;
        private SqlInt32 m_iRepairMultId;
        private SqlInt32 m_iPartUsedId;
        private SqlInt32 m_iPartUsedQty;
        private SqlString m_sPartUsedStock;
        private SqlString m_sPartUsedDesc;
        private SqlDecimal m_dmPartUsedCost;

        private SqlDateTime m_daMinDate;
        private SqlDateTime m_daMaxDate;
        private SqlDateTime m_daCurrentDate;
        private SqlInt32 m_iDocumentId;
        private SqlInt32 m_iDocumentTypeId;
        private SqlString m_sUserName;
        private SqlString m_sLastInspection;
        private SqlString m_sDatesRange;
        private SqlInt32 m_iTimeLogId;
        private SqlDateTime m_daStartTime;
        private SqlDateTime m_daStopTime;
        private SqlDecimal m_dmHours;
        private SqlDecimal m_dmHourlyRate;
        #endregion

        public clsWorkOrders()
        {

        }


        public DataTable GetWOListFromEquip()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderListFromEquip]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));

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
                throw new Exception("clsWorkOrders::GetWOListFromEquip::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetEquipWorkOrderReport()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderListForEquip]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtMinDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daMinDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtMaxDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daMaxDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTypeId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@CategoryId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iRepairCatId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TechId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTechId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OperatorId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOperatorId));

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
                throw new Exception("clsWorkOrders::GetEquipWorkOrderReport::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetWOListForDate()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderListForDate]";
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
                throw new Exception("clsWorkOrders::GetWOListForDate::Error occured.\n" + ex.Message, ex);
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


        public DataSet GetWOListForToday()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderListForToday]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataSet dsToReturn = new DataSet("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));

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
                throw new Exception("clsWorkOrders::GetWOListForToday::Error occured.\n" + ex.Message, ex);
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


        public string GetWOListForTime()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderListForTime]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            //System.Xml.XmlDocument xmlDoc = new System.Xml.XmlDocument();
            System.Xml.XmlReader xmlReader;
            //DataSet dsToReturn = new DataSet("Result");
            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                string sResult;

                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDay", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));

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
                xmlReader = scmCmdToExecute.ExecuteXmlReader();
                xmlReader.Read();
                sResult = "";
                while (xmlReader.ReadState != ReadState.EndOfFile)
                {
                    sResult += xmlReader.ReadOuterXml();
                }

                xmlReader.Close();

                //return dsToReturn.GetXml();
                return "<WorkOrders>" + sResult + "</WorkOrders>";
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetWOListForToday::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetWOUnsignedList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderUnsigned]";
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetWOUnsignedList::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetWOUnassignedList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderUnassigned]";
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetWOUnassignedList::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetWOCompletedList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderCompleted]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OperatorId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOperatorId));

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
                throw new Exception("clsWorkOrders::GetWOCompletedList::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetCategoryList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectCategoryList]";
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetCategoryList::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetReOpenCategoryList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectReOpenCategoryList]";
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetReOpenCategoryList::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetPartsUsedList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectPartsUsed]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iRepairId));

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
                throw new Exception("clsWorkOrders::GetPartsUsedList::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetPartsUsedListForOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectPartsUsedForOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTechId));

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
                throw new Exception("clsWorkOrders::GetPartsUsedListForOrder::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetPartsUsedListForReport()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectPartsForReport]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

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
                throw new Exception("clsWorkOrders::GetPartsUsedListForReport::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetSpareEquips()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectEquipListForSpare2]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

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
                throw new Exception("clsWorkOrders::GetSpareEquips::Error occured.\n" + ex.Message, ex);
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
            scmCmdToExecute.CommandText = "dbo.[sp_SelectReportedIssueListsForWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataSet dsToReturn = new DataSet("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
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
                sdaAdapter.Fill(dsToReturn);

                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;

                return dsToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetReportedIssueLists::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetReportedIssueListsOperatorKiosk()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectReportedIssueListsForOpeartorKiosk]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

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
                throw new Exception("clsWorkOrders::GetReportedIssueListsOperatorKiosk::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetPMServicesListForWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectPMServicesListForWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipCurUnits", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 19, 8, "", DataRowVersion.Proposed, m_dmMileage));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@CurDate", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daReportDate));

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

                dmMileage = (SqlDecimal)scmCmdToExecute.Parameters["@EquipCurUnits"].Value;
                m_daReportDate = (SqlDateTime)scmCmdToExecute.Parameters["@CurDate"].Value;

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetPMServicesListForWorkOrder::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetReportedIssues()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_Report_GetReportedIssues]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetDetailsForWorkOrder::Error occured.\n" + ex.Message, ex);
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

        public DataTable CheckInDetailsForReport(string URL)
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_Report_CheckInDetails]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@URL", SqlDbType.NVarChar, 255, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, URL));

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
                throw new Exception("clsWorkOrders::CheckInDetailsForReport::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetRepairsListForReport()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_Report_RepairsList]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::RepairsList::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetPMItemsList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_Report_GetPMItems]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetPMItemsList::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetDetailsForWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectDetailsForWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetDetailsForWorkOrder::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetInspectionsListForWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectInspectionsListForWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@CurDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));

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
                throw new Exception("clsWorkOrders::GetInspectionsListForWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetWorkOrderPMItems()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderPMItems]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTechId));

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
                throw new Exception("clsWorkOrders::GetWorkOrderPMItems::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetWorkOrderReportedIssues()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderReportedIssues]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTechId));

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
                throw new Exception("clsWorkOrders::GetWorkOrderReportedIssues::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetWorkOrderInspections()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderInspections]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTechId));

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
                throw new Exception("clsWorkOrders::GetWorkOrderInspections::Error occured.\n" + ex.Message, ex);
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


        public DataSet GetWorkOrderIssuesItems()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderIssuesItems]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataSet dsToReturn = new DataSet("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

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
                throw new Exception("clsWorkOrders::GetWorkOrderIssuesItems::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetActivityWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectActivityWorkOrderList]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));

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
                throw new Exception("clsWorkOrders::GetActivityWorkOrder::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetInspectionDetailForReport()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_Report_InspectionDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectionId));

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
                throw new Exception("clsWorkOrders::GetInspectionDetailForReport::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetInspectionListForReport()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_Report_InspectionListForReport]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectionId));

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
                throw new Exception("clsWorkOrders::GetInspectionListForReport::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetInspectionItemsListForReport()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_Report_GetInspectionItems]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectionId));

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
                throw new Exception("clsWorkOrders::GetInspectionItemsListForReport::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetWorkOrderInspectItems()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderInspectionItems]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectionId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTechId));

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
                throw new Exception("clsWorkOrders::GetWorkOrderInspectItems::Error occured.\n" + ex.Message, ex);
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


        public DataSet GetRepairItemsAndCats()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectRepairItemsAndCats]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataSet dsToReturn = new DataSet("Result");
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
                sdaAdapter.Fill(dsToReturn);

                return dsToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetRepairItemsAndCats::Error occured.\n" + ex.Message, ex);
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

        public int GetRepairPreId()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "SELECT TOP 1 id FROM Repairs ORDER BY id DESC";
            scmCmdToExecute.CommandType = CommandType.Text;
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

                return (dtToReturn.Rows.Count > 0) ? ((int)dtToReturn.Rows[0][0]) : 0;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsUsers::UserDetails::Error occured.\n" + ex.Message, ex);
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

        public DataTable GetRepairsList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectRepairsList]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTechId));

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
                throw new Exception("clsWorkOrders::GetRepairsList::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetRepairsShortList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectRepairsListShort]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

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
                throw new Exception("clsWorkOrders::GetRepairsShortList::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetRepairsListUpdate()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectRepairsListForUpdate]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchType", SqlDbType.VarChar, 25, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sTypeService));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iItemId));


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
                throw new Exception("clsWorkOrders::GetRepairsListUpdate::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetReportedIssuesListUpdate()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectReportedIssuesListForUpdate]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectionItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iItemId));


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
                throw new Exception("clsWorkOrders::GetReportedIssuesListUpdate::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetSourceList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectSourceList]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iRepairId));

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
                throw new Exception("clsWorkOrders::GetSourceList::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetTypesList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectWorkOrderTypesList]";
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetTypesList::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetInstructionByCheckIn()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectInstructionByCheckIn]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@btPrint", SqlDbType.Bit, 1, ParameterDirection.InputOutput, true, 1, 0, "", DataRowVersion.Proposed, m_bPrint));

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

                m_bPrint = (SqlBoolean)scmCmdToExecute.Parameters["@btPrint"].Value;

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetInstructionByCheckIn::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetInstructionByCheckOut()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectInstructionByCheckOut]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

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
                throw new Exception("clsWorkOrders::GetInstructionByCheckIOut:Error occured.\n" + ex.Message, ex);
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


        public DataTable GetInstructionByReOpen()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectInstructionByReOpen]";
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetInstructionByReOpen:Error occured.\n" + ex.Message, ex);
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


        public DataTable GetTimeLogList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectTimeLogList]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TechId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iTechId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchTotalHours", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sReportDesc));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchTotalCosts", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDecs));

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

                m_sReportDesc = (SqlString)scmCmdToExecute.Parameters["@vchTotalHours"].Value;
                m_sDecs = (SqlString)scmCmdToExecute.Parameters["@vchTotalCosts"].Value;

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetTimeLogList::Error occured.\n" + ex.Message, ex);
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


        public DataTable WorkOrderDetail_CustomFields(SqlParameter[] parameters)
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_WorkOrderDetail_CustomFields]";
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

                return dtToReturn;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::WorkOrderDetail_CustomFields::Error occured.\n" + ex.Message, ex);
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


        public int WorkOrderReportedIssuesDetail()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_WorkOrderReportedIssuesDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iReportedIssueId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDesc", SqlDbType.VarChar, 4000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sReportDesc));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@LastWorkOrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iLastWorkOrderId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairCatId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairCatId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceResultId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceResultId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceCheckId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceCheckId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairItemId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairMultId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtReport", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daReportDate));
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

                m_iReportedIssueId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
                m_iEquipId = (SqlInt32)scmCmdToExecute.Parameters["@EquipId"].Value;
                m_sReportDesc = (SqlString)scmCmdToExecute.Parameters["@vchDesc"].Value;
                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderId"].Value;
                m_iLastWorkOrderId = (SqlInt32)scmCmdToExecute.Parameters["@LastWorkOrderId"].Value;
                m_iRepairCatId = (SqlInt32)scmCmdToExecute.Parameters["@RepairCatId"].Value;
                m_iServiceResultId = (SqlInt32)scmCmdToExecute.Parameters["@ServiceResultId"].Value;
                m_iServiceCheckId = (SqlInt32)scmCmdToExecute.Parameters["@ServiceCheckId"].Value;
                m_iRepairMultId = (SqlInt32)scmCmdToExecute.Parameters["@RepairItemId"].Value;
                m_daReportDate = (SqlDateTime)scmCmdToExecute.Parameters["@dtReport"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::WorkOrderReportedIssuesDetail::Error occured.\n" + ex.Message, ex);
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


        public int WorkOrderPMItemsDetail()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_WorkOrderPMItemsDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iPMItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@PMSchedDetailId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iSchedDetailId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceResultId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceResultId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceCheckId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceCheckId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairItemId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairMultId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtReport", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daReportDate));
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

                m_iPMItemId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderId"].Value;
                m_iSchedDetailId = (SqlInt32)scmCmdToExecute.Parameters["@PMSchedDetailId"].Value;
                m_iServiceResultId = (SqlInt32)scmCmdToExecute.Parameters["@ServiceResultId"].Value;
                m_iServiceCheckId = (SqlInt32)scmCmdToExecute.Parameters["@ServiceCheckId"].Value;
                m_iRepairMultId = (SqlInt32)scmCmdToExecute.Parameters["@RepairItemId"].Value;
                m_daReportDate = (SqlDateTime)scmCmdToExecute.Parameters["@dtReport"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::WorkOrderPMItemsDetail::Error occured.\n" + ex.Message, ex);
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


        public int UpdatePMItem()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdatePMItems]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@btChecked", SqlDbType.Bit, 1, ParameterDirection.Input, true, 1, 0, "", DataRowVersion.Proposed, m_bChecked));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iPMItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@PMSchedDetailId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iSchedDetailId));
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
                throw new Exception("clsWorkOrders::UpdatePMItem::Error occured.\n" + ex.Message, ex);
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


        public int UpdateInspection()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateInspections]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@btChecked", SqlDbType.Bit, 1, ParameterDirection.Input, true, 1, 0, "", DataRowVersion.Proposed, m_bChecked));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iWOInspectionId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectSchedDetailId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectSchedDetailId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@CurrDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
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
                throw new Exception("clsWorkOrders::UpdateInspection::Error occured.\n" + ex.Message, ex);
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


        public int UpdateInspectionItem()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateInspectionItems]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceCheckId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iServiceCheckId));
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
                throw new Exception("clsWorkOrders::UpdateInspectionItem::Error occured.\n" + ex.Message, ex);
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


        public int WorkOrderInspectionsDetail()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_WorkOrderInspectionsDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iWOInspectionId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectSchedDetailId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iInspectSchedDetailId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TechId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iTechId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtReport", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daReportDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@btIsProcessed", SqlDbType.Bit, 1, ParameterDirection.InputOutput, true, 1, 0, "", DataRowVersion.Proposed, m_bIsProcessed));
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

                m_iWOInspectionId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderId"].Value;
                m_iInspectSchedDetailId = (SqlInt32)scmCmdToExecute.Parameters["@InspectSchedDetailId"].Value;
                m_iTechId = (SqlInt32)scmCmdToExecute.Parameters["@TechId"].Value;
                m_daReportDate = (SqlDateTime)scmCmdToExecute.Parameters["@dtReport"].Value;
                m_bIsProcessed = (SqlBoolean)scmCmdToExecute.Parameters["@btIsProcessed"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::WorkOrderInspectionsDetail::Error occured.\n" + ex.Message, ex);
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


        public int WorkOrderInspectItemsDetail()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_WorkOrderInspectItemsDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iWOInspectItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderInspectId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iWOInspectionId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectionItemId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iInspectItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceResultId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceResultId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceCheckId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceCheckId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairItemId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairMultId));
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

                m_iWOInspectItemId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderId"].Value;
                m_iInspectionId = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderInspectId"].Value;
                m_iInspectItemId = (SqlInt32)scmCmdToExecute.Parameters["@InspectionItemId"].Value;
                m_iServiceResultId = (SqlInt32)scmCmdToExecute.Parameters["@ServiceResultId"].Value;
                m_iServiceCheckId = (SqlInt32)scmCmdToExecute.Parameters["@ServiceCheckId"].Value;
                m_iRepairMultId = (SqlInt32)scmCmdToExecute.Parameters["@RepairItemId"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::WorkOrderInspectItemsDetail::Error occured.\n" + ex.Message, ex);
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


        public int NoteDetails()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_NotesDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iNoteId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iNoteTypeId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCreated", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daCreated));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDesc", SqlDbType.VarChar, 8000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sNote));
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

                m_iNoteId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
                m_iNoteTypeId = (SqlInt32)scmCmdToExecute.Parameters["@TypeId"].Value;
                m_iItemId = (SqlInt32)scmCmdToExecute.Parameters["@ItemId"].Value;
                m_iUserId = (SqlInt32)scmCmdToExecute.Parameters["@UserId"].Value;
                m_daCreated = (SqlDateTime)scmCmdToExecute.Parameters["@dtCreated"].Value;
                m_sNote = (SqlString)scmCmdToExecute.Parameters["@vchDesc"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::NoteDetails::Error occured.\n" + ex.Message, ex);
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


        public int RepairItemDetails()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_RepairItemDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iRepairItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@CatId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairCatId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDesc", SqlDbType.VarChar, 1000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sRepairItemDesc));
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

                m_iRepairItemId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
                m_iRepairCatId = (SqlInt32)scmCmdToExecute.Parameters["@CatId"].Value;
                m_sRepairItemDesc = (SqlString)scmCmdToExecute.Parameters["@vchDesc"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::RepairItemDetail::Error occured.\n" + ex.Message, ex);
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


        public int RepairDetails()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_RepairsDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iRepairId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairItemId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
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
                m_iRepairItemId = (SqlInt32)scmCmdToExecute.Parameters["@RepairItemId"].Value;
                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderId"].Value;
                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::RepairDetails::Error occured.\n" + ex.Message, ex);
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


        public int PartsUsedDetails()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_PartsUsedDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iPartUsedId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intQty", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iPartUsedQty));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchStock", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPartUsedStock));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDesc", SqlDbType.VarChar, 1024, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sPartUsedDesc));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmCost", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 18, 2, "", DataRowVersion.Proposed, m_dmPartUsedCost));
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

                m_iRepairId = (SqlInt32)scmCmdToExecute.Parameters["@RepairId"].Value;
                m_iPartUsedId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
                m_iPartUsedQty = (SqlInt32)scmCmdToExecute.Parameters["@intQty"].Value;
                m_sPartUsedStock = (SqlString)scmCmdToExecute.Parameters["@vchStock"].Value;
                m_sPartUsedDesc = (SqlString)scmCmdToExecute.Parameters["@vchDesc"].Value;
                m_dmPartUsedCost = (SqlDecimal)scmCmdToExecute.Parameters["@dmCost"].Value;


                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::PartsUsedDetails::Error occured.\n" + ex.Message, ex);
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


        public int TimeLogDetails()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_TimeLogDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iTimeLogId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TechId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iTechId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtStartTime", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daStartTime));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtStopTime", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daStopTime));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmHours", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 19, 8, "", DataRowVersion.Proposed, m_dmHours));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmHourlyRate", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 19, 8, "", DataRowVersion.Proposed, m_dmHourlyRate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchNote", SqlDbType.VarChar, 6000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sNote));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCreatedDate", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, DateTime.Now));
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

                m_iTimeLogId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@OrderId"].Value;
                m_iRepairId = (SqlInt32)scmCmdToExecute.Parameters["@RepairId"].Value;
                m_iTechId = (SqlInt32)scmCmdToExecute.Parameters["@TechId"].Value;
                m_daStartTime = (SqlDateTime)scmCmdToExecute.Parameters["@dtStartTime"].Value;
                m_daStopTime = (SqlDateTime)scmCmdToExecute.Parameters["@dtStopTime"].Value;
                m_dmHours = (SqlDecimal)scmCmdToExecute.Parameters["@dmHours"].Value;
                m_dmHourlyRate = (SqlDecimal)scmCmdToExecute.Parameters["@dmHourlyRate"].Value;
                m_sNote = (SqlString)scmCmdToExecute.Parameters["@vchNote"].Value;


                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::TimeLogDetails::Error occured.\n" + ex.Message, ex);
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


        public int WorkOrderDetails()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_WorkOrderDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderNumber", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iWorkOrderNumber));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipTypeName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipTypeName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipMakeModel", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipMakeModel));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipYear", SqlDbType.VarChar, 25, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipYear));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchVinSerial", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipVinSerial));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@SpareEquipId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iSpareEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchSpareEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sSpareEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iTypeId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchType", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sType));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@StatusId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iStatusId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchStatus", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sStatusId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OperatorStatusId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iOperatorStatusId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchOperatorStatus", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sOperatorStatus));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@DataId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iDataId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@btIsActive", SqlDbType.Bit, 1, ParameterDirection.InputOutput, true, 1, 0, "", DataRowVersion.Proposed, m_bActive));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDesc", SqlDbType.VarChar, 8000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDecs));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intOperatorId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iOperatorId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchOperatorName", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sOperatorName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intTechId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iTechId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchTechName", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sTechName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmMileage", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 19, 8, "", DataRowVersion.Proposed, m_dmMileage));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@bitStaying", SqlDbType.Bit, 1, ParameterDirection.InputOutput, true, 1, 0, "", DataRowVersion.Proposed, m_bStaying));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDropedOffBy", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDropedOffBy));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchReleasedTo", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sReleasedTo));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchCleanliness", SqlDbType.VarChar, 1000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sCleanliness));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtScheduled", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daScheduled));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtArrival", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daArrival));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtOpened", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daOpened));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCompleted", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daCompleted));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtClosed", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daClosed));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtDeparture", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daDeparture));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intCreatedBy", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchCreatedBy", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sCreatedBy));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCreated", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daCreated));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intUpdatedBy", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchUpdatedBy", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sUpdatedBy));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtUpdated", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daUpdated));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@btWizardUpdate", SqlDbType.Bit, 1, ParameterDirection.Input, false, 1, 0, "", DataRowVersion.Proposed, m_bWizardUpdate));
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

                m_iWorkOrderNumber = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderNumber"].Value;
                m_iEquipId = (SqlInt32)scmCmdToExecute.Parameters["@EquipId"].Value;
                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;
                m_sEquipTypeName = (SqlString)scmCmdToExecute.Parameters["@vchEquipTypeName"].Value;
                m_sEquipMakeModel = (SqlString)scmCmdToExecute.Parameters["@vchEquipMakeModel"].Value;
                m_sEquipYear = (SqlString)scmCmdToExecute.Parameters["@vchEquipYear"].Value;
                m_sEquipVinSerial = (SqlString)scmCmdToExecute.Parameters["@vchVinSerial"].Value;
                m_iSpareEquipId = (SqlInt32)scmCmdToExecute.Parameters["@SpareEquipId"].Value;
                m_sSpareEquipId = (SqlString)scmCmdToExecute.Parameters["@vchSpareEquipId"].Value;
                m_iTypeId = (SqlInt32)scmCmdToExecute.Parameters["@TypeId"].Value;
                m_sType = (SqlString)scmCmdToExecute.Parameters["@vchType"].Value;
                m_iStatusId = (SqlInt32)scmCmdToExecute.Parameters["@StatusId"].Value;
                m_sStatusId = (SqlString)scmCmdToExecute.Parameters["@vchStatus"].Value;
                m_iOperatorStatusId = (SqlInt32)scmCmdToExecute.Parameters["@OperatorStatusId"].Value;
                m_sOperatorStatus = (SqlString)scmCmdToExecute.Parameters["@vchOperatorStatus"].Value;
                m_iDataId = (SqlInt32)scmCmdToExecute.Parameters["@DataId"].Value;
                m_bActive = (SqlBoolean)scmCmdToExecute.Parameters["@btIsActive"].Value;
                m_sDecs = (SqlString)scmCmdToExecute.Parameters["@vchDesc"].Value;
                m_iOperatorId = (SqlInt32)scmCmdToExecute.Parameters["@intOperatorId"].Value;
                m_sOperatorName = (SqlString)scmCmdToExecute.Parameters["@vchOperatorName"].Value;
                m_iTechId = (SqlInt32)scmCmdToExecute.Parameters["@intTechId"].Value;
                m_sTechName = (SqlString)scmCmdToExecute.Parameters["@vchTechName"].Value;
                m_dmMileage = (SqlDecimal)scmCmdToExecute.Parameters["@dmMileage"].Value;
                m_bStaying = (SqlBoolean)scmCmdToExecute.Parameters["@bitStaying"].Value;
                m_sDropedOffBy = (SqlString)scmCmdToExecute.Parameters["@vchDropedOffBy"].Value;
                m_sReleasedTo = (SqlString)scmCmdToExecute.Parameters["@vchReleasedTo"].Value;
                m_sCleanliness = (SqlString)scmCmdToExecute.Parameters["@vchCleanliness"].Value;
                m_daScheduled = (SqlDateTime)scmCmdToExecute.Parameters["@dtScheduled"].Value;
                m_daArrival = (SqlDateTime)scmCmdToExecute.Parameters["@dtArrival"].Value;
                m_daOpened = (SqlDateTime)scmCmdToExecute.Parameters["@dtOpened"].Value;
                m_daCompleted = (SqlDateTime)scmCmdToExecute.Parameters["@dtCompleted"].Value;
                m_daClosed = (SqlDateTime)scmCmdToExecute.Parameters["@dtClosed"].Value;
                m_daDeparture = (SqlDateTime)scmCmdToExecute.Parameters["@dtDeparture"].Value;
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
                throw new Exception("clsWorkOrders::WorkOrderDetails::Error occured.\n" + ex.Message, ex);
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


        public int GetCompleteAbleOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetCompleteAbleOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
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
                throw new Exception("clsWorkOrders::GetCompleteAbleOrder::Error occured.\n" + ex.Message, ex);
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


        public int GetDeleteAbleOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetDeleteAbleOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
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
                throw new Exception("clsWorkOrders::GetDeleteAbleOrder::Error occured.\n" + ex.Message, ex);
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


        public int RepairCommonDetails()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_RepairCommonDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iRepairId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairDesc", SqlDbType.VarChar, 4000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sRepairDesc));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairItemId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairCatId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairCatId));
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

                m_sRepairDesc = (SqlString)scmCmdToExecute.Parameters["@RepairDesc"].Value;
                m_iRepairItemId = (SqlInt32)scmCmdToExecute.Parameters["@RepairItemId"].Value;
                m_iRepairCatId = (SqlInt32)scmCmdToExecute.Parameters["@RepairCatId"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::RepairCommonDetails::Error occured.\n" + ex.Message, ex);
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


        public int GetInfoForWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetInfoForWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iTypeId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtScheduled", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daScheduled));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchNote", SqlDbType.VarChar, 8000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDecs));
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

                m_iTypeId = (SqlInt32)scmCmdToExecute.Parameters["@TypeId"].Value;
                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;
                m_sDecs = (SqlString)scmCmdToExecute.Parameters["@vchNote"].Value;
                m_daScheduled = (SqlDateTime)scmCmdToExecute.Parameters["@dtScheduled"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetInfoForWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public int GetWorkOrderId()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetWorkOrderId]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderNumber", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iWorkOrderNumber));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCreated", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daCreated));
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

                m_iWorkOrderNumber = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderNumber"].Value;
                m_daCreated = (SqlDateTime)scmCmdToExecute.Parameters["@dtCreated"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetWorkOrderId::Error occured.\n" + ex.Message, ex);
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


        public int GetInfoForInspection()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetInfoForInspection]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectionId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchInspectName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sInspectionName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchInspectScheduleName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sInspectSchedule));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intInspectTargetDays", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iInspectTargetDays));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectSchedDetailId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iInspectSchedDetailId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipMake", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipMake));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipModel", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipModel));
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

                m_sInspectionName = (SqlString)scmCmdToExecute.Parameters["@vchInspectName"].Value;
                m_sInspectSchedule = (SqlString)scmCmdToExecute.Parameters["@vchInspectScheduleName"].Value;
                m_iInspectTargetDays = (SqlInt32)scmCmdToExecute.Parameters["@intInspectTargetDays"].Value;
                m_iInspectSchedDetailId = (SqlInt32)scmCmdToExecute.Parameters["@InspectSchedDetailId"].Value;
                m_iEquipId = (SqlInt32)scmCmdToExecute.Parameters["@EquipId"].Value;
                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;
                m_sEquipMake = (SqlString)scmCmdToExecute.Parameters["@vchEquipMake"].Value;
                m_sEquipModel = (SqlString)scmCmdToExecute.Parameters["@vchEquipModel"].Value;
                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetInfoForInspection::Error occured.\n" + ex.Message, ex);
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


        public int SigningWorkOrderOpen()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SigningWorkOrderOpen]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@chInitials", SqlDbType.Char, 3, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sInitials));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPIN", SqlDbType.VarChar, 10, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sPIN));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
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
                throw new Exception("clsWorkOrders::SigningWorkOrderOpen::Error occured.\n" + ex.Message, ex);
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


        public int SigningWorkOrderReOpen()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SigningWorkOrderReOpen]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
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
                throw new Exception("clsWorkOrders::SigningWorkOrderReOpen::Error occured.\n" + ex.Message, ex);
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


        public int SigningWorkOrderClose()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SigningWorkOrderClose]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@chInitials", SqlDbType.Char, 3, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sInitials));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPIN", SqlDbType.VarChar, 10, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sPIN));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchCleanliness", SqlDbType.VarChar, 1000, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sCleanliness));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
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
                throw new Exception("clsWorkOrders::SigningWorkOrderClose::Error occured.\n" + ex.Message, ex);
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


        public int SigningEquipmentCheckIn()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SigningEquipmentCheckIn]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@chInitials", SqlDbType.Char, 3, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sInitials));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPIN", SqlDbType.VarChar, 10, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sPIN));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmCurrentUnits", SqlDbType.Decimal, 12, ParameterDirection.Input, false, 19, 8, "", DataRowVersion.Proposed, m_dmMileage));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@btStaying", SqlDbType.Bit, 1, ParameterDirection.Input, false, 1, 0, "", DataRowVersion.Proposed, m_bStaying));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDropedOffBy", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sDropedOffBy));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
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

                m_iUserId = (SqlInt32)scmCmdToExecute.Parameters["@UserId"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::sp_SigningEquipmentCheckIn::Error occured.\n" + ex.Message, ex);
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


        public int SigningEquipmentCheckOut()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SigningEquipmentCheckOut]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@chInitials", SqlDbType.Char, 3, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sInitials));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPIN", SqlDbType.VarChar, 10, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sPIN));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchReleasedTo", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sReleasedTo));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
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

                m_iUserId = (SqlInt32)scmCmdToExecute.Parameters["@UserId"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::SigningEquipmentCheckOut::Error occured.\n" + ex.Message, ex);
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


        public int SigningInspectionList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SigningInspection]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectionId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@chInitials", SqlDbType.Char, 3, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sInitials));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchPIN", SqlDbType.VarChar, 10, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sPIN));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
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
                throw new Exception("clsWorkOrders::SigningInspectionList::Error occured.\n" + ex.Message, ex);
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


        public int GetSignedDocument()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetSignedDocument]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@DocumentId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iDocumentId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@DocumentTypeId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iDocumentTypeId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchUserName", SqlDbType.VarChar, 102, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sUserName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@chInitials", SqlDbType.Char, 3, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sInitials));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtSignDate", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daReportDate));
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

                m_sUserName = (SqlString)scmCmdToExecute.Parameters["@vchUserName"].Value;
                m_sInitials = (SqlString)scmCmdToExecute.Parameters["@chInitials"].Value;
                m_daReportDate = (SqlDateTime)scmCmdToExecute.Parameters["@dtSignDate"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetSignedDocument::Error occured.\n" + ex.Message, ex);
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


        public int GetIssueInfo()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetServiceName]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchTypeService", SqlDbType.VarChar, 25, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sTypeService));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceName", SqlDbType.VarChar, 100, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sServiceName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceType", SqlDbType.VarChar, 25, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sTypeService));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceCategory", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sRepairCatName));

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

                m_sServiceName = (SqlString)scmCmdToExecute.Parameters["@ServiceName"].Value;
                m_sTypeService = (SqlString)scmCmdToExecute.Parameters["@ServiceType"].Value;
                m_sRepairCatName = (SqlString)scmCmdToExecute.Parameters["@ServiceCategory"].Value;

                return 1;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetIssueInfo::Error occured.\n" + ex.Message, ex);
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


        public int PMHistoryDetail()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_PMHistoryDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iPMHistoryId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtDate", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daDateHistory));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@PMSchedDetailId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iSchedDetailId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmUnits", SqlDbType.Decimal, 12, ParameterDirection.InputOutput, true, 19, 8, "", DataRowVersion.Proposed, m_dmUnitsHistory));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchServiceCatName", SqlDbType.VarChar, 25, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sRepairCatName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchServiceName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sServiceName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@PMStatus", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iPMStatus));
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
                m_iPMHistoryId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
                m_iEquipId = (SqlInt32)scmCmdToExecute.Parameters["@EquipId"].Value;
                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;
                m_daDateHistory = (SqlDateTime)scmCmdToExecute.Parameters["@dtDate"].Value;
                m_iSchedDetailId = (SqlInt32)scmCmdToExecute.Parameters["@PMSchedDetailId"].Value;
                m_dmUnitsHistory = (SqlDecimal)scmCmdToExecute.Parameters["@dmUnits"].Value;
                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderId"].Value;
                m_sRepairCatName = (SqlString)scmCmdToExecute.Parameters["@vchServiceCatName"].Value;
                m_sServiceName = (SqlString)scmCmdToExecute.Parameters["@vchServiceName"].Value;
                m_iPMStatus = (SqlInt32)scmCmdToExecute.Parameters["@PMStatus"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::PMHistoryDetail::Error occured.\n" + ex.Message, ex);
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


        public int InspectHistoryDetail()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_InspectHistoryDetail]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Action", SqlDbType.Char, 1, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Default, m_cAction));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectHistoryId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtDate", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daDateHistory));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectSchedDetailId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iInspectSchedDetailId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchInspectionName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sInspectionName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchInspectScheduleName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sInspectSchedule));
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
                m_iInspectHistoryId = (SqlInt32)scmCmdToExecute.Parameters["@Id"].Value;
                m_iEquipId = (SqlInt32)scmCmdToExecute.Parameters["@EquipId"].Value;
                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;
                m_daDateHistory = (SqlDateTime)scmCmdToExecute.Parameters["@dtDate"].Value;
                m_iInspectSchedDetailId = (SqlInt32)scmCmdToExecute.Parameters["@InspectSchedDetailId"].Value;
                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderId"].Value;
                m_sInspectionName = (SqlString)scmCmdToExecute.Parameters["@vchInspectionName"].Value;
                m_sInspectSchedule = (SqlString)scmCmdToExecute.Parameters["@vchInspectScheduleName"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::InspectHistoryDetail::Error occured.\n" + ex.Message, ex);
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


        public int UpdateActiveWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateActiveWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
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
                throw new Exception("clsWorkOrders::UpdateActiveWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public int UpdateInActiveWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateInActiveWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
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
                throw new Exception("clsWorkOrders::UpdateInActiveWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public int UpdateStayingWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateStayingWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@btStaying", SqlDbType.Bit, 1, ParameterDirection.Input, false, 1, 0, "", DataRowVersion.Proposed, m_bStaying));
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
                throw new Exception("clsWorkOrders::UpdateStayingWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public int UpdateCheckInWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateCheckInWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
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
                throw new Exception("clsWorkOrders::UpdateCheckInWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public int UpdateCheckOutWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateCheckOutWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
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
                throw new Exception("clsWorkOrders::UpdateCheckOutWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public int SetIssueChecks()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SetIssueChecks]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iReportedIssueId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceCheckId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceCheckId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceResultId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceResultId));
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
                throw new Exception("clsWorkOrders::SetIssueChecks::Error occured.\n" + ex.Message, ex);
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


        public int SetPMItemChecks()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SetPMItemChecks]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iPMItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceCheckId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceCheckId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceResultId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceResultId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@CurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, DateTime.Now));
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
                throw new Exception("clsWorkOrders::SetPMItemChecks::Error occured.\n" + ex.Message, ex);
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


        public int SetInspectItemChecks()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SetInspectItemChecks]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceCheckId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceCheckId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceResultId", SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, m_iServiceResultId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, DateTime.Now));
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
                throw new Exception("clsWorkOrders::SetInspectItemChecks::Error occured.\n" + ex.Message, ex);
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


        public int SetAssociationsRepair()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SetAssociationsRepair]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@btChecked", SqlDbType.Bit, 1, ParameterDirection.Input, true, 1, 0, "", DataRowVersion.Proposed, m_bChecked));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchType", SqlDbType.VarChar, 25, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sTypeService));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iRepairId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceResultId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iServiceResultId));
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
                throw new Exception("clsWorkOrders::SetAssociationsRepair::Error occured.\n" + ex.Message, ex);
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


        public int SetAssociationsIssue()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SetAssociationsIssue]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ReportedIssueId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iReportedIssueId));
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
                throw new Exception("clsWorkOrders::SetAssociationsIssue::Error occured.\n" + ex.Message, ex);
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

        public int UpdateRepair()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateRepair]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchType", SqlDbType.VarChar, 25, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sTypeService));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ServiceResultId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iServiceResultId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairDesc", SqlDbType.VarChar, 4000, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sRepairDesc));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairItemId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@RepairCatId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iRepairCatId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Insert", SqlDbType.Bit, 1, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_Insert));
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

                m_iRepairId = (SqlInt32)scmCmdToExecute.Parameters["@RepairId"].Value;
                m_sRepairDesc = (SqlString)scmCmdToExecute.Parameters["@RepairDesc"].Value;
                m_iRepairItemId = (SqlInt32)scmCmdToExecute.Parameters["@RepairItemId"].Value;
                m_iRepairCatId = (SqlInt32)scmCmdToExecute.Parameters["@RepairCatId"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::UpdateRepair::Error occured.\n" + ex.Message, ex);
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


        public int UpdateOpenWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateOpenWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intTechId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTechId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmCurrentUnits", SqlDbType.Decimal, 12, ParameterDirection.Input, false, 19, 8, "", DataRowVersion.Proposed, m_dmMileage));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDropedOffBy", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, m_sDropedOffBy));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtOpened", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daOpened));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
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

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value; ;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::UpdateOpenWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public int UpdateReOpenWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateReOpenWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@intOperatorId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOperatorId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ReOpenCategoryId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iReOpenCategoryId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
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

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value; ;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::UpdateReOpenWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public void SelectWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SetWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dmCurrentUnits", SqlDbType.Decimal, 12, ParameterDirection.Input, false, 19, 8, "", DataRowVersion.Proposed, m_dmMileage));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iId));


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

                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@OrderId"].Value;

                return;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::SelectWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public void SetRoadsideWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SetRoadsideWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TechId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iTechId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iId));


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

                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@OrderId"].Value;

                return;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::SetRoadsideWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public void SetInspectWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SetInspectWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtScheduledDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daScheduled));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectSchedDetailId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectSchedDetailId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@WorkOrderNumber", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iWorkOrderNumber));


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

                m_iId = (SqlInt32)scmCmdToExecute.Parameters["@OrderId"].Value;
                m_iWorkOrderNumber = (SqlInt32)scmCmdToExecute.Parameters["@WorkOrderNumber"].Value;

                return;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::SetInspectWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetNotesList()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectNotesList]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@ItemId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iItemId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@TypeId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iNoteTypeId));

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
                throw new Exception("clsWorkOrders::GetNotesList::Error occured.\n" + ex.Message, ex);
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


        public int GetEquipInfo()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetEquipInfo_Order]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipType", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipTypeName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchMakeModelName", SqlDbType.VarChar, 101, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipMakeModel));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchYear", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipYear));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchOperatorLastName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sOperatorName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtFutureInspectionDate", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daScheduled));
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

                m_iEquipId = (SqlInt32)scmCmdToExecute.Parameters["@EquipId"].Value;
                m_sEquipId = (SqlString)scmCmdToExecute.Parameters["@vchEquipId"].Value;
                m_sEquipTypeName = (SqlString)scmCmdToExecute.Parameters["@vchEquipType"].Value;
                m_sEquipMakeModel = (SqlString)scmCmdToExecute.Parameters["@vchMakeModelName"].Value;
                m_sEquipYear = (SqlString)scmCmdToExecute.Parameters["@vchYear"].Value;
                m_sOperatorName = (SqlString)scmCmdToExecute.Parameters["@vchOperatorLastName"].Value;
                m_daScheduled = (SqlDateTime)scmCmdToExecute.Parameters["@dtFutureInspectionDate"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetEquipInfo::Error occured.\n" + ex.Message, ex);
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


        public int DeleteFutureWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_DeleteFutureWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
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
                throw new Exception("clsWorkOrders::DeleteFutureWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetFuturePMItems()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectFutureWorkOrderPMItems]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

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
                throw new Exception("clsWorkOrders::GetFuturePMItems::Error occured.\n" + ex.Message, ex);
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


        public DataTable GetFutureInspections()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_SelectFutureWorkOrderInspections]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));

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
                throw new Exception("clsWorkOrders::GetFutureInspections::Error occured.\n" + ex.Message, ex);
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


        public int SetFutureInspection()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateFutureInspections]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.InputOutput, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iWOInspectionId));
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

                iId = (SqlInt32)scmCmdToExecute.Parameters["@OrderId"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::SetFutureInspection::Error occured.\n" + ex.Message, ex);
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


        public int DeleteWorkOrder()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_DeleteWorkOrder]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrderId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iUserId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtCurrentDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
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
                throw new Exception("clsWorkOrders::DeleteWorkOrder::Error occured.\n" + ex.Message, ex);
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


        public int GetDateTimeOfForecastInspection()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetDateTimeOfForecastInspection]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectSchedDetailId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectSchedDetailId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtTodayDate", SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, m_daCurrentDate));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@iError", SqlDbType.Int, 4, ParameterDirection.InputOutput, true, 10, 0, "", DataRowVersion.Proposed, m_iErrorCode));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@dtResultDate", SqlDbType.DateTime, 8, ParameterDirection.InputOutput, true, 23, 3, "", DataRowVersion.Proposed, m_daScheduled));
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

                m_iErrorCode = (SqlInt32)scmCmdToExecute.Parameters["@iError"].Value;
                m_daScheduled = (SqlDateTime)scmCmdToExecute.Parameters["@dtResultDate"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetDateTimeOfForecastInspection::Error occured.\n" + ex.Message, ex);
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


        public int GetInfoForCreateWOInspection()
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetInfoForCreateWOInspection]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrgId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iOrgId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@EquipId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@InspectSchedDetailId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, m_iInspectSchedDetailId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchEquipId", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sEquipId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchType", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sType));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchInspectScheduleName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sInspectSchedule));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchInspectName", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sInspectionName));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchStatus", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sStatusId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchLastInspection", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sLastInspection));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@vchDatesRange", SqlDbType.VarChar, 50, ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Proposed, m_sDatesRange));
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
                m_sType = (SqlString)scmCmdToExecute.Parameters["@vchType"].Value;
                m_sInspectSchedule = (SqlString)scmCmdToExecute.Parameters["@vchInspectScheduleName"].Value;
                m_sInspectionName = (SqlString)scmCmdToExecute.Parameters["@vchInspectName"].Value;
                m_sStatusId = (SqlString)scmCmdToExecute.Parameters["@vchStatus"].Value;
                m_sLastInspection = (SqlString)scmCmdToExecute.Parameters["@vchLastInspection"].Value;
                m_sDatesRange = (SqlString)scmCmdToExecute.Parameters["@vchDatesRange"].Value;

                return (Int32)scmCmdToExecute.Parameters["ReturnValue"].Value;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsWorkOrders::GetInfoForCreateWOInspection::Error occured.\n" + ex.Message, ex);
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

        public string GetIntegrationKey(int OrganizationId)
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_GetIntegrationKey]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrganizationId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, OrganizationId));

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
                    throw new Exception("Stored Procedure 'sp_GetIntegrationKey' reported the ErrorCode: " + m_iErrorCode);
                }

                string key = string.Empty;

                if (dtToReturn.Rows.Count > 0)
                    key = dtToReturn.Rows[0]["IntegrationKey"].ToString();

                return key;
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsDepartments::GetIntegrationKey::Error occured.\n" + ex.Message, ex);
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

        public void InsertIntegrationKey(int OrganizationId, string Key)
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_InsertIntegrationKey]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrganizationId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, OrganizationId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Key", SqlDbType.NVarChar, 255, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, Key));

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
                m_iErrorCode = 0;

                if (m_iErrorCode != (int)Error.AllOk)
                {
                    // Throw error.
                    throw new Exception("Stored Procedure 'sp_InsertIntegrationKey' reported the ErrorCode: " + m_iErrorCode);
                }
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsDepartments::InsertIntegrationKey::Error occured.\n" + ex.Message, ex);
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

        public void DeleteIntegrationKey(string Key)
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_DeleteIntegrationKey]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Key", SqlDbType.NVarChar, 255, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, Key));

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
                m_iErrorCode = 0;

                if (m_iErrorCode != (int)Error.AllOk)
                {
                    // Throw error.
                    throw new Exception("Stored Procedure 'sp_DeleteIntegrationKey' reported the ErrorCode: " + m_iErrorCode);
                }
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsDepartments::DeleteIntegrationKey::Error occured.\n" + ex.Message, ex);
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

        public void UpdateIntegrationKey(int OrganizationId, string Key)
        {
            SqlCommand scmCmdToExecute = new SqlCommand();
            scmCmdToExecute.CommandText = "dbo.[sp_UpdateIntegrationKey]";
            scmCmdToExecute.CommandType = CommandType.StoredProcedure;
            DataTable dtToReturn = new DataTable("Result");
            SqlDataAdapter sdaAdapter = new SqlDataAdapter(scmCmdToExecute);

            // Use base class' connection object
            scmCmdToExecute.Connection = m_scoMainConnection;
            try
            {
                scmCmdToExecute.Parameters.Add(new SqlParameter("@OrganizationId", SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, OrganizationId));
                scmCmdToExecute.Parameters.Add(new SqlParameter("@Key", SqlDbType.NVarChar, 255, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, Key));

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
                m_iErrorCode = 0;

                if (m_iErrorCode != (int)Error.AllOk)
                {
                    // Throw error.
                    throw new Exception("Stored Procedure 'sp_UpdateIntegrationKey' reported the ErrorCode: " + m_iErrorCode);
                }
            }
            catch (Exception ex)
            {
                // some error occured. Bubble it to caller and encapsulate Exception object
                throw new Exception("clsDepartments::UpdateIntegrationKey::Error occured.\n" + ex.Message, ex);
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
        public SqlInt32 iEquipId
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
        public SqlInt32 iWorkOrderNumber
        {
            get
            {
                return m_iWorkOrderNumber;
            }
            set
            {
                m_iWorkOrderNumber = value;
            }
        }
        public SqlString sEquipTypeName
        {
            get
            {
                return m_sEquipTypeName;
            }
            set
            {
                m_sEquipTypeName = value;
            }
        }
        public SqlString sEquipMakeModel
        {
            get
            {
                return m_sEquipMakeModel;
            }
            set
            {
                m_sEquipMakeModel = value;
            }
        }
        public SqlString sEquipYear
        {
            get
            {
                return m_sEquipYear;
            }
            set
            {
                m_sEquipYear = value;
            }
        }
        public SqlString sEquipVinSerial
        {
            get
            {
                return m_sEquipVinSerial;
            }
            set
            {
                m_sEquipVinSerial = value;
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
        public SqlString sStatusId
        {
            get
            {
                return m_sStatusId;
            }
            set
            {
                m_sStatusId = value;
            }
        }
        public SqlInt32 iOperatorStatusId
        {
            get
            {
                return m_iOperatorStatusId;
            }
            set
            {
                m_iOperatorStatusId = value;
            }
        }
        public SqlString sOperatorStatus
        {
            get
            {
                return m_sOperatorStatus;
            }
            set
            {
                m_sOperatorStatus = value;
            }
        }
        public SqlInt32 iDataId
        {
            get
            {
                return m_iDataId;
            }
            set
            {
                m_iDataId = value;
            }
        }
        public SqlBoolean bActive
        {
            get
            {
                return m_bActive;
            }
            set
            {
                m_bActive = value;
            }
        }
        public SqlString sDecs
        {
            get
            {
                return m_sDecs;
            }
            set
            {
                m_sDecs = value;
            }
        }
        public SqlInt32 iOperatorId
        {
            get
            {
                return m_iOperatorId;
            }
            set
            {
                m_iOperatorId = value;
            }
        }
        public SqlString sOperatorName
        {
            get
            {
                return m_sOperatorName;
            }
            set
            {
                m_sOperatorName = value;
            }
        }
        public SqlInt32 iTechId
        {
            get
            {
                return m_iTechId;
            }
            set
            {
                m_iTechId = value;
            }
        }
        public SqlString sTechName
        {
            get
            {
                return m_sTechName;
            }
            set
            {
                m_sTechName = value;
            }
        }
        public SqlDecimal dmMileage
        {
            get
            {
                return m_dmMileage;
            }
            set
            {
                m_dmMileage = value;
            }
        }
        public SqlBoolean bStaying
        {
            get
            {
                return m_bStaying;
            }
            set
            {
                m_bStaying = value;
            }
        }
        public SqlInt32 iSpareEquipId
        {
            get
            {
                return m_iSpareEquipId;
            }
            set
            {
                m_iSpareEquipId = value;
            }
        }
        public SqlString sSpareEquipId
        {
            get
            {
                return m_sSpareEquipId;
            }
            set
            {
                m_sSpareEquipId = value;
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
        public SqlBoolean bPrint
        {
            get
            {
                return m_bPrint;
            }
            set
            {
                m_bPrint = value;
            }
        }
        public SqlString sDropedOffBy
        {
            get
            {
                return m_sDropedOffBy;
            }
            set
            {
                m_sDropedOffBy = value;
            }
        }
        public SqlString sReleasedTo
        {
            get
            {
                return m_sReleasedTo;
            }
            set
            {
                m_sReleasedTo = value;
            }
        }
        public SqlString sCleanliness
        {
            get
            {
                return m_sCleanliness;
            }
            set
            {
                m_sCleanliness = value;
            }
        }
        public SqlDateTime daScheduled
        {
            get
            {
                return m_daScheduled;
            }
            set
            {
                m_daScheduled = value;
            }
        }
        public SqlDateTime daArrival
        {
            get
            {
                return m_daArrival;
            }
            set
            {
                m_daArrival = value;
            }
        }
        public SqlDateTime daOpened
        {
            get
            {
                return m_daOpened;
            }
            set
            {
                m_daOpened = value;
            }
        }
        public SqlDateTime daCompleted
        {
            get
            {
                return m_daCompleted;
            }
            set
            {
                m_daCompleted = value;
            }
        }
        public SqlDateTime daClosed
        {
            get
            {
                return m_daClosed;
            }
            set
            {
                m_daClosed = value;
            }
        }
        public SqlDateTime daDeparture
        {
            get
            {
                return m_daDeparture;
            }
            set
            {
                m_daDeparture = value;
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
        public SqlInt32 iSchedDetailId
        {
            get
            {
                return m_iSchedDetailId;
            }
            set
            {
                m_iSchedDetailId = value;
            }
        }
        public SqlString sServiceName
        {
            get
            {
                return m_sServiceName;
            }
            set
            {
                m_sServiceName = value;
            }
        }
        public SqlInt32 iPMStatus
        {
            get
            {
                return m_iPMStatus;
            }
            set
            {
                m_iPMStatus = value;
            }
        }
        public SqlInt32 iPMItemId
        {
            get
            {
                return m_iPMItemId;
            }
            set
            {
                m_iPMItemId = value;
            }
        }
        public SqlInt32 iWOPMItemId
        {
            get
            {
                return m_iWOPMItemId;
            }
            set
            {
                m_iWOPMItemId = value;
            }
        }
        public SqlBoolean bChecked
        {
            get
            {
                return m_bChecked;
            }
            set
            {
                m_bChecked = value;
            }
        }
        public SqlBoolean bIsProcessed
        {
            get
            {
                return m_bIsProcessed;
            }
            set
            {
                m_bIsProcessed = value;
            }
        }
        public SqlInt32 iServiceResultId
        {
            get
            {
                return m_iServiceResultId;
            }
            set
            {
                m_iServiceResultId = value;
            }
        }
        public SqlInt32 iServiceCheckId
        {
            get
            {
                return m_iServiceCheckId;
            }
            set
            {
                m_iServiceCheckId = value;
            }
        }
        public SqlInt32 iInspectHistoryId
        {
            get
            {
                return m_iInspectHistoryId;
            }
            set
            {
                m_iInspectHistoryId = value;
            }
        }
        public SqlInt32 iInspectionId
        {
            get
            {
                return m_iInspectionId;
            }
            set
            {
                m_iInspectionId = value;
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
        public SqlInt32 iInspectSchedDetailId
        {
            get
            {
                return m_iInspectSchedDetailId;
            }
            set
            {
                m_iInspectSchedDetailId = value;
            }
        }
        public SqlInt32 iInspectTargetDays
        {
            get
            {
                return m_iInspectTargetDays;
            }
            set
            {
                m_iInspectTargetDays = value;
            }
        }
        public SqlString sEquipMake
        {
            get
            {
                return m_sEquipMake;
            }
            set
            {
                m_sEquipMake = value;
            }
        }
        public SqlString sEquipModel
        {
            get
            {
                return m_sEquipModel;
            }
            set
            {
                m_sEquipModel = value;
            }
        }
        public SqlInt32 iWOInspectItemId
        {
            get
            {
                return m_iWOInspectItemId;
            }
            set
            {
                m_iWOInspectItemId = value;
            }
        }
        public SqlInt32 iWOInspectionId
        {
            get
            {
                return m_iWOInspectionId;
            }
            set
            {
                m_iWOInspectionId = value;
            }
        }
        public SqlInt32 iInspectItemId
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
        public SqlString sInspectionName
        {
            get
            {
                return m_sInspectionName;
            }
            set
            {
                m_sInspectionName = value;
            }
        }
        public SqlString sWorkOrderId
        {
            get
            {
                return m_sWorkOrderId;
            }
            set
            {
                m_sWorkOrderId = value;
            }
        }
        public SqlString sWODetails
        {
            get
            {
                return m_sWODetails;
            }
            set
            {
                m_sWODetails = value;
            }
        }
        public SqlString sEquipDetails
        {
            get
            {
                return m_sEquipDetails;
            }
            set
            {
                m_sEquipDetails = value;
            }
        }
        public SqlString sInitials
        {
            get
            {
                return m_sInitials;
            }
            set
            {
                m_sInitials = value;
            }
        }
        public SqlString sPIN
        {
            get
            {
                return m_sPIN;
            }
            set
            {
                m_sPIN = value;
            }
        }
        public SqlString sTypeService
        {
            get
            {
                return m_sTypeService;
            }
            set
            {
                m_sTypeService = value;
            }
        }
        public SqlInt32 iItemId
        {
            get
            {
                return m_iItemId;
            }
            set
            {
                m_iItemId = value;
            }
        }
        public SqlBoolean bWizardUpdate
        {
            get
            {
                return m_bWizardUpdate;
            }
            set
            {
                m_bWizardUpdate = value;
            }
        }
        public SqlDateTime daReportDate
        {
            get
            {
                return m_daReportDate;
            }
            set
            {
                m_daReportDate = value;
            }
        }
        public SqlInt32 iReportedIssueId
        {
            get
            {
                return m_iReportedIssueId;
            }
            set
            {
                m_iReportedIssueId = value;
            }
        }
        public SqlString sReportDesc
        {
            get
            {
                return m_sReportDesc;
            }
            set
            {
                m_sReportDesc = value;
            }
        }
        public SqlInt32 iLastWorkOrderId
        {
            get
            {
                return m_iLastWorkOrderId;
            }
            set
            {
                m_iLastWorkOrderId = value;
            }
        }
        public SqlInt32 iPMHistoryId
        {
            get
            {
                return m_iPMHistoryId;
            }
            set
            {
                m_iPMHistoryId = value;
            }
        }
        public SqlDateTime daDateHistory
        {
            get
            {
                return m_daDateHistory;
            }
            set
            {
                m_daDateHistory = value;
            }
        }
        public SqlDecimal dmUnitsHistory
        {
            get
            {
                return m_dmUnitsHistory;
            }
            set
            {
                m_dmUnitsHistory = value;
            }
        }
        public SqlInt32 iRepairCatId
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
        public SqlString sRepairCatName
        {
            get
            {
                return m_sRepairCatName;
            }
            set
            {
                m_sRepairCatName = value;
            }
        }
        public SqlString sRepairCatDesc
        {
            get
            {
                return m_sRepairCatDesc;
            }
            set
            {
                m_sRepairCatDesc = value;
            }
        }
        public SqlInt32 iRepairId
        {
            get
            {
                return m_iRepairId;
            }
            set
            {
                m_iRepairId = value;
            }
        }
        public SqlBoolean iInsert
        {
            get
            {
                return m_Insert;
            }
            set
            {
                m_Insert = value;
            }
        }
        public SqlString sRepairDesc
        {
            get
            {
                return m_sRepairDesc;
            }
            set
            {
                m_sRepairDesc = value;
            }
        }
        public SqlInt32 iRepairItemId
        {
            get
            {
                return m_iRepairItemId;
            }
            set
            {
                m_iRepairItemId = value;
            }
        }
        public SqlString sRepairItemDesc
        {
            get
            {
                return m_sRepairItemDesc;
            }
            set
            {
                m_sRepairItemDesc = value;
            }
        }
        public SqlInt32 iRepairReasonId
        {
            get
            {
                return m_iRepairReasonId;
            }
            set
            {
                m_iRepairReasonId = value;
            }
        }
        public SqlString sRepairReasonDesc
        {
            get
            {
                return m_sRepairReasonDesc;
            }
            set
            {
                m_sRepairReasonDesc = value;
            }
        }
        public SqlInt32 iRepairMultId
        {
            get
            {
                return m_iRepairMultId;
            }
            set
            {
                m_iRepairMultId = value;
            }
        }
        public SqlInt32 iPartUsedId
        {
            get
            {
                return m_iPartUsedId;
            }
            set
            {
                m_iPartUsedId = value;
            }
        }
        public SqlInt32 iPartUsedQty
        {
            get
            {
                return m_iPartUsedQty;
            }
            set
            {
                m_iPartUsedQty = value;
            }
        }
        public SqlString sPartUsedStock
        {
            get
            {
                return m_sPartUsedStock;
            }
            set
            {
                m_sPartUsedStock = value;
            }
        }
        public SqlString sPartUsedDesc
        {
            get
            {
                return m_sPartUsedDesc;
            }
            set
            {
                m_sPartUsedDesc = value;
            }
        }
        public SqlDecimal dmPartUsedCost
        {
            get
            {
                return m_dmPartUsedCost;
            }
            set
            {
                m_dmPartUsedCost = value;
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
        public SqlDateTime daCurrentDate
        {
            get
            {
                return m_daCurrentDate;
            }
            set
            {
                m_daCurrentDate = value;
            }
        }
        public SqlInt32 iDocumentId
        {
            get
            {
                return m_iDocumentId;
            }
            set
            {
                m_iDocumentId = value;
            }
        }
        public SqlInt32 iDocumentTypeId
        {
            get
            {
                return m_iDocumentTypeId;
            }
            set
            {
                m_iDocumentTypeId = value;
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
        public SqlInt32 iNoteId
        {
            get
            {
                return m_iNoteId;
            }
            set
            {
                m_iNoteId = value;
            }
        }
        public SqlInt32 iNoteTypeId
        {
            get
            {
                return m_iNoteTypeId;
            }
            set
            {
                m_iNoteTypeId = value;
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
        public SqlString sLastInspection
        {
            get
            {
                return m_sLastInspection;
            }
            set
            {
                m_sLastInspection = value;
            }
        }
        public SqlString sDatesRange
        {
            get
            {
                return m_sDatesRange;
            }
            set
            {
                m_sDatesRange = value;
            }
        }
        public SqlInt32 iReOpenCategoryId
        {
            get
            {
                return m_iReOpenCategoryId;
            }
            set
            {
                m_iReOpenCategoryId = value;
            }
        }
        public SqlInt32 iTimeLogId
        {
            get
            {
                return m_iTimeLogId;
            }
            set
            {
                m_iTimeLogId = value;
            }
        }
        public SqlDateTime daStartTime
        {
            get
            {
                return m_daStartTime;
            }
            set
            {
                m_daStartTime = value;
            }
        }
        public SqlDateTime daStopTime
        {
            get
            {
                return m_daStopTime;
            }
            set
            {
                m_daStopTime = value;
            }
        }
        public SqlDecimal dmHours
        {
            get
            {
                return m_dmHours;
            }
            set
            {
                m_dmHours = value;
            }
        }
        public SqlDecimal dmHourlyRate
        {
            get
            {
                return m_dmHourlyRate;
            }
            set
            {
                m_dmHourlyRate = value;
            }
        }
        #endregion
    }
}
