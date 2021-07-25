<%@ Page Title="White Sun Crafts | Register an Account" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="GetRegistered.aspx.cs" Inherits="GetRegistered" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Register an Account</h1>
    <div class="para-an">
        <h3>Register an Account</h3>
        <p>Please create a new account by filling out the fields below.</p>
    </div>
    <%--<div class="col-md-offset-4">--%>
    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" RenderOuterTable="False" ContinueDestinationPageUrl="~/Secure/ManageAccount.aspx" OnCreatedUser="CreateUserWizard1_CreatedUser" OnActiveStepChanged="CreateUserWizard1_ActiveStepChanged">
        <MailDefinition BodyFileName="Register.txt" From="whitesuncrafts@anigrams.org" Subject="Registration Confirmation"></MailDefinition>
        <WizardSteps>
            <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                <ContentTemplate>
                    <table style="margin-left: -10px">
                        <tr>
                            <td>
                                <asp:Label runat="server" AssociatedControlID="UserName" ID="UserNameLabel">Username:</asp:Label></td>
                            <td>
                                <asp:TextBox runat="server" ID="UserName"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName" ErrorMessage="*Username is required." ValidationGroup="CreateUserWizard1" ToolTip="User Name is required." ID="UserNameRequired" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" AssociatedControlID="Password" ID="PasswordLabel">Password:</asp:Label></td>
                            <td>
                                <asp:TextBox runat="server" TextMode="Password" ID="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" ErrorMessage="*Password is required." ValidationGroup="CreateUserWizard1" ToolTip="Password is required." ID="PasswordRequired" CssClass="emphasize"></asp:RequiredFieldValidator>
                                <p style="font-size:0.8em; font-style: italic">Must have a minimum of 7 characters, including at least 1 non-alphanumeric character</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" AssociatedControlID="ConfirmPassword" ID="ConfirmPasswordLabel">Confirm Password:</asp:Label></td>
                            <td>
                                <asp:TextBox runat="server" TextMode="Password" ID="ConfirmPassword"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="*Confirm Password is required." ValidationGroup="CreateUserWizard1" ToolTip="Confirm Password is required." ID="ConfirmPasswordRequired" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" AssociatedControlID="Email" ID="EmailLabel">E-mail:</asp:Label></td>
                            <td>
                                <asp:TextBox runat="server" ID="Email"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" ErrorMessage="*E-mail is required." ValidationGroup="CreateUserWizard1" ToolTip="E-mail is required." ID="EmailRequired" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" AssociatedControlID="Question" ID="QuestionLabel">Security Question:</asp:Label></td>
                            <td>
                                <asp:TextBox runat="server" ID="Question"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Question" ErrorMessage="*Security question is required." ValidationGroup="CreateUserWizard1" ToolTip="Security question is required." ID="QuestionRequired" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" AssociatedControlID="Answer" ID="AnswerLabel">Security Answer:</asp:Label></td>
                            <td>
                                <asp:TextBox runat="server" ID="Answer"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Answer" ErrorMessage="*Security answer is required." ValidationGroup="CreateUserWizard1" ToolTip="Security answer is required." ID="AnswerRequired" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" ErrorMessage="The Password and Confirmation Password must match." Display="Dynamic" ValidationGroup="CreateUserWizard1" ID="PasswordCompare" CssClass="emphasize"></asp:CompareValidator>
                            </td>
                        </tr>
                    </table>
                    <span class="emphasize">
                        <asp:Literal runat="server" ID="ErrorMessage" EnableViewState="False"></asp:Literal></span>
                    <br />
                    <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Next Step" ValidationGroup="CreateUserWizard1" CssClass="btn btn-default" />
                </ContentTemplate>
                <CustomNavigationTemplate>
                    
                </CustomNavigationTemplate>
            </asp:CreateUserWizardStep>
            <asp:WizardStep ID="UserSettings" runat="server" StepType="Step" Title="Your Profile Settings">
                <table style="margin-left: -10px">
                    <tr>
                        <td>
                            <asp:Label runat="server" AssociatedControlID="FirstName" ID="FirstNameLabel">First Name:</asp:Label></td>
                        <td>
                            <asp:TextBox runat="server" ID="FirstName"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" AssociatedControlID="LastName" ID="LastNameLabel">Last Name:</asp:Label></td>
                        <td>
                            <asp:TextBox runat="server" ID="LastName"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" AssociatedControlID="Address" ID="AddressLabel">Shipping Address:</asp:Label></td>
                        <td>
                            <asp:TextBox runat="server" ID="Address"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" AssociatedControlID="City" ID="CityLabel">City:</asp:Label></td>
                        <td>
                            <asp:TextBox runat="server" ID="City"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" AssociatedControlID="Region" ID="RegionLabel">Region/State:</asp:Label></td>
                        <td>
                            <asp:TextBox runat="server" ID="Region"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" AssociatedControlID="PostalCode" ID="PostalCodeLabel">Postal Code:</asp:Label></td>
                        <td>
                            <asp:TextBox runat="server" ID="PostalCode"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" AssociatedControlID="Country" ID="CountryLabel">Country:</asp:Label></td>
                        <td>
                            <asp:DropDownList ID="Country" runat="server" DataSourceID="dsCountry" DataTextField="CountryName" DataValueField="CountryID"></asp:DropDownList>
                            <asp:SqlDataSource ID="dsCountry" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [CountryID], [CountryName] FROM [Countries] ORDER BY [CountryName]"></asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="cbSubscribe" runat="server" Text=" Do you want to receive notifications about new offers and products?"/>
                        </td>
                    </tr>
                </table>
                <br />
                    <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Register" ValidationGroup="CreateUserWizard1" CssClass="btn btn-default" />
            </asp:WizardStep>
            <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                <ContentTemplate>
                    <table>
                        <tr>
                            <td>Success!</td>
                        </tr>
                        <tr>
                            <td>Your account has been successfully created.</td>
                        </tr>
                        <tr>
                            <td>You should receive a confirmation email soon. If you do not, please notify us at <a href="mailto:whitesuncrafts@anigrams.org">whitesuncrafts@anigrams.org</a></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button runat="server" CausesValidation="False" CommandName="Continue" Text="Continue" ValidationGroup="CreateUserWizard1" ID="ContinueButton" CssClass="btn btn-default"></asp:Button>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:CompleteWizardStep>
        </WizardSteps>
        <StepNavigationTemplate>
        </StepNavigationTemplate>
    </asp:CreateUserWizard>
    <br />
    <br />
    <%--</div>--%>
</asp:Content>

