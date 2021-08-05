using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Microsoft.SqlServer.ReportingServices;

namespace BWA.BFP.Web
{
	public class GetImage : System.Web.UI.Page
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
			try
			{
				string reportPath = Server.UrlDecode(Request["report"]);

				string streamID = Request["streamid"];

				ReportingService rs = (ReportingService)Session["rs"];

				string encodingImage;
				string mimeTypeImage;
				byte[] image;
				ParameterValue[] parameters = (ParameterValue[])Session["reportParameterValues"];

				image = rs.RenderStream(reportPath, "HTML4.0", streamID, null, null, 
					parameters, out encodingImage, out mimeTypeImage);

				Response.Clear();
				Response.ContentType = mimeTypeImage;
				Response.AppendHeader("content-length", image.Length.ToString());
				Response.BinaryWrite(image);
				Response.Flush();
				Response.Close();

			}
			catch(Exception ex)
			{
				Core._functions.Log(ex, HttpContext.Current.User.Identity.Name, "GetImage.aspx.cs");
				Session["lastpage"] = "main.aspx";
				Session["error"] = ex.Message;
				Session["error_report"] = ex.ToString();
				Response.Redirect("error.aspx", false);
			}
			finally
			{
			}
		}


		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
		}
		
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
