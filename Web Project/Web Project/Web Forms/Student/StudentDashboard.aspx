<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="Web_Project.Web_Forms.Student.StudentDashboard2" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Property Dashboard</title>
    <style>
        .property-details .property-card {
            border: none;
            box-shadow: none;
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

        .approved-properties,
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

        .admin-post-card {
            display: flex;
            align-items: center;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .admin-post-details {
            flex-grow: 1;
        }

            .admin-post-details h3 {
                margin-top: 0;
            }

            .admin-post-details p {
                margin: 5px 0;
            }

        .awareness-post-card {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 20px;
            transition: transform 0.3s ease;
        }

            .awareness-post-card:hover {
                transform: translateY(-5px);
            }

        .awareness-post-content {
            color: #333333;
        }

        .post-title {
            font-size: 18px;
            font-weight: bold;
            color: #007bff;
            margin-top: 0;
        }

        .post-content {
            font-size: 16px;
            line-height: 1.6;
        }

        .post-date {
            color: #999999;
            font-size: 14px;
            margin-top: 10px;
        }

        /* Pagination Styles */
        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }

            .pagination ul {
                list-style: none;
                padding: 0;
                margin: 0;
                display: flex;
            }

            .pagination li {
                margin: 0;
                padding: 2px;
            }

            .pagination a {
                padding: 5px 10px;
                border: 1px solid #007bff;
                border-radius: 5px;
                background-color: #fff;
                color: #007bff;
                text-decoration: none;
            }

                .pagination a:hover {
                    background-color: #007bff;
                    color: #fff;
                }

            .pagination .active a {
                background-color: #007bff;
                color: #fff;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1 style="text-align: center;">Student Dashboard</h1>
        <div class="container">
            <div class="sidebar">
                <div class="property-cards-container" runat="server" id="propertyCardsContainer">
                    <!-- Property cards will be dynamically loaded here -->
                </div>
            </div>
            <div class="map-container">
                <div id="map" class="map"></div>
            </div>
        </div>
        <!-- Reserved properties section -->
        <div class="approved-properties" runat="server" id="approvedProperties">
            <h2>Accepted and Reserved Properties</h2>
            <!-- Property cards will be dynamically added here -->
        </div>

        <!-- Awareness posts section -->
        <div class="awareness-posts">
            <h2>Awareness Posts by Admin</h2>
            <div class="awareness-post-cards-container" runat="server" id="awarenessPostCardsContainer">
                <!-- Awareness post cards will be dynamically loaded here -->
            </div>
            <!-- Pagination -->
            <div class="pagination" style="margin-bottom: 20px;">
                <ul style="display: inline-flex;">
                    <% if (currentPage > 1)
                        { %>
                    <li><a href="?page=<%=currentPage - 1%>">&laquo; Previous</a></li>
                    <% } %>
                    <% for (int i = 1; i <= totalPages; i++)
                        { %>
                    <li class="<% if (currentPage == i) { Response.Write("active"); } %>">
                        <a href="?page=<%=i%>"><%=i%></a>
                    </li>
                    <% } %>
                    <% if (currentPage < totalPages)
                        { %>
                    <li><a href="?page=<%=currentPage + 1%>">Next &raquo;</a></li>
                    <% } %>
                </ul>
            </div>

        </div>
    </form>

    <script>
        function initMap() {
            var map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: 6.822415694864501, lng: 80.04180893495239 }, // Set default center
                zoom: 15 // Set default zoom level
            });

            // Retrieve all buttons with class 'view-details-btn'
            var viewButtons = document.querySelectorAll('.view-details-btn');

            // Loop through each button to add click event listener
            viewButtons.forEach(function (button) {
                button.addEventListener('click', function () {
                    var latitude = parseFloat(this.getAttribute('data-lat'));
                    var longitude = parseFloat(this.getAttribute('data-lng'));

                    // Create marker
                    var marker = new google.maps.Marker({
                        position: { lat: latitude, lng: longitude },
                        map: map,
                        title: 'Property Location'
                    });

                    // Set map center to marker position
                    map.setCenter({ lat: latitude, lng: longitude });
                });
            });
        }
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCVy90FE4evtixL-8e0avAziJz0aajSI7I&callback=initMap"></script>
</body>
</html>
