using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class About : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            mvAbout.SetActiveView(vwDetails);
        }
        else
        {
            mvAbout.SetActiveView(vwMaster);
        }
    }

    protected void lvProductsByVendor_DataBound(object sender, EventArgs e)
    {
        ListView lvProductsByVendor = (ListView)fvSelectedVendor.FindControl("lvProductsByVendor");
        DataPager dpProductsByVendor = (DataPager)fvSelectedVendor.FindControl("dpProductsByVendor");
        Label lblShowingResults = (Label)fvSelectedVendor.FindControl("lblShowingResults");

        if (dpProductsByVendor.TotalRowCount < 6)
        {
            dpProductsByVendor.Visible = false;
        }
        else
        {
            dpProductsByVendor.Visible = true;
        }

        if (dpProductsByVendor.TotalRowCount < 1)
        {
            lblShowingResults.Visible = false;
        }
        else
        {
            int currentRows = lvProductsByVendor.Items.Count;

            lblShowingResults.Text = string.Format("Showing {0}-{1} of {2} results",
                dpProductsByVendor.StartRowIndex + 1,
                dpProductsByVendor.StartRowIndex + currentRows,
                dpProductsByVendor.TotalRowCount);
        }
    }
}