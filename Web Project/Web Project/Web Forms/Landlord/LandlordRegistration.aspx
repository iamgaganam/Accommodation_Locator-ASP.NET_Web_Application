<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandlordRegistration.aspx.cs" Inherits="Web_Project.Web_Forms.Landlord.LandlordRegistration" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Landlord Registration</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f5f5f5;
        }

        #formContainer {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 400px; 
        }

        h2 {
            margin-top: 0;
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #555;
            text-align: left;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        #btnRegister {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

            #btnRegister:hover {
                background-color: #45a049; 
            }

        #lblErrorMessage {
            color: #ff3333;
            margin-top: 10px;
            text-align: center;
            display: block;
        }

        p a {
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s;
        }

            p a:hover {
                color: #0056b3;
            }
    </style>
    <script>
        function validateForm() {
            var username = document.getElementById('<%= txtUsername.ClientID %>').value.trim();
            var password = document.getElementById('<%= txtPassword.ClientID %>').value.trim();
            var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            var firstName = document.getElementById('<%= txtFirstName.ClientID %>').value.trim();
            var lastName = document.getElementById('<%= txtLastName.ClientID %>').value.trim();
            var phoneNumber = document.getElementById('<%= txtPhoneNumber.ClientID %>').value.trim();

            // REGEX for validation
            var usernameRegex = /^[a-zA-Z0-9_]+$/;
            var passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            var phoneNumberRegex = /^\d{10}$/; // Setted 10 for sri lankan numbers.

            // Validation happens in here.
            if (!usernameRegex.test(username)) {
                alert('Invalid username');
                return false;
            }
            if (!passwordRegex.test(password)) {
                alert('Invalid password');
                return false;
            }
            if (!emailRegex.test(email)) {
                alert('Invalid email');
                return false;
            }
            if (firstName === "") {
                alert('First name cannot be empty');
                return false;
            }
            if (lastName === "") {
                alert('Last name cannot be empty');
                return false;
            }
            if (!phoneNumberRegex.test(phoneNumber)) {
                alert('Invalid phone number');
                return false;
            }
            return true;
        }
    </script>
</head>

<body>
    <form id="form1" runat="server" onsubmit="return validateForm()">
        <div>
            <h2>Landlord Registration</h2>
            <div>
                <label for="txtUsername">Username:</label>
                <asp:TextBox ID="txtUsername" runat="server" />
            </div>
            <div>
                <label for="txtPassword">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
            </div>
            <div>
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" />
            </div>
            <div>
                <label for="txtFirstName">First Name:</label>
                <asp:TextBox ID="txtFirstName" runat="server" />
            </div>
            <div>
                <label for="txtLastName">Last Name:</label>
                <asp:TextBox ID="txtLastName" runat="server" />
            </div>
            <div>
                <label for="txtPhoneNumber">Phone Number:</label>
                <asp:TextBox ID="txtPhoneNumber" runat="server" />
            </div>
            <div>
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click"/>
            </div>
            <div>
                <p>Already have a account? <a href="LandlordLogin.aspx">Login</a></p>
            </div>
        </div>
    </form>
</body>
</html>
