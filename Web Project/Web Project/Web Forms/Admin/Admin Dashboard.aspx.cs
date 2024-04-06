using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Web_Project.Web_Forms.Admin
{
    public partial class Admin_Dashboard : System.Web.UI.Page
    {
        private int currentPage = 1;
        private int articlesPerPage = 5;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplayArticles();
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["page"] != null)
                {
                    int page;
                    if (int.TryParse(Request.QueryString["page"], out page))
                    {
                        currentPage = page;
                        articleContainer.InnerHtml = string.Empty;
                        DisplayArticles();
                    }
                }
            }
        }

        protected void RegisterUser(object sender, EventArgs e)
        {
            string userType = userTypeDropdown.SelectedValue;

            switch (userType)
            {
                case "Landlord":
                    RegisterLandlord();
                    break;
                case "Student":
                    RegisterStudent();
                    break;
                case "Warden":
                    RegisterWarden();
                    break;
                default:
                    break;
            }
        }

        protected void PostArticle(object sender, EventArgs e)
        {
            string title = articleTitle.Value.Trim();
            string content = articleContent.Value.Trim();

            InsertArticle(title, content);
        }

        private void InsertArticle(string title, string content)
        {
            string connectionString = ConfigurationManager.ConnectionStrings[DatabaseData.ConnectionString].ConnectionString;

            string query = @"INSERT INTO Articles (Title, Content, RegistrationDateTime)
                 VALUES (@Title, @Content, @RegistrationDateTime)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@Title", title);
                command.Parameters.AddWithValue("@Content", content);
                command.Parameters.AddWithValue("@RegistrationDateTime", DateTime.Now);

                try
                {
                    connection.Open();

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        string script = "<script>alert('Post successfully published!');</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "InsertSuccess", script);
                    }
                    else
                    {
                        string script = "<script>alert('Post upload failed!');</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "InsertSuccess", script);
                    }
                }
                catch (Exception ex)
                {
                }
            }
        }

        private void DisplayArticles()
        {
            string connectionString = ConfigurationManager.ConnectionStrings[DatabaseData.ConnectionString].ConnectionString;

            int startIndex = (currentPage - 1) * articlesPerPage;
            int endIndex = startIndex + articlesPerPage;

            string query = $@"SELECT Title, Content, RegistrationDateTime 
                              FROM (SELECT ROW_NUMBER() OVER (ORDER BY RegistrationDateTime DESC) AS RowNum,
                                           Title, Content, RegistrationDateTime 
                                    FROM Articles) AS RowConstrainedResult
                              WHERE RowNum > {startIndex} AND RowNum <= {endIndex}";

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        string title = reader["Title"].ToString();
                        string content = reader["Content"].ToString();
                        DateTime registrationDateTime = (DateTime)reader["RegistrationDateTime"];

                        string articleCard = $@"
                            <div class='card'>
                                <div class='card-header'>{title}</div>
                                <div class='card-body'>
                                    <p>{content}</p>
                                    <p>Published on: {registrationDateTime.ToString("MMMM dd, yyyy")}</p>
                                </div>
                            </div>";
                        articleContainer.InnerHtml += articleCard;
                    }

                    // Display pagination links
                    DisplayPaginationLinks();
                }
                catch (Exception ex)
                {
                }
            }
        }

        private void DisplayPaginationLinks()
        {
            string connectionString = ConfigurationManager.ConnectionStrings[DatabaseData.ConnectionString].ConnectionString;

            // Count total number of articles
            string countQuery = "SELECT COUNT(*) FROM Articles";
            int totalArticles = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(countQuery, connection))
            {
                try
                {
                    connection.Open();
                    totalArticles = (int)command.ExecuteScalar();
                }
                catch (Exception ex)
                {
                }
            }

            // Calculate total number of pages
            int totalPages = (int)Math.Ceiling((double)totalArticles / articlesPerPage);

            // Display pagination links wrapped inside a container
            string paginationHtml = "<div class='pagination-container'><nav aria-label='Page navigation example'><ul class='pagination'>";

            // Previous Button
            paginationHtml += "<li class='page-item'>";
            if (currentPage > 1)
            {
                paginationHtml += $"<a class='page-link' href='?page={currentPage - 1}' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a>";
            }
            paginationHtml += "</li>";

            // Page Numbers
            for (int i = 1; i <= totalPages; i++)
            {
                paginationHtml += $"<li class='page-item {(i == currentPage ? "active" : "")}'><a class='page-link' href='?page={i}'>{i}</a></li>";
            }

            // Next Button
            paginationHtml += "<li class='page-item'>";
            if (currentPage < totalPages)
            {
                paginationHtml += $"<a class='page-link' href='?page={currentPage + 1}' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a>";
            }
            paginationHtml += "</li>";

            paginationHtml += "</ul></nav></div>";

            articleContainer.InnerHtml += paginationHtml;
        }

        private void RegisterLandlord()
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string email = txtEmail.Text.Trim();
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string phoneNumber = txtPhoneNumber.Text.Trim();

            InsertUser("Landlords", username, password, email, firstName, lastName, phoneNumber);
        }

        private void RegisterStudent()
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string email = txtEmail.Text.Trim();
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string phoneNumber = txtPhoneNumber.Text.Trim();

            InsertUser("Students", username, password, email, firstName, lastName, phoneNumber);
        }

        private void RegisterWarden()
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string email = txtEmail.Text.Trim();
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string phoneNumber = txtPhoneNumber.Text.Trim();

            InsertUser("Warden", username, password, email, firstName, lastName, phoneNumber);
        }

        private void InsertUser(string tableName, string username, string password, string email, string firstName, string lastName, string phoneNumber)
        {
            string connectionString = ConfigurationManager.ConnectionStrings[DatabaseData.ConnectionString].ConnectionString;

            string query = $@"INSERT INTO {tableName} (Username, Password, Email, FirstName, LastName, PhoneNumber, RegistrationDate)
                             VALUES (@Username, @Password, @Email, @FirstName, @LastName, @PhoneNumber, @RegistrationDate)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@Username", username);
                command.Parameters.AddWithValue("@Password", password);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@FirstName", firstName);
                command.Parameters.AddWithValue("@LastName", lastName);
                command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                command.Parameters.AddWithValue("@RegistrationDate", DateTime.Now);

                try
                {
                    connection.Open();

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        string script = $"<script>alert('{tableName} successfully registered!');</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "InsertSuccess", script);
                    }
                    else
                    {
                        string script = $"<script>alert('{tableName} registration failed!');</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "InsertSuccess", script);
                    }
                }
                catch (Exception ex)
                {
                }
            }
        }
    }
}
