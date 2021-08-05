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
using Microsoft.Reporting.WebForms;
using BWA.BFP.Core;
using System.Collections.Generic;
using BWA.BFP.Data;

namespace BWA.BFP.Web
{
    public partial class ReportViewerPage : System.Web.UI.Page
    {
        private void Page_Load(object sender, System.EventArgs e)
        {
            //try
            //{
            ReportViewerControl.LocalReport.ReportPath = _functions.GetValueFromConfig("SQLRS.DefaultPath") + ".rdlc";
            if (Request["Report"] != null)
                ReportViewerControl.LocalReport.ReportPath = Request["Report"] + ".rdlc";

            ReportViewerControl.LocalReport.EnableExternalImages = true;

            clsWorkOrders wo = new clsWorkOrders();

            if (!string.IsNullOrEmpty(Request["OrgId"]))
                wo.iOrgId = Convert.ToInt32(Request["OrgId"]);

            if (!string.IsNullOrEmpty(Request["OrderId"]))
                wo.iId = Convert.ToInt32(Request["OrderId"]);

            if (!string.IsNullOrEmpty(Request["InspectId"]))
                wo.iInspectionId = Convert.ToInt32(Request["InspectId"]);

            string url = string.Empty;
            if (!string.IsNullOrEmpty(Request["URL"]))
                url = Request["URL"];

            foreach (string dataSource in ReportViewerControl.LocalReport.GetDataSourceNames())
            {
                switch (dataSource)
                {
                    case "ReportedIssueList":
                        DataSet ds = wo.GetReportedIssueLists();
                        if (ds != null && ds.Tables.Count > 0)
                            ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, ds.Tables[0]));
                        break;
                    case "PMItemList":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetPMServicesListForWorkOrder()));
                        break;
                    case "InspectionsList":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetInspectionsListForWorkOrder()));
                        break;
                    case "WorkOrderDetail":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetDetailsForWorkOrder()));
                        break;
                    case "CreationNotesList":
                        wo.iNoteTypeId = 1;
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetNotesList()));
                        break;
                    case "OperatorNotesList":
                        wo.iNoteTypeId = 2;
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetNotesList()));
                        break;
                    case "PartsList":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetPartsUsedListForReport()));
                        break;
                    case "ReportedIssuesList":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetReportedIssues()));
                        break;
                    case "PMItemsList":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetPMItemsList()));
                        break;
                    case "RepairsList":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetRepairsListForReport()));
                        break;
                    case "TechNotesList":
                        wo.iNoteTypeId = 3;
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetNotesList()));
                        break;
                    case "CheckOutNotesList":
                        wo.iNoteTypeId = 4;
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetNotesList()));
                        break;
                    case "CheckInDetails":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.CheckInDetailsForReport(url)));
                        break;
                    case "InstructionList":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetInstructionByCheckIn()));
                        break;
                    case "InspectionDetail":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetInspectionDetailForReport()));
                        break;
                    case "InspectionItemsList":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetInspectionItemsListForReport()));
                        break;    
                    case "InspectionList":
                        ReportViewerControl.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(dataSource, wo.GetInspectionListForReport()));
                        break;
                }
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
        }
        #endregion
    }
}
