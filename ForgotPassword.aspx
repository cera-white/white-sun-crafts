<%@ Page Title="White Sun Crafts | Password Recovery" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Password Recovery</h1>
    <div class="para-an">
        <h3>Password Recovery</h3>
        <p>Please answer the following questions to retrieve your password.</p>
    </div>

    <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" RenderOuterTable="False">
        <UserNameTemplate>
            <p>Start by entering your username in the space below.</p>
            <br />
            <table>
                <tr>
                    <td>
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="*Username is required." ToolTip="Username is required." ValidationGroup="PasswordRecovery1" CssClass="emphasize"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>

            <span class="emphasize">
                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal></span>
            <br />
            <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Submit" ValidationGroup="PasswordRecovery1" CssClass="btn btn-default" />
        </UserNameTemplate>
        <QuestionTemplate>
            <p>Answer the security question associated with this username.</p>
            <br />
            <table>
                <tr>
                    <td>Username:</td>
                    <td>
                        <asp:Literal ID="UserName" runat="server"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td>Question:</td>
                    <td>
                        <asp:Literal ID="Question" runat="server"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">Answer:</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer" ErrorMessage="*Answer is required." ToolTip="Answer is required." ValidationGroup="PasswordRecovery1" CssClass="emphasize"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>

            <span class="emphasize"><asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal></span>
            <br />
            <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Submit" ValidationGroup="PasswordRecovery1" CssClass="btn btn-default" />

        </QuestionTemplate>
    </asp:PasswordRecovery>
    <br />
    <br />
</asp:Content>

