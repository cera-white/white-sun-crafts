<%@ Page Title="White Sun Crafts | Manage: Vendors" Language="C#" ValidateRequest="false" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageVendors.aspx.cs" Inherits="Secure_Vendor_ManageVendors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Manage: Vendors</h1>
    <asp:MultiView ID="mvVendors" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <!--Master-->
            <div class="para-an">
                <h3>Manage Vendors</h3>
                <p>Use this panel to view and edit vendor information.</p>
            </div>
            <asp:GridView ID="gvVendors" runat="server" AutoGenerateColumns="False" DataKeyNames="WGVendorID" DataSourceID="dsVendors" GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered" OnSelectedIndexChanged="gvVendors_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="WGVendorID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="WGVendorID"></asp:BoundField>
                    <asp:TemplateField HeaderText="Name" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Eval("Name") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Specialty" HeaderText="Specialty" SortExpression="Specialty"></asp:BoundField>
                    <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive"></asp:CheckBoxField>
                </Columns>
            </asp:GridView>

            <%if (User.IsInRole("Admin"))
                { %>
            <asp:Button ID="btnAdd" runat="server" Text="Add New Vendor" CssClass="btn btn-default" OnClick="btnAdd_Click" />
            <%} %>

            <asp:SqlDataSource ID="dsVendors" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGVendorID], [Name], [IsActive], [Specialty] FROM [WGVendors]"></asp:SqlDataSource>

        </asp:View>

        <asp:View ID="vwDetails" runat="server">
            <!--Details-->
            <asp:FormView ID="fvSelectedVendor" runat="server" DataKeyNames="WGVendorID" DataSourceID="dsSelectedVendor" EnableViewState="false">
                <EditItemTemplate>
                    <div class="para-an">
                        <h3>Edit Vendor Profile</h3>
                        <p>Please update your profile settings by filling out the fields below.</p>
                    </div>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblName" runat="server">Name:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="NameTextBox" runat="server" ErrorMessage="*Name Required" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <%if (User.IsInRole("Admin"))
                                { %>
                            <td>
                                <asp:Label ID="lblUsername" runat="server">Username:</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlUsername" runat="server" DataSourceID="dsUsername" DataTextField="UserName" DataValueField="UserId" SelectedValue='<%# Bind("UserId") %>' AppendDataBoundItems="true">
                                    <asp:ListItem Value="-1">Choose a username...</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="dsUsername" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [UserId], [UserName] FROM [aspnet_Users]"></asp:SqlDataSource>
                            </td>
                            <%}
                                else
                                { %>
                            <asp:HiddenField ID="hfUserId" runat="server" Value='<%# Bind("UserId") %>' />
                            <%} %>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSpecialty" runat="server">Specialty:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="SpecialtyTextBox" runat="server" Text='<%# Bind("Specialty") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDescription" runat="server">Description:</asp:Label>
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="DescriptionTextBox" TextMode="MultiLine" Width="400px" Rows="5" runat="server" Text='<%# Bind("Description") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblWebsite" runat="server">Website:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="WebsiteTextBox" runat="server" Text='<%# Bind("Website") %>' PlaceHolder="www.example.com" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblStatus" runat="server">Status:</asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox ID="IsActiveCheckBox" runat="server" Checked='<%# Bind("IsActive") %>' />
                                Set as Active
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="ImageLabel">Picture:</asp:Label>
                            </td>
                            <td>
                                <asp:FileUpload ID="fuploadProfilePicture" runat="server" />
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Image") %>' />
                                <p style="font-size:0.9em; font-style: italic">500 x 550px, max 4MB</p>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="para-an">
                        <h3>Add New Vendor</h3>
                        <p>Please fill out the form below to add a new vendor to the site.</p>
                    </div>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblName" runat="server">Name:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="NameTextBox" runat="server" ErrorMessage="*Name Required" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <%if (User.IsInRole("Admin"))
                                { %>
                            <td>
                                <asp:Label ID="lblUsername" runat="server">Username:</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlUsername" runat="server" DataSourceID="dsUsername" DataTextField="UserName" DataValueField="UserId" SelectedValue='<%# Bind("UserId") %>' AppendDataBoundItems="true">
                                    <asp:ListItem Value="-1">Choose a username...</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="dsUsername" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [UserId], [UserName] FROM [aspnet_Users]"></asp:SqlDataSource>
                            </td>
                            <%}
                                else
                                { %>
                            <asp:HiddenField ID="hfUserId" runat="server" Value='<%# Bind("UserId") %>' />
                            <%} %>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSpecialty" runat="server">Specialty:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="SpecialtyTextBox" runat="server" Text='<%# Bind("Specialty") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDescription" runat="server">Description:</asp:Label>
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="DescriptionTextBox" TextMode="MultiLine" Width="400px" Rows="5" runat="server" Text='<%# Bind("Description") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblWebsite" runat="server">Website:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="WebsiteTextBox" runat="server" Text='<%# Bind("Website") %>' PlaceHolder="www.example.com" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblStatus" runat="server">Status:</asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox ID="IsActiveCheckBox" runat="server" Checked='<%# Bind("IsActive") %>' />
                                Set as Active
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="ImageLabel">Picture:</asp:Label>
                            </td>
                            <td>
                                <asp:FileUpload ID="fuploadProfilePicture" runat="server" />
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Image") %>' />
                                <p style="font-size:0.9em; font-style: italic">500 x 550px, max 4MB</p>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Add" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="InsertCancelButton_Click"/>
                </InsertItemTemplate>
                <ItemTemplate>
                    <div class="article-top">
                        <h3>Vendor Profile</h3>

                        <div class="article-bottom row">
                            <div class="col-md-3 article-para">
                                <asp:Image ID="imgProfile" runat="server" ImageUrl='<%# Eval("Image", "~/images/vendors/{0}") %>' CssClass="img-responsive zoom-img" />
                                <p>
                                    <br />
                                    <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit Profile" OnPreRender="EditButton_PreRender" CssClass="btn btn-default" /> 
                                    <asp:Button ID="btnBack" runat="server" Text="Back to Vendors" CssClass="btn btn-default" OnClick="btnBack_Click" />
                                </p>
                            </div>

                            <div class="col-md-9 article-para" style="margin-top: -10px">
                                <div class="account-section">
                                    <h4>Basic Information</h4>
                                    <table>
                                        <tr>
                                            <td>Name:</td>
                                            <td>
                                                <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' />
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>Specialty:</td>
                                            <td>
                                                <asp:Label ID="SpecialtyLabel" runat="server" Text='<%# Bind("Specialty") %>' />

                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-top: 2.5em; padding-bottom: 2.5em">Description:</td>
                                            <td>
                                                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Bind("Description") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Website:</td>
                                            <td>
                                                <a href="<%# Eval("Website", "http://{0}") %>">
                                                    <asp:Label ID="WebsiteLabel" runat="server" Text='<%# Bind("Website", "http://{0}") %>' /></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="IsActiveCheckBox" runat="server" Checked='<%# Bind("IsActive") %>' Enabled="false" />
                                                Active
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="dsSelectedVendor" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>'
                DeleteCommand="DELETE FROM [WGVendors] WHERE [WGVendorID] = @WGVendorID"
                InsertCommand="INSERT INTO [WGVendors] ([Name], [Image], [Website], [IsActive], [UserId], [Description], [Specialty]) VALUES (@Name, @Image, @Website, @IsActive, CONVERT(UNIQUEIDENTIFIER,@UserId), @Description, @Specialty)"
                SelectCommand="SELECT [WGVendorID], [Name], [Image], [Website], [IsActive], [UserId], [Description], [Specialty] FROM [WGVendors] WHERE ([WGVendorID] = @WGVendorID)"
                UpdateCommand="UPDATE [WGVendors] SET [Name] = @Name, [Image] = @Image, [Website] = @Website, [IsActive] = @IsActive, [UserId] = CONVERT(UNIQUEIDENTIFIER,@UserId), [Description] = @Description, [Specialty] = @Specialty WHERE [WGVendorID] = @WGVendorID" OnInserting="dsSelectedVendor_Inserting" OnUpdating="dsSelectedVendor_Updating" OnInserted="dsSelectedVendor_Inserted" OnUpdated="dsSelectedVendor_Updated">
                <DeleteParameters>
                    <asp:Parameter Name="WGVendorID" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Image" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Website" Type="String"></asp:Parameter>
                    <asp:Parameter Name="IsActive" Type="Boolean"></asp:Parameter>
                    <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
                    <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Specialty" Type="String"></asp:Parameter>
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvVendors" PropertyName="SelectedValue" Name="WGVendorID" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Image" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Website" Type="String"></asp:Parameter>
                    <asp:Parameter Name="IsActive" Type="Boolean"></asp:Parameter>
                    <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
                    <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Specialty" Type="String"></asp:Parameter>
                    <asp:Parameter Name="WGVendorID" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>

        </asp:View>
    </asp:MultiView>
    <br />
    <br />
</asp:Content>

