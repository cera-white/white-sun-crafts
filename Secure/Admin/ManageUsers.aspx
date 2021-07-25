<%@ Page Title="White Sun Crafts | Manage: Users" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="Secure_Admin_ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Manage: Users</h1>
    <div class="para-an">
        <h3>Manage Users</h3>
        <p>Use this panel to edit user information.</p>
    </div>

    <asp:MultiView ID="mvUsers" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <!--Master-->
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" DataKeyNames="UserId" DataSourceID="dsUsers" GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered" OnSelectedIndexChanged="gvUsers_SelectedIndexChanged">
                <Columns>
                    <asp:TemplateField HeaderText="Username" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Eval("UserName") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="RoleName" HeaderText="Role" SortExpression="RoleName" />
                    <asp:CheckBoxField DataField="Subscribed" HeaderText="Subscribed" SortExpression="Subscribed" />
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" SelectCommand="SELECT t1.UserId, UserName, Email, RoleName, Subscribed FROM aspnet_Users as t1 JOIN aspnet_Membership as t2 on t1.UserId = t2.UserId JOIN aspnet_UsersInRoles as t3 on t1.UserId = t3.UserId JOIN aspnet_Roles as t4 on t3.RoleId = t4.RoleId JOIN WGCustomers as t5 on t1.UserId = t5.UserId"></asp:SqlDataSource>
        </asp:View>

        <asp:View ID="vwDetails" runat="server">
            <!--Details-->
            <asp:FormView ID="fvSelectedUser" runat="server" DataKeyNames="UserId" DataSourceID="dsSelectedUser" EnableViewState="false">
                <EditItemTemplate>
                    <table>
                        <tr>
                            <td>Username:</td>
                            <td>
                                <asp:Label ID="UserNameLabel" runat="server" Text='<%# Bind("UserName") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td>
                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Role:</td>
                            <td>
                                <asp:DropDownList ID="ddlRoles" runat="server" DataSourceID="dsRoles" DataTextField="RoleName" DataValueField="RoleId" SelectedValue='<%# Bind("RoleId") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="dsRoles" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT RoleId, RoleName FROM dbo.aspnet_Roles"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="SubscribedCheckBox" runat="server" Checked='<%# Bind("Subscribed") %>' />
                                Subscribed to newsletter
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <table>
                        <tr>
                            <td>Username:</td>
                            <td>
                                <asp:Label ID="UserNameLabel" runat="server" Text='<%# Bind("UserName") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td>
                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Role:</td>
                            <td>
                                <asp:DropDownList ID="ddlRoles" runat="server" DataSourceID="dsRoles" DataTextField="RoleName" DataValueField="RoleId" SelectedValue='<%# Bind("RoleId") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="dsRoles" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT RoleId, RoleName FROM dbo.aspnet_Roles"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="SubscribedCheckBox" runat="server" Checked='<%# Bind("Subscribed") %>' />
                                Subscribed to newsletter
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Add" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </InsertItemTemplate>
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>Username:</td>
                            <td>
                                <asp:Label ID="UserNameLabel" runat="server" Text='<%# Bind("UserName") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td>
                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Role:</td>
                            <td>
                                <asp:Label ID="RoleNameLabel" runat="server" Text='<%# Bind("RoleName") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="SubscribedCheckBox" runat="server" Checked='<%# Bind("Subscribed") %>' Enabled="false" />
                                Subscribed to newsletter
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-default" />
                    &nbsp;<asp:Button ID="btnBack" runat="server" Text="Back to Users" CssClass="btn btn-default" OnClick="btnBack_Click" />
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="dsSelectedUser" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>"
                DeleteCommand="DELETE FROM [WGCustomers] WHERE [UserId] = @UserId"
                InsertCommand="INSERT INTO [WGCustomers] ([Subscribed], [UserId]) VALUES (@Subscribed, @UserId)"
                SelectCommand="SELECT dbo.WGCustomers.Subscribed, dbo.WGCustomers.UserId, dbo.aspnet_Membership.Email, dbo.aspnet_UsersInRoles.RoleId, dbo.aspnet_Roles.RoleName, dbo.aspnet_Users.UserName FROM dbo.WGCustomers INNER JOIN dbo.aspnet_Membership ON dbo.WGCustomers.UserId = dbo.aspnet_Membership.UserId INNER JOIN dbo.aspnet_Users ON dbo.WGCustomers.UserId = dbo.aspnet_Users.UserId AND dbo.aspnet_Membership.UserId = dbo.aspnet_Users.UserId INNER JOIN dbo.aspnet_UsersInRoles ON dbo.aspnet_Users.UserId = dbo.aspnet_UsersInRoles.UserId INNER JOIN dbo.aspnet_Roles ON dbo.aspnet_UsersInRoles.RoleId = dbo.aspnet_Roles.RoleId WHERE (dbo.WGCustomers.UserId = @UserId)"
                UpdateCommand="UPDATE [WGCustomers] SET [Subscribed] = @Subscribed WHERE [UserId] = @UserId; UPDATE [aspnet_UsersInRoles] SET [RoleId] = CONVERT(UNIQUEIDENTIFIER,@RoleId) WHERE [UserId] = @UserId" OnUpdated="dsSelectedUser_Updated">
                <DeleteParameters>
                    <asp:Parameter Name="UserId" Type="Object" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Subscribed" Type="Boolean" />
                    <asp:Parameter Name="UserId" Type="Object" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvUsers" Name="UserId" PropertyName="SelectedValue" Type="Object" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Subscribed" Type="Boolean" />
                    <asp:Parameter Name="UserId" Type="Object" />
                    <asp:Parameter Name="RoleId" Type="Object" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
    </asp:MultiView>
    <br />
    <br />
</asp:Content>

