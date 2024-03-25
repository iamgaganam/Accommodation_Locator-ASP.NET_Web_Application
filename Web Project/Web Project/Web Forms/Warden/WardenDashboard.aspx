<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WardenDashboard.aspx.cs" Inherits="Web_Project.Web_Forms.Warden.WardenDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Property Dashboard</title>
    <style>
        /* CSS styles for property cards */
        .property-details .property-card {
            border: none; /* Remove border */
            box-shadow: none; /* Remove box shadow */
        }

        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        .container {
            display: flex;
            width: 100%;
            height: 80vh;
            margin: 0 auto;
        }

        .sidebar {
            width: 30%;
            overflow-y: auto;
            background-color: #f4f4f4;
            border-right: 1px solid #ccc;
        }

        .map-container {
            width: 70%;
            position: relative;
            overflow-y: auto;
        }

        .map {
            width: 100%;
            height: 100%;
        }

        .approved-properties {
            margin-top: 20px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
        }

        .rejected-properties {
            margin-top: 20px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
        }

        .property-card {
            display: flex;
            align-items: center;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .property-image {
            width: 150px;
            height: 150px;
            margin-right: 20px;
            border-radius: 10px;
            object-fit: cover;
        }

        .property-details {
            flex-grow: 1;
        }

        .action-buttons {
            display: flex;
            flex-direction: column;
        }

            .action-buttons button {
                padding: 8px 16px;
                border: none;
                border-radius: 15px;
                font-size: 14px;
                cursor: pointer;
            }

        .view-details-btn {
            background-color: #007bff;
            color: #fff;
            margin-bottom: 5px;
            width: 110px;
            text-align: center;
        }

            .view-details-btn:hover {
                background-color: #0056b3;
            }

        .approve-btn,
        .reject-btn {
            background-color: #28a745;
            color: #fff;
            margin-right: 5px;
            max-width: 100%;
            text-align: center;
        }

            .approve-btn:hover,
            .reject-btn:hover {
                background-color: #218838;
            }

        .reject-btn {
            background-color: #dc3545;
        }

            .reject-btn:hover {
                background-color: #c82333;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1 style="text-align: center;">Warden Dashboard</h1>
        <div class="container">
            <div class="sidebar" runat="server" id="propertyCardsContainer">
                <!-- Property cards will be dynamically loaded here -->
            </div>
            <div class="map-container">
                <div id="map" class="map"></div>
            </div>
        </div>
        <!-- Approved properties section -->
        <h2>Approved Properties</h2>
        <div class="approved-properties" runat="server" id="approvedPropertiesContainer">

            <!-- Approved property cards will be dynamically loaded here -->
        </div>
        <!-- Rejected properties section -->
        <h2>Rejected Properties</h2>
        <div class="rejected-properties" runat="server" id="rejectedPropertiesContainer">
            <!-- Rejected property cards will be dynamically loaded here -->
        </div>
    </form>

    <!-- Google Maps API script -->
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCVy90FE4evtixL-8e0avAziJz0aajSI7I&callback=initMap"></script>
    <script>
        function initMap() {
            var map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: 6.822415694864501, lng: 80.04180893495239 }, // Set default center
                zoom: 15 // Set default zoom level
            });
        }
    </script>
</body>
</html>
