using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Web_Project.Web_Forms.Student
{
    public partial class StudentDashboard2 : System.Web.UI.Page
    {
        protected int totalPages;
        protected int currentPage;

        public string approvedPropertiesJson { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                currentPage = Request.QueryString["page"] != null ? Convert.ToInt32(Request.QueryString["page"]) : 1;
                LoadApprovedProperties();
                LoadAwarenessPosts(currentPage);
                CalculateTotalPages();
            }
        }

        private void LoadApprovedProperties()
        {
            string constraint = "WHERE status = 1 ORDER BY id DESC";
            List<PropertyData> propertyData = DatabaseData.GetProperties(constraint);

            approvedPropertiesJson = JsonConvert.SerializeObject(propertyData);
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
