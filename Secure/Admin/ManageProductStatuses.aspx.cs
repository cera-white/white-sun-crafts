using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Admin_ManageProductStatuses : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        mvStatuses.SetActiveView(vwDetails);
        fvSelectedStatus.ChangeMode(FormViewMode.Insert);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        mvStatuses.SetActiveView(vwMaster);
        fvSelectedStatus.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void InsertCancelButton_Click(object sender, EventArgs e)
    {
        mvStatuses.SetActiveView(vwMaster);
        fvSelectedStatus.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void gvStatuses_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvStatuses.SetActiveView(vwDetails);
        fvSelectedStatus.ChangeMode(FormViewMode.ReadOnly);
    }
}