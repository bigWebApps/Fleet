using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Configuration;

namespace BWA.BFP.Data
{
	/// <summary>
	/// Purpose: Error Enums used by this  library.
	/// </summary>
	public enum Error
	{
		AllOk
		// Add more here (check the comma's!)
	}

	/// <summary>
	/// Purpose: Abstract base class for Database Interaction classes.
	/// </summary>
	public abstract class clsDBInteractionBase : IDisposable
	{
		#region Class Member Declarations
		protected	SqlConnection			m_scoMainConnection;
		protected	SqlInt32				m_iErrorCode;
		protected	bool					m_bMainConnectionIsCreatedLocal;
		protected	clsConnectionProvider	m_cpMainConnectionProvider;
		private		bool					m_bIsDisposed;
		#endregion

		/// <summary>
		/// Constructor
		/// </summary>
		public clsDBInteractionBase()
		{
			InitClass();
		}

		/// <summary>
		/// Purpose: Initializes class members.
		/// </summary>
		private void InitClass()
		{
			// create all the objects and initialize other members.
			m_scoMainConnection = new SqlConnection();
			m_bMainConnectionIsCreatedLocal = true;
			m_cpMainConnectionProvider = null;
			//AppSettingsReader m_asrConfigReader = new AppSettingsReader();

			// Set connection string of the sqlconnection object
			m_scoMainConnection.ConnectionString = ConfigurationManager.ConnectionStrings["FleetSystem.ConnectionString"].ConnectionString;
			//m_asrConfigReader.GetValue("BFPCntStr", typeof(string)).ToString();
			m_iErrorCode = (int)Error.AllOk;
			m_bIsDisposed = false;
		}

		/// <summary>
		/// Purpose: Implements the IDispose' method Dispose.
		/// </summary>
		public void Dispose()
		{
			Dispose(true);
			GC.SuppressFinalize(this);
		}

		/// <summary>
		/// Purpose: Implements the Dispose functionality.
		/// </summary>
		protected virtual void Dispose(bool bIsDisposing)
		{
			// Check to see if Dispose has already been called.
			if(!m_bIsDisposed)
			{
				if(bIsDisposing)
				{
					// Dispose managed resources.
					if(m_bMainConnectionIsCreatedLocal)
					{
						// Object is created in this class, so destroy it here.
						m_scoMainConnection.Close();
						m_scoMainConnection.Dispose();
						m_bMainConnectionIsCreatedLocal = false;
					}
					m_cpMainConnectionProvider = null;
					m_scoMainConnection = null;
				}
			}
			m_bIsDisposed = true;
		}

		
		#region Class Property Declarations
		public clsConnectionProvider cpMainConnectionProvider
		{
			set
			{
				if(value==null)
				{
					// Invalid value
					throw new ArgumentNullException("cpMainConnectionProvider", "Null passed as value to this property which is not allowed.");
				}

				// A connection provider object is passed to this class.
				// Retrieve the SqlConnection object, if present and create a
				// reference to it. If there is already a MainConnection object
				// referenced by the membervar, destroy that one or simply 
				// remove the reference, based on the flag.
				if(m_scoMainConnection!=null)
				{
					// First get rid of current connection object. Caller is responsible
					if(m_bMainConnectionIsCreatedLocal)
					{
						// Is local created object, close it and dispose it.
						m_scoMainConnection.Close();
						m_scoMainConnection.Dispose();
					}
					// Remove reference.
					m_scoMainConnection = null;
				}
				m_cpMainConnectionProvider = (clsConnectionProvider)value;
				m_scoMainConnection = m_cpMainConnectionProvider.scoDBConnection;
				m_bMainConnectionIsCreatedLocal = false;
			}
		}


		public SqlInt32 iErrorCode
		{
			get
			{
				return m_iErrorCode;
			}
		}
		#endregion

	}
}
