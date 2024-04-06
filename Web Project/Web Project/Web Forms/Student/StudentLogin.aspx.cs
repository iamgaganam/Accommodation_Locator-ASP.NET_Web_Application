using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_Project.Web_Forms.Student
{
    public partial class StudentLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["testDBConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Students WHERE Username = @Username AND Password = @Password";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        // Login successful
                        while (reader.Read())
                        {
                            // Stores data as cookies.
                            Session["StudentID"] = reader["StudentID"].ToString();
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("StudentDashboard.aspx");
                        }
                    }
                    else
                    {
                        lblErrorMessage.Text = "Invalid username or password";
                        lblErrorMessage.Visible = true;
                    }
                }
            }
        }
    }
}