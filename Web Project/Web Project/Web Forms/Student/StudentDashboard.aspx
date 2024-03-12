<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="Web_Project.Web_Forms.Student.StudentDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accommodation Finder</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .advertisement {
            border: 1px solid #ccc;
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 5px;
        }

            .advertisement h2 {
                margin-top: 0;
            }

            .advertisement p {
                margin-top: 5px;
            }

        .reserve-btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
        }

            .reserve-btn:hover {
                background-color: #0056b3;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Admin Alert Posts! </h1>
            <asp:Repeater ID="advertisementsRepeater" runat="server">
                <ItemTemplate>
                    <div class="advertisement">
                        <h2><%# Eval("Title") %></h2>
                        <p>Description: <%# Eval("Content") %></p>
                        <p>Posted On: <%# Eval("RegistrationDateTime") %></p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
