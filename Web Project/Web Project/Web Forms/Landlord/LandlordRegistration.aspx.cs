using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_Project.Web_Forms.Landlord
{
    public partial class LandlordRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;
            string email = txtEmail.Text;
            string firstName = txtFirstName.Text;
            string lastName = txtLastName.Text;
            string phoneNumber = txtPhoneNumber.Text;

            // I used Landlord method to insert details to database.
            InsertLandlord(username, password, email, firstName, lastName, phoneNumber);

            // Redirect logic will be implemented in here.
            Response.Redirect("LandlordLogin.aspx");
        }

        private void InsertLandlord(string username, string password, string email, string firstName, string lastName, string phoneNumber)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LandlordRegConStr"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Landlords (Username, Password, Email, FirstName, LastName, PhoneNumber)
                                 VALUES (@Username, @Password, @Email, @FirstName, @LastName, @PhoneNumber)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", password);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@FirstName", firstName);
                    command.Parameters.AddWithValue("@LastName", lastName);
                    command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

    }
}