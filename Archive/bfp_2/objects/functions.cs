using System;
using System.Data;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Collections;
using System.Threading;
using System.Web.Mail;
using System.Configuration;
using BWA.BFP.Data;


namespace BWA.BFP.Core
{
	
	/// <summary>
	/// The data type of the custom fields 
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
	/// The structure contain a amount of a custom fields in database
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
	/// The Custom Fields class contain information for one record of a CustFieldsDef table of database.
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
	/// The data class contain data of one record of EquipData table of database
	/// The class doesn't using in the application by now.
	/// </summary>
	public struct clsData
	{
		public int iId;
		public SqlString nvarchar1; 
		public SqlString nvarchar2; 
		public SqlString nvarchar3;
		public SqlString nvarchar4;
		public SqlString nvarchar5;
		public SqlString nvarchar6;
		public SqlString nvarchar7;
		public SqlString nvarchar8;
		public SqlString nvarchar9;
		public SqlString nvarchar10;
		public SqlString nvarchar11;
		public SqlString nvarchar12;
		public SqlString nvarchar13;
		public SqlString nvarchar14;
		public SqlString nvarchar15;
		public SqlString nvarchar16;
		public SqlString nvarchar17;
		public SqlString nvarchar18;
		public SqlString nvarchar19;
		public SqlString nvarchar20;
		public SqlString nvarchar21;
		public SqlString nvarchar22;
		public SqlString nvarchar23;
		public SqlString nvarchar24;
		public SqlString nvarchar25;
		public SqlString nvarchar26;
		public SqlString nvarchar27;
		public SqlString nvarchar28;
		public SqlString nvarchar29;
		public SqlString nvarchar30;
		public SqlString nvarchar31;
		public SqlString nvarchar32;
		public SqlInt32 int1;
		public SqlInt32 int2;
		public SqlInt32 int3;
		public SqlInt32 int4;
		public SqlInt32 int5;
		public SqlInt32 int6;
		public SqlInt32 int7;
		public SqlInt32 int8;
		public SqlInt32 lookup1;
		public SqlInt32 lookup2;
		public SqlInt32 lookup3;
		public SqlInt32 lookup4;
		public SqlInt32 lookup5;
		public SqlInt32 lookup6;
		public SqlInt32 lookup7;
		public SqlInt32 lookup8;
		public SqlDouble float1;
		public SqlDouble float2;
		public SqlDouble float3;
		public SqlDouble float4;
		public SqlDouble float5;
		public SqlDouble float6;
		public SqlDouble float7;
		public SqlDouble float8;
		public SqlDateTime datetime1;
		public SqlDateTime datetime2;
		public SqlDateTime datetime3;
		public SqlDateTime datetime4;
		public SqlDateTime datetime5;
		public SqlDateTime datetime6;
		public SqlDateTime datetime7;
		public SqlDateTime datetime8;
		public SqlBoolean bit1;
		public SqlBoolean bit2;
		public SqlBoolean bit3;
		public SqlBoolean bit4;
		public SqlBoolean bit5;
		public SqlBoolean bit6;
		public SqlBoolean bit7;
		public SqlBoolean bit8;

	}


