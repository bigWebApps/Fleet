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
using BWA.BFP.Core;

namespace BWA.BFP.Core
{
	/// <summary>
	/// Summary description for Calendar.
	/// </summary>
	public class _calendar : System.Web.UI.Page 
	{
		protected System.Web.UI.WebControls.DropDownList MonthSelect;
		protected System.Web.UI.WebControls.DropDownList YearSelect;
		protected System.Web.UI.WebControls.Calendar Cal;
		protected System.Web.UI.WebControls.Label lblDate;
		protected System.Web.UI.WebControls.Button OKButton;
		protected System.Web.UI.WebControls.Button CancelButton;
		protected System.Web.UI.HtmlControls.HtmlInputHidden datechosen;
	
		private string SourcePageName;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				SourcePageName = "calendar.aspx.cs";

				string selected = Request.QueryString["selected"];
				string id = Request.QueryString["id"];
				string form = Request.QueryString["formname"];
				string postBack = Request.QueryString["postBack"];
				try
				{
					if(selected == "0" || selected == "") Cal.VisibleDate = DateTime.Now;
					else Cal.VisibleDate = (new DateTime(1970, 1, 1)).AddMilliseconds(Convert.ToDouble(selected));
					Cal.SelectedDate = Cal.VisibleDate;
					FillCalendarChoices();
					SelectCorrectValues();
                    // Add JScript to the OK button so that when the user clicks on it, the selected date
                    // is passed back to the calling page.
                    OKButton.Attributes.Add("onClick", "window.opener.SetDateToActiveDate('" + form + "','" + id + "', document.Calendar.datechosen.value," + postBack + ", 0);CloseWindow();");
                    CancelButton.Attributes.Add("onClick", "CloseWindow();");
				}
				catch(Exception ex)
				{
					_functions.Log(ex, HttpContext.Current.User.Identity.Name, "calendar.aspx.cs");
				}
			}
		}

		/// <summary>
		/// Filling the months and years into dropdownlists on calendar screen
		/// </summary>
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

		/// <summary>
		/// Showing the selected date on screen
		/// </summary>
		public void SelectCorrectValues()
		{
			try
			{
				lblDate.Text = (Cal.SelectedDate.GetDateTimeFormats())[3].ToString();
				datechosen.Value = lblDate.Text;
				MonthSelect.SelectedIndex = MonthSelect.Items.IndexOf(MonthSelect.Items.FindByValue(Cal.SelectedDate.Month.ToString()));
				YearSelect.SelectedIndex = YearSelect.Items.IndexOf(YearSelect.Items.FindByValue(Cal.SelectedDate.Year.ToString()));
			}
			catch(Exception ex)
			{
				throw new Exception("Function SelectCorrectValues in Calendar.aspx.cs reported the Error: " + ex.Message);
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
			this.MonthSelect.SelectedIndexChanged += new System.EventHandler(this.MonthSelect_SelectedIndexChanged);
			this.YearSelect.SelectedIndexChanged += new System.EventHandler(this.YearSelect_SelectedIndexChanged);
			this.Cal.SelectionChanged += new System.EventHandler(this.Cal_SelectionChanged);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		/// <summary>
		/// Selecting the date on calendar
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void Cal_SelectionChanged(object sender, System.EventArgs e)
		{
			try
			{
				Cal.VisibleDate = Cal.SelectedDate;
				SelectCorrectValues();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		/// <summary>
		/// Selecting month on calendar
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void MonthSelect_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			try
			{
	            Cal.VisibleDate = new DateTime(Convert.ToInt32(YearSelect.SelectedItem.Value), Convert.ToInt32(MonthSelect.SelectedItem.Value), 1);
		        Cal.SelectedDate = Cal.VisibleDate;
			    SelectCorrectValues();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}

		/// <summary>
		/// Selecting year on calendar
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void YearSelect_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			try
			{
				Cal.VisibleDate = new DateTime(Convert.ToInt32(YearSelect.SelectedItem.Value), Convert.ToInt32(MonthSelect.SelectedItem.Value), 1);
				Cal.SelectedDate = Cal.VisibleDate;
				SelectCorrectValues();
			}
			catch(Exception ex)
			{
				_functions.Log(ex, HttpContext.Current.User.Identity.Name, SourcePageName);
			}
		}
	}
}
