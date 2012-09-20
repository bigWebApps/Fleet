using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Collections;
using System.Threading;
using System.Web.Mail;
using System.Web.Security;
using System.Configuration;
using System.Security.Cryptography;
using BWA.BFP.Data;


namespace BWA.BFP.Core
{
	
	/// <summary>
	/// The data type of the custom fields coming from FieldTypes table 
	/// </summary>
	public enum DBFieldType : int
	{
		_nvarchar = 1,
		_int = 2,
		_float = 3,
		_datetime = 4,
		_bit = 5,
		_ntext = 6,
		_sql_variant = 7,
		_lookup = 8
	}
	/// <summary>
	/// The Result Status of Service
	/// </summary>
	public enum ServiceResults : int
	{
		_Repaired = 1,
		_Replaced = 2
	}
	
	/// <summary>
	/// The Checked Status
	/// </summary>
	public enum ServiceChecks : int
	{
		_CheckOK = 1,
		_CheckFair = 2,
		_CheckRepairs_Needed = 3,
		_Not_Equipped  = 4
	}
	

	/// <summary>
	/// The Custom Fields data type coming from DataTypes table
	/// </summary>
	public enum CFDataType : int
	{
		Equipment = 1,
		Component = 2,
		WorkOrder = 3
	}
	/// <summary>
	/// The Reported Repair Status coming from RepairStatus table
	/// </summary>
	public enum RepairStatus : int
	{
		NotDoneInOrder = 1,
		WasDoneInOrder = 2,
		NotDoneWillTransf = 3,
		WasTransf = 4
	}

	/// <summary>
	/// The Reported Repair Reasons coming from RepairReasons table
	/// </summary>
	public enum RepairReasons : int
	{
		UsersReport = 1,
		PreventiveMaintenance = 2,
		StateInspection = 3,
		Blank = 4
	}

	/// <summary>
	/// The User Types
	/// </summary>
	public enum UserTypes : int
	{
		All = 0,
		Technician = 1,
		Operator = 2
	}

	/// <summary>
	/// The Signed Documents type
	/// </summary>
	public enum DocumentTypes : int
	{
		WorkOrderCheckedIn = 1,
		InspectionCompleted = 2,
		WorkOrderCheckedOut = 3,
		WorkOrderClosed = 4,
		WorkOrderOpen = 5,
		WorkOrderReOpened = 6
	}

	/// <summary>
	/// The types of the work order
	/// </summary>
	public enum WorkOrderTypes : int
	{
		Routine = 1,
		NonRoutine = 2
	}

	/// <summary>
	/// Work Order Technician's statuses
	/// </summary>
	public enum WorkOrderStatus : int
	{
		Open = 1,
		Closed = 2,
		Scheduled = 3,
		ReOpened = 6
		// OpenAwaitingParts = 4,
		// OpenAwaitingExternalService = 5
	}

	/// <summary>
	/// Work Order Operator's statuses
	/// </summary>
	public enum WorkOrderOperatorStatus : int
	{
		Null = 0,
		Checked_In = 1,
		Checked_Out = 2
	}

	public enum NoteTypes : int 
	{
		CreationNote = 1,
		OperatorNote = 2,
		TechnicianNote = 3,
		CheckOutNote = 4
	}

	public enum OperatorInstructionTypes : int
	{
		CheckOut_Global = 1,
		CheckIn_Global = 3,
		CheckIn_Staying = 4,
		CheckIn_Spare = 5,
		CheckOut_Spare = 8,
		ReOpen_Global = 11
	}

	/// <summary>
	/// The Structure containing a amount of a custom fields in database
	/// </summary>
	public struct MAXFIELDS
	{
		public const int MAX_NVARCHAR = 32;
		public const int MAX_INT = 8;
		public const int MAX_FLOAT = 8;
		public const int MAX_DATETIME = 8;
		public const int MAX_BIT = 8;
		public const int MAX_NTEXT = 8;
		public const int MAX_SQL_VARIANT = 8;
		public const int MAX_LOOKUP = 8;
	};

