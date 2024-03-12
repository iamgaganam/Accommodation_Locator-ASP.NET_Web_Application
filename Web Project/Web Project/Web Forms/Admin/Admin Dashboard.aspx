<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin Dashboard.aspx.cs" Inherits="Web_Project.Web_Forms.Admin.Admin_Dashboard" %>

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
        textarea {
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome, Admin!</h1>

        <form runat="server">
            <!-- Landlord Registration Form -->
            <h2>Register Landlord</h2>
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
            <asp:Button ID="btnRegisterLandlord" runat="server" Text="Register Landlord" OnClick="btnRegisterLandlord_Click" />

            <!-- Student Account Creation -->
            <h2>Register Student</h2>
            <label for="txtStudentUsername">Username:</label>
            <asp:TextBox ID="txtStudentUsername" runat="server" /><br />
            <label for="txtStudentPassword">Password:</label>
            <asp:TextBox ID="txtStudentPassword" runat="server" TextMode="Password" /><br />
            <label for="txtStudentEmail">Email:</label>
            <asp:TextBox ID="txtStudentEmail" runat="server" /><br />
            <label for="txtStudentFirstName">First Name:</label>
            <asp:TextBox ID="txtStudentFirstName" runat="server" /><br />
            <label for="txtStudentLastName">Last Name:</label>
            <asp:TextBox ID="txtStudentLastName" runat="server" /><br />
            <label for="txtStudentPhoneNumber">Phone Number:</label>
            <asp:TextBox ID="txtStudentPhoneNumber" runat="server" /><br />
            <asp:Button ID="btnRegisterStudent" runat="server" Text="Register Student" OnClick="btnRegisterStudent_Click" />

            <!-- Warden Registration Form -->
            <h2>Register Warden</h2>
            <label for="txtWardenUsername">Username:</label>
            <asp:TextBox ID="txtWardenUsername" runat="server" /><br />
            <label for="txtWardenPassword">Password:</label>
            <asp:TextBox ID="txtWardenPassword" runat="server" TextMode="Password" /><br />
            <label for="txtWardenEmail">Email:</label>
            <asp:TextBox ID="txtWardenEmail" runat="server" /><br />
            <label for="txtWardenFirstName">First Name:</label>
            <asp:TextBox ID="txtWardenFirstName" runat="server" /><br />
            <label for="txtWardenLastName">Last Name:</label>
            <asp:TextBox ID="txtWardenLastName" runat="server" /><br />
            <label for="txtWardenPhoneNumber">Phone Number:</label>
            <asp:TextBox ID="txtWardenPhoneNumber" runat="server" /><br />
            <asp:Button ID="btnRegisterWarden" runat="server" Text="Register Warden" OnClick="btnRegisterWarden_Click" />
            <asp:HiddenField ID="HiddenField1" runat="server" />

            <!-- Article Posting -->
            <h2>Article Posting</h2>
            <label for="articleTitle">Title:</label>
            <input type="text" id="articleTitle" runat="server" /><br />
            <label for="articleContent">Content:</label>
            <textarea id="articleContent" runat="server" rows="5"></textarea><br />
            <asp:Button ID="btnPostArticle" runat="server" Text="Post Article" OnClick="btnPostArticle_Click" />
        </form>
    </div>
    <div>
        <h2>Admin Posts </h2>
    </div>
    <div id="articleContainer" runat="server"></div>

</body>
</html>
