using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //switch active view to Confirmation
        mvContact.SetActiveView(vwConfirmation);

        //send email
        string body = string.Format("You have been sent an e-mail from {0} regarding White Sun Crafts. Here are their comments: <blockquote>{1}</blockquote>",
            tbName.Text, tbMessage.Text);

        MailMessage msg = new MailMessage(
            "whitesuncrafts@anigrams.org",
            "white.ca12@gmail.com",
            "White Sun Crafts - " + tbSubject.Text,
            body);

        msg.CC.Add("whitelgdst@gmail.com");
        msg.IsBodyHtml = true;
        msg.ReplyToList.Add(tbEmail.Text);

        SmtpClient client = new SmtpClient("mail.anigrams.org", 26)
        {
            Credentials = new NetworkCredential("whitesuncrafts@anigrams.org", "rIc41j6@")
        };

        client.Send(msg);
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        //switch active view
        mvContact.SetActiveView(vwForm);

        //clear out fields
        tbName.Text = "";
        tbEmail.Text = "";
        tbSubject.Text = "";
        tbMessage.Text = "";
    }
}