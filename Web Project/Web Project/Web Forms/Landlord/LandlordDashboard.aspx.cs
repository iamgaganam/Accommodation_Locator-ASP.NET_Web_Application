using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Web_Project.Web_Forms.Landlord
{
    public partial class LandlordDashboard : System.Web.UI.Page
    {
        public string reservedPropertiesJson { private set; get; }
        protected void Page_Load(object sender, EventArgs e)
        {
            // Not the way if statement is used but thats that! 
            if (!IsPostBack)
            {
                LoadLandlordProperties();
                LoadRequestedProperties();
            }
        }

        protected void AddProperty(object sender, EventArgs e)
        {
            // Validate form fields
            if (ValidateForm())
            {
                // Form fields are valid, proceed with adding property
                string propertyName = this.propertyName.Text;
                string propertyDescription = this.propertyDescription.Text;
                decimal propertyPrice;

                if (decimal.TryParse(this.propertyPrice.Text, out propertyPrice))
                {
                    string propertyLocation = this.propertyLocation.Text;
                    decimal propertyLatitude = Convert.ToDecimal(this.propertyLatitude.Text);
                    decimal propertyLongitude = Convert.ToDecimal(this.propertyLongitude.Text);

                    // Check if file is uploaded
                    if (propertyImage.HasFile)
                    {
                        // Save uploaded image
                        string fileName = System.IO.Path.GetFileName(propertyImage.FileName);
                        string imagePath = "~/Images/" + fileName;
                        string imageUrl = "Images/" + fileName;
                        propertyImage.SaveAs(Server.MapPath(imagePath));

                        // Insert property into database
                        string connectionString = ConfigurationManager.ConnectionStrings[DatabaseData.ConnectionString].ConnectionString;
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            string query = @"INSERT INTO Properties (name, description, price, location, imageUrl, latitude, longitude, LandlordID)
                                     VALUES (@Name, @Description, @Price, @Location, @ImageUrl, @Latitude, @Longitude, @LandlordID)";

                            SqlCommand command = new SqlCommand(query, connection);
                            command.Parameters.AddWithValue("@Name", propertyName);
                            command.Parameters.AddWithValue("@Description", propertyDescription);
                            command.Parameters.AddWithValue("@Price", propertyPrice);
                            command.Parameters.AddWithValue("@Location", propertyLocation);
                            command.Parameters.AddWithValue("@ImageUrl", imageUrl);
                            command.Parameters.AddWithValue("@Latitude", propertyLatitude);
                            command.Parameters.AddWithValue("@Longitude", propertyLongitude);

                            // Get the logged-in landlord's ID
                            int landlordID = GetLoggedInLandlordID();
                            command.Parameters.AddWithValue("@LandlordID", landlordID);

                            connection.Open();
                            command.ExecuteNonQuery();
                        }

                        // Reload properties list after adding a new property
                        LoadLandlordProperties();
                    }
                    else
                    {
                        Response.Write("Please upload an image for the property.");
                    }
                }
                else
                {
                    Response.Write("Invalid property price.");
                }
            }
            else
            {
                Response.Write("Please fill in all required fields.");
            }
        }

        private bool ValidateForm()
        {
            if (string.IsNullOrEmpty(propertyName.Text) ||
                string.IsNullOrEmpty(propertyDescription.Text) ||
                string.IsNullOrEmpty(propertyPrice.Text) ||
                string.IsNullOrEmpty(propertyLocation.Text) ||
                string.IsNullOrEmpty(propertyLatitude.Text) ||
                string.IsNullOrEmpty(propertyLongitude.Text) ||
                !propertyImage.HasFile)
            {
                return false;
            }
            return true;
        }

        protected void DeleteProperty_OnClick(object sender, EventArgs e)
        {
            Button btnDelete = (Button)sender;
            int propertyID = Convert.ToInt32(btnDelete.CommandArgument);

            DeletePropertyFromDB(propertyID);
            LoadLandlordProperties();
        }

        // Select properties based on landlord ID
        private void LoadLandlordProperties()
        {
            propertyList.Controls.Clear();

            // Get the logged-in landlord ID for automation.
            int landlordID = GetLoggedInLandlordID();
            Debug.WriteLine("Landlord id: " + landlordID);

            string connectionString = ConfigurationManager.ConnectionStrings[DatabaseData.ConnectionString].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT id, name, description, price, location, imageUrl, latitude, longitude FROM Properties WHERE LandlordID = @LandlordID ORDER BY id DESC";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@LandlordID", landlordID);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    li.Attributes["class"] = "property";

                    // Creating property image element in here.
                    Image img = new Image();
                    img.ImageUrl = reader["imageUrl"].ToString();
                    img.AlternateText = reader["name"].ToString();
                    img.CssClass = "property-image";

                    // Create property details container in  here.
                    HtmlGenericControl divDetails = new HtmlGenericControl("div");
                    divDetails.Attributes["class"] = "property-details";

                    Label lblName = new Label();
                    lblName.Text = reader["name"].ToString();

                    Label lblDescription = new Label();
                    lblDescription.Text = reader["description"].ToString();

                    Label lblPrice = new Label();
                    lblPrice.Text = "LKR: " + reader["price"].ToString();

                    Label lblLocation = new Label();
                    lblLocation.Text = reader["location"].ToString();

                    // Add elements to property details to0 the container
                    divDetails.Controls.Add(lblName);
                    divDetails.Controls.Add(new LiteralControl("<br />"));
                    divDetails.Controls.Add(lblDescription);
                    divDetails.Controls.Add(new LiteralControl("<br />"));
                    divDetails.Controls.Add(lblPrice);
                    divDetails.Controls.Add(new LiteralControl("<br />"));
                    divDetails.Controls.Add(lblLocation);

                    // Add image and details container to property list item
                    li.Controls.Add(img);
                    li.Controls.Add(divDetails);

                    Button btnDelete = new Button();
                    btnDelete.Text = "Delete";
                    btnDelete.CssClass = "btn-delete";
                    btnDelete.CommandArgument = reader["id"].ToString();
                    btnDelete.Click += new EventHandler(DeleteProperty_OnClick);

                    li.Controls.Add(btnDelete);

                    propertyList.Controls.Add(li);
                }
                reader.Close();
            }
        }

        private void LoadRequestedProperties() 
        {
            reservedPropertiesJson = JsonConvert.SerializeObject(DatabaseData.GetReservedPropertiesLandlord(GetLoggedInLandlordID()));
        }

        private int GetLoggedInLandlordID()
        {
            string username = Session["Username"]?.ToString();

            if (Session["Username"] != null) 
            {
                string connectionStr = ConfigurationManager.ConnectionStrings[DatabaseData.ConnectionString].ConnectionString.ToString();
                using (SqlConnection connection = new SqlConnection(connectionStr))
                {
                    connection.Open();
                    string query = $"SELECT LandlordID FROM Landlords WHERE Username=@username";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@username", username);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read()) 
                            {
                                int landlordId = Convert.ToInt32(reader["LandlordID"]);

                                return landlordId;
                            }
                        }
                    }
                    
                }
            }

            return -1;
        }

        // Delete Feature.
        private void DeletePropertyFromDB(int propertyID)
        {
            DatabaseData.DeleteProperty(propertyID);
        }

    }
}
