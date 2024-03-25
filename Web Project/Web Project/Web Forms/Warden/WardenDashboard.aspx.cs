using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Web_Project.Web_Forms.Warden
{
    public partial class WardenDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Not a if condition how 
            if (!IsPostBack)
            {
                LoadProperties();
                LoadApprovedProperties();
                LoadRejectedProperties();
            }
            else
            {
                LoadProperties();
                LoadApprovedProperties();
                LoadRejectedProperties();
            }

        }

        private void LoadProperties()
        {
            propertyCardsContainer.Controls.Clear();

            string connectionString = ConfigurationManager.ConnectionStrings["PropertiesConStr"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT id, name, description, location, price, imageUrl, latitude, longitude FROM Properties ORDER BY id DESC";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // Retrieve property data
                            int propertyId = Convert.ToInt32(reader["id"]);
                            string propertyName = reader["name"].ToString();
                            string propertyDescription = reader["description"].ToString();
                            string propertyLocation = reader["location"].ToString();
                            decimal propertyPrice = Convert.ToDecimal(reader["price"]);
                            string propertyImageUrl = reader["imageUrl"].ToString();

                            // Check for DBNull for latitude and longitude
                            double latitude = 0.0;
                            double longitude = 0.0;
                            if (!reader.IsDBNull(reader.GetOrdinal("latitude")))
                            {
                                latitude = Convert.ToDouble(reader["latitude"]);
                            }
                            if (!reader.IsDBNull(reader.GetOrdinal("longitude")))
                            {
                                longitude = Convert.ToDouble(reader["longitude"]);
                            }

                            // Create HTML content for each property card
                            string propertyCardHtml = $@"
<div class='property-card'>
    <img src='{propertyImageUrl}' class='property-image' />
    <div class='property-details'>
        <h3>{propertyName}</h3>
        <p>{propertyDescription}</p>
        <p>{propertyLocation}</p>
        <p> Price: {propertyPrice:C}</p>
        <div class='action-buttons'>
            <button class='view-details-btn' 
        data-lat='{latitude}' 
        data-lng='{longitude}'>View Details</button>

            <div>
                <button class='approve-btn'>Approve</button>
                <button class='reject-btn'>Reject</button>
            </div>
        </div>
    </div>
</div>";

                            // Add the property card HTML to the propertyCardsContainer
                            propertyCardsContainer.Controls.Add(new LiteralControl(propertyCardHtml));
                        }
                    }
                }
            }

        }

        private void LoadApprovedProperties()
        {
            // Clear existing content
            approvedPropertiesContainer.Controls.Clear();

            string connectionString = ConfigurationManager.ConnectionStrings["PropertiesConStr"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT id, name, description, location, price, imageUrl, latitude, longitude FROM Properties WHERE status = 1 ORDER BY id DESC";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // Retrieve property data
                            int propertyId = Convert.ToInt32(reader["id"]);
                            string propertyName = reader["name"].ToString();
                            string propertyDescription = reader["description"].ToString();
                            string propertyLocation = reader["location"].ToString();
                            decimal propertyPrice = Convert.ToDecimal(reader["price"]);
                            string propertyImageUrl = reader["imageUrl"].ToString();

                            // Check for DBNull for latitude and longitude
                            double latitude = 0.0;
                            double longitude = 0.0;
                            if (!reader.IsDBNull(reader.GetOrdinal("latitude")))
                            {
                                latitude = Convert.ToDouble(reader["latitude"]);
                            }
                            if (!reader.IsDBNull(reader.GetOrdinal("longitude")))
                            {
                                longitude = Convert.ToDouble(reader["longitude"]);
                            }

                            // Create HTML content for each property card
                            string propertyCardHtml = $@"
<div class='property-card'>
    <img src='{propertyImageUrl}' class='property-image' />
    <div class='property-details'>
        <h3>{propertyName}</h3>
        <p>{propertyDescription}</p>
        <p>{propertyLocation}</p>
        <p> Price: {propertyPrice:C}</p>
        <div class='action-buttons'>
            <button class='view-details-btn' 
        data-lat='{latitude}' 
        data-lng='{longitude}'>View Details</button>
        </div>
    </div>
</div>";

                            // Add the property card HTML to the approvedPropertiesContainer
                            approvedPropertiesContainer.Controls.Add(new LiteralControl(propertyCardHtml));
                        }
                    }
                }
            }
        }

        private void LoadRejectedProperties()
        {
            rejectedPropertiesContainer.Controls.Clear();

            string connectionString = ConfigurationManager.ConnectionStrings["PropertiesConStr"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT id, name, description, location, price, imageUrl, latitude, longitude FROM Properties WHERE status = 0 ORDER BY id DESC";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // Retrieve property data
                            int propertyId = Convert.ToInt32(reader["id"]);
                            string propertyName = reader["name"].ToString();
                            string propertyDescription = reader["description"].ToString();
                            string propertyLocation = reader["location"].ToString();
                            decimal propertyPrice = Convert.ToDecimal(reader["price"]);
                            string propertyImageUrl = reader["imageUrl"].ToString();

                            // Check for DBNull for latitude and longitude
                            double latitude = 0.0;
                            double longitude = 0.0;
                            if (!reader.IsDBNull(reader.GetOrdinal("latitude")))
                            {
                                latitude = Convert.ToDouble(reader["latitude"]);
                            }
                            if (!reader.IsDBNull(reader.GetOrdinal("longitude")))
                            {
                                longitude = Convert.ToDouble(reader["longitude"]);
                            }

                            // Create HTML content for each property card
                            string propertyCardHtml = $@"
<div class='property-card'>
    <img src='{propertyImageUrl}' class='property-image' />
    <div class='property-details'>
        <h3>{propertyName}</h3>
        <p>{propertyDescription}</p>
        <p>{propertyLocation}</p>
        <p> Price: {propertyPrice:C}</p>
        <div class='action-buttons'>
            <button class='view-details-btn' 
        data-lat='{latitude}' 
        data-lng='{longitude}'>View Details</button>
        </div>
    </div>
</div>";

                            // Add the property card HTML to the rejectedPropertiesContainer
                            rejectedPropertiesContainer.Controls.Add(new LiteralControl(propertyCardHtml));
                        }
                    }
                }
            }
        }


    }
}