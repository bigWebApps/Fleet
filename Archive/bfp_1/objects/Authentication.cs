using System;
using System.Web.Security;
using System.Data.SqlClient;
using System.Data;
using System.Collections;

namespace BWA.WebModules
{
	/// <summary>
	/// Summary description for Authentication.
	/// </summary>
	/// 
	public interface ICredentialStore
	{
		bool Authenticate(string login, string password, out int orgId, out string firstName, out int userId);
		string[] GetRoles(int userId);
	}

	public class DBAuthentication : BWA.BFP.Data.DbObject, ICredentialStore
	{
		public DBAuthentication()
		{
			
			
		}

		public bool Authenticate(string login, string password, out int orgId, out string firstName, out int userId)
		{
			orgId=0;
			firstName=null;
			bool isAuthenticated = false;
			userId=0;

			SqlParameter[] parameters = 
				{
					new SqlParameter("@vchEmail",SqlDbType.VarChar,75),
					new SqlParameter("@vchPass",SqlDbType.VarChar,50),
					new SqlParameter("@OrgId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,string.Empty,DataRowVersion.Default,null),
					new SqlParameter("@vchFirstName",SqlDbType.VarChar,50,ParameterDirection.Output,false,0,0,string.Empty,DataRowVersion.Default,null),
					new SqlParameter("@UserId",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,string.Empty,DataRowVersion.Default,null)
				};
			parameters[0].Value = login;
			parameters[1].Value = password;
			
			int returnValue;
			SqlCommand cmd = cmdRunProcedure("sp_Authenticate",parameters,out returnValue);
			if(returnValue!=-1)
			{
				isAuthenticated = true;
				orgId = (int)cmd.Parameters["@OrgId"].Value;
				firstName = (string)cmd.Parameters["@vchFirstName"].Value;
				userId = (int)cmd.Parameters["@UserId"].Value;
			}
			return isAuthenticated;
		}

		public string[] GetRoles(int userId)
		{
			ArrayList roles = new ArrayList();

			roles.Add("role1");
			roles.Add("role2");
			roles.Add("role3");

			return (string[])roles.ToArray(Type.GetType("System.String"));

		}

	}
}
