using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_ChangeEmail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        fvChangeEmail.ChangeMode(FormViewMode.Edit);
    }

    protected void fvChangeEmail_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        Response.Redirect("~/Secure/ManageAccount.aspx");
    }
}