<%@ Page Title="White Sun Crafts | Contact" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Contact</h1>
    <div class="contact">
        <asp:MultiView ID="mvContact" runat="server" ActiveViewIndex="0">
            <asp:View ID="vwForm" runat="server">
                <%--Form--%>
                <div class="contact-in">
                    <h3>CONTACT</h3>
                    <p>Please send us any comments or concerns you may have. We would love to hear from you!</p>
                    <br />
                    <div class=" col-md-9 contact-left">
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
                            <span>Subject</span>
                            <asp:TextBox ID="tbSubject" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSubject" ControlToValidate="tbSubject" runat="server" ErrorMessage="*Subject required" CssClass="emphasize" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div>
                            <span>Message</span>
                            <asp:TextBox ID="tbMessage" TextMode="MultiLine" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMessage" ControlToValidate="tbMessage" runat="server" ErrorMessage="*Message required" CssClass="emphasize" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div>
                            <span>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></span>
                        </div>
                    </div>

                    <div class=" col-md-3 contact-right">
                        <h5>Company Information</h5>
                        <p><strong>White Sun Crafts</strong></p>
                        <p>Phone: +1 (816) 392 4887</p>
                        <p>Email: <a href="mailto:whitesuncrafts@anigrams.org">whitesuncrafts@anigrams.org</a></p>
                        <p>Follow on <a href="https://www.facebook.com/whitesuncrafts/">Facebook</a></p>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </asp:View>

            <asp:View ID="vwConfirmation" runat="server">
                <%--Confirmation--%>
                <div class="contact-in">
                    <h3>THANK YOU</h3>
                    <p>Your message has been sent!</p>
                    <br />
                    <p>
                        <asp:Button ID="btnReturn" runat="server" Text="Return" CssClass="btn btn-default" OnClick="btnReturn_Click" />
                    </p>
                </div>
            </asp:View>
        </asp:MultiView>

    </div>
</asp:Content>