	/// <summary>
	/// The Structure for the Finish screen
	/// </summary>
	public struct BackFinishScreen
	{
		public string sMainText;

		public bool bMainMenuVisible;
		public string sMainMenuText;
		public string sMainMenuURL;

		public bool bContinueVisible;
		public string sContinueText; 
		public string sContinueURL;
		
		public bool bViewVisible;
		public string sViewText;
		public string sViewURL;

		public bool bAdditionalVisible;
		public string sAdditionalText;
		public string sAdditionalURL;

		public bool bPrintVisible;
		public string sPrintText;
		public string sPrintURL;
	};

	/// <summary>
	/// The structure for equipments searching
	/// </summary>
	public struct EquipFilter
	{
		public int iTypeId;
		public int iDeptId;
		public int iLocId;
		public int iOperatorId;
		public int iIsSpare;
		public string sEquipId;
	};

	/// <summary>
	/// The structure for users searching
	/// </summary>
	public struct UserFilter
	{
		public string sFirstName;
		public string sLastName;
		public string sEmail;
		public int iTypeId;
		public int iActiveStatus;
		public int iGroupId;
	};

	/// <summary>
	/// The Custom Fields class containing information for one record of a CustFieldsDef table of database.
	/// </summary>
	public class clsCustomFieldsDef
	{
		public int Id;
		public bool IsComponent;
		public int ComponentTypeID;
		public int NumberColumn;
		public string Name;
		public string NameText;
		public string NameLookupTable;
		public string NameFieldLookup;
		public bool Required;
		public DBFieldType FieldTypeId;
		public string Default;
		public string Help;

		public clsCustomFieldsDef()
		{
		}
	};

	/// <summary>
	/// Structure for Operator info in the Operator Kiosk
	/// </summary>
	public class OperatorInfo
	{
		private int m_Id;
		private string m_FirstName;
//		private int m_iEquipId;
//		private string m_sEquipId;

		public OperatorInfo(int _Id, string _FirstName)
		{
			m_Id = _Id;
			m_FirstName = _FirstName;
//			m_iEquipId = 0;
//			m_sEquipId = "";
		}

		public OperatorInfo(string _Input)
		{
			try
			{
				string[] sContext;
				sContext = _Input.Split(new char[] {':'});
				m_Id = Convert.ToInt32(sContext[0]);
				m_FirstName = sContext[1];
//				m_iEquipId = 0;
//				m_sEquipId = "";
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}


		public int Id
		{
			get
			{
				return m_Id;
			}
			set
			{
				m_Id = value;
			}
		}
		public string FirstName
		{
			get
			{
				return m_FirstName;
			}
			set
			{
				m_FirstName = value;
			}
		}

//		public int iEquipId
//		{
//			get
//			{
//				return m_iEquipId;
//			}
//			set
//			{
//				m_iEquipId = value;
//			}
//		}
//		public string sEquipId
//		{
//			get
//			{
//				return m_sEquipId;
//			}
//			set
//			{
//				m_sEquipId = value;
//			}
//		}

		public override string ToString()
		{
			return m_Id.ToString() + ":" + m_FirstName;
		}
	}
	

	/// <summary>
	/// Main class containing core functions
	/// </summary>
	public class _functions
	{

		/// <summary>
		/// The application name using in the Application Log of Event Viewer
		/// </summary>
		private const string EVENT_LOG_SOURCE = "bfp";

		/// <summary>
		/// The email address string for function SendEmail
		/// </summary>
		private string email; 

		/// <summary>
		/// The email's subject string for function SendEmail
		/// </summary>
		private string subj; 

		/// <summary>
		/// The email's body string for function SendEmail
		/// </summary>
		private string message;

		public _functions()
		{
		}


