using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Web_Project.Web_Forms.Landlord
{
    public partial class LandlordDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProperties();
            }
        }

        protected void btnAddProperty_Click(object sender, EventArgs e)
        {
            // Retrieve property details from form inputs
            string propertyName = this.propertyName.Text;
            string propertyDescription = this.propertyDescription.Text;
            decimal propertyPrice;

            if (decimal.TryParse(this.propertyPrice.Text, out propertyPrice))
            {
                // Successfully parsed propertyPrice
                string propertyLocation = this.propertyLocation.Text;

                // Assuming you have some way to get the uploaded image
                string fileName = System.IO.Path.GetFileName(propertyImage.FileName);
                string imagePath = "~/Images/" + fileName;
                string imageUrl = "Images/" + fileName;
                propertyImage.SaveAs(Server.MapPath(imagePath));

                // Insert property details into the database
                string connectionString = ConfigurationManager.ConnectionStrings["PropertiesConStr"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Properties (name, description, price, location, imageUrl, LandlordID)
                             VALUES (@Name, @Description, @Price, @Location, @ImageUrl, @LandlordID)";

                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Name", propertyName);
                    command.Parameters.AddWithValue("@Description", propertyDescription);
                    command.Parameters.AddWithValue("@Price", propertyPrice);
                    command.Parameters.AddWithValue("@Location", propertyLocation);
                    command.Parameters.AddWithValue("@ImageUrl", imageUrl);

                    // Get the logged-in landlord's ID
                    int landlordID = GetLoggedInLandlordID();
                    command.Parameters.AddWithValue("@LandlordID", landlordID);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
                LoadProperties();
            }
            else
            {
                Response.Write("Invalid property price.");
            }
        }

        private void LoadProperties()
        {
            // Clear existing property list items
            propertyList.Controls.Clear();

            // Get the logged-in landlord ID
            int landlordID = GetLoggedInLandlordID(); // Assuming you have implemented this method

            // Query the database to retrieve properties associated with the logged-in landlord
            string connectionString = ConfigurationManager.ConnectionStrings["PropertiesConStr"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT id, name, description, price, location, imageUrl FROM Properties WHERE LandlordID = @LandlordID ORDER BY id DESC";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@LandlordID", landlordID);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    // Create HTML elements to display property details
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    li.Attributes["class"] = "property";

                    // Create property image element
                    Image img = new Image();
                    img.ImageUrl = reader["imageUrl"].ToString();
                    img.AlternateText = reader["name"].ToString();
                    img.CssClass = "property-image";

                    // Create property details container
                    HtmlGenericControl divDetails = new HtmlGenericControl("div");
                    divDetails.Attributes["class"] = "property-details";

                    // Create property name element
                    Label lblName = new Label();
                    lblName.Text = reader["name"].ToString();

                    // Create property description element
                    Label lblDescription = new Label();
                    lblDescription.Text = reader["description"].ToString();

                    // Create property price element
                    Label lblPrice = new Label();
                    lblPrice.Text = "$" + reader["price"].ToString(); // Assuming price is in USD

                    // Create property location element
                    Label lblLocation = new Label();
                    lblLocation.Text = reader["location"].ToString();

                    // Add elements to property details container
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

                    // Add property list item to the property list
                    propertyList.Controls.Add(li);
                }
                reader.Close();
            }
        }

        private int GetLoggedInLandlordID()
        {
            return 1;
        }
    }
}
