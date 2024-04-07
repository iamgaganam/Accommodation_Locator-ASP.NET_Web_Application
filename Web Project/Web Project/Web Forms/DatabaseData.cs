using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;

namespace Web_Project.Web_Forms
{
    public struct PropertyData
    {
        public int id;
        public string name;
        public string description;
        public string location;
        public decimal price;
        public string imageUrl;
        public int landlordId; // owned by landlord
        public int studentId; // reserved by student
        public double latitude;
        public double longitude;
    }

    public class DatabaseData
    {
        public static string ConnectionString { private set; get; } = "testDBConnection";

        public static List<PropertyData> GetReservedPropertiesLandlord(int landlordId) 
        {
            string connectionStr = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString.ToString();
            List<PropertyData> propertyData = new List<PropertyData>();

            using (SqlConnection connection = new SqlConnection(connectionStr))
            {
                string query = $"SELECT r.*, p.* FROM Reservations r JOIN Properties p ON r.PropertyID = p.id WHERE p.LandlordID = @LandlordId;";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@LandlordId", landlordId);

                    connection.Open();

                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        // Retrieve property data
                        int propertyId = Convert.ToInt32(reader["PropertyID"]);
                        string propertyName = reader["name"].ToString();
                        string propertyDescription = reader["description"].ToString();
                        string propertyLocation = reader["location"].ToString();
                        decimal propertyPrice = Convert.ToDecimal(reader["price"]);
                        string propertyImageUrl = reader["imageUrl"].ToString();
                        int studentId = Convert.ToInt32(reader["StudentID"]);

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

                        // Store that into a new propertyData struct instance
                        PropertyData data = new PropertyData();

                        data.id = propertyId;
                        data.name = propertyName;
                        data.description = propertyDescription;
                        data.location = propertyLocation;
                        data.price = propertyPrice;
                        data.imageUrl = propertyImageUrl;
                        data.landlordId = landlordId;
                        data.studentId = studentId;
                        data.latitude = latitude;
                        data.longitude = longitude;

                        propertyData.Add(data);
                    }
                }

                return propertyData;
            }
        }

        public static List<PropertyData> GetProperties(string constraint = "") 
        {
            string connectionStr = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString.ToString();

            using (SqlConnection connection = new SqlConnection(connectionStr))
            {
                connection.Open();
                // ORDER BY id DESC;
                string query = $"SELECT id, name, description, location, price, imageUrl, LandlordID, latitude, longitude FROM Properties {constraint};";

                List<PropertyData> propertyData = new List<PropertyData>();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
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
                            int landlordId = Convert.ToInt32(reader["LandlordID"]);

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

                            // Store that into a new propertyData struct instance
                            PropertyData data = new PropertyData();
                            data.id = propertyId;
                            data.name = propertyName;
                            data.description = propertyDescription;
                            data.location = propertyLocation;
                            data.price = propertyPrice;
                            data.imageUrl = propertyImageUrl;
                            data.landlordId = landlordId;
                            data.latitude = latitude;
                            data.longitude = longitude;

                            propertyData.Add(data);
                        }
                    }
                }

                return propertyData;
            }
        }

        public static void UpdateProperty(int propertyId, int newStatus) 
        {
            string connectionStr = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString.ToString();
            string query = "UPDATE [dbo].[Properties] SET [status] = @NewStatus WHERE [id] = @PropertyId";

            using (SqlConnection connection = new SqlConnection(connectionStr))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the SQL command
                    command.Parameters.AddWithValue("@NewStatus", newStatus);
                    command.Parameters.AddWithValue("@PropertyId", propertyId);

                    try
                    {
                        connection.Open();
                        // Execute the SQL command
                        int rowsAffected = command.ExecuteNonQuery();
                        // Check if the update was successful
                        if (rowsAffected > 0)
                        {
                            // Update successful
                            Debug.WriteLine("Property status updated successfully.");
                        }
                        else
                        {
                            // No rows affected, possibly the property with the given ID doesn't exist
                            Debug.WriteLine("No property found with the provided ID.");
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle any exceptions
                        Debug.WriteLine("An error occurred: " + ex.Message);
                    }
                }
            }
        }

        public static void ReserveProperty(int propertyId, int studentId) 
        {
            // Insert property into reserved table
            string connectionString = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString;
            string query = @"INSERT INTO [dbo].[Reservations] ([PropertyID], [StudentID], [Status])
                            VALUES (@PropertyId, @StudentId, @Status);";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection)) 
                {
                    command.Parameters.AddWithValue("@PropertyId", propertyId);
                    command.Parameters.AddWithValue("@StudentId", studentId);

                    command.Parameters.AddWithValue("@Status", 0);

                    try
                    {
                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        // Check if the update was successful
                        if (rowsAffected > 0)
                        {
                            // Update property status to reserved
                            UpdateProperty(propertyId, 2);

                            // Update successful
                            Debug.WriteLine($"Property {propertyId} reserved for {studentId} successfully.");
                        }

                    }
                    catch (Exception ex) 
                    {
                        Debug.WriteLine("An error occurred: " + ex.Message);
                    }
                }
            }
        }

        public static void DeleteReservedProperty(int propertyId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString;
            string query = "DELETE FROM Reservations WHERE PropertyID = @PropertyID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@PropertyID", propertyId);

                    try
                    {
                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        // Check if the update was successful
                        if (rowsAffected > 0)
                        {
                            UpdateProperty(propertyId, 1);
                            // Update successful
                            Debug.WriteLine($"Deleted reserved {propertyId} successfully.");
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("An error occurred: " + ex.Message);
                    }
                }
            }
        }

        public static void DeleteProperty(int propertyId)
        {
            DeleteReservedProperty(propertyId);

            string connectionString = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString;
            string query = "DELETE FROM Properties WHERE id = @PropertyID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection)) 
                {
                    try
                    {
                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        // Check if the update was successful
                        if (rowsAffected > 0)
                        {
                            // Update successful
                            Debug.WriteLine($"Deleted {propertyId} successfully.");
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("An error occurred: " + ex.Message);
                    }
                }
            }
        }
    }
}