		/// <summary>
		/// Setting a input data to a SqlParameter array for inputting arguments of SQL Storage Procedure 
		/// </summary>
		/// <param name="_dtInput">the DataTable containing the inputting data</param>
		/// <returns>Return the SqlParameter array containing the inputting data</returns>
		internal static SqlParameter[] SetDataToParameters(DataTable _dtInput)
		{
			try
			{
				SqlParameter[] parameters = new SqlParameter[_dtInput.Rows.Count] ; 
				
				string sTypeName;
			
				for(int i=0; i < _dtInput.Rows.Count; i++)
				{
					sTypeName = Convert.ToString(_dtInput.Rows[i]["TypeName"]);
					switch(TypeNameParser(sTypeName))
					{
						case DBFieldType._nvarchar:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.NVarChar, 255, ParameterDirection.Input, true, 0, 0, "", DataRowVersion.Proposed, ((string)_dtInput.Rows[i]["Value_String"] == "")?SqlString.Null:_dtInput.Rows[i]["Value_String"]);
							break;
						case DBFieldType._int:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, ((string)_dtInput.Rows[i]["Value_String"] == "")?SqlInt32.Null:_dtInput.Rows[i]["Value_String"]);
							break;
						case DBFieldType._float:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Float, 8, ParameterDirection.Input, true, 19, 8, "", DataRowVersion.Proposed, ((string)_dtInput.Rows[i]["Value_String"] == "")?SqlDouble.Null:_dtInput.Rows[i]["Value_String"]);
							break;
						case DBFieldType._datetime:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.DateTime, 8, ParameterDirection.Input, true, 23, 3, "", DataRowVersion.Proposed, ((string)_dtInput.Rows[i]["Value_String"] == "")?SqlDateTime.Null:_dtInput.Rows[i]["Value_String"]);
							break;
						case DBFieldType._bit:
							if((string)_dtInput.Rows[i]["Value_String"] == "True")
								parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Bit, 1, ParameterDirection.Input, true, 1, 0, "", DataRowVersion.Proposed, SqlBoolean.True);
							else
								parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Bit, 1, ParameterDirection.Input, true, 1, 0, "", DataRowVersion.Proposed, ((string)_dtInput.Rows[i]["Value_String"] == "")?SqlBoolean.Null:SqlBoolean.False);
							break;
						case DBFieldType._ntext:
							//parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.NText, 8, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, _dtInput.Rows[i]["Value"]);
							break;
						case DBFieldType._sql_variant:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Variant, 0, ParameterDirection.Input, true, 0, 0, "", DataRowVersion.Proposed, ((string)_dtInput.Rows[i]["Value_String"] == "")?null:_dtInput.Rows[i]["Value_String"]);
							break;
						case DBFieldType._lookup:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Int, 4, ParameterDirection.Input, true, 10, 0, "", DataRowVersion.Proposed, _dtInput.Rows[i]["Value_String"]);
							break;
						default:
							parameters[i] = null;
							break;
					}
				}
				return parameters;
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally
			{
			}
		}

		
		/// <summary>
		/// Parsing a string for define the type of the custom fields
		/// </summary>
		/// <param name="_input">The string containing the type name</param>
		/// <returns>Return the DBFieldType type of custom field</returns>
		internal static DBFieldType TypeNameParser(string _input)
		{
			DBFieldType _ft;
			try
			{
				switch(_input.Substring(0,3))
				{
					case "nva":
						_ft = DBFieldType._nvarchar;
						break;
					case "int":
						_ft = DBFieldType._int;
						break;
					case "flo":
						_ft = DBFieldType._float;
						break;
					case "dat":
						_ft = DBFieldType._datetime;
						break;
					case "bit":
						_ft = DBFieldType._bit;
						break;
					case "nte":
						_ft = DBFieldType._ntext;
						break;
					case "sql":
						_ft = DBFieldType._sql_variant;
						break;
					case "loo":
						_ft = DBFieldType._lookup;
						break;
					default:
						_ft = DBFieldType._sql_variant;
						break;
				}
				return _ft;
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally
			{
			}
		}

		
		/// <summary>
		/// Getting the custom fields data from EquipData table
		/// </summary>
		/// <param name="bIsComponent">The boolean argument using for defining owner of data: the Equipment or the its component.</param>
		/// <param name="iTypeId">The integer argument for defining type of data</param>
		/// <param name="sContext_User_Identity">The Org string</param>
		/// <returns>Return the array containing data of custom fields in the clsCustomFieldsDef classes</returns>
		internal static ArrayList GetCustomFields(CFDataType cfdDataTypeId, int iTypeId, string sContext_User_Identity)
		{
			ArrayList arrCFD = null;
			clsCustomFieldsDef cfd = null;
			clsCustFields custfield = null;
			DataTable dtFields = null;
			try
			{
				custfield = new clsCustFields();
				arrCFD = new ArrayList();
				custfield.iOrgId = GetUserOrgId(sContext_User_Identity, false);
				custfield.iDataTypeId = (int)cfdDataTypeId;
				custfield.iComponentTypeID = (SqlInt32)iTypeId;
				dtFields = custfield.GetCustFields();
				if(dtFields.Rows.Count == 0)
				{
					return null;
				}
				for(int i = 0; i < dtFields.Rows.Count; i++)
				{
					cfd = new clsCustomFieldsDef();
					cfd.Id = Convert.ToInt32(dtFields.Rows[i]["Id"]);
					cfd.NumberColumn = Convert.ToInt32(dtFields.Rows[i]["NumberColumn"]);
					cfd.Name = Convert.ToString(dtFields.Rows[i]["vchName"]);
					cfd.NameText = Convert.ToString(dtFields.Rows[i]["vchNameText"]);
					cfd.NameLookupTable = Convert.ToString(dtFields.Rows[i]["vchNameLookupTable"]);
					cfd.NameFieldLookup = Convert.ToString(dtFields.Rows[i]["vchNameFieldLookup"]);
					cfd.Required = Convert.ToBoolean(dtFields.Rows[i]["btRequired"]);
					cfd.FieldTypeId = (DBFieldType)Convert.ToInt32(dtFields.Rows[i]["intFieldTypeId"]);
					cfd.Default = Convert.ToString(dtFields.Rows[i]["vchDefault"]);
					cfd.Help = Convert.ToString(dtFields.Rows[i]["vchHelp"]);
					arrCFD.Add(cfd);
					cfd = null;
				}
				return arrCFD;
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally
			{
				if(custfield != null)
				{
					custfield.Dispose();
				}
			}
		}
		

		/// <summary>
		/// Getting the string containing type name from inputting the DBFieldType type
		/// </summary>
		/// <param name="_ft">The inputting DBFieldType type </param>
		/// <returns>The string containing type name</returns>
		internal static string GetFieldTypeText(DBFieldType _ft)
		{
			string result;
			switch(_ft)
			{
				case DBFieldType._nvarchar:
					result = "nvarchar";
					break;
				case DBFieldType._int:
					result = "int";
					break;
				case DBFieldType._float:
					result = "float";
					break;
				case DBFieldType._datetime:
					result = "datetime";
					break;
				case DBFieldType._bit:
					result = "bit";
					break;
				case DBFieldType._ntext:
					result = "ntext";
					break;
				case DBFieldType._sql_variant:
					result = "sql_variant";
					break;
				case DBFieldType._lookup:
					result = "lookup";
					break;
				default:
					result = "sql_variant";
					break;
			}
			return result;
		}


		/// <summary>
		/// The function convert the standard search string to SQL search string, 
		/// for example: the symbol '*' convert to '%' or '?' to '_' and etc.
		/// </summary>
		/// <param name="_input">Convertible string</param>
		/// <returns>The string for SQL search.</returns>
		internal static string ConvertToSQLFilter(string _input)
		{
			try
			{
				if(_input.Length > 0)
				{
					_input = _input.Replace("*", "%");
					_input = _input.Replace("?", "_");
					return _input;
				}
				else
				{
					return "%";
				}
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}

		/// <summary>
		/// The function convert the SQL search string to standard search string, 
		/// for example: the symbol '%' convert to '*' or '_' to '?' and etc.
		/// </summary>
		/// <param name="_input">Convertible string</param>
		/// <returns>The standard search string.</returns>
		internal static string ConvertFromSQLFilter(string _input)
		{
			try
			{
				if(_input != "%")
				{
					_input = _input.Replace("%", "*");
					_input = _input.Replace("_", "?");
					return _input;
				}
				else
				{
					return "";
				}
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}


		/// <summary>
		/// Getting a string of error description by error code
		/// </summary>
		/// <param name="Code"></param>
		/// <returns></returns>
		internal static string ErrorMessage(int Code)
		{
			try
			{
				switch(Code)
				{
					case 101:
						return "The Equipment's types doesn't exits";
					case 102:
						return "Cannot found the Equipment(s)";
					case 103:
						return "The Equipmet wasn't added in the database";
					case 104:
						return "The id key in the URL string doesn't exist";
					case 105:
						return "The id key in the URL string must be numeric";
					case 106:
						return "The Equipment wasn't added in the database along of the Equipment wasn't found in the database";
					case 107:
						return "The Equipment wasn't updated in the database along of the Equipment wasn't found in the database";
					case 108:
						return "The Inputting data is not valid";
					case 109:
						return "Cannot execute the change because the Equipment isn't assigned to user";
					case 110:
						return "The Equipment component cannot be added/updated";
					case 111:
						return "Cannot found the users list";
					case 112:
						return "Cannot send the error report, sorry";
					case 113:
						return "Sorry, the Error Report service is disabled";
					case 114:
						return "Cannot found the custom fields";
					case 115:
						return "Cannot found the Error";
					case 116:
						return "Cannot found the Permission";
					case 117:
						return "Cannot found the Group";
					case 118:
						return "Cannot remove the Group because this Group has Users";
					case 119:
						return "The Work Order wasn't updated in the database along of the Work Order wasn't found in the database";
					case 120:
						return "Cannot found the Work Order";
					case 121:
						return "Cannot found the Reported Issue Item";
					case 122:
						return "You cannot delete this reported issue because It is using in other work orders";
					case 123:
						return "Cannot found the Service Item";
					case 124:
						return "Cannot found Inspections";
					case 125:
						return "Cannot found Part";
					case 126:
						return "You cannot delete this item because it has repair relating to other issues or other items";
					case 127:
						return "Cannot found Inspection Item";
					case 128:
						return "Cannot found Repair";
					case 129:
						return "You cannot view the unsigned order";
					case 130:
						return "You had signed nothing";
					case 131:
						return "Sorry, but only technicians has access to open order";
					case 132:
						return "You haven't possibility to order opening";
					case 133:
						return "Cannot found the Reported Issue Item";
					case 134:
						return "Unable to locate the user";
					case 135:
						return "You cannot add a New Repair in Edit mode";
					case 136:
						return "Equipment already checked-in to the Work Order";
					case 137:
						return "The Work Order must be scheduled and checked-In for the opening";
					case 138:
						return "The equipment cannot be checked-out because the work order has not been closed";
					case 139:
						return "The inspection cannot be signed because the non all inspection items were processed";
					case 140:
						return "The Initials or PIN is not correct";
					case 141:
						return "The system cannot close the work order because the work order hasn't Open status";
					case 142:
						return "The system cannot close work order because the not all service items were serviced";
					case 143:
						return "You must assign technician to the order for order completing";
					case 144:
						return "The Work Order must be scheduled and checked-In for the opening";
					case 145:
						return "This work order is currently Close";
					case 146:
						return "The certain issues are completed on the work order";
					case 147:
						return "The current equipment wasn't included to current inspection schedule";
					case 148:
						return "Next Inspection hasn't been created because the Work Order with this Inspection already exists";
					case 149:
						return "The date range is too small or the Holiday/No Service date ranges are too wide and the system is unable to identify any service dates available, thereby the work order with inspection has been scheduled to unworkday.";
					case 150:
						return "The work orders too much for current amount of technicians";
					case 151:
						return "Overflow of cycle";
					case 152:
						return "Future Work Order with this Inspection already exists.";
					case 153:
						return "Cannot found the Holidays";
					case 154:
						return "Cannot remove Inspection because the Inspection Schedule contain this Inspection. Please first remove Inspection Schedule.";
					case 155:
						return "Cannot remove Inspection because the this Inspection has been serviced in Work Orders.";
					case 156:
						return "Cannot found Inspection Category";
					case 157:
						return "Cannot remove Inspection item because the this Inspection Item has been serviced in Work Order(s).";
					case 158:
						return "System has not a Inspection Category for adding Inspection Item. Please create Category before.";
					case 159:
						return "Cannot found Inspection Schedule";
					case 160:
						return "Cannot remove Inspection Schedule because this Inspection has been serviced in Work Order(s)";
					case 161:
						return "Cannot remove Inspection Schedule because this Inspection is used by Equipment(s)";
					case 162:
						return "Minimal Days value must be less than Target Days value";
					case 163:
						return "Target Days value must be less than Maximal Days value";
					case 164:
						return "Minimal Days value must be less than Maximal Days value";
					case 165:
						return "The system cannot select one equipment from many activity work orders, please select work order from table by manually";
					case 166:
						return "You must add Issue or Comment to the Work Order";
					case 167:
						return "The system already has the opened Work Order for current Equipment";
					case 168:
						return "Cannot found Operator Instruction";
					case 169:
						return "Cannot found Preventive Maintenance Schedule";
					case 170:
						return "Cannot remove PM Schedule because this Preventive Maintenance has been serviced in Work Order(s)";
					case 171:
						return "Cannot remove PM Schedule because this Preventive Maintenance is used by Equipment(s)";
					case 172:
						return "Cannot found Preventive Maintenance Item";
					case 173:
						return "Cannot remove PM Item because this Preventive Maintenance has been set in PM Schedule";
					case 174:
						return "Cannot found PM Schedule Service Item";
					case 175:
						return "Cannot remove PM Service Item from Schedule because this Preventive Maintenance has been serviced in Work Order(s)";
					case 201:
						return "The Last Name or PIN is not correct";
					case 202:
						return "User is deactivated. Please apply to administrator.";
					case 203:
						return "Total hours must be less than 1000.";
					case 204:
						return "Stop time must occur after start time.";
					case 205:
						return "The inputting hours or minutes is not valid";
					case 206:
						return "The minutes has a incorrect format";
					default:
						return "Unknown Error";
				}
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally
			{
			}
		}

		
		/// <summary>
		/// Writting the Log in the Errors tables of database
		/// </summary>
		/// <param name="ex">The Exception</param>
		/// <param name="sUserOrgId">The user's string from Context.User</param>
		/// <param name="sPageName">Current Page Name</param>
		internal static void Log(Exception ex, string sUserOrgId, string sPageName)
		{
			clsErrors _error = null;
			try
			{
				_error = new clsErrors();
				_error.cAction = "U";
				_error.iId = 0;
				if(sUserOrgId.Length > 0)
				{
					_error.iUserId = GetUserOrgId(sUserOrgId, true);
					_error.iOrgId = GetUserOrgId(sUserOrgId, false);
				}
				else
				{
					_error.iUserId = 6;
					_error.iOrgId = 1;
				}
				_error.sPageName = sPageName;
				_error.sErrorName = ex.Message;
				_error.daCreated = DateTime.Now;
				_error.sDesc = ex.ToString();
				_error.ErrorDetail();
			}
			catch
			{ 
			}
			finally
			{
				if(_error != null)
				{
					_error.Dispose();
				}
			}
		}

		
		/// <summary>
		/// Getting a settings from web.config file
		/// </summary>
		/// <param name="_key">The key of a config setting</param>
		/// <returns>The setting string</returns>
		internal static string GetValueFromConfig(string key)
		{
			AppSettingsReader m_asrConfigReader;
			try
			{
				m_asrConfigReader = new AppSettingsReader();
				return m_asrConfigReader.GetValue(key, typeof(string)).ToString();
				
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			} 
		}

		
		/// <summary>
		/// The function is sending an email.
		/// </summary>
		/// <param name="_email">The email address string</param>
		/// <param name="_subj">The email's subject string </param>
		/// <param name="_message">The email's body string </param>
		/// <returns>Return true If Email is enabled</returns>
		internal static bool SendEmail(string _email, string _subj, string _message)
		{
			try
			{
				if(((string)GetValueFromConfig("Report.Enabled")).ToLower() == "true")
				{
					_functions _newF = new _functions();
					_newF.email = _email;
					_newF.subj = _subj;
					_newF.message = _message;
					Thread _th = new Thread(new ThreadStart(_newF.SendEmailThread));
					_th.Start();
					return true;
				}
				else
					return false;
			}
			catch(ThreadAbortException taex)
			{
				throw new Exception(taex.Message, taex);
			}
		}


		/// <summary>
		/// Getting a UserId or OrgId
		/// </summary>
		/// <param name="Input">Inputting string from HttpContext.Current.User.Identity.Name</param>
		/// <param name="IsUser">If true then return UserId else OrgId</param>
		/// <returns>Return UserId or OrgId</returns>
		internal static int GetUserOrgId(string Input, bool IsUser)
		{
			try
			{
				string[] sContext;
				sContext = Input.Split(new char[] {':'});
				if(IsUser)
					return Convert.ToInt32(sContext[0]);
				else
					return Convert.ToInt32(sContext[1]);
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}

		
		/// <summary>
		/// Getting the file name from URL link
		/// </summary>
		/// <param name="_url">the URL string</param>
		/// <returns>The file name</returns>
		internal static string GetFileNameFromURL(string _url)
		{
			int iIndex;
			string sResult;
			try
			{
				iIndex = _url.LastIndexOf("/");
				if(iIndex == -1)
					iIndex = 0;
				sResult = _url.Substring(iIndex);
				iIndex = sResult.IndexOf("?");
				if(iIndex == -1)
					return sResult;
				else
					return sResult.Substring(0, iIndex);
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}


		/// <summary>
		/// Method used to create a cryptographic random number that is used to
		/// salt the user's password for added security
		/// </summary>
		/// <param name="size"></param>
		/// <returns></returns>
		internal static string CreateSalt(int size)
		{
			// Generate a cryptographic random number using the cryptographic
			// service provider
			RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
			byte[] buff = new byte[size];
			rng.GetBytes(buff);
			// Return a Base64 string representation of the random number
			return Convert.ToBase64String(buff);
		}

		
		/// <summary>
		/// Returns a hash of the combined password and salt value
		/// </summary>
		/// <param name="pwd">password</param>
		/// <param name="salt">salt</param>
		/// <returns></returns>
		internal static string CreatePasswordHash(string pwd, string salt)
		{
			// Concat the raw password and salt value
			string saltAndPwd = String.Concat(pwd, salt);
			// Hash the salted password
			string hashedPwd = 
				FormsAuthentication.HashPasswordForStoringInConfigFile(
				saltAndPwd, "SHA1");
			return hashedPwd;
		}


		internal static DateTime CorrectDate(DateTime activeDateTime)
		{
			DateTime daTmpForFixBug;
			if(activeDateTime.Hour == 0 || activeDateTime.Hour == 12)
			{
				daTmpForFixBug = activeDateTime;
				if(daTmpForFixBug.Hour == 0)daTmpForFixBug = daTmpForFixBug.AddHours(12);
				else daTmpForFixBug = daTmpForFixBug.AddHours(-12);
			}
			else
				daTmpForFixBug = activeDateTime;
			return daTmpForFixBug;
		}

		private void SendEmailThread()
		{
			MailMessage myMail = null;
			try
			{
				myMail = new MailMessage();
				myMail.From = "The FleetPro Error Report Service <alexey.gavrilov@micajah.com>";
				myMail.BodyEncoding = System.Text.Encoding.Default;
				lock(this)
				{
					myMail.To = email.Trim();
					myMail.Subject = subj.Trim();
					myMail.Body = message.Trim();
				}
				myMail.BodyFormat = MailFormat.Html;
				myMail.Priority = MailPriority.Normal;
				SmtpMail.SmtpServer = GetValueFromConfig("Report.SMTPServer");
				SmtpMail.Send(myMail);
			}
			catch(Exception ex)
			{
				Log(ex, "", "functions.cs");
			}
			finally
			{
			}
		}

	}
}
