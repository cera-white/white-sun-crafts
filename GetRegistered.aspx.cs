using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;

public partial class GetRegistered : System.Web.UI.Page
{
    string Email, ActivationUrl;
    MailMessage message;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        //Get the UserId of the just-added user
        MembershipUser newUser = Membership.GetUser(CreateUserWizard1.UserName);
        Guid newUserId = (Guid)newUser.ProviderUserKey;

        //Insert a new record into UserProfiles
        string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
        string insertSql = "INSERT INTO WGCustomers(FirstName, LastName, Address, City, PostalCode, Country, Image, UserId, Region, Subscribed) VALUES(@FirstName, @LastName, @Address, @City, @PostalCode, @Country, @Image, @UserId, @Region, @Subscribed)";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand(insertSql, conn);
            cmd.Parameters.AddWithValue("@UserId", newUserId);
            cmd.Parameters.AddWithValue("@FirstName", "");
            cmd.Parameters.AddWithValue("@LastName", "");
            cmd.Parameters.AddWithValue("@Address", "");
            cmd.Parameters.AddWithValue("@City", "");
            cmd.Parameters.AddWithValue("@PostalCode", "");
            cmd.Parameters.AddWithValue("@Country", 236);
            cmd.Parameters.AddWithValue("@Image", "noimage.jpg");
            cmd.Parameters.AddWithValue("@Region", "");
            cmd.Parameters.AddWithValue("@Subscribed", false);

            cmd.ExecuteNonQuery();

            conn.Close();
        }

        //Set the Role to default to Customer
        Roles.AddUserToRole(CreateUserWizard1.UserName, "Customer");

        using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
        {
            string cartId = usersShoppingCart.GetCartId();
            usersShoppingCart.MigrateCart(cartId, CreateUserWizard1.UserName);
        }
    }

    protected void CreateUserWizard1_ActiveStepChanged(object sender, EventArgs e)
    {
        //Have we JUST reached the Complete step?
        if (CreateUserWizard1.ActiveStep.Title == "Complete")
        {
            WizardStep UserSettings = CreateUserWizard1.FindControl("UserSettings") as WizardStep;

            //Programmatically reference the TextBox controls
            TextBox FirstName = UserSettings.FindControl("FirstName") as TextBox;
            TextBox LastName = UserSettings.FindControl("LastName") as TextBox;
            TextBox Address = UserSettings.FindControl("Address") as TextBox;
            TextBox City = UserSettings.FindControl("City") as TextBox;
            TextBox Region = UserSettings.FindControl("Region") as TextBox;
            TextBox PostalCode = UserSettings.FindControl("PostalCode") as TextBox;
            DropDownList Country = UserSettings.FindControl("Country") as DropDownList;
            CheckBox Subscribe = UserSettings.FindControl("cbSubscribe") as CheckBox;

            //Update the UserProfiles record for this user
            //Get the UserId of the just-added User
            MembershipUser newUser = Membership.GetUser(CreateUserWizard1.UserName);
            Guid newUserId = (Guid)newUser.ProviderUserKey;

            //Insert a new record into UserProfiles
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            string updateSql = "UPDATE WGCustomers SET FirstName = @FirstName, LastName = @LastName, Address = @Address, City = @City, Region = @Region, PostalCode = @PostalCode, Country = @Country, Subscribed = @Subscribed WHERE UserId = @UserId";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(updateSql, conn);
                cmd.Parameters.AddWithValue("@FirstName", FirstName.Text.Trim());
                cmd.Parameters.AddWithValue("@LastName", LastName.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", Address.Text.Trim());
                cmd.Parameters.AddWithValue("@City", City.Text.Trim());
                cmd.Parameters.AddWithValue("@Region", Region.Text.Trim());
                cmd.Parameters.AddWithValue("@PostalCode", PostalCode.Text.Trim());
                cmd.Parameters.AddWithValue("@Country", int.Parse(Country.SelectedValue));
                cmd.Parameters.AddWithValue("@Subscribed", Subscribe.Checked ? 1 : 0);
                cmd.Parameters.AddWithValue("@UserId", newUserId);

                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
    }
}