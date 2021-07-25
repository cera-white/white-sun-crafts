using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Login1_LoggedIn(object sender, EventArgs e)
    {
        string username = Login1.UserName;

        ShoppingCartActions usersShoppingCart = new ShoppingCartActions();
        string cartId = usersShoppingCart.GetCartId();
        usersShoppingCart.MigrateCart(cartId, username);
    }
}