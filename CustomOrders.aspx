<%@ Page Title="White Sun Crafts | Custom Orders" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CustomOrders.aspx.cs" Inherits="CustomOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Custom Orders</h1>
    <asp:MultiView ID="mvCustomOrders" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <div class="article-top">
                <h3>CUSTOM ORDERS</h3>
                <div class="article-bottom">
                    <div class="col-md-8 article-head" style="margin-left: -13px">
                        <h6><a href="#">Request your own piece of unique, handcrafted jewelry, made to your specifications!</a></h6>
                        <p>Did you see something you like but it's sold out, or maybe it's the wrong color or size? Or maybe you would like a different pendant or clasp. Now you can request a custom jewelry order! All you have to do is fill out the form below.</p>
                        <p>In the <strong>Details</strong> section of the form, please provide information such as material(s) you want used, color(s), measurements and/or size, any themes or symbols you would like included, and any budget or time restrictions you may have. It would also be helpful to provide references of something similar to what you would like made, either by pointing to a similar item on this site or by linking to an image on some external site.</p>
                        <p>Once you've sent your request, we will look it over and send an estimate back to you. Please make sure you enter the correct email address so we can reach you!</p>
                        <br />
                        <div class="contact-left">
                            <div>
                                <span>Name</span>
                                <asp:TextBox ID="tbName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="tbName" runat="server" ErrorMessage="*Name required" CssClass="emphasize" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div>
                                <span>Email</span>
                                <asp:TextBox ID="tbEmail" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="tbEmail" runat="server" ErrorMessage="*Email address required" CssClass="emphasize" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revEmail" ControlToValidate="tbEmail" runat="server" ErrorMessage="*Must be a valid email (you@example.com)" CssClass="emphasize" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                            <div>
                                <span>Commission Details</span>
                                <asp:TextBox ID="tbMessage" TextMode="MultiLine" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMessage" ControlToValidate="tbMessage" runat="server" ErrorMessage="*Message required" CssClass="emphasize" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div>
                                <span>
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 article-para">
                        <a href="#">
                            <img src="~/images/hands.jpg" alt="Rings" class="img-responsive zoom-img" runat="server">
                        </a>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </asp:View>

        <asp:View ID="vwDetails" runat="server">
            <%--Confirmation--%>
            <div class="contact-in">
                <h3>THANK YOU</h3>
                <p>Your message has been sent! We'll reply with an estimate as soon as we can.</p>
                <br />
                <p>
                    <asp:Button ID="btnReturn" runat="server" Text="Return" CssClass="btn btn-default" OnClick="btnReturn_Click" />
                </p>
            </div>
        </asp:View>
    </asp:MultiView>
</asp:Content>

