using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ((MasterPage)Master).HighlightNav("liHome");
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
}//end class