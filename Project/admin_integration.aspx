<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_integration.aspx.cs"
    Inherits="BWA.BFP.Web.admin.admin_integration" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Setup Warehouse Integration</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Panel runat="server" ID="MessagePanel" Visible="false">
            <div style="color: Green; font-weight: bold; font-size: 14pt; padding-bottom: 5px">
                Connected to Warehouse</div>
            <asp:Button runat="server" ID="reconnectButton" Text="Reconnect" OnClick="ReConnectButton_Click" />
        </asp:Panel>
        <asp:Panel runat="server" ID="WarehouseLoginPanel">
            <table>
                <tr>
                    <td align="right">
                        Warehouse Login:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="WarehouseLoginTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Warehouse Password:
                    </td>
                    <td>
                        <asp:TextBox runat="server" TextMode="Password" ID="WarehousePasswordTextBox" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button runat="server" ID="LoginButton" Text="Login to Warehouse" OnClick="LoginButton_Click" />
                        &nbsp;&nbsp;<asp:Label runat="server" ID="errorLabel" ForeColor="Red" Visible="false">Can't login to Warehouse</asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel runat="server" ID="ConnectPanel" Visible="false">
            <table>
                <tr>
                    <td>
                        Warehouse Organization:
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="OrganizationList" DataTextField="Name" DataValueField="OrganizationId"
                            AutoPostBack="true" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Warehouse Instance:
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="InstanceList" DataTextField="Name" DataValueField="InstanceId" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button runat="server" ID="ConnectButton" Text="Connect with Warehouse" OnClick="ConnectButton_Click" />
                        &nbsp;or&nbsp;<asp:LinkButton ID="lbCancel" OnClick="lbCancel_Click" runat="server">Cancel</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
