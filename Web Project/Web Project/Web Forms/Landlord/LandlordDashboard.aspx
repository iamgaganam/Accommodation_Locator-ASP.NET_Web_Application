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
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: stretch;
        }

            .property:hover {
                transform: translateY(-5px);
            }

            .property img {
                width: 150px;
                height: auto;
                object-fit: cover;
                border: 1px solid #ccc;
                margin-right: 20px;
            }

        .property-details {
            flex: 1;
        }

        .property-actions {
            align-self: flex-end;
        }

            .property-actions .btn-approve {
                background-color: #4CAF50;
                color: white;
            }

            .property-actions .btn-reject {
                background-color: #FF5733;
                color: white;
            }

            .property-actions button {
                padding: 8px 16px;
                margin-right: 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

                .property-actions button:hover {
                    filter: brightness(0.8);
                }

        .btn-delete {
            padding: 8px 16px;
            background-color: #FF5733;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            height: auto;
        }

            .btn-delete:hover {
                background-color: #E64A19;
            }

        #propertyRequests {
            margin-top: 50px;
        }

        .property-request {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: stretch;
        }

            .property-request:hover {
                transform: translateY(-5px);
            }

        .property-image {
            width: 150px;
            height: auto;
            object-fit: cover;
            border: 1px solid #ccc;
            margin-right: 20px;
        }

        .property-details {
            flex: 1;
        }

        .property-actions {
            align-self: flex-end;
        }

            .property-actions .btn-approve {
                background-color: #4CAF50;
                color: white;
            }

            .property-actions .btn-reject {
                background-color: #FF5733;
                color: white;
            }

            .property-actions button {
                padding: 8px 16px;
                margin-right: 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

                .property-actions button:hover {
                    filter: brightness(0.8);
                }
    </style>

</head>
<body>
    <h1>Landlord Dashboard</h1>

    <form id="form1" runat="server">
        <div>
            <asp:Panel runat="server" ID="addPropertyForm">
                <asp:Label runat="server" AssociatedControlID="propertyName" Text="Property Name:" /><br />
                <asp:TextBox runat="server" ID="propertyName" /><br />
                <asp:Label runat="server" AssociatedControlID="propertyDescription" Text="Description:" /><br />
                <asp:TextBox runat="server" ID="propertyDescription" TextMode="MultiLine" /><br />
                <asp:Label runat="server" AssociatedControlID="propertyPrice" Text="Price:" /><br />
                <asp:TextBox runat="server" ID="propertyPrice" TextMode="Number" /><br />
                <asp:Label runat="server" AssociatedControlID="propertyLocation" Text="Location:" /><br />
                <asp:TextBox runat="server" ID="propertyLocation" /><br />
                <asp:Label runat="server" AssociatedControlID="propertyLatitude" Text="Latitude:" /><br />
                <asp:TextBox runat="server" ID="propertyLatitude" /><br />
                <asp:Label runat="server" AssociatedControlID="propertyLongitude" Text="Longitude:" /><br />
                <asp:TextBox runat="server" ID="propertyLongitude" /><br />
                <asp:Label runat="server" AssociatedControlID="propertyImage" Text="Image:" /><br />
                <asp:FileUpload runat="server" ID="propertyImage" /><br />
                <asp:Button runat="server" ID="btnAddProperty" Text="Add Property" OnClick="AddProperty" />
            </asp:Panel>
        </div>

        <div>
            <h2>Hello, Your properties</h2>
            <ul id="propertyList" runat="server">
            </ul>
        </div>
    </form>

    <!-- Section for property requests -->
    <div id="propertyRequests">
        <h2>Property Requests By Students</h2>
        <div class="property-request js-requested-properties" id="propertyRequest1">
            
        </div>
    </div>
</body>

    <script>
        const reservedProperties = <%=reservedPropertiesJson%>
        console.log(reservedProperties);

        var propertyContainer = document.querySelector('.js-requested-properties');

        for (let x in reservedProperties) {
            const propertyCardHtml = `
                <img src="${reservedProperties[x].imageUrl}" alt="${reservedProperties[x].imageUrl}" class="property-image">
                <div class="property-details">
                    <h3>${reservedProperties[x].name}</h3>
                    <h4>${reservedProperties[x].studentId} requesting for this property</h4>
                    <p>Description: ${reservedProperties[x].description}</p>
                    <p>Price: ${reservedProperties[x].price}</p>
                    <p>Location: ${reservedProperties[x].location}</p>
                </div>
                <div class="property-actions">
                    <button class="btn-approve">Approve</button>
                    <button class="btn-reject">Reject</button>
                </div>
            `;

            propertyContainer.innerHTML += propertyCardHtml;
        }
    </script>
</html>
