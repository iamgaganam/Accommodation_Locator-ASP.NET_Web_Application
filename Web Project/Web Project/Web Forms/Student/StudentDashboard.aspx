<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="Web_Project.Web_Forms.Student.StudentDashboard2" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Property Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

            .card-container {
                position: absolute;
                bottom: 20px; /* Adjust as needed */
                right: 60px; /* Adjust as needed */
                width: 300px;
                background-color: white;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
                z-index: 1000; /* Ensure it appears above the map */
                display: none; /* Initially hidden */
            }

            .image-container {
                position: relative;
                width: 100%;
            }

            .property-image {
                width: 100%;
                height: auto;
                display: block;
                border-radius: 5px 5px 0 0; /* Rounded borders only on top */
            }

            .price-overlay {
                position: absolute;
                bottom: 0;
                right: 5px;
                background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black */
                padding: 5px;
                border-radius: 0 5px;
            }

            .property-price {
                color: white;
                font-weight: bold;
            }

            .property-details {
                padding: 10px;
            }

            .property-name {
                font-weight: bold;
            }

            .property-info {
                margin-top: 5px;
            }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField runat="server" ID="hdnStudentId" ClientIDMode="Static" value=""/>

        <h1 style="text-align: center;">Student Dashboard as <%=username%></h1>
        <div class="container">
            <div class="sidebar">
                <div class="property-cards-container js-property-container" runat="server" id="propertyCardsContainer">
                    <!-- Property cards will be dynamically loaded here -->
                </div>
                <div class="property-cards-container js-reserved-container" runat="server" id="reservedCardsContainer">
                    <!-- Reserved Property cards will be dynamically loaded here -->
                </div>
            </div>
            <div class="map-container">
                <div id="map" class="map"></div>

                <div class="card-container" id="propertyCard">
                    <div class="image-container">
                        <div class="price-overlay">
                            <span class="property-price"></span>
                        </div>
                        <img src="" alt="Property Image" class="property-image">
                    </div>
                    <div class="property-details">
                        <div class="property-name"></div>
                        <div class="property-info"></div>
                    </div>
                </div>

            </div>
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
        // instantiate approved properties
        var approvedProperties = <%= approvedPropertiesJson %>;

        var approvedPropertyContainer = document.querySelector('.js-property-container');

        for (let x in approvedProperties) {
            const propertyCardHtml = `
                <div class='property-card'>
                    <img src='${approvedProperties[x].imageUrl}' class='property-image' />
                    <div class='property-details'>
                        <h3>${approvedProperties[x].name}</h3>
                        <p>${approvedProperties[x].description}</p>
                        <p>${approvedProperties[x].location}</p>
                        <p> Price: ${approvedProperties[x].price}</p>
                        <div class='action-buttons'>
                                <button class='view-details-btn' 
                            data-lat='${approvedProperties[x].latitude}' 
                            data-lng='${approvedProperties[x].longitude}'>View Details</button>
                            <div>
                                <button type="button" class='approve-btn'
                                    data-propertyid='${approvedProperties[x].id}'>Reserve</button>
                            </div>
                        </div>
                    </div>
                </div>
            `;

            approvedPropertyContainer.innerHTML += propertyCardHtml;
        }

        // Function to handle button clicks and perform action
        function handleReserveButtonClick(propertyId, studentId) {
            // Display confirmation dialog
            if (confirm(`Are you sure you want to reserve this property?`)) {

                // Perform AJAX request to server
                performAction(propertyId, studentId);
            }
        }

        // Handle click events
        approvedPropertyContainer.addEventListener('click', function (event) {
            const target = event.target;

            if (target.classList.contains('approve-btn')) {
                handleReserveButtonClick(target.getAttribute('data-propertyid'),
                    document.getElementById('hdnStudentId').value);
            }
        });

        function performAction(propertyId, studentId) {
            // Perform AJAX request to server
            $.ajax({
                url: 'StudentDashboard.aspx/ReserveApprovedProperty',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    propertyId: propertyId,
                    studentId: studentId
                }),
                success: function (response) {
                    // Handle success response
                    window.location.reload();
                },
                error: function (xhr, status, error) {
                    // Handle error
                    console.error('Error:', error);
                }
            });
        }

        // instantiate reserved properties
        var reservedProperties = <%= reservedPropertiesJson %>;

        var reservedPropertyContainer = document.querySelector('.js-reserved-container');

        for (let x in reservedProperties) {
            const propertyCardHtml = `
                <div class='property-card'>
                    <img src='${reservedProperties[x].imageUrl}' class='property-image' />
                    <div class='property-details'>
                        <h3>${reservedProperties[x].name}</h3>
                        <p>${reservedProperties[x].description}</p>
                        <p>${reservedProperties[x].location}</p>
                        <p> Price: ${reservedProperties[x].price}</p>
                        <div class='action-buttons'>
                                <button class='view-details-btn'
                            data-lat='${reservedProperties[x].latitude}' 
                            data-lng='${reservedProperties[x].longitude}'>View Details</button>
                            <div>
                                <button type="button" class='reject-btn'
                                    data-propertyid='${reservedProperties[x].id}'>Unreserve</button>
                            </div>
                        </div>
                    </div>
                </div>
            `;

            reservedPropertyContainer.innerHTML += propertyCardHtml;
        }

        // Function to handle button clicks and perform action
        function handleUnreserveButtonClick(propertyId) {
            // Display confirmation dialog
            if (confirm(`Are you sure you want to unreserve this property?`)) {

                // Perform AJAX request to server
                performUnreserve(propertyId);
            }
        }

        // Handle click events
        reservedPropertyContainer.addEventListener('click', function (event) {
            const target = event.target;

            if (target.classList.contains('reject-btn')) {
                handleUnreserveButtonClick(target.getAttribute('data-propertyid'));
            }
        });

        function performUnreserve(propertyId) {
            // Perform AJAX request to server
            $.ajax({
                url: 'StudentDashboard.aspx/DeleteReservedProperty',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    propertyId: propertyId,
                }),
                success: function (response) {
                    // Handle success response
                    window.location.reload();
                },
                error: function (xhr, status, error) {
                    // Handle error
                    console.error('Error:', error);
                }
            });
        }

        function showPropertyCard(property)
        {
            var cardContainer = document.getElementById('propertyCard');
            var propertyImage = cardContainer.querySelector('.property-image');
            var propertyPrice = cardContainer.querySelector('.property-price');
            var propertyName = cardContainer.querySelector('.property-name');
            var propertyInfo = cardContainer.querySelector('.property-info');

            // Set property data
            propertyImage.src = property.imageUrl;
            propertyImage.alt = property.imageUrl;
            propertyPrice.textContent = "$"+property.price;
            propertyName.textContent = property.name;
            propertyInfo.textContent = property.description;

            // Show the card container
            cardContainer.style.display = 'block';
        }

        const combinedProperties = <%=GetCombinedProperties()%>;

        console.log(combinedProperties);

        function initMap() {
            const nsbmPos = new google.maps.LatLng(6.8206348, 80.0385984);

            var mapProp = {
                center: nsbmPos,
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            var map = new google.maps.Map(document.getElementById("map"), mapProp);

            var infoWindow = new google.maps.InfoWindow();

            var marker, i;

            for (i = 0; i < combinedProperties.length; i++) {
                marker = new google.maps.Marker({
                    position: new google.maps.LatLng(combinedProperties[i].latitude, combinedProperties[i].longitude),
                    animation: google.maps.Animation.BOUNCE,
                    map: map
                });

                google.maps.event.addListener(marker, 'click', (function (marker, i) {
                    return function () {
                        // event instantiated here add external logic
                        //infoWindow.setContent(approvedProperties[i].name);

                        showPropertyCard(combinedProperties[i]);
                    }
                })(marker, i));
            }
        }
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCVy90FE4evtixL-8e0avAziJz0aajSI7I&callback=initMap"></script>
</body>
</html>
