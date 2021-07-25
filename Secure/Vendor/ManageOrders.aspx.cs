using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Vendor_ManageOrders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.User.IsInRole("Admin"))
        {
            gvOrders.DataSourceID = dsAllOrders.ID;
        }
        else
        {
            gvOrders.DataSourceID = dsVendorOrders.ID;
        }
    }

    protected void dsVendorOrders_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        int vendorID;

        string connectionString = ConfigurationManager.ConnectionStrings["WGConnectionString"].ConnectionString;
        string selectSql = "SELECT [WGVendorID] from WGVendors WHERE [UserId] = @UserId";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(selectSql, conn);
            cmd.Parameters.AddWithValue("@UserId", currentUserId);
            vendorID = (int)cmd.ExecuteScalar();
        }

        e.Command.Parameters["@WGVendorID"].Value = vendorID;
    }

    protected void Label1_PreRender(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)((Label)sender).Parent.FindControl("CheckBox1");

        if (!cb.Checked)
        {
            ((Label)sender).Text = "N/A";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        mvOrders.SetActiveView(vwMaster);
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        mvOrders.SetActiveView(vwEdit);
        fvShipping.ChangeMode(FormViewMode.Edit);
    }

    protected void gvOrders_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvOrders.SetActiveView(vwDetails);
    }

    protected void UpdateCancelButton_Click(object sender, EventArgs e)
    {
        mvOrders.SetActiveView(vwDetails);
        fvShipping.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void fvShipping_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvOrders.DataBind();
    }
}