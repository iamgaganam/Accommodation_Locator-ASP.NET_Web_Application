using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
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
        public double latitude;
        public double longitude;
    }

    public class DatabaseData
    {
        public static string ConnectionString { private set; get; } = "testDBConnection";

        public static List<PropertyData> GetProperties(string constraint = "") 
        {
            string connectionStr = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString.ToString();

            using (SqlConnection connection = new SqlConnection(connectionStr))
            {
                connection.Open();
                // ORDER BY id DESC;
                string query = $"SELECT id, name, description, location, price, imageUrl, latitude, longitude FROM Properties {constraint};";

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
                            data.latitude = latitude;
                            data.longitude = longitude;

                            propertyData.Add(data);
                        }
                    }
                }

                return propertyData;
            }
        }
    }
}