using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Admin_ManageUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        mvUsers.SetActiveView(vwMaster);
        fvSelectedUser.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void gvUsers_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvUsers.SetActiveView(vwDetails);
        fvSelectedUser.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void dsSelectedUser_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        mvUsers.SetActiveView(vwMaster);
        gvUsers.DataBind();
    }
}