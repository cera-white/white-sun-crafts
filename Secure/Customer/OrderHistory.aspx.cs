using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Customer_OrderHistory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void dsOrders_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        string username = currentUser.UserName;

        e.Command.Parameters["@Username"].Value = username;
    }

    protected void Label1_PreRender(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)((Label)sender).Parent.FindControl("CheckBox1");

        if (!cb.Checked)
        {
            ((Label)sender).Text = "N/A";
        }
    }

    protected void gvOrders_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvOrderHistory.SetActiveView(vwOrderDetails);
        lblOrderNo.Text = "Item List for Order #" + gvOrders.SelectedValue.ToString();
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        mvOrderHistory.SetActiveView(vwOrders);
    }
}