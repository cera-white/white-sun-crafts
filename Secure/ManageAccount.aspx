<%@ Page Title="White Sun Crafts | My Account" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageAccount.aspx.cs" Inherits="Secure_ManageAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | My Account</h1>
    <asp:FormView ID="fvCustomerAccount" runat="server" DataKeyNames="UserId" DataSourceID="dsCustomerAccount" RenderOuterTable="False">
        <EditItemTemplate>
        </EditItemTemplate>
        <InsertItemTemplate>
        </InsertItemTemplate>
        <ItemTemplate>
            <div class="article-top">
                <h3>MY ACCOUNT</h3>

                <div class="article-bottom row">
                    <div class="col-md-3 article-para">
                        <asp:Image ID="imgProfile" runat="server" ImageUrl='<%# Eval("Image", "~/images/users/{0}") %>' CssClass="img-responsive zoom-img" />
                        <p>
                            <asp:Label ID="lblMemberSince" runat="server" Text='<%# Eval("CreateDate", "Member since {0:d}") %>'></asp:Label>
                        </p>
                        <p>
                            <asp:LinkButton ID="btnEditProfile" runat="server" PostBackUrl="~/Secure/EditProfile.aspx">Edit Profile</asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton ID="btnChangeEmail" runat="server" PostBackUrl="~/Secure/ChangeEmail.aspx">Change Email Address</asp:LinkButton>
                        </p>
                    </div>

                    <div class="col-md-9 article-para">
                        <div class="account-section">
                            <h4>Identity</h4>
                            <table>
                                <tr>
                                    <td>Name:</td>
                                    <td>
                                        <asp:Label ID="lblName" runat="server" Text='<%# Bind("FullName") %>' /></td>
                                </tr>
                                <tr>
                                    <td>Username:</td>
                                    <td>
                                        <asp:Label ID="lblUsername" runat="server" Text='<%# Bind("UserName") %>' /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="btnChangePassword" runat="server" PostBackUrl="~/Secure/ChangePassword.aspx">Change Password</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="account-section">
                            <h4>Contact</h4>
                            <table>
                                <tr>
                                    <td>Email:</td>
                                    <td>
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("Email") %>' /></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:CheckBox ID="cbSubscribed" runat="server" Checked='<%# Eval("Subscribed") %>' Enabled="false" Text="&nbsp;Receive notifications about new offers and products" />
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Primary Address:</td>
                                    <td>
                                        <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("Address") %>' />
                                        <br />
                                        <asp:Label ID="lblCity" runat="server" Text='<%# Bind("City") %>' />,
                                        <asp:Label ID="lblRegion" runat="server" Text='<%# Bind("Region") %>' />
                                        <asp:Label ID="lblZip" runat="server" Text='<%# Bind("PostalCode") %>' />
                                        <br />
                                        <asp:Label ID="lblCountry" runat="server" Text='<%# Bind("CountryName") %>' /></td>
                                </tr>
                            </table>

                        </div>
                        <div class="account-section">
                            <h4>User Controls</h4>
                            <table>
                                <%if (Page.User.IsInRole("Customer") || Page.User.IsInRole("Vendor") || Page.User.IsInRole("Admin"))
                                { %>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnOrderHistory" runat="server" Text="View Order History" CssClass="btn btn-default" PostBackUrl="~/Secure/Customer/OrderHistory.aspx" />

                                    </td>
                                    <td>
                                        <asp:Button ID="btnWishlist" runat="server" Text="Manage Wishlist" CssClass="btn btn-default" PostBackUrl="~/Secure/Customer/Wishlist.aspx" />
                                    </td>
                                </tr>
                                <%} %>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="btnDeleteAccount" runat="server" CausesValidation="False" Text="Delete Account" OnClientClick="return confirm('Are you sure you want to permanently DELETE your account? You will lose all saved information and order history.')" OnClick="btnDeleteAccount_Click"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </ItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="dsCustomerAccount" runat="server" ConnectionString='<%$ ConnectionStrings:LocalSqlServer %>' SelectCommand="SELECT WGCustomers.FirstName, WGCustomers.LastName, WGCustomers.FirstName + ' ' + WGCustomers.LastName AS FullName, WGCustomers.Address, WGCustomers.City, WGCustomers.PostalCode, WGCustomers.Country, WGCustomers.Image, WGCustomers.UserId, WGCustomers.Region, aspnet_Membership.Email, aspnet_Membership.CreateDate, aspnet_Users.UserName, WGCustomers.Subscribed, Countries.CountryID, Countries.CountryName FROM WGCustomers INNER JOIN aspnet_Membership ON WGCustomers.UserId = aspnet_Membership.UserId INNER JOIN aspnet_Users ON WGCustomers.UserId = aspnet_Users.UserId AND aspnet_Membership.UserId = aspnet_Users.UserId INNER JOIN Countries ON WGCustomers.Country = Countries.CountryID WHERE (WGCustomers.UserId = @UserId)" OnSelecting="dsCustomerAccount_Selecting">
        <SelectParameters>
            <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
    <br />
</asp:Content>

