<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Dashboard.aspx.cs" Inherits="Web_Project.Web_Forms.Admin.Admin_Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
        }

        h1 {
            text-align: center;
        }

        .form-panel {
            display: none;
        }

        form {
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="password"],
        textarea,
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            grid-gap: 20px;
        }

        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 20px;
        }

        .card-header {
            background-color: #4CAF50;
            color: #fff;
            font-size: 1.2em;
            padding: 10px;
        }

        .card-body {
            padding: 20px;
        }

            .card-body p {
                margin-bottom: 10px;
                line-height: 1.5;
            }

        .pagination-container {
            text-align: center;
            margin-top: 20px;
        }

        .pagination {
            display: inline-block;
            padding-left: 0;
            margin: 0;
            border-radius: 4px;
            list-style: none;
        }

        .page-item {
            display: inline;
            margin-right: 5px;
        }

        .page-link {
            position: relative;
            display: inline-block;
            padding: 0.5rem 0.75rem;
            line-height: 1.25;
            color: #007bff;
            background-color: #fff;
            border: 1px solid #dee2e6;
        }

            .page-link:hover {
                z-index: 2;
                color: #0056b3;
                text-decoration: none;
                background-color: #e9ecef;
                border-color: #dee2e6;
            }

            .page-link:focus {
                z-index: 2;
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

        .page-item.active .page-link {
            z-index: 1;
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
        }

        .page-item.disabled .page-link {
            color: #6c757d;
            pointer-events: none;
            cursor: auto;
            background-color: #fff;
            border-color: #dee2e6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome, Admin!</h1>

        <form runat="server">
            <!-- User Registration -->
            <h2>User Registration</h2>
            <label for="userTypeDropdown">Select User Type:</label>
            <asp:DropDownList ID="userTypeDropdown" runat="server">
                <asp:ListItem Value="Landlord">Landlord</asp:ListItem>
                <asp:ListItem Value="Student">Student</asp:ListItem>
                <asp:ListItem Value="Warden">Warden</asp:ListItem>
            </asp:DropDownList><br />

            <!-- Common User Registration Fields -->
            <h2>Register User</h2>
            <label for="txtUsername">Username:</label>
            <asp:TextBox ID="txtUsername" runat="server" /><br />
            <label for="txtPassword">Password:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" /><br />
            <label for="txtEmail">Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" /><br />
            <label for="txtFirstName">First Name:</label>
            <asp:TextBox ID="txtFirstName" runat="server" /><br />
            <label for="txtLastName">Last Name:</label>
            <asp:TextBox ID="txtLastName" runat="server" /><br />
            <label for="txtPhoneNumber">Phone Number:</label>
            <asp:TextBox ID="txtPhoneNumber" runat="server" /><br />
            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />

            <!-- Article Posting -->
            <h2>Article Posting</h2>
            <label for="articleTitle">Title:</label>
            <input type="text" id="articleTitle" runat="server" /><br />
            <label for="articleContent">Content:</label>
            <textarea id="articleContent" runat="server" rows="5"></textarea><br />
            <asp:Button ID="btnPostArticle" runat="server" Text="Post Article" OnClick="btnPostArticle_Click" OnClientClick="return validateArticleForm();" />
        </form>
    </div>
    <div>
        <h2>Admin Posts</h2>
        <div id="articleContainer" runat="server"></div>
        <div class="pagination-container">
            <ul class="pagination">
                <!-- Pagination elements will be added dynamically from code-behind -->
            </ul>
        </div>
    </div>
</body>
</html>
