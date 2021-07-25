using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using EF;
using System.Web.UI.HtmlControls;

public partial class Products : System.Web.UI.Page
{

    //Create the datacontext (to reach the EF layer)
    WGEntities ctx = new WGEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            mvProducts.SetActiveView(vwDetails);
        }
        else
        {
            mvProducts.SetActiveView(vwMaster);

            //set page navigation based on category
            if (Request.QueryString["cat"] == "1")
            {
                ((MasterPage)Master).HighlightNav("liNecklaces");
                lblHeader.Text = "NECKLACES";
            }
            else if (Request.QueryString["cat"] == "2")
            {
                ((MasterPage)Master).HighlightNav("liBracelets");
                lblHeader.Text = "BRACELETS";
            }
            else if (Request.QueryString["cat"] == "3")
            {
                ((MasterPage)Master).HighlightNav("liPendants");
                lblHeader.Text = "PENDANTS";
            }
            else if (Request.QueryString["discount"] != null)
            {
                ((MasterPage)Master).HighlightNav("liProducts");
                lblHeader.Text = "ON SALE";
            }
            else if (Request.QueryString["search"] != null)
            {
                ((MasterPage)Master).HighlightNav("liProducts");
                lblHeader.Text = "SEARCH RESULTS FOR \"" + Request.QueryString["search"].ToUpper() + "\"";
            }
            else
            {
                ((MasterPage)Master).HighlightNav("liProducts");
                lblHeader.Text = "ALL PRODUCTS";
            }

            //change datasource based on querystring
            if (Request.QueryString["cat"] != null)
            {
                lvProducts.DataSourceID = dsProductsByCategory.ID;
            }
            else if (Request.QueryString["search"] != null)
            {
                lvProducts.DataSourceID = dsProductsBySearch.ID;
            }
            else if (Request.QueryString["discount"] != null)
            {
                lvProducts.DataSourceID = dsProductsByDiscount.ID;
            }
            else
            {
                lvProducts.DataSourceID = dsAllProducts.ID;
            }
        }
    }

    protected void lvProducts_DataBound(object sender, EventArgs e)
    {
        if (dpProducts.TotalRowCount < dpProducts.MaximumRows)
        {
            dpProducts.Visible = false;
        }
        else
        {
            dpProducts.Visible = true;
        }

        if (dpProducts.TotalRowCount < 1)
        {
            lblShowingResults.Visible = false;
        }
        else
        {
            int currentRows = lvProducts.Items.Count;

            lblShowingResults.Text = string.Format("Showing {0}-{1} of {2} results",
                dpProducts.StartRowIndex + 1,
                dpProducts.StartRowIndex + currentRows,
                dpProducts.TotalRowCount);
        }
    }

    protected void btnAddToWishlist_Click(object sender, EventArgs e)
    {
        if (Request.IsAuthenticated)
        {
            //get the UserId of the current user
            MembershipUser currentUser = Membership.GetUser();
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            //get the selected product ID
            int prodID = int.Parse(Request.QueryString["id"]);

            LinkButton btnAddToWishlist = (LinkButton)fvSelectedProduct.FindControl("btnAddToWishlist");

            string connectionString = ConfigurationManager.ConnectionStrings["WGConnectionString"].ConnectionString;
            string insertSql = "INSERT INTO WGUserWishlist VALUES (@UserId, @WGProductID, @DateAdded)";
            string deleteSql = "DELETE FROM WGUserWishlist WHERE (UserId = @UserId) AND (WGProductID = @WGProductID)";

            int userCount = CheckProductInWishlist();

            if (userCount > 0)
            {
                //user/product pair already exists in database
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(deleteSql, conn);
                    cmd.Parameters.AddWithValue("@UserId", currentUserId);
                    cmd.Parameters.AddWithValue("@WGProductID", prodID);

                    cmd.ExecuteNonQuery();

                    btnAddToWishlist.Text = "Item removed from wishlist";
                    lvWishlist.DataBind();

                    conn.Close();
                }//end using
            }
            else
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(insertSql, conn);
                    cmd.Parameters.AddWithValue("@UserId", currentUserId);
                    cmd.Parameters.AddWithValue("@WGProductID", prodID);
                    cmd.Parameters.AddWithValue("@DateAdded", DateTime.Now);

                    cmd.ExecuteNonQuery();

                    btnAddToWishlist.Text = "Saved to your wishlist!";
                    lvWishlist.DataBind();

                    conn.Close();
                }//end using
            }
        }//end if authenticated
    }

    protected void btnAddToWishlist_PreRender(object sender, EventArgs e)
    {
        LinkButton btnAddToWishlist = (LinkButton)fvSelectedProduct.FindControl("btnAddToWishlist");

        int userCount = CheckProductInWishlist();

        if (userCount > 0)
        {
            //user/product pair already exists in database
            btnAddToWishlist.Text = "Remove from wishlist";
        }
        else
        {
            btnAddToWishlist.Text = "Save to wishlist";
        }
    }

    //helper method to check if product is currently in wishlist
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

    protected void dsWishlist_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        if (Request.IsAuthenticated)
        {
            //get currently logged on user's ID
            MembershipUser currentUser = Membership.GetUser();
            Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            e.Command.Parameters["@UserId"].Value = currentUserId;
        }
        else
        {
            e.Command.Parameters["@UserId"].Value = "";
        }
    }

    protected void btnPostComment_Click(object sender, EventArgs e)
    {
        TextBox tbComment = (TextBox)fvSelectedProduct.FindControl("tbComment");
        ListView lvComments = (ListView)fvSelectedProduct.FindControl("lvComments");

        if (tbComment.Text == null || tbComment.Text == "")
        {
            return;
        }
        else
        {
            if (Request.IsAuthenticated)
            {
                MembershipUser currentUser = Membership.GetUser();
                Guid currentUserId = (Guid)currentUser.ProviderUserKey;

                int prodID = int.Parse(Request.QueryString["id"]);

                string connectionString = ConfigurationManager.ConnectionStrings["WGConnectionString"].ConnectionString;
                string insertSql = "INSERT INTO WGUserComments(Comment, DatePosted, UserId, WGProductID) VALUES(@Comment, @DatePosted, @UserId, @WGProductID)";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(insertSql, conn);
                    cmd.Parameters.AddWithValue("@Comment", tbComment.Text.Trim());
                    cmd.Parameters.AddWithValue("@DatePosted", DateTime.Now);
                    cmd.Parameters.AddWithValue("@UserId", currentUserId);
                    cmd.Parameters.AddWithValue("@WGProductID", prodID);
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                lvComments.DataBind();

                tbComment.Text = string.Empty;
            }//end if authenticated
        }//end else
    }

    protected void fvSelectedProduct_PreRender(object sender, EventArgs e)
    {
        int prodID = int.Parse(Request.QueryString["id"]);
        HtmlGenericControl AddToCart = (HtmlGenericControl)fvSelectedProduct.FindControl("AddToCart");

        WGProduct prod = ctx.WGProducts.Where(p => p.WGProductID == prodID).FirstOrDefault<WGProduct>();

        if (prod.WGProductStatusID != 1 || prod.QtyAvailable < 1)
        {
            AddToCart.Visible = false;
        }
    }
}//end class