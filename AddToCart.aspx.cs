using EF;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddToCart : System.Web.UI.Page
{
    WGEntities ctx = new WGEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        string rawId = Request.QueryString["id"];
        int productId;
        if (!string.IsNullOrEmpty(rawId) && int.TryParse(rawId, out productId))
        {
            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                usersShoppingCart.AddToCart(Convert.ToInt16(rawId));
            }

        }
        else
        {
            Debug.Fail("ERROR : We should never get to AddToCart.aspx without a ProductId.");
            throw new Exception("ERROR : It is illegal to load AddToCart.aspx without setting a ProductId.");
        }

        Response.Redirect("ShoppingCart.aspx");
    }
}