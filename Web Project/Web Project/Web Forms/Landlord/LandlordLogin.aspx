<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandlordLogin.aspx.cs" Inherits="Web_Project.Web_Forms.Landlord.LandlordLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Landlord Login</title>
</head>
    <style>
    /* Flexbox styles to center specific content */
    html, body {
        height: 100%;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f5f5f5;
    }

    /* Styles for the form container */
    #formContainer {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 400px; /* Increased width */
    }

    /* Styles for form headings */
    h2 {
        margin-top: 0;
        color: #333;
        font-size: 24px;
        margin-bottom: 20px;
    }

    /* Styles for labels */
    label {
        display: block;
        margin-bottom: 6px;
        font-weight: bold;
        color: #555;
        text-align: left;
    }

    /* Styles for textboxes */
    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        border-radius: 4px;
        border: 1px solid #ccc;
        margin-bottom: 16px;
        box-sizing: border-box;
    }

    /* Styles for the login button */
    #btnLogin {
        width: 100%;
        padding: 12px;
        background-color: #4CAF50; /* Green */
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s;
    }

        /* Hover effect for the login button */
        #btnLogin:hover {
            background-color: #45a049; /* Darker green */
        }

    /* Styles for error message */
    #lblErrorMessage {
        color: #ff3333;
        margin-top: 10px;
        text-align: center;
        display: block;
    }

    /* Styles for the link */
    p a {
        color: #007bff;
        text-decoration: none;
        transition: color 0.3s;
    }

        /* Hover effect for the link */
        p a:hover {
            color: #0056b3;
        }
</style>

<body>
    <form id="form1" runat="server">
        <div>
            <h2>Landlord Login</h2>
            <div>
                <label for="txtUsername">Username:</label>
                <asp:TextBox ID="txtUsername" runat="server" required />
            </div>
            <div>
                <label for="txtPassword">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" required />
            </div>
            <div>
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="Login" />
            </div>
            <div>
                <p>Don't have an account? <a href="LandlordRegistration.aspx">Register</a></p>
            </div>
            <div>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>
