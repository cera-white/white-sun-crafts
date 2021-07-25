using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_ManageAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        fvCustomerAccount.ChangeMode(FormViewMode.ReadOnly);
        fvCustomerAccount.DataBind();
    }

    protected void dsCustomerAccount_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        //Get a reference to the currently logged in user
        MembershipUser currentUser = Membership.GetUser();

        //Determine the current logged in user's UserID value
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        //Assign the currently logged in user's UserId to the @UserId parameter
        e.Command.Parameters["@UserId"].Value = currentUserId;
    }


    protected void btnDeleteAccount_Click(object sender, EventArgs e)
    {
        //Delete user account (aka all references to UserId)
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        //Clear user out of WGMembership
        string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
        string deleteSql = "DELETE FROM WGCustomers WHERE UserId = @UserId;" +
            "DELETE FROM aspnet_Membership WHERE UserId = @UserId;" + 
            "DELETE FROM aspnet_UsersInRoles WHERE UserId = @UserId;" + 
            "DELETE FROM aspnet_Users WHERE UserId = @UserId";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand(deleteSql, conn);
            cmd.Parameters.AddWithValue("@UserId", currentUserId);
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        //Clear user out of WG
        string connectionString2 = ConfigurationManager.ConnectionStrings["WGConnectionString"].ConnectionString;
        if (User.IsInRole("Vendor") || User.IsInRole("Admin"))
        {
            string updateSql = "UPDATE WGVendors SET IsActive = 0, UserId = NULL WHERE UserId = @UserId";

            using (SqlConnection conn = new SqlConnection(connectionString2))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(updateSql, conn);
                cmd.Parameters.AddWithValue("@UserId", currentUserId);
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        string deleteSql2 = "DELETE FROM WGUserComments WHERE UserId = @UserId;" +
            "DELETE FROM WGUserWishlist WHERE UserId = @UserId";

        using (SqlConnection conn = new SqlConnection(connectionString2))
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand(deleteSql2, conn);
            cmd.Parameters.AddWithValue("@UserId", currentUserId);
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        //Log user out and redirect to home page
        FormsAuthentication.SignOut();
        Response.Redirect("~/Default.aspx");
    }
}//end class