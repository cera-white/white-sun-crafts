<%@ Page Title="White Sun Crafts | Payment Success" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PaymentSuccess.aspx.cs" Inherits="PaymentSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Payment Success</h1>
    <div class="contact-in">
        <h3>THANK YOU</h3>
        <p>Your payment has been received and a receipt for your purchase has been emailed to you.</p>
        <br />
        <p>
            <asp:Button ID="btnReturn" runat="server" Text="Continue Shopping" CssClass="btn btn-default" PostBackUrl="~/Default.aspx" />
        </p>
    </div>
</asp:Content>

