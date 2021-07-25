using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void HighlightNav(string ctrlName)
    {
        //only first time the page loads
        if (!Page.IsPostBack)
        {
            //add the class selected to highlight the navigation link that corresponds with the page (or the header of the ddl nav)
            HtmlControl ctrl = (HtmlControl)FindControl(ctrlName);

            if (ctrl != null)
            {
                ctrl.Attributes["class"] = "active";
            }//end if

            //as long as you have a class called active defined in your css, this should work
            //you will need to double check to make sure WHERE it is applied (either the a tag or the li) and apply the runat server and id appropriately
        }//end if page is postback
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Products.aspx?search=" + tbSearch.Text);
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
        {
            lblCartCount.Text = usersShoppingCart.GetCount().ToString();
        }
    }

    protected void loginMaster_LoggedIn(object sender, EventArgs e)
    {
        string username = loginMaster.UserName;

        ShoppingCartActions usersShoppingCart = new ShoppingCartActions();
        string cartId = usersShoppingCart.GetCartId();
        usersShoppingCart.MigrateCart(cartId, username);
    }
}
