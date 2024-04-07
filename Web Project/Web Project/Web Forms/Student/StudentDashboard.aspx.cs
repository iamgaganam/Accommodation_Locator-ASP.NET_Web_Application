using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;

namespace Web_Project.Web_Forms.Student
{
    public partial class StudentDashboard2 : System.Web.UI.Page
    {
        public string username;

        protected int totalPages;
        protected int currentPage;

        public string approvedPropertiesJson { get; private set; }
        public string reservedPropertiesJson { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if session variables exist and are not null
                if (Session["StudentID"] != null && Session["Username"] != null)
                {
                    // Retrieve values from session variables
                    string studentID = Session["StudentID"].ToString();
                    string username = Session["Username"].ToString();

                    // Now you can use these values as needed in your page
                    // For example, you can display them in labels or textboxes
                    hdnStudentId.Value = studentID;
                    this.username = username;
                }
                else 
                {
                    // Handle the case where session variables are not set
                    // For example, redirect the user to a login page

                    Response.Redirect("StudentLogin.aspx");
                }

                currentPage = Request.QueryString["page"] != null ? Convert.ToInt32(Request.QueryString["page"]) : 1;
                LoadApprovedProperties();
                LoadReservedProperties();
                LoadAwarenessPosts(currentPage);
                CalculateTotalPages();
            }
        }

        [WebMethod]
        public static void ReserveApprovedProperty(string propertyId, string studentId) 
        {
            int prId = int.Parse(propertyId);
            int stdId = int.Parse(studentId);

            DatabaseData.ReserveProperty(prId, stdId);
        }

        [WebMethod]
        public static void DeleteReservedProperty(string propertyId) 
        {
            int prId = int.Parse(propertyId);
            DatabaseData.DeleteReservedProperty(prId);
        }

        public string GetCombinedProperties() 
        {
            List<PropertyData> approvedProperties = GetApprovedProperties();
            List<PropertyData> reservedProperties = GetReservedProperties();

            approvedProperties.AddRange(reservedProperties);

            return JsonConvert.SerializeObject(approvedProperties);
        }

        private void LoadReservedProperties() 
        {
            reservedPropertiesJson = JsonConvert.SerializeObject(GetReservedProperties());
        }

        private List<PropertyData> GetReservedProperties() 
        {
            string constraint = "WHERE status = 2 ORDER BY id DESC";
            return DatabaseData.GetProperties(constraint);
        }

        private void LoadApprovedProperties()
        {
            approvedPropertiesJson = JsonConvert.SerializeObject(GetApprovedProperties());
        }

        private List<PropertyData> GetApprovedProperties()
        {
            string constraint = "WHERE status = 1 ORDER BY id DESC";
            return DatabaseData.GetProperties(constraint);
        }

        private void LoadAwarenessPosts(int pageNumber)
        {
            int postsPerPage = 5;
            int offset = (pageNumber - 1) * postsPerPage;

            string connectionString = ConfigurationManager.ConnectionStrings[DatabaseData.ConnectionString].ConnectionString;

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
            string connectionString = ConfigurationManager.ConnectionStrings[DatabaseData.ConnectionString].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Articles";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    int totalPosts = Convert.ToInt32(command.ExecuteScalar());
                    totalPages = (int)Math.Ceiling((double)totalPosts / 5); // Keeping 5 posts per page nigga
                }
            }
        }
    }
}
