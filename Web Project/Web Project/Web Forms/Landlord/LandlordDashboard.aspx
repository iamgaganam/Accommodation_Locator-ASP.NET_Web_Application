<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandlordDashboard.aspx.cs" Inherits="Web_Project.Web_Forms.Landlord.LandlordDashboard" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Landlord Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        h1 {
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 20px;
        }

        input,
        button {
            margin-bottom: 10px;
        }

        #propertyList {
            list-style-type: none;
            padding: 0;
        }

        .property {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

            .property img {
                max-width: 100px;
                max-height: 100px;
                margin-right: 20px;
            }

        .property-details {
            flex: 1;
        }

        .property-actions button {
            margin-left: 10px;
        }
    </style>
</head>

<body>
    <h1>Landlord Dashboard</h1>
    <form id="form1" runat="server">
        <asp:Panel runat="server" ID="addPropertyForm">
            <asp:Label runat="server" AssociatedControlID="propertyName" Text="Property Name:" /><br />
            <asp:TextBox runat="server" ID="propertyName" Required="true" /><br />
            <asp:Label runat="server" AssociatedControlID="propertyDescription" Text="Description:" /><br />
            <asp:TextBox runat="server" ID="propertyDescription" TextMode="MultiLine" Required="true" /><br />
            <asp:Label runat="server" AssociatedControlID="propertyPrice" Text="Price:" /><br />
            <asp:TextBox runat="server" ID="propertyPrice" TextMode="Number" Required="true" /><br />
            <asp:Label runat="server" AssociatedControlID="propertyLocation" Text="Location:" /><br />
            <asp:TextBox runat="server" ID="propertyLocation" Required="true" /><br />
            <asp:Label runat="server" AssociatedControlID="propertyImage" Text="Image:" /><br />
            <asp:FileUpload runat="server" ID="propertyImage" Required="true" /><br />
            <asp:Button runat="server" ID="btnAddProperty" Text="Add Property" OnClick="btnAddProperty_Click"/>
        </asp:Panel>

        <!-- Display the property list -->
        <h2>Hello, Your properties </h2>
        <ul id="propertyList" runat="server"></ul>
    </form>
</body>
</html>
