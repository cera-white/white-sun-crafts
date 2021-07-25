<%@ Page Title="White Sun Crafts | Change Password" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Secure_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Change Password</h1>
    <div class="para-an">
        <h3>Change Password</h3>
        <p>Please fill out the form below to update the password for your account.</p>
    </div>

    <asp:ChangePassword ID="ChangePassword1" runat="server" RenderOuterTable="False" CancelDestinationPageUrl="~/Secure/ManageAccount.aspx" ContinueDestinationPageUrl="~/Secure/ManageAccount.aspx">
        <ChangePasswordTemplate>
            <table>
                <tr>
                    <td>
                        <asp:Label runat="server" AssociatedControlID="CurrentPassword" ID="CurrentPasswordLabel">Password:</asp:Label></td>
                    <td>
                        <asp:TextBox runat="server" TextMode="Password" ID="CurrentPassword"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword" ErrorMessage="*Password is required." ValidationGroup="ChangePassword1" ToolTip="Password is required." ID="CurrentPasswordRequired" CssClass="emphasize"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" AssociatedControlID="NewPassword" ID="NewPasswordLabel">New Password:</asp:Label></td>
                    <td>
                        <asp:TextBox runat="server" TextMode="Password" ID="NewPassword"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword" ErrorMessage="*New Password is required." ValidationGroup="ChangePassword1" ToolTip="New Password is required." ID="NewPasswordRequired" CssClass="emphasize"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" AssociatedControlID="ConfirmNewPassword" ID="ConfirmNewPasswordLabel">Confirm New Password:</asp:Label></td>
                    <td>
                        <asp:TextBox runat="server" TextMode="Password" ID="ConfirmNewPassword"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword" ErrorMessage="*Confirm New Password is required." ValidationGroup="ChangePassword1" ToolTip="Confirm New Password is required." ID="ConfirmNewPasswordRequired" CssClass="emphasize"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="emphasize">
                        <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" ErrorMessage="The Confirm New Password must match the New Password entry." Display="Dynamic" ValidationGroup="ChangePassword1" ID="NewPasswordCompare"></asp:CompareValidator>
                    </td>
                </tr>
            </table>
            <span class="emphasize">
                <asp:Literal runat="server" ID="FailureText" EnableViewState="False"></asp:Literal></span>
            <br />
            <asp:Button runat="server" CommandName="ChangePassword" Text="Change Password" ValidationGroup="ChangePassword1" ID="ChangePasswordPushButton" CssClass="btn btn-default"></asp:Button>

            <asp:LinkButton runat="server" CausesValidation="False" CommandName="Cancel" ID="CancelPushButton">Cancel</asp:LinkButton>

        </ChangePasswordTemplate>
        <SuccessTemplate>
            <p>Your password has been changed!</p>
            <br />
            <asp:Button ID="ContinuePushButton" runat="server" CausesValidation="False" CommandName="Continue" Text="Continue" CssClass="btn btn-default" />

        </SuccessTemplate>
    </asp:ChangePassword>
    <br />
    <br />
</asp:Content>