	/// <summary>
	/// Main class having core functions
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
		/// Setting a inputting data to a SqlParameter array for inputting arguments of SQL Storage Procedure 
		/// </summary>
		/// <param name="_dtInput">the DataTable containing the inputting data</param>
		/// <returns>Return the SqlParameter array containing the inputting data</returns>
		public static SqlParameter[] SetDataToParameters(DataTable _dtInput)
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
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.NVarChar, 255, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, _dtInput.Rows[i]["Value_String"]);
							break;
						case DBFieldType._int:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, _dtInput.Rows[i]["Value_String"]);
							break;
						case DBFieldType._float:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Float, 8, ParameterDirection.Input, false, 19, 8, "", DataRowVersion.Proposed, _dtInput.Rows[i]["Value_String"]);
							break;
						case DBFieldType._datetime:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.DateTime, 8, ParameterDirection.Input, false, 23, 3, "", DataRowVersion.Proposed, _dtInput.Rows[i]["Value_String"]);
							break;
						case DBFieldType._bit:
							if((string)_dtInput.Rows[i]["Value_String"] == "True")
								parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Bit, 1, ParameterDirection.Input, false, 1, 0, "", DataRowVersion.Proposed, SqlBoolean.True);
							else
								parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Bit, 1, ParameterDirection.Input, false, 1, 0, "", DataRowVersion.Proposed, SqlBoolean.False);
							break;
						case DBFieldType._ntext:
							//parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.NText, 8, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, _dtInput.Rows[i]["Value"]);
							break;
						case DBFieldType._sql_variant:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Variant, 0, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Proposed, _dtInput.Rows[i]["Value_String"]);
							break;
						case DBFieldType._lookup:
							parameters[i] = new SqlParameter("@" + sTypeName, SqlDbType.Int, 4, ParameterDirection.Input, false, 10, 0, "", DataRowVersion.Proposed, _dtInput.Rows[i]["Value_String"]);
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
				throw new Exception(ex.Message);
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
		public static DBFieldType TypeNameParser(string _input)
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
				throw new Exception(ex.Message);
			}
			finally
			{
			}
		}

		
		/// <summary>
		/// Parsing the data string from EquipData table for defining the custom fields
		/// The function doesn't using in the application by now.
		/// </summary>
		/// <param name="dtInput">The DataTable containing data of one record of EquipData table of database</param>
		/// <param name="iTypeId">The type of equipment</param>
		/// <returns>Return the array containing data of custom fields in the clsCustomFieldsDef classes</returns>
		public static ArrayList CustomFieldsParse(DataTable dtInput, int iTypeId)
		{
			int j;
			ArrayList arrCFD = null;
			clsCustomFieldsDef cfd = null;
			clsCustFields custfield = null;
			try
			{
				custfield = new clsCustFields();
				arrCFD = new ArrayList();
				custfield.cAction = "S";
				custfield.iOrgId = 1; // will change
				// processing nvarchar's fields type
				for(j = 1; j <= MAXFIELDS.MAX_NVARCHAR; j++)
				{
					if( dtInput.Rows[0]["nvarchar" + j.ToString()] != DBNull.Value)
					{
						cfd = new clsCustomFieldsDef();
						cfd.FieldTypeId = DBFieldType._nvarchar;
						custfield.iFieldTypeId = (int)DBFieldType._nvarchar;
						cfd.NumberColumn = j;
						custfield.iNumberColumn = j;
						
						cfd.IsComponent = false;
						custfield.bitIsComponent = false;
						cfd.ComponentTypeID = iTypeId; 
						custfield.iComponentTypeID = iTypeId;
						custfield.CustFieldsEquipment();
						cfd.Id = custfield.iId.Value;
						cfd.Name = custfield.sName.Value;
						cfd.NameText = custfield.sNameText.Value;
						cfd.NameLookupTable = custfield.sNameLookupTable.Value;
						cfd.NameFieldLookup = custfield.sNameFieldLookup.Value;
						cfd.Required = custfield.bitRequired.Value;
						cfd.Default = custfield.sDefault.Value;
						cfd.Help = custfield.sHelp.Value;
						arrCFD.Add(cfd);
						cfd = null;
					}
				}

				// processing int's fields type
				for(j = 1; j <= MAXFIELDS.MAX_INT; j++)
				{
					if( dtInput.Rows[0]["int" + j.ToString()] != DBNull.Value)
					{
						cfd = new clsCustomFieldsDef();
						cfd.FieldTypeId = DBFieldType._int;
						custfield.iFieldTypeId = (int)DBFieldType._int;
						cfd.NumberColumn = j;
						custfield.iNumberColumn = j;
						cfd.IsComponent = false;
						custfield.bitIsComponent = false;
						cfd.ComponentTypeID = iTypeId;
						custfield.iComponentTypeID = iTypeId;
						custfield.CustFieldsEquipment();
						cfd.Id = (int)custfield.iId;
						cfd.Name = (string)custfield.sName;
						cfd.NameText = (string)custfield.sNameText;
						cfd.NameLookupTable = (string)custfield.sNameLookupTable;
						cfd.NameFieldLookup = (string)custfield.sNameFieldLookup;
						cfd.Required = (bool)custfield.bitRequired;
						cfd.Default = (string)custfield.sDefault;
						arrCFD.Add(cfd);
						cfd = null;
					}
				}

				// processing lookup's fields type
				for(j = 1; j <= MAXFIELDS.MAX_LOOKUP; j++)
				{
					if( dtInput.Rows[0]["lookup" + j.ToString()] != DBNull.Value)
					{
						cfd = new clsCustomFieldsDef();
						cfd.FieldTypeId = DBFieldType._lookup;
						custfield.iFieldTypeId = (int)DBFieldType._lookup;
						cfd.NumberColumn = j;
						custfield.iNumberColumn = j;
						cfd.IsComponent = false;
						custfield.bitIsComponent = false;
						cfd.ComponentTypeID = iTypeId;
						custfield.iComponentTypeID = iTypeId;
						custfield.CustFieldsEquipment();
						cfd.Id = (int)custfield.iId;
						cfd.Name = (string)custfield.sName;
						cfd.NameText = (string)custfield.sNameText;
						cfd.NameLookupTable = (string)custfield.sNameLookupTable;
						cfd.NameFieldLookup = (string)custfield.sNameFieldLookup;
						cfd.Required = (bool)custfield.bitRequired;
						cfd.Default = (string)custfield.sDefault;
						arrCFD.Add(cfd);
						cfd = null;
					}
				}

				// processing float's fields type
				for(j = 1; j <= MAXFIELDS.MAX_FLOAT; j++)
				{
					if( dtInput.Rows[0]["float" + j.ToString()] != DBNull.Value)
					{
						cfd = new clsCustomFieldsDef();
						custfield.cAction = "S";
						custfield.iOrgId = 1; // will change
						cfd.FieldTypeId = DBFieldType._float;
						custfield.iFieldTypeId = (int)DBFieldType._float;
						cfd.NumberColumn = j;
						custfield.iNumberColumn = j;
						cfd.IsComponent = false;
						custfield.bitIsComponent = false;
						cfd.ComponentTypeID = iTypeId;
						custfield.iComponentTypeID = iTypeId;
						custfield.CustFieldsEquipment();
						cfd.Id = (int)custfield.iId;
						cfd.Name = (string)custfield.sName;
						cfd.NameText = (string)custfield.sNameText;
						cfd.NameLookupTable = (string)custfield.sNameLookupTable;
						cfd.NameFieldLookup = (string)custfield.sNameFieldLookup;
						cfd.Required = (bool)custfield.bitRequired;
						cfd.Default = (string)custfield.sDefault;
						arrCFD.Add(cfd);
						cfd = null;
					}
				}

				// processing datetime's fields type
				for(j = 1; j <= MAXFIELDS.MAX_DATETIME; j++)
				{
					if( dtInput.Rows[0]["datetime" + j.ToString()] != DBNull.Value)
					{
						cfd = new clsCustomFieldsDef();
						cfd.FieldTypeId = DBFieldType._datetime;
						custfield.iFieldTypeId = (int)DBFieldType._datetime;
						cfd.NumberColumn = j;
						custfield.iNumberColumn = j;
						cfd.IsComponent = false;
						custfield.bitIsComponent = false;
						cfd.ComponentTypeID = iTypeId;
						custfield.iComponentTypeID = iTypeId;
						custfield.CustFieldsEquipment();
						cfd.Id = (int)custfield.iId;
						cfd.Name = (string)custfield.sName;
						cfd.NameText = (string)custfield.sNameText;
						cfd.NameLookupTable = (string)custfield.sNameLookupTable;
						cfd.NameFieldLookup = (string)custfield.sNameFieldLookup;
						cfd.Required = (bool)custfield.bitRequired;
						cfd.Default = (string)custfield.sDefault;
						arrCFD.Add(cfd);
						cfd = null;
					}
				}

				// processing bit's fields type
				for(j = 1; j <= MAXFIELDS.MAX_BIT; j++)
				{
					if( dtInput.Rows[0]["bit" + j.ToString()] != DBNull.Value)
					{
						cfd = new clsCustomFieldsDef();
						cfd.FieldTypeId = DBFieldType._bit;
						custfield.iFieldTypeId = (int)DBFieldType._bit;
						cfd.NumberColumn = j;
						custfield.iNumberColumn = j;
						cfd.IsComponent = false;
						custfield.bitIsComponent = false;
						cfd.ComponentTypeID = iTypeId;
						custfield.iComponentTypeID = iTypeId;
						custfield.CustFieldsEquipment();
						cfd.Id = (int)custfield.iId;
						cfd.Name = (string)custfield.sName;
						cfd.NameText = (string)custfield.sNameText;
						cfd.NameLookupTable = (string)custfield.sNameLookupTable;
						cfd.NameFieldLookup = (string)custfield.sNameFieldLookup;
						cfd.Required = (bool)custfield.bitRequired;
						cfd.Default = (string)custfield.sDefault;
						arrCFD.Add(cfd);
						cfd = null;
					}
				}
				return arrCFD;
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message);
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
		/// Getting the custom fields data from EquipData table
		/// </summary>
		/// <param name="bIsComponent">The boolean argument using for defining owner of data: the Equipment or the its component.</param>
		/// <param name="iTypeId">The integer argument for defining type of data</param>
		/// <param name="sContext_User_Identity">The Org string</param>
		/// <returns>Return the array containing data of custom fields in the clsCustomFieldsDef classes</returns>
		public static ArrayList GetCustomFields(bool bIsComponent, int iTypeId, string sContext_User_Identity)
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
				custfield.bitIsComponent = (SqlBoolean)bIsComponent;
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
				throw new Exception(ex.Message);
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
		public static string GetFieldTypeText(DBFieldType _ft)
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
		/// Getting a string of error description by error code
		/// </summary>
		/// <param name="Code"></param>
		/// <returns></returns>
		public static string ErrorMessage(int Code)
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
						return "The Equipmet wasn't added in the database along of the Equipment wasn't found in the database";
					case 107:
						return "The Equipmet wasn't updated in the database along of the Equipment wasn't found in the database";
					case 108:
						return "The Inputting data is not valid";
					case 109:
						return "Cannot execute the change because the Equipment isn't assigned to user";
					case 110:
						return "the Equipment component cannot be added/updated.";
					case 111:
						return "Cannot found the users list";
					case 112:
						return "Cannot send the error report, sorry";
					case 113:
						return "Sorry, the Error Report service is disabled";
					case 114:
						return "Cannot found the custom fields of Equipment type";
					default:
						throw new Exception("Cannot found the error message");
				}
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message);
			}
			finally
			{
			}
		}

		
		/// <summary>
		/// Writting the Log in the Application Log of System Events
		/// </summary>
		/// <param name="message">Error string</param>
		public static void Log(string message)
		{
			EventLog m_eventLog = null;
			try
			{
				if(!EventLog.SourceExists(EVENT_LOG_SOURCE))
				{
					EventLog.CreateEventSource(EVENT_LOG_SOURCE, "Application");
				}
				if(m_eventLog == null)
				{
					m_eventLog = new EventLog("Application");
					m_eventLog.Source = EVENT_LOG_SOURCE;
				}
				m_eventLog.WriteEntry(message, System.Diagnostics.EventLogEntryType.Error);
			}
			catch
			{ 
			}
		}

		
		/// <summary>
		/// Getting a settings from web.config file
		/// </summary>
		/// <param name="_key">The key of a config setting</param>
		/// <returns>The setting string</returns>
		public static string GetValueFromConfig(string key)
		{
			AppSettingsReader m_asrConfigReader;
			try
			{
				m_asrConfigReader = new AppSettingsReader();
				return m_asrConfigReader.GetValue(key, typeof(string)).ToString();
				
			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message);
			} 
		}

		
		/// <summary>
		/// The function is sending an email.
		/// </summary>
		/// <param name="_email">The email address string</param>
		/// <param name="_subj">The email's subject string </param>
		/// <param name="_message">The email's body string </param>
		/// <returns>Return true If Email is enabled</returns>
		public static bool SendEmail(string _email, string _subj, string _message)
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
				throw new Exception(taex.Message);
			}
		}


		/// <summary>
		/// Getting a UserId or OrgId
		/// </summary>
		/// <param name="Input">Inputting string from HttpContext.Current.User.Identity.Name</param>
		/// <param name="IsUser">If true then return UserId else OrgId</param>
		/// <returns>Return UserId or OrgId</returns>
		public static int GetUserOrgId(string Input, bool IsUser)
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
				throw new Exception(ex.Message);
			}
		}

		/// <summary>
		/// Getting the file name from URL link
		/// </summary>
		/// <param name="_url">the URL string</param>
		/// <returns>The file name</returns>
		public static string GetFileNameFromURL(string _url)
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
				throw new Exception(ex.Message);
			}
		}

		private void SendEmailThread()
		{
			MailMessage myMail = null;
			try
			{
				myMail = new MailMessage();
				myMail.From = "The FleetPro Error Report Service <jon.vickers@micajah.com>";
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
				Log("Application error: \n" + ex.ToString());
			}
			finally
			{
			}
		}

	}
}
