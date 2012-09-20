using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace BWA.BFP.Data
{
	/// <summary>
	/// DbObject is the class from which all classes in the Data Services
	/// Tier inherit. The core functionality of establishing a connection
	/// with the database and executing simple stored procedures is also
	/// provided by this base class.
	/// </summary>
	public class DbObject
	{
		protected SqlConnection cnt;
		private string cntString;

		public DbObject()
		{
			cntString = ConfigurationSettings.AppSettings["BFPCntStr"];
			cnt = new SqlConnection( cntString );
		}
		/// <summary>
		/// A parameterized constructor, it allows us to take a connection
		/// string as a constructor argument, automatically instantiating
		/// a new connection.
		/// </summary>
		/// <param name="newcntString">Connection String to the associated database</param>
		/// 
		//public DbObject( string newcntString )
		//{
		//	cntString = newcntString;
		//	Connection = new SqlConnection( cntString );
		//}

		/// <summary>
		/// Protected property that exposes the connection string
		/// to inheriting classes. Read-Only.
		/// </summary>
		protected string CntString
		{
			get 
			{
				return cntString;
			}
		}


		public void CntOpen()
		{
			cnt.Open();
		}

		public void CntClose()
		{
			cnt.Close();
		}

		/// <summary>
		/// Private routine allowed only by this base class, it automates the task
		/// of building a SqlCommand object designed to obtain a return value from
		/// the stored procedure.
		/// </summary>
		/// <param name="storedProcName">Name of the stored procedure in the DB, eg. sp_DoTask</param>
		/// <param name="parameters">Array of IDataParameter objects containing parameters to the stored proc</param>
		/// <returns>Newly instantiated SqlCommand instance</returns>
		protected SqlCommand BuildIntCommand(string storedProcName, IDataParameter[] parameters)
		{
			SqlCommand command = BuildQueryCommand( storedProcName, parameters );			

			command.Parameters.Add( new SqlParameter ( "ReturnValue",
				SqlDbType.Int,
				4, /* Size */
				ParameterDirection.ReturnValue,
				false, /* is nullable */
				0, /* byte precision */
				0, /* byte scale */
				string.Empty,
				DataRowVersion.Default,
				null ));

			return command;
		}

		/// <summary>
		/// Builds a SqlCommand designed to return a SqlDataReader, and not
		/// an actual integer value.
		/// </summary>
		/// <param name="storedProcName">Name of the stored procedure</param>
		/// <param name="parameters">Array of IDataParameter objects</param>
		/// <returns></returns>
		private SqlCommand BuildQueryCommand(string storedProcName, IDataParameter[] parameters)
		{
			SqlCommand command = new SqlCommand( storedProcName, cnt );
			command.CommandType = CommandType.StoredProcedure;

			foreach (SqlParameter parameter in parameters)
			{
				command.Parameters.Add( parameter );
			}

			return command;

		}

		/// <summary>
		/// Runs a stored procedure, can only be called by those classes deriving
		/// from this base. It return a SqlCommand object that can be manipluated manually
		/// </summary>
		/// <param name="storedProcName">Name of the stored procedure</param>
		/// <param name="parameters">Array of IDataParameter objects</param>
		/// <param name="ReturnConnection">The SqlConnection to close after using command object</param>
		/// <returns>SqlCommand Object</returns>
		public SqlCommand cmdRunProcedure(string storedProcName, IDataParameter[] parameters, out SqlConnection ReturnConnection, out int ReturnValue )
		{
			CntOpen();
			SqlCommand command = BuildIntCommand( storedProcName, parameters );
			command.ExecuteNonQuery();
			ReturnValue = (int)command.Parameters["ReturnValue"].Value;
			ReturnConnection = cnt;
			return command;
		}

		public SqlCommand cmdRunProcedure(string storedProcName, IDataParameter[] parameters, out int ReturnValue )
		{
			CntOpen();
			SqlCommand command = BuildIntCommand( storedProcName, parameters );
			command.ExecuteNonQuery();
			ReturnValue = (int)command.Parameters["ReturnValue"].Value;
			CntClose();
			return command;
		}

		


		/// <summary>
		/// Runs a stored procedure, can only be called by those classes deriving
		/// from this base. It returns an integer indicating the return value of the
		/// stored procedure, and also returns the value of the RowsAffected aspect
		/// of the stored procedure that is returned by the ExecuteNonQuery method.
		/// </summary>
		/// <param name="storedProcName">Name of the stored procedure</param>
		/// <param name="parameters">Array of IDataParameter objects</param>
		/// <param name="rowsAffected">Number of rows affected by the stored procedure.</param>
		/// <returns>An integer indicating return value of the stored procedure</returns>
		public int intRunProcedure(string storedProcName, IDataParameter[] parameters, out int rowsAffected )
		{
			int result;
			SqlCommand command = BuildIntCommand( storedProcName, parameters );
			CntOpen();
			rowsAffected = command.ExecuteNonQuery();
			CntClose();
			result = (int)command.Parameters["ReturnValue"].Value;
			return result;
		}

		public int intRunProcedure(string storedProcName, IDataParameter[] parameters)
		{
			int result;
			SqlCommand command = BuildIntCommand( storedProcName, parameters );
			CntOpen();
			command.ExecuteNonQuery();
			CntClose();
			result = (int)command.Parameters["ReturnValue"].Value;
			return result;
		}

		public void RunProcedure(string storedProcName, IDataParameter[] parameters)
		{
			CntOpen();
			SqlCommand command = BuildIntCommand( storedProcName, parameters );
			command.ExecuteNonQuery();
			CntClose();
			return;
		}

		/// <summary>
		/// Will run a stored procedure, can only be called by those classes deriving
		/// from this base. It returns a SqlDataReader containing the result of the stored
		/// procedure.
		/// </summary>
		/// <param name="storedProcName">Name of the stored procedure</param>
		/// <param name="parameters">Array of parameters to be passed to the procedure</param>
		/// <returns>A newly instantiated SqlDataReader object</returns>
		public SqlDataReader drRunProcedure(string storedProcName, IDataParameter[] parameters )
		{
			SqlDataReader returnReader;
			SqlCommand command = BuildQueryCommand( storedProcName, parameters );
			command.CommandType = CommandType.StoredProcedure;
			returnReader = command.ExecuteReader();
			return returnReader;
		}

		/// <summary>
		/// Creates a DataSet by running the stored procedure and placing the results
		/// of the query/proc into the given tablename.
		/// </summary>
		/// <param name="storedProcName"></param>
		/// <param name="parameters"></param>
		/// <param name="tableName"></param>
		/// <returns></returns>
		public DataSet dsRunProcedure(string storedProcName, IDataParameter[] parameters, string tableName )
		{
			DataSet dataSet = new DataSet();
			SqlDataAdapter sqlDA = new SqlDataAdapter();
			sqlDA.SelectCommand = BuildQueryCommand( storedProcName, parameters );
			sqlDA.Fill( dataSet, tableName );
			
			return dataSet;
		}

		public DataSet dsRunProcedure(string storedProcName, IDataParameter[] parameters, out int ReturnValue, string TableName, out SqlCommand sqlCommand) {
			sqlCommand = BuildIntCommand( storedProcName, parameters );
			SqlDataAdapter sqlDA = new SqlDataAdapter();
			sqlDA.SelectCommand = sqlCommand;
			DataSet dsReturn = new DataSet();
			CntOpen();
			sqlDA.Fill(dsReturn,TableName);
			ReturnValue = (int)sqlCommand.Parameters["ReturnValue"].Value;
			CntClose();
			return dsReturn;
		}
		/// <summary>
		/// Takes an -existing- dataset and fills the given table name with the results
		/// of the stored procedure.
		/// </summary>
		/// <param name="storedProcName"></param>
		/// <param name="parameters"></param>
		/// <param name="dataSet"></param>
		/// <param name="tableName"></param>
		/// <returns></returns>
		public void RunProcedure(string storedProcName, IDataParameter[] parameters, DataSet dataSet, string tableName )
		{
			//cnt.Open();
			SqlDataAdapter sqlDA = new SqlDataAdapter();
			sqlDA.SelectCommand = BuildIntCommand( storedProcName, parameters );
			sqlDA.Fill( dataSet, tableName );
			//cnt.Close();			
		}


	}
}
