using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_Project.Web_Forms.Admin
{
    public partial class Admin_Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplayArticles();
            }
        }

        // Post Article.
        protected void btnPostArticle_Click(object sender, EventArgs e)
        {
            string title = articleTitle.Value.Trim();
            string content = articleContent.Value.Trim();

            InsertArticle(title, content);
        }

        private void InsertArticle(string title, string content)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ArticlesConStr"].ConnectionString;

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
            string connectionString = ConfigurationManager.ConnectionStrings["ArticlesConStr"].ConnectionString;

            string query = "SELECT Title, Content, RegistrationDateTime FROM Articles ORDER BY RegistrationDateTime DESC";

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
                }
                catch (Exception ex)
                {

                }
            }
        }

        // Warden Registration
        protected void btnRegisterWarden_Click(object sender, EventArgs e)
        {
            string username = txtWardenUsername.Text.Trim();
            string password = txtWardenPassword.Text.Trim();
            string email = txtWardenEmail.Text.Trim();
            string firstName = txtWardenFirstName.Text.Trim();
            string lastName = txtWardenLastName.Text.Trim();
            string phoneNumber = txtWardenPhoneNumber.Text.Trim();

            InsertWarden(username, password, email, firstName, lastName, phoneNumber);
        }

        private void InsertWarden(string username, string password, string email, string firstName, string lastName, string phoneNumber)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["WardenLogConStr"].ConnectionString;

            string query = @"INSERT INTO Warden (Username, Password, Email, FirstName, LastName, PhoneNumber, RegistrationDate)
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
                        string script = "<script>alert('Warden sucessfully registered!');</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "InsertSuccess", script);
                    }
                    else
                    {
                        string script = "<script>alert('Warden registration failed!');</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "InsertSuccess", script);
                    }
                }
                catch (Exception ex)
                {

                }
            }
        }

        // Student Registration.
        protected void btnRegisterStudent_Click(object sender, EventArgs e)
        {
            string username = txtStudentUsername.Text.Trim();
            string password = txtStudentPassword.Text.Trim();
            string email = txtStudentEmail.Text.Trim();
            string firstName = txtStudentFirstName.Text.Trim();
            string lastName = txtStudentLastName.Text.Trim();
            string phoneNumber = txtStudentPhoneNumber.Text.Trim();

            InsertStudent(username, password, email, firstName, lastName, phoneNumber);
        }

        private void InsertStudent(string username, string password, string email, string firstName, string lastName, string phoneNumber)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["StudentLoginConStr"].ConnectionString;

            string query = @"INSERT INTO Students (Username, Password, Email, FirstName, LastName, PhoneNumber, RegistrationDate)
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
                        string script = "<script>alert('Student sucessfully registered!');</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "InsertSuccess", script);
                    }
                    else
                    {
                        string script = "<script>alert('Student registration failed!');</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "InsertSuccess", script);
                    }
                }
                catch (Exception ex)
                {

                }
            }
        }

        // Landlord Registration.
        protected void btnRegisterLandlord_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string email = txtEmail.Text.Trim();
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string phoneNumber = txtPhoneNumber.Text.Trim();

            // Insert Landlord details to database method i created.
            InsertLandlord(username, password, email, firstName, lastName, phoneNumber);
        }

        private void InsertLandlord(string username, string password, string email, string firstName, string lastName, string phoneNumber)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LandlordRegConStr"].ConnectionString;

            string query = @"INSERT INTO Landlords (Username, Password, Email, FirstName, LastName, PhoneNumber, RegistrationDate)
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
                        string script = "<script>alert('Landlord sucessfully registered!');</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "InsertSuccess", script);
                    }
                    else
                    {
                        string script = "<script>alert('Landlord registration failed!');</script>";
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