using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EF;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class PaymentSuccess : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        WGEntities dc = new WGEntities();
        ShoppingCartActions userShoppingCart = new ShoppingCartActions();
        List<WGCartItem> cartItems = userShoppingCart.GetCartItems();
        string firstName = "";
        string lastName = "";
        string address = "";
        string city = "";
        string region = "";
        string postalCode = "";
        string country = "";

        //if user is logged in
        string username = Membership.GetUser().UserName;
        string email = Membership.GetUser().Email;
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
        string selectSql = "SELECT [FirstName],[LastName],[Address],[City],[PostalCode],Countries.[CountryName],[Region] FROM [WGCustomers] JOIN [Countries] on WGCustomers.Country = Countries.CountryID WHERE UserId = @UserId";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(selectSql, conn);
            cmd.Parameters.AddWithValue("@UserId", currentUserId);
            SqlDataReader rdr = cmd.ExecuteReader();

            while (rdr.Read())
            {
                firstName = (string)rdr["FirstName"];
                lastName = (string)rdr["LastName"];
                address = (string)rdr["Address"];
                city = (string)rdr["City"];
                region = (string)rdr["Region"];
                postalCode = (string)rdr["PostalCode"];
                country = (string)rdr["CountryName"];

                WGOrder order = new WGOrder
                {
                    Username = username,
                    OrderDate = DateTime.Now,
                    Email = email,
                    FirstName = firstName,
                    LastName = lastName,
                    ShipAddress = address,
                    ShipCity = city,
                    ShipRegion = region,
                    ShipPostalCode = postalCode,
                    ShipCountry = country,
                    HasBeenShipped = false,
                    ShippedDate = null
                };
                dc.WGOrders.Add(order);
                dc.SaveChanges();

                foreach (var item in cartItems)
                {
                    WGOrderDetail orderDetail = new WGOrderDetail
                    {
                        WGOrderID = order.WGOrderID,
                        WGProductID = item.WGProductID,
                        Price = item.WGProduct.Price,
                        Quantity = item.Quantity,
                        Username = username
                    };

                    dc.WGOrderDetails.Add(orderDetail);
                    dc.SaveChanges();

                    //update product quantity
                    //1. get product from DB
                    WGProduct prod = dc.WGProducts.Where(p => p.WGProductID == item.WGProductID).FirstOrDefault();

                    if (prod != null)
                    {
                        prod.QtyAvailable -= item.Quantity;
                    }

                    if (prod.QtyAvailable < 1)
                    {
                        prod.WGProductStatusID = 2;
                    }

                    dc.Entry(prod).State = System.Data.Entity.EntityState.Modified;
                    dc.SaveChanges();
                }//end foreach
            }//end while Read()

            rdr.Close();
        }//end using

        userShoppingCart.EmptyCart();
    }
}//end class