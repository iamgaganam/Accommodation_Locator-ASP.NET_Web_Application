<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WardenLogin.aspx.cs" Inherits="Web_Project.Web_Forms.Warden.WardenLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Warden Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Warden Login</h2>
            <div>
                <label for="txtUsername">Username:</label>
                <asp:TextBox ID="txtUsername" runat="server" required />
            </div>
            <div>
                <label for="txtPassword">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" required />
            </div>
            <div>
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
            </div>
            <div>
                <p>Don't have an account? Contact NSBM Web Master! </p>
            </div>
            <div>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>
