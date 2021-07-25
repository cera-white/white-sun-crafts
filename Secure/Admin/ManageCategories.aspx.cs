using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Admin_ManageCategories : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        mvCategories.SetActiveView(vwDetails);
        fvSelectedCategory.ChangeMode(FormViewMode.Insert);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        mvCategories.SetActiveView(vwMaster);
        fvSelectedCategory.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void InsertCancelButton_Click(object sender, EventArgs e)
    {
        mvCategories.SetActiveView(vwMaster);
        fvSelectedCategory.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void gvCategories_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvCategories.SetActiveView(vwDetails);
        fvSelectedCategory.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void dsSelectedCategory_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        mvCategories.SetActiveView(vwMaster);
        fvSelectedCategory.ChangeMode(FormViewMode.ReadOnly);
    }
}