<%@ Page Title="White Sun Crafts | Change Email Address" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ChangeEmail.aspx.cs" Inherits="Secure_ChangeEmail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <h1 style="display: none;">White Sun Crafts | Change Email Address</h1>
    <div class="para-an">
        <h3>Change Email Address</h3>
        <p>Please update your email address by filling out the form below.</p>
    </div>
    <asp:FormView ID="fvChangeEmail" runat="server" DataKeyNames="UserId" DataSourceID="dsEmail" OnItemUpdated="fvChangeEmail_ItemUpdated">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>Current Email Address:</td>
                    <td>
                        <asp:Label ID="lblCurrentEmail" runat="server"><%# Eval("Email") %></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>New Email Address:</td>
                    <td>
                        <asp:TextBox Text='<%# Bind("Email") %>' runat="server" ID="EmailTextBox" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:Button runat="server" Text="Update" CommandName="Update" ID="UpdateButton" CausesValidation="True" CssClass="btn btn-default" /> 
            <asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" PostBackUrl="~/Secure/ManageAccount.aspx" />
        </EditItemTemplate>
        <InsertItemTemplate>
        </InsertItemTemplate>
        <ItemTemplate>
            This is stuff so I can see.
        </ItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="dsEmail" runat="server" ConnectionString='<%$ ConnectionStrings:LocalSqlServer %>' SelectCommand="SELECT UserId, Email, LoweredEmail FROM aspnet_Membership" UpdateCommand="UPDATE aspnet_Membership SET Email = @Email, LoweredEmail = LOWER(@Email) WHERE (UserId = @UserId)">
        <UpdateParameters>
            <asp:Parameter Name="Email" Type="String"></asp:Parameter>
            <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <br /><br />
</asp:Content>

