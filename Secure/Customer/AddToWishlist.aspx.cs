using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Customer_AddToWishlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string rawId = Request.QueryString["id"];
        int prodID;
        if (!string.IsNullOrEmpty(rawId) && int.TryParse(rawId, out prodID))
        {
            if (Request.IsAuthenticated)
            {
                //get the UserId of the current user
                MembershipUser currentUser = Membership.GetUser();
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

                //get the selected product ID
                prodID = int.Parse(rawId);

                string connectionString = ConfigurationManager.ConnectionStrings["WGConnectionString"].ConnectionString;
                string insertSql = "INSERT INTO WGUserWishlist VALUES (@UserId, @WGProductID, @DateAdded)";

                int userCount = CheckProductInWishlist();

                if (userCount == 0)
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand(insertSql, conn);
                        cmd.Parameters.AddWithValue("@UserId", currentUserId);
                        cmd.Parameters.AddWithValue("@WGProductID", prodID);
                        cmd.Parameters.AddWithValue("@DateAdded", DateTime.Now);

                        cmd.ExecuteNonQuery();

                        conn.Close();
                    }//end using
                }
            }//end if authenticated

            Response.Redirect("Wishlist.aspx");
        }
        else
        {
            Debug.Fail("ERROR : We should never get to AddToWishlist.aspx without a ProductId.");
            throw new Exception("ERROR : It is illegal to load AddToWishlist.aspx without setting a ProductId.");
        }
    }

    protected int CheckProductInWishlist()
    {
        if (Request.IsAuthenticated)
        {
            //get the UserId of the current user
            MembershipUser currentUser = Membership.GetUser();
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            //get the selected product ID
            int prodID = int.Parse(Request.QueryString["id"]);

            string connectionString = ConfigurationManager.ConnectionStrings["WGConnectionString"].ConnectionString;
            string selectSql = "SELECT COUNT(*) FROM WGUserWishlist WHERE UserId = @UserId AND WGProductID = @WGProductID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                SqlCommand cmd_check = new SqlCommand(selectSql, conn);
                cmd_check.Parameters.AddWithValue("@UserId", currentUserId);
                cmd_check.Parameters.AddWithValue("@WGProductID", prodID);
                int userCount = (int)cmd_check.ExecuteScalar();

                return userCount;
            }
        }
        else
        {
            return 0;
        }
    }
}//end class