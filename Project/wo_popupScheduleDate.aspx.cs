using System;
using System.Collections;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Xml;
using System.Xml.Xsl;
using BWA.BFP.Core;
using BWA.BFP.Data;

namespace BWA.BFP.Web.workorder
{
	public class _wo_popupScheduleDate : BFPPage
	{
		protected System.Web.UI.WebControls.DropDownList MonthSelect;
		protected System.Web.UI.WebControls.DropDownList YearSelect;
		protected System.Web.UI.WebControls.Calendar Cal;
		protected System.Web.UI.WebControls.Label lblDate;
		protected System.Web.UI.WebControls.Button OKButton;
		protected System.Web.UI.WebControls.Button CancelButton;
		protected System.Web.UI.WebControls.Xml xmlTimeSheet;
		protected System.Web.UI.HtmlControls.HtmlInputHidden datechosen;
		
		protected clsWorkOrders order = null;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			string selected, id, form, postBack, time;

			SourcePageName = "wo_popupScheduleDate.aspx.cs";
			NameValueCollection CollQS;

			Header.MainMenuVisible = false;
			Header.Visible = false;
			Footer.Visible = false;
			try
			{
				if(!IsPostBack)
				{
					selected = Request.QueryString["selected"];
					id = Request.QueryString["id"];
					form = Request.QueryString["formname"];
					postBack = Request.QueryString["postBack"];
					if(Request.QueryString["time"] != null)
						time = Request.QueryString["time"];
					else
					{
						time = "0";
					}
					ViewState["formname"] = form;
					ViewState["id"] = id;
					ViewState["postBack"] = postBack;

					if(selected == "0" || Request.QueryString["selected"] == null) Cal.VisibleDate = DateTime.Now;
					else Cal.VisibleDate = (new DateTime(1970, 1, 1, 0, 0, 0, 0)).AddMilliseconds(Convert.ToDouble(selected));
					Cal.SelectedDate = Cal.VisibleDate;
					FillCalendarChoices();
					SelectCorrectValues();
					SelectXmlTimeSheet();

					// Add JScript to the OK button so that when the user clicks on it, the selected date
					// is passed back to the calling page.
					OKButton.Attributes.Add("onClick", "window.opener.SetDateToActiveDate('" + form + "','" + id + "', document.Calendar.datechosen.value," + postBack + ", " + time + ");CloseWindow();");
					CancelButton.Attributes.Add("onClick", "CloseWindow();");
				}
				if(ViewState["Day"] != null)
				{
					if((long)ViewState["Day"] == Cal.SelectedDate.Ticks)
						SelectXmlTimeSheet();
				}
				else
				{
					ViewState["Day"] = Cal.SelectedDate.Ticks;
				}
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		public void FillCalendarChoices()
		{
			DateTime thisdate; 
			int x,y;
			ListItem li;
			try
			{
				thisdate = new DateTime(2010,1,1);
				for(x=0; x<=11; x++)
				{
					li = new ListItem(thisdate.ToString("MMMM"), thisdate.Month.ToString());
					MonthSelect.Items.Add(li);
					thisdate = thisdate.AddMonths(1);
				}
				for(y = 1970; y<= thisdate.Year; y++)
				{
					YearSelect.Items.Add(y.ToString());
				}
			}
			catch(Exception ex)
			{
				throw new Exception("Function FillCalendarChoices in Calendar.aspx.cs reported the Error: " + ex.Message);
			}
		}

		public void SelectCorrectValues()
		{
			int iTime = 0;
			try
			{
				lblDate.Text = (Cal.SelectedDate.GetDateTimeFormats())[3].ToString() + " " + GetTimeFromRS(ref iTime);
				datechosen.Value = lblDate.Text;
				MonthSelect.SelectedIndex = MonthSelect.Items.IndexOf(MonthSelect.Items.FindByValue(Cal.SelectedDate.Month.ToString()));
				YearSelect.SelectedIndex = YearSelect.Items.IndexOf(YearSelect.Items.FindByValue(Cal.SelectedDate.Year.ToString()));
			}
			catch(Exception ex)
			{
				throw new Exception("Function SelectCorrectValues in Calendar.aspx.cs reported the Error: " + ex.Message, ex);
			}
		}

		private string GetTimeFromRS(ref int iTime)
		{
			string sTime;
			try
			{
				if(Request.QueryString["time"] != null)
				{
					iTime = Convert.ToInt32(Request.QueryString["time"]);
					sTime = iTime==0?"12:00 AM":(iTime<12?iTime.ToString()+":00 AM":(iTime==12?"12:00 PM":((int)(iTime-12)).ToString() + ":00 PM"));
				}
				else
				{
					iTime = 0;
					sTime = "";
				}
				return sTime;

			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
		}

		private void SelectXmlTimeSheet()
		{
			XslTransform trans = null;
			XmlDocument doc = null;
			XsltArgumentList agr = null;
			string _input;
			TimeSpan times;
			int iTime = 0;
			try
			{
				GetTimeFromRS(ref iTime);

				times = Cal.SelectedDate.Subtract(new DateTime(1970, 1, 1));
				order = new clsWorkOrders();
				order.iOrgId = _functions.GetUserOrgId(HttpContext.Current.User.Identity.Name, false);
				order.daCurrentDate = Cal.SelectedDate;
				doc = new XmlDocument();
				doc.LoadXml(order.GetWOListForTime());
				trans = new XslTransform();
				trans.Load(Server.MapPath("ShowTime.xsl"));
				agr = new XsltArgumentList();
				agr.AddParam("selected", "", ((long)(times.Ticks/10000)).ToString());
				agr.AddParam("formname", "", (string)ViewState["formname"]);
				agr.AddParam("id", "", (string)ViewState["id"]);
				agr.AddParam("postBack", "", (string)ViewState["postBack"]);
				agr.AddParam("TimeSelected", "", iTime);
				xmlTimeSheet.Document = doc;
				xmlTimeSheet.Transform = trans;
				xmlTimeSheet.TransformArgumentList = agr;

			}
			catch(Exception ex)
			{
				throw new Exception(ex.Message, ex);
			}
			finally
			{
				if(order != null)
					order.Dispose();
			}
		}


		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
			base.CheckLinks(this.Page);
		}
		
		private void InitializeComponent()
		{    
			this.MonthSelect.SelectedIndexChanged += new System.EventHandler(this.MonthSelect_SelectedIndexChanged);
			this.YearSelect.SelectedIndexChanged += new System.EventHandler(this.YearSelect_SelectedIndexChanged);
			this.Cal.SelectionChanged += new System.EventHandler(this.Cal_SelectionChanged);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void Cal_SelectionChanged(object sender, System.EventArgs e)
		{
			try
			{
				ViewState["Day"] = Cal.SelectedDate.Ticks;
				Cal.VisibleDate = Cal.SelectedDate;
				SelectCorrectValues();
				SelectXmlTimeSheet();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}

		}

		private void MonthSelect_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			try
			{
				Cal.VisibleDate = new DateTime(Convert.ToInt32(YearSelect.SelectedItem.Value), Convert.ToInt32(MonthSelect.SelectedItem.Value), 1);
				Cal.SelectedDate = Cal.VisibleDate;
				SelectCorrectValues();
				SelectXmlTimeSheet();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		private void YearSelect_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			try
			{
				Cal.VisibleDate = new DateTime(Convert.ToInt32(YearSelect.SelectedItem.Value), Convert.ToInt32(MonthSelect.SelectedItem.Value), 1);
				Cal.SelectedDate = Cal.VisibleDate;
				SelectCorrectValues();
				SelectXmlTimeSheet();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}		
		}
	}
}
