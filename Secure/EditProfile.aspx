<%@ Page Title="White Sun Crafts | Edit Profile" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EditProfile.aspx.cs" Inherits="Secure_EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Edit Profile</h1>
    <div class="para-an">
        <h3>Edit Profile</h3>
        <p>Please update your profile settings by filling out the fields below.</p>
    </div>
    <asp:FormView ID="fvProfile" runat="server" DataKeyNames="UserId" DataSourceID="dsProfile" OnItemUpdated="fvProfile_ItemUpdated" RenderOuterTable="False">
        <EditItemTemplate>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblFirstName" runat="server">First Name:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' /></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblLastName" runat="server">Last Name:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAddress" runat="server">Shipping Address:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCity" runat="server">City:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRegion" runat="server">Region/State:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="RegionTextBox" runat="server" Text='<%# Bind("Region") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPostalCode" runat="server">Postal Code:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="PostalCodeTextBox" runat="server" Text='<%# Bind("PostalCode") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCountry" runat="server">Country:</asp:Label></td>
                    <td>
                        <asp:DropDownList ID="Country" runat="server" DataSourceID="dsCountry" DataTextField="CountryName" DataValueField="CountryID" SelectedValue='<%# Bind("Country") %>'></asp:DropDownList>
                        <asp:SqlDataSource ID="dsCountry" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [CountryID], [CountryName] FROM [Countries] ORDER BY [CountryName]"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="ImageLabel">Profile Picture:</asp:Label></td>
                    <td>
                        <asp:FileUpload ID="fuploadProfilePicture" runat="server" />
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Image") %>' />
                        <p style="font-size:0.9em; font-style: italic">Max 4MB</p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:CheckBox ID="SubscribedCheckBox" runat="server" Checked='<%# Bind("Subscribed") %>' Text="&nbsp;Do you want to receive notifications about new offers and products?" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update Settings" CssClass="btn btn-default"/> 
            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" PostBackUrl="~/Secure/ManageAccount.aspx" />
        </EditItemTemplate>
        <InsertItemTemplate>
        </InsertItemTemplate>
        <ItemTemplate>
            FirstName:
            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
            <br />
            LastName:
            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
            <br />
            Address:
            <asp:Label ID="AddressLabel" runat="server" Text='<%# Bind("Address") %>' />
            <br />
            City:
            <asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' />
            <br />
            PostalCode:
            <asp:Label ID="PostalCodeLabel" runat="server" Text='<%# Bind("PostalCode") %>' />
            <br />
            Country:
            <asp:Label ID="CountryLabel" runat="server" Text='<%# Bind("Country") %>' />
            <br />
            Image:
            <asp:Label ID="ImageLabel" runat="server" Text='<%# Bind("Image") %>' />
            <br />
            UserId:
            <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
            <br />
            Region:
            <asp:Label ID="RegionLabel" runat="server" Text='<%# Bind("Region") %>' />
            <br />
            Subscribed:
            <asp:CheckBox ID="SubscribedCheckBox" runat="server" Checked='<%# Bind("Subscribed") %>' Enabled="false" />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
        </ItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="dsProfile" runat="server" ConnectionString='<%$ ConnectionStrings:LocalSqlServer %>' DeleteCommand="DELETE FROM [WGCustomers] WHERE [UserId] = @UserId" InsertCommand="INSERT INTO [WGCustomers] ([FirstName], [LastName], [Address], [City], [PostalCode], [Country], [Image], [UserId], [Region]) VALUES (@FirstName, @LastName, @Address, @City, @PostalCode, @Country, @Image, @UserId, @Region)" SelectCommand="SELECT FirstName, LastName, Address, City, PostalCode, Country, Image, UserId, Region, Subscribed FROM WGCustomers WHERE (UserId = @UserId)" UpdateCommand="UPDATE WGCustomers SET FirstName = @FirstName, LastName = @LastName, Address = @Address, City = @City, PostalCode = @PostalCode, Country = @Country, Image = @Image, Region = @Region, Subscribed = @Subscribed WHERE (UserId = @UserId)" OnInserting="dsProfile_Inserting" OnSelecting="dsProfile_Selecting" OnUpdating="dsProfile_Updating">
        <DeleteParameters>
            <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FirstName" Type="String"></asp:Parameter>
            <asp:Parameter Name="LastName" Type="String"></asp:Parameter>
            <asp:Parameter Name="Address" Type="String"></asp:Parameter>
            <asp:Parameter Name="City" Type="String"></asp:Parameter>
            <asp:Parameter Name="PostalCode" Type="String"></asp:Parameter>
            <asp:Parameter Name="Country" Type="String"></asp:Parameter>
            <asp:Parameter Name="Image" Type="String"></asp:Parameter>
            <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
            <asp:Parameter Name="Region" Type="String"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FirstName" Type="String"></asp:Parameter>
            <asp:Parameter Name="LastName" Type="String"></asp:Parameter>
            <asp:Parameter Name="Address" Type="String"></asp:Parameter>
            <asp:Parameter Name="City" Type="String"></asp:Parameter>
            <asp:Parameter Name="PostalCode" Type="String"></asp:Parameter>
            <asp:Parameter Name="Country" Type="String"></asp:Parameter>
            <asp:Parameter Name="Image" Type="String"></asp:Parameter>
            <asp:Parameter Name="Region" Type="String"></asp:Parameter>
            <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
            <asp:Parameter Name="Subscribed" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <br />
    <br />
</asp:Content>

