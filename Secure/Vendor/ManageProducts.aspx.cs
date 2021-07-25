using EF;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Vendor_ManageProducts : System.Web.UI.Page
{
    WGEntities ctx = new WGEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void dsVendorProducts_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
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

    protected void gvProducts_PreRender(object sender, EventArgs e)
    {
        if (Page.User.IsInRole("Admin"))
        {
            gvProducts.DataSourceID = dsAllProducts.ID;
            gvProducts.DataBind();
        }
        else
        {
            gvProducts.DataSourceID = dsVendorProducts.ID;
            gvProducts.DataBind();
        }
    }

    protected void gvProducts_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvProducts.SetActiveView(vwDetails);
        fvSelectedProduct.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        mvProducts.SetActiveView(vwDetails);
        fvSelectedProduct.ChangeMode(FormViewMode.Insert);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        mvProducts.SetActiveView(vwMaster);
        fvSelectedProduct.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void dsSelectedProduct_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        FileUpload fupload1 = (FileUpload)fvSelectedProduct.FindControl("fupImage1");
        FileUpload fupload1Thumb = (FileUpload)fvSelectedProduct.FindControl("fupImage1Thumb");
        FileUpload fupload2 = (FileUpload)fvSelectedProduct.FindControl("fupImage2");
        FileUpload fupload2Thumb = (FileUpload)fvSelectedProduct.FindControl("fupImage2Thumb");

        string image1, image1thumb, image2, image2thumb;
        string defaultImage = "noimage.jpg";

        if (fupload1.HasFile)
        {
            image1 = fupload1.FileName;
            string ext = image1.Substring(image1.LastIndexOf('.'));
            image1 = Guid.NewGuid() + ext;
            fupload1.SaveAs(Server.MapPath("~/images/products/" + image1));
            e.Command.Parameters["@Image"].Value = image1;
        }
        else
        {
            e.Command.Parameters["@Image"].Value = defaultImage;
        }

        if (fupload1Thumb.HasFile)
        {
            image1thumb = fupload1Thumb.FileName;
            string ext = image1thumb.Substring(image1thumb.LastIndexOf('.'));
            image1thumb = Guid.NewGuid() + ext;
            fupload1Thumb.SaveAs(Server.MapPath("~/images/products/" + image1thumb));
            e.Command.Parameters["@Thumbnail"].Value = image1thumb;
        }
        else
        {
            e.Command.Parameters["@Thumbnail"].Value = defaultImage;
        }

        if (fupload2.HasFile)
        {
            image2 = fupload2.FileName;
            string ext = image2.Substring(image2.LastIndexOf('.'));
            image2 = Guid.NewGuid() + ext;
            fupload2.SaveAs(Server.MapPath("~/images/products/" + image2));
            e.Command.Parameters["@Image2"].Value = image2;
        }
        else
        {
            e.Command.Parameters["@Image2"].Value = defaultImage;
        }

        if (fupload2Thumb.HasFile)
        {
            image2thumb = fupload2Thumb.FileName;
            string ext = image2thumb.Substring(image2thumb.LastIndexOf('.'));
            image2thumb = Guid.NewGuid() + ext;
            fupload2Thumb.SaveAs(Server.MapPath("~/images/products/" + image2thumb));
            e.Command.Parameters["@Thumbnail2"].Value = image2thumb;
        }
        else
        {
            e.Command.Parameters["@Thumbnail2"].Value = defaultImage;
        }

        //no matter what, update LastUpdated
        e.Command.Parameters["@LastUpdated"].Value = DateTime.Now;
    }

    protected void dsSelectedProduct_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        FileUpload fupload1 = (FileUpload)fvSelectedProduct.FindControl("fupImage1");
        FileUpload fupload1Thumb = (FileUpload)fvSelectedProduct.FindControl("fupImage1Thumb");
        FileUpload fupload2 = (FileUpload)fvSelectedProduct.FindControl("fupImage2");
        FileUpload fupload2Thumb = (FileUpload)fvSelectedProduct.FindControl("fupImage2Thumb");

        string image1, image1thumb, image2, image2thumb;

        if (fupload1.HasFile)
        {
            image1 = fupload1.FileName;
            string ext = image1.Substring(image1.LastIndexOf('.'));
            image1 = Guid.NewGuid() + ext;
            fupload1.SaveAs(Server.MapPath("~/images/products/" + image1));
            e.Command.Parameters["@Image"].Value = image1;
        }

        if (fupload1Thumb.HasFile)
        {
            image1thumb = fupload1Thumb.FileName;
            string ext = image1thumb.Substring(image1thumb.LastIndexOf('.'));
            image1thumb = Guid.NewGuid() + ext;
            fupload1Thumb.SaveAs(Server.MapPath("~/images/products/" + image1thumb));
            e.Command.Parameters["@Thumbnail"].Value = image1thumb;
        }

        if (fupload2.HasFile)
        {
            image2 = fupload2.FileName;
            string ext = image2.Substring(image2.LastIndexOf('.'));
            image2 = Guid.NewGuid() + ext;
            fupload2.SaveAs(Server.MapPath("~/images/products/" + image2));
            e.Command.Parameters["@Image2"].Value = image2;
        }

        if (fupload2Thumb.HasFile)
        {
            image2thumb = fupload2Thumb.FileName;
            string ext = image2thumb.Substring(image2thumb.LastIndexOf('.'));
            image2thumb = Guid.NewGuid() + ext;
            fupload2Thumb.SaveAs(Server.MapPath("~/images/products/" + image2thumb));
            e.Command.Parameters["@Thumbnail2"].Value = image2thumb;
        }

        //no matter what, update LastUpdated
        e.Command.Parameters["@LastUpdated"].Value = DateTime.Now;
    }

    protected void InsertCancelButton_Click(object sender, EventArgs e)
    {
        mvProducts.SetActiveView(vwMaster);
        fvSelectedProduct.ChangeMode(FormViewMode.ReadOnly);
    }

    protected void dsSelectedProduct_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        CheckBox cbNotification = (CheckBox)fvSelectedProduct.FindControl("cbNotification");

        //get new product just added
        int newProductID = (int)e.Command.Parameters["@NewProductID"].Value;
        WGProduct prod = ctx.WGProducts.Where(p => p.WGProductID == newProductID).FirstOrDefault();

        string imageName = prod.Thumbnail;
        string productName = prod.Name;
        string productDescription = prod.Description;

        if (cbNotification.Checked)
        {
            string body = string.Format("<img src='http://whitesuncrafts.anigrams.org/images/products/{0}' alt='{1}' style='float: left; width:20%' /><div style=\"width: 75%; margin: 10px; margin-top: 0; padding: 10px; padding-top: 0; float: left; border: 1px solid lightgray; font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif\">" +
            "<h1>A new product has been added to White Sun Crafts!</h1><p>We just added a cool new <a href = 'http://whitesuncrafts.anigrams.org/Products.aspx?id={2}' target='_blank'>{1}</a> to the line-up.</p>" +
            "<blockquote style='padding: 10px; background-color: lightgray'>{3}</blockquote><p> Come check out the new stuff!</p></div><br style = 'clear: both' /><br />" +
            "<p style='margin: 10px; font-size: 0.8em'> You received this e-mail because you're signed up to receive offers and notifications from <a href='http://whitesuncrafts.anigrams.org'>White Sun Crafts.</a> If you no longer wish to receive these notifications, please <a href = 'http://whitesuncrafts.anigrams.org/Secure/EditProfile.aspx'> update your settings</a> or reply with 'UNSUBSCRIBE' to this message.</p>",
            imageName, productName, newProductID, productDescription);

            List<string> mailTo = new List<string>();

            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("whitesuncrafts@anigrams.org");
            msg.Subject = "New Product at White Sun Crafts";
            msg.Body = body;
            msg.IsBodyHtml = true;

            SmtpClient client = new SmtpClient("mail.anigrams.org", 26)
            {
                Credentials = new NetworkCredential("whitesuncrafts@anigrams.org", "rIc41j6@")
            };

            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            string selectSql = "SELECT Email FROM aspnet_Membership JOIN WGCustomers on aspnet_Membership.UserId = WGCustomers.UserId WHERE Subscribed = 1";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(selectSql, conn);
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    mailTo.Add(Convert.ToString(rdr["Email"]));
                }

                foreach (string address in mailTo)
                {
                    msg.To.Add(new MailAddress(address));
                    client.Send(msg);
                    msg.To.Clear();
                }

                rdr.Close();
            }

        }//end if checked

        mvProducts.SetActiveView(vwMaster);
        fvSelectedProduct.ChangeMode(FormViewMode.ReadOnly);
    }
}