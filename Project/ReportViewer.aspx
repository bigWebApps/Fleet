<%@ Page Language="c#" CodeBehind="ReportViewer.aspx.cs" AutoEventWireup="True" Inherits="BWA.BFP.Web.ReportViewerPage" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Report Viewer</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="C#">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <link href="ReportStyles.css" type="text/css" rel="stylesheet">
</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <rsweb:ReportViewer runat="server" ID="ReportViewerControl" Font-Names="Verdana"
        Font-Size="8pt" Height="100%" Width="100%">
    </rsweb:ReportViewer>
    </form>
</body>
</html>
