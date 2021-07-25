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

public partial class RemoveWishlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string rawId = Request.QueryString["id"];
        int prodID;
        if (!string.IsNullOrEmpty(rawId) && int.TryParse(rawId, out prodID))
        {
            //get the UserId of the current user
            MembershipUser currentUser = Membership.GetUser();
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            string connectionString = ConfigurationManager.ConnectionStrings["WGConnectionString"].ConnectionString;
            string deleteSql = "DELETE FROM WGUserWishlist WHERE (UserId = @UserId) AND (WGProductID = @WGProductID)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(deleteSql, conn);
                cmd.Parameters.AddWithValue("@UserId", currentUserId);
                cmd.Parameters.AddWithValue("@WGProductID", prodID);

                cmd.ExecuteNonQuery();

                conn.Close();
            }//end using

            if (Request.QueryString["action"] == "move")
            {
                Response.Redirect("../../AddToCart.aspx?id=" + prodID);
            }

            Response.Redirect("Wishlist.aspx");
        }
        else
        {
            Debug.Fail("ERROR : We should never get to RemoveWishlist.aspx without a ProductId.");
            throw new Exception("ERROR : It is illegal to load RemoveWishlist.aspx without setting a ProductId.");
        }

    }
}