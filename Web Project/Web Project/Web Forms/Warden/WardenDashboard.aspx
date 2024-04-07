<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WardenDashboard.aspx.cs" Inherits="Web_Project.Web_Forms.Warden.WardenDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Property Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        <asp:HiddenField runat="server" ID="hdnPropertyId" ClientIDMode="Static" value=""/>

        <h1 style="text-align: center;">Warden Dashboard</h1>
        <div class="container">
            <div class="sidebar js-propertyCardContainer" runat="server" id="propertyCardsContainer">
                <!-- Property cards will be dynamically loaded here -->
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
        <!-- Approved properties section -->
        <h2>Approved Properties</h2>
        <div class="approved-properties js-approved-propertyContainer" runat="server" id="approvedPropertiesContainer">

            <!-- Approved property cards will be dynamically loaded here -->
        </div>
        <!-- Rejected properties section -->
        <h2>Rejected Properties</h2>
        <div class="rejected-properties js-rejected-propertyContainer" runat="server" id="rejectedPropertiesContainer">
            <!-- Rejected property cards will be dynamically loaded here -->
        </div>

    <!-- Google Maps API script -->
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCVy90FE4evtixL-8e0avAziJz0aajSI7I&callback=initMap"></script>
    <script>

        function extractLocationData(jsonArray)
        {
            const locationData = [];

            for (let i = 0; i < jsonArray.length; i++)
            {
                const jsonObject = jsonArray[i];

                if (jsonObject.location !== undefined && jsonObject.latitude !== undefined && jsonObject.longitude !== undefined)
                {
                    locationData.push({
                        location: jsonObject.location,
                        latitude: jsonObject.latitude,
                        longitude: jsonObject.longitude
                    });
                }
            }

            return locationData;
        }


        // instantiate regular properties
        var properties = <%= propertyDataJson %>;
        console.log(properties);

        const noOfProperties = Object.keys(properties).length;
        var propertyContainer = document.querySelector('.js-propertyCardContainer');

        for (let x in properties)
        {
            const propertyCardHtml = `
                <div class='property-card'>
                    <img src='${properties[x].imageUrl}' class='property-image' alt='${properties[x].imageUrl}'/>
                    <div class='property-details'>
                        <h3>${properties[x].name}</h3>
                        <p>${properties[x].description}</p>
                        <p>${properties[x].location}</p>
                        <p> Price: ${properties[x].price}</p>
                        <div class='action-buttons'>
                            <button class='view-details-btn'
                                data-lat='${properties[x].latitude}'
                                data-lng='${properties[x].longitude}'>View Details</button>

                            <div>
                                <button type="button" class='approve-btn' data-propertyid='${properties[x].id}'>Approve</button>
                                <button type="button" class='reject-btn' data-propertyid='${properties[x].id}'>Reject</button>
                            </div>
                        </div>
                    </div>
                </div>"
            `;

            propertyContainer.innerHTML += propertyCardHtml;
        }

        // Function to handle button clicks and perform action
        function handleButtonClick(propertyId, action)
        {
            // Display confirmation dialog
            if (confirm(`Are you sure you want to ${action} this property?`))
            {
                // Set the hidden field value
                document.getElementById('hdnPropertyId').value = propertyId;

                // Perform AJAX request to server
                performAction(propertyId, action);
            }
        }

        // Handle click events
        propertyContainer.addEventListener('click', function (event)
        {
            const target = event.target;

            if (target.classList.contains('approve-btn'))
            {
                handleButtonClick(target.getAttribute('data-propertyid'), 'approve');
            }
            else if (target.classList.contains('reject-btn'))
            {
                handleButtonClick(target.getAttribute('data-propertyid'), 'reject');
            }
        });

        function performAction(propertyId, action)
        {
            // Perform AJAX request to server
            $.ajax({
                url: 'WardenDashboard.aspx/ApproveOrRejectProperty',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    propertyId: propertyId,
                    action: action
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


        // instantiate approved properties
        var approvedProperties = <%= approvedPropertiesJson %>;

        var approvedPropertyContainer = document.querySelector('.js-approved-propertyContainer');

        for (let x in approvedProperties) {
            const propertyCardHtml = `
                <div class='property-card'>
                    <img src='${approvedProperties[x].imageUrl}' style="width:150px; height:150px;"/>
                    <div class='property-details'>
                        <h3>${approvedProperties[x].name}</h3>
                        <p>${approvedProperties[x].description}</p>
                        <p>${approvedProperties[x].location}</p>
                        <p> Price: ${approvedProperties[x].price}</p>
                        <div class='action-buttons'>
                                <button class='view-details-btn' 
                            data-lat='${approvedProperties[x].latitude}' 
                            data-lng='${approvedProperties[x].longitude}'>View Details</button>
                        </div>
                    </div>
                </div>
            `;

            approvedPropertyContainer.innerHTML += propertyCardHtml;
        }

        // instantiate rejected properties
        var rejectedProperties = <%= rejectedPropertiesJson %>;

        var rejectedPropertyContainer = document.querySelector('.js-rejected-propertyContainer');

        for (let x in rejectedProperties) {
            const propertyCardHtml = `
                <div class='property-card'>
                    <img src='${rejectedProperties[x].imageUrl}' style="width:150px; height:150px;"/>
                    <div class='property-details'>
                        <h3>${rejectedProperties[x].name}</h3>
                        <p>${rejectedProperties[x].description}</p>
                        <p>${rejectedProperties[x].location}</p>
                        <p> Price: ${rejectedProperties[x].price}</p>
                        <div class='action-buttons'>
                                <button class='view-details-btn' 
                            data-lat='${rejectedProperties[x].latitude}' 
                            data-lng='${rejectedProperties[x].longitude}'>View Details</button>
                        </div>
                    </div>
                </div>
            `;

            rejectedPropertyContainer.innerHTML += propertyCardHtml;
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
            propertyPrice.textContent = "$" + property.price;
            propertyName.textContent = property.name;
            propertyInfo.textContent = property.description;

            // Show the card container
            cardContainer.style.display = 'block';
        }

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

            for (i = 0; i < properties.length; i++)
            {
                marker = new google.maps.Marker({
                    position: new google.maps.LatLng(properties[i].latitude, properties[i].longitude),
                    animation: google.maps.Animation.BOUNCE,
                    map: map
                });

                google.maps.event.addListener(marker, 'click', (function (marker, i) {
                    return function () {
                        // event instantiated here add external logic
                        showPropertyCard(properties[i]);
                    }
                })(marker, i));
            }
        }
    </script>
    </form>

    </body>
</html>
