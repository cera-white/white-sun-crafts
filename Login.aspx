<%@ Page Title="White Sun Crafts | Log In" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Log In</h1>
    <div class="para-an">
        <h3>Log In</h3>
        <p>Please log in with your username and password.</p>
    </div>

    <asp:Login ID="Login1" runat="server" PasswordRecoveryText="Forgot Password?" PasswordRecoveryUrl="~/ForgotPassword.aspx" CreateUserText="Don't have an account? Sign up now!" CreateUserUrl="~/GetRegistered.aspx" RenderOuterTable="False" OnLoggedIn="Login1_LoggedIn">
        <LayoutTemplate>
            <span class="emphasize">
                        <asp:Literal runat="server" ID="FailureText" EnableViewState="False"></asp:Literal></span>
            <table>
                <tr>
                    <td>
                        <asp:Label runat="server" AssociatedControlID="UserName" ID="UserNameLabel">Username:</asp:Label></td>
                    <td>
                        <asp:TextBox runat="server" ID="UserName"></asp:TextBox></td>
                    <td>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName" ErrorMessage="*Username is required." ValidationGroup="Login1" ToolTip="User Name is required." ID="UserNameRequired" CssClass="emphasize"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" AssociatedControlID="Password" ID="PasswordLabel">Password:&nbsp;</asp:Label></td>
                    <td>
                        <asp:TextBox runat="server" TextMode="Password" ID="Password"></asp:TextBox></td>
                    <td>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" ErrorMessage="*Password is required." ValidationGroup="Login1" ToolTip="Password is required." ID="PasswordRequired" CssClass="emphasize"></asp:RequiredFieldValidator></td>
                </tr>
            </table>

            <br />
            <asp:CheckBox runat="server" Text="&nbsp; Remember me next time." ID="RememberMe"></asp:CheckBox>
            <br />
            <asp:Button runat="server" CommandName="Login" Text="Log In" ValidationGroup="Login1" ID="LoginButton" CssClass="btn btn-default"></asp:Button>
            <br /><br />
            <asp:HyperLink runat="server" NavigateUrl="~/ForgotPassword.aspx" ID="PasswordRecoveryLink">Forgot Password?</asp:HyperLink>
            <br />
            <asp:HyperLink runat="server" NavigateUrl="~/GetRegistered.aspx" ID="CreateUserLink">Don't have an account? Sign up now!</asp:HyperLink>
        </LayoutTemplate>
    </asp:Login>
    <br /><br />
</asp:Content>

