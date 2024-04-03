using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Web_Project.Web_Forms.Student
{
    public partial class StudentDashboard2 : System.Web.UI.Page
    {
        protected int totalPages;
        protected int currentPage;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the session variable containing student ID exists
                if (Session["StudentID"] == null)
                {
                    // Redirect the user to the login page
                    Response.Redirect("StudentLogin.aspx");
                }
                else
                {
                    // Proceed with loading the dashboard
                    int studentID = Convert.ToInt32(Session["StudentID"]);
                    currentPage = Request.QueryString["page"] != null ? Convert.ToInt32(Request.QueryString["page"]) : 1;
                    LoadProperties();
                    LoadAwarenessPosts(currentPage);
                    CalculateTotalPages();
                    LoadReservedProperties(studentID);
                }
            }
        }

        private void LoadProperties()
        {
            propertyCardsContainer.Controls.Clear();

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
                            // Created HTML content for each property card
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
                <button class='approve-btn'>Reserve</button>
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

        private void LoadAwarenessPosts(int pageNumber)
        {
            int postsPerPage = 5;
            int offset = (pageNumber - 1) * postsPerPage;

            string connectionString = ConfigurationManager.ConnectionStrings["PropertiesConStr"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = $"SELECT Title, Content, RegistrationDateTime FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY RegistrationDateTime DESC) AS RowNum FROM Articles) AS ArticleWithRowNum WHERE RowNum BETWEEN @StartIndex AND @EndIndex";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StartIndex", offset + 1);
                    command.Parameters.AddWithValue("@EndIndex", offset + postsPerPage);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // Retrieve article data
                            string title = reader["Title"].ToString();
                            string content = reader["Content"].ToString();
                            DateTime registrationDateTime = Convert.ToDateTime(reader["RegistrationDateTime"]);

                            // Create HTML content for awareness post card
                            string awarenessPostCardHtml = $@"
<div class='property-card awareness-post-card'>
    <div class='property-details'>
        <h3>{title}</h3>
        <p>{content}</p>
        <p>Posted On: {registrationDateTime.ToString("MMMM dd, yyyy, hh:mm tt")}</p>
    </div>
</div>";
                            // Add the awareness post card HTML to the page
                            awarenessPostCardsContainer.Controls.Add(new LiteralControl(awarenessPostCardHtml));
                        }
                    }
                }
            }
        }

        private void CalculateTotalPages()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PropertiesConStr"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Articles";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    int totalPosts = Convert.ToInt32(command.ExecuteScalar());
                    totalPages = (int)Math.Ceiling((double)totalPosts / 5); // Keeping 5 posts per page
                }
            }
        }

        private void LoadReservedProperties(int studentID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ReserveConStr"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("SELECT p.name, p.description, p.price, p.location, p.imageUrl FROM Properties p INNER JOIN Reservations r ON p.id = r.PropertyID WHERE r.Status = 'Accepted' AND r.StudentID = @StudentID", connection);
                command.Parameters.AddWithValue("@StudentID", studentID);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    string name = reader["name"].ToString();
                    string description = reader["description"].ToString();
                    decimal price = Convert.ToDecimal(reader["price"]);
                    string location = reader["location"].ToString();
                    string imageUrl = reader["imageUrl"].ToString();

                    // Create HTML elements dynamically and add them to the page
                    AddPropertyCardToPage(name, description, price, location, imageUrl);
                }

                reader.Close();
            }
        }

        private void AddPropertyCardToPage(string name, string description, decimal price, string location, string imageUrl)
        {
            // Create property card dynamically
            System.Web.UI.HtmlControls.HtmlGenericControl propertyCardDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            propertyCardDiv.Attributes["class"] = "property-card";

            // Add image to property card
            System.Web.UI.HtmlControls.HtmlImage image = new System.Web.UI.HtmlControls.HtmlImage();
            image.Src = imageUrl;
            image.Alt = "Property Image";
            image.Attributes["class"] = "property-image";
            propertyCardDiv.Controls.Add(image);

            // Add property details to property card
            System.Web.UI.HtmlControls.HtmlGenericControl propertyDetailsDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            propertyDetailsDiv.Attributes["class"] = "property-details";
            propertyDetailsDiv.InnerHtml = "<p>" + description + "</p>" +
                                           "<p>Price: $" + price.ToString() + "</p>" +
                                           "<p>Location: " + location + "</p>";

            propertyCardDiv.Controls.Add(propertyDetailsDiv);

            // Add property card to approved-properties div
            approvedProperties.Controls.Add(propertyCardDiv);
        }
    }
}
