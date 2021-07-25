using EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Secure_Customer_Wishlist : System.Web.UI.Page
{
    WGEntities ctx = new WGEntities();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void dsWishlist_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        e.Command.Parameters["@UserId"].Value = currentUserId;
    }

    protected void cbShowInactive_CheckedChanged(object sender, EventArgs e)
    {
        if (cbShowInactive.Checked)
        {
            lvInactiveWishlist.Visible = true;
        }
        else
        {
            lvInactiveWishlist.Visible = false;
        }
    }
}