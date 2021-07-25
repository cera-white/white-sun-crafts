using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_EditProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        fvProfile.ChangeMode(FormViewMode.Edit);
    }

    protected void dsProfile_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();

        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        e.Command.Parameters["@UserId"].Value = currentUserId;
    }

    protected void dsProfile_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        FileUpload fupload = (FileUpload)fvProfile.FindControl("fuploadProfilePicture");

        string imageName = "noimage.jpg";

        if (fupload.HasFile)
        {
            imageName = fupload.FileName;
            string ext = imageName.Substring(imageName.LastIndexOf('.'));
            imageName = Guid.NewGuid() + ext;
            fupload.SaveAs(Server.MapPath("~/images/users/" + imageName));
        }

        e.Command.Parameters["@Image"].Value = imageName;
    }

    protected void dsProfile_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        FileUpload fupload = (FileUpload)fvProfile.FindControl("fuploadProfilePicture");

        if (fupload.HasFile)
        {
            string imageName = fupload.FileName;
            string ext = imageName.Substring(imageName.LastIndexOf('.'));
            imageName = Guid.NewGuid() + ext;
            fupload.SaveAs(Server.MapPath("~/images/users/" + imageName));

            e.Command.Parameters["@Image"].Value = imageName;
        }//end if
    }

    protected void fvProfile_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        Response.Redirect("~/Secure/ManageAccount.aspx");
    }
}