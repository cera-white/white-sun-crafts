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

public partial class Secure_Vendor_ManageVendors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void dsSelectedVendor_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        if (Page.User.IsInRole("Admin"))
        {
            DropDownList ddlUsername = (DropDownList)fvSelectedVendor.FindControl("ddlUsername");

            e.Command.Parameters["@UserId"].Value = Guid.Parse(ddlUsername.SelectedValue);
        }
        else
        {
            e.Command.Parameters["@UserId"].Value = currentUserId;
        }

        FileUpload fupload = (FileUpload)fvSelectedVendor.FindControl("fuploadProfilePicture");

        string imageName = "noimage.jpg";

        if (fupload.HasFile)
        {
            imageName = fupload.FileName;
            string ext = imageName.Substring(imageName.LastIndexOf('.'));
            imageName = Guid.NewGuid() + ext;
            fupload.SaveAs(Server.MapPath("~/images/vendors/" + imageName));
        }

        e.Command.Parameters["@Image"].Value = imageName;
    }

    protected void dsSelectedVendor_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        if (Page.User.IsInRole("Admin"))
        {
            DropDownList ddlUsername = (DropDownList)fvSelectedVendor.FindControl("ddlUsername");

            e.Command.Parameters["@UserId"].Value = Guid.Parse(ddlUsername.SelectedValue);
        }
        else
        {
            e.Command.Parameters["@UserId"].Value = currentUserId;
        }

        FileUpload fupload = (FileUpload)fvSelectedVendor.FindControl("fuploadProfilePicture");

        if (fupload.HasFile)
        {
            string imageName = fupload.FileName;
            string ext = imageName.Substring(imageName.LastIndexOf('.'));
            imageName = Guid.NewGuid() + ext;
            fupload.SaveAs(Server.MapPath("~/images/vendors/" + imageName));

            e.Command.Parameters["@Image"].Value = imageName;
        }//end if
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        mvVendors.SetActiveView(vwDetails);
        fvSelectedVendor.ChangeMode(FormViewMode.Insert);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        mvVendors.SetActiveView(vwMaster);
        fvSelectedVendor.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void gvVendors_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvVendors.SetActiveView(vwDetails);
        fvSelectedVendor.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void dsSelectedVendor_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        mvVendors.SetActiveView(vwMaster);
        gvVendors.DataBind();
    }

    protected void dsSelectedVendor_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        mvVendors.SetActiveView(vwMaster);
        gvVendors.DataBind();
    }

    protected void EditButton_PreRender(object sender, EventArgs e)
    {
        Button EditButton = (Button)fvSelectedVendor.FindControl("EditButton");

        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        Guid? userID;

        //if currentUserId matches selected vendor UserId, show button - else hide

        int vendorId = (int)gvVendors.SelectedValue;
        string connectionString = ConfigurationManager.ConnectionStrings["WGConnectionString"].ConnectionString;
        string selectSql = "SELECT [UserId] FROM WGVendors WHERE [WGVendorID] = @WGVendorID";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(selectSql, conn);
            cmd.Parameters.AddWithValue("@WGVendorID", vendorId);
            var result = cmd.ExecuteScalar();

            if (result != DBNull.Value)
            {
                userID = (Guid)result;
            }
            else
            {
                userID = null;
            }
        }

        if (userID == currentUserId)
        {
            EditButton.Visible = true;
        }
        else
        {
            EditButton.Visible = false;
        }
    }

    protected void InsertCancelButton_Click(object sender, EventArgs e)
    {
        mvVendors.SetActiveView(vwMaster);
        fvSelectedVendor.ChangeMode(FormViewMode.ReadOnly);
    }
}