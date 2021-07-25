<%@ Page Title="White Sun Crafts | Manage: Products" ValidateRequest="false" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageProducts.aspx.cs" Inherits="Secure_Vendor_ManageProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Manage: Products</h1>
    <asp:MultiView ID="mvProducts" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <!--Master-->
            <div class="para-an">
                <h3>Manage Products</h3>
                <asp:Button ID="btnAdd" runat="server" Text="Add New Product" CssClass="btn btn-default pull-right" OnClick="btnAdd_Click" />
                <p>Use this panel to add and edit product information.</p>

            </div>

            <asp:GridView ID="gvProducts" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="WGProductID" DataSourceID="dsAllProducts" OnPreRender="gvProducts_PreRender"
                GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered" OnSelectedIndexChanged="gvProducts_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="WGProductID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="WGProductID" />
                    <asp:TemplateField HeaderText="Name" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Eval("Name") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                    <asp:BoundField DataField="Price" DataFormatString="{0:c}" HeaderText="Price" SortExpression="Price" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="QtyAvailable" HeaderText="Qty" SortExpression="QtyAvailable" />
                    <asp:BoundField DataField="Vendor" HeaderText="Vendor" SortExpression="Vendor" />
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsAllProducts" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT dbo.WGProducts.WGProductID, dbo.WGProducts.Name, dbo.WGProducts.Price, dbo.WGProducts.WGCategoryID, dbo.WGProducts.WGProductStatusID, dbo.WGProducts.WGVendorID, dbo.WGProducts.QtyAvailable, dbo.WGCategories.Name AS Category, dbo.WGProductStatuses.Name AS Status, dbo.WGVendors.Name AS Vendor FROM dbo.WGProducts INNER JOIN dbo.WGCategories ON dbo.WGProducts.WGCategoryID = dbo.WGCategories.WGCategoryID INNER JOIN dbo.WGProductStatuses ON dbo.WGProducts.WGProductStatusID = dbo.WGProductStatuses.WGProductStatusID INNER JOIN dbo.WGVendors ON dbo.WGProducts.WGVendorID = dbo.WGVendors.WGVendorID ORDER BY dbo.WGProducts.WGProductStatusID, dbo.WGProducts.Name"></asp:SqlDataSource>

            <asp:SqlDataSource ID="dsVendorProducts" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" OnSelecting="dsVendorProducts_Selecting" SelectCommand="SELECT dbo.WGProducts.WGProductID, dbo.WGProducts.Name, dbo.WGProducts.Price, dbo.WGProducts.WGCategoryID, dbo.WGProducts.WGProductStatusID, dbo.WGProducts.WGVendorID, dbo.WGProducts.QtyAvailable, dbo.WGCategories.Name AS Category, dbo.WGProductStatuses.Name AS Status, dbo.WGVendors.Name AS Vendor FROM dbo.WGProducts INNER JOIN dbo.WGCategories ON dbo.WGProducts.WGCategoryID = dbo.WGCategories.WGCategoryID INNER JOIN dbo.WGProductStatuses ON dbo.WGProducts.WGProductStatusID = dbo.WGProductStatuses.WGProductStatusID INNER JOIN dbo.WGVendors ON dbo.WGProducts.WGVendorID = dbo.WGVendors.WGVendorID WHERE (dbo.WGProducts.WGVendorID = @WGVendorID) ORDER BY dbo.WGProducts.WGProductStatusID, dbo.WGProducts.Name">
                <SelectParameters>
                    <asp:Parameter Name="WGVendorID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <div class="buy-an">
                <h3 style="padding-bottom: 5px">MOST POPULAR PRODUCTS</h3>
            </div>
            <asp:ListView ID="lvPopular" runat="server" DataSourceID="dsPopular">
                <LayoutTemplate>
                    <div class="lady-on" style="margin-left: -14px">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="col-md-3">
                        <a href="../../Products.aspx?id=<%# Eval("WGProductID") %>" target="_blank">
                            <img class="img-responsive pic-in" src="../../images/products/<%# Eval("Thumbnail") %>" alt="<%# Eval("Name") %>"></a>
                        <p style="font-weight: bold"><%# Eval("Name") %></p>
                        <span><%# Eval("Price", "{0:c}") %>  | <%# Eval("Status") %>
                        </span>
                    </div>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <p>No products have been added to users' wishlists.</p>
                </EmptyDataTemplate>
            </asp:ListView>

            <asp:SqlDataSource ID="dsPopular" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT TOP 4 dbo.WGProducts.WGProductID, dbo.WGProducts.Name, dbo.WGProducts.Price, dbo.WGProducts.Thumbnail, dbo.WGProductStatuses.Name AS Status, COUNT(dbo.WGUserWishlist.WGProductID) AS TimesFavorited FROM dbo.WGProducts INNER JOIN dbo.WGProductStatuses ON dbo.WGProducts.WGProductStatusID = dbo.WGProductStatuses.WGProductStatusID LEFT OUTER JOIN dbo.WGUserWishlist ON dbo.WGProducts.WGProductID = dbo.WGUserWishlist.WGProductID GROUP BY dbo.WGProducts.WGProductID, dbo.WGProducts.Name, dbo.WGProducts.Price, dbo.WGProducts.Thumbnail, dbo.WGProductStatuses.Name HAVING (COUNT(dbo.WGUserWishlist.WGProductID) &gt; 0) ORDER BY TimesFavorited, dbo.WGProducts.Name"></asp:SqlDataSource>

            <div class="clearfix"></div>
        </asp:View>

        <asp:View ID="vwDetails" runat="server">
            <!--Details-->
            <asp:FormView ID="fvSelectedProduct" runat="server" DataKeyNames="WGProductID" DataSourceID="dsSelectedProduct" EnableViewState="false">
                <EditItemTemplate>
                    <div class="para-an">
                        <h3>Edit Product Information</h3>
                        <p>Please update the product listing by filling out the fields below.</p>
                    </div>
                    <table>
                        <tr>
                            <td>
                                Name:
                            </td>
                            <td>
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="NameTextBox" runat="server" ErrorMessage="*Name Required" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Description:
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="DescriptionTextBox" TextMode="MultiLine" Width="400px" Rows="5" runat="server" Text='<%# Bind("Description") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Price:</td>
                            <td>
                                <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvPrice" ControlToValidate="PriceTextBox" runat="server" ErrorMessage="*Price Required" Display="Dynamic" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:CheckBox ID="DiscountedCheckBox" runat="server" Checked='<%# Bind("Discounted") %>' /> Is this a discount price?
                            </td>
                        </tr>
                        <tr>
                            <td>Category:</td>
                            <td>
                                <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="dsCategory" DataTextField="Name" DataValueField="WGCategoryID" SelectedValue='<%# Bind("WGCategoryID") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="dsCategory" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGCategoryID], [Name] FROM [WGCategories] ORDER BY [Name]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>Vendor:</td>
                            <td>
                                <asp:DropDownList ID="ddlVendor" runat="server" DataSourceID="dsVendor" DataTextField="Name" DataValueField="WGVendorID" SelectedValue='<%# Bind("WGVendorID") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="dsVendor" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGVendorID], [Name] FROM [WGVendors] ORDER BY [Name]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>Status:</td>
                            <td>
                                <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="dsStatus" DataTextField="Name" DataValueField="WGProductStatusID" SelectedValue='<%# Bind("WGProductStatusID") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="dsStatus" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGProductStatusID], [Name] FROM [WGProductStatuses]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>Quantity Available:</td>
                            <td>
                                <asp:TextBox ID="QtyAvailableTextBox" runat="server" Width="50px" Text='<%# Bind("QtyAvailable") %>' />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvQtyAvailable" ControlToValidate="QtyAvailableTextBox" runat="server" ErrorMessage="*Quantity Required" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Main Image:</td>
                            <td>
                                <asp:FileUpload ID="fupImage1" runat="server" />
                                <asp:HiddenField ID="hfImage1" runat="server" Value='<%# Bind("Image") %>' />
                                <p style="font-size:0.9em; font-style: italic">1000 x 563px, max 4MB</p>
                            </td>
                        </tr>
                        <tr>
                            <td>Main Image Thumbnail:</td>
                            <td>
                                <asp:FileUpload ID="fupImage1Thumb" runat="server" />
                                <asp:HiddenField ID="hfImage1Thumb" runat="server" Value='<%# Bind("Thumbnail") %>' />
                                <p style="font-size:0.9em; font-style: italic">360 x 203px, max 4MB</p>
                            </td>
                        </tr>
                        <tr>
                            <td>Close-up Image:</td>
                            <td>
                                <asp:FileUpload ID="fupImage2" runat="server" />
                                <asp:HiddenField ID="hfImage2" runat="server" Value='<%# Bind("Image2") %>' />
                                <p style="font-size:0.9em; font-style: italic">1000 x 563px, max 4MB</p>
                            </td>
                        </tr>
                        <tr>
                            <td>Close-up Thumbnail:</td>
                            <td>
                                <asp:FileUpload ID="fupImage2Thumb" runat="server" />
                                <asp:HiddenField ID="hfImage2Thumb" runat="server" Value='<%# Bind("Thumbnail2") %>' />
                                <p style="font-size:0.9em; font-style: italic">360 x 203px, max 4MB</p>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="para-an">
                        <h3>Add New Product</h3>
                        <p>Please fill out the form below to add a new product to the site.</p>
                    </div>
                    <table>
                        <tr>
                            <td>
                                Name:
                            </td>
                            <td>
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="NameTextBox" runat="server" ErrorMessage="*Name Required" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Description:
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="DescriptionTextBox" TextMode="MultiLine" Width="400px" Rows="5" runat="server" Text='<%# Bind("Description") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Price:</td>
                            <td>
                                <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvPrice" ControlToValidate="PriceTextBox" runat="server" ErrorMessage="*Price Required" Display="Dynamic" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:CheckBox ID="DiscountedCheckBox" runat="server" Checked='<%# Bind("Discounted") %>' /> Is this a discount price?
                            </td>
                        </tr>
                        <tr>
                            <td>Category:</td>
                            <td>
                                <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="dsCategory" DataTextField="Name" DataValueField="WGCategoryID" SelectedValue='<%# Bind("WGCategoryID") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="dsCategory" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGCategoryID], [Name] FROM [WGCategories] ORDER BY [Name]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>Vendor:</td>
                            <td>
                                <asp:DropDownList ID="ddlVendor" runat="server" DataSourceID="dsVendor" DataTextField="Name" DataValueField="WGVendorID" SelectedValue='<%# Bind("WGVendorID") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="dsVendor" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGVendorID], [Name] FROM [WGVendors] ORDER BY [Name]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>Status:</td>
                            <td>
                                <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="dsStatus" DataTextField="Name" DataValueField="WGProductStatusID" SelectedValue='<%# Bind("WGProductStatusID") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="dsStatus" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGProductStatusID], [Name] FROM [WGProductStatuses]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>Quantity Available:</td>
                            <td>
                                <asp:TextBox ID="QtyAvailableTextBox" runat="server" Width="50px" Text='<%# Bind("QtyAvailable") %>' />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvQtyAvailable" ControlToValidate="QtyAvailableTextBox" runat="server" ErrorMessage="*Quantity Required" CssClass="emphasize"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Main Image:</td>
                            <td>
                                <asp:FileUpload ID="fupImage1" runat="server" />
                                <asp:HiddenField ID="hfImage1" runat="server" Value='<%# Bind("Image") %>' />
                                <p style="font-size:0.9em; font-style: italic">1000 x 563px, max 4MB</p>
                            </td>
                        </tr>
                        <tr>
                            <td>Main Image Thumbnail:</td>
                            <td>
                                <asp:FileUpload ID="fupImage1Thumb" runat="server" />
                                <asp:HiddenField ID="hfImage1Thumb" runat="server" Value='<%# Bind("Thumbnail") %>' />
                                <p style="font-size:0.9em; font-style: italic">360 x 203px, max 4MB</p>
                            </td>
                        </tr>
                        <tr>
                            <td>Close-up Image:</td>
                            <td>
                                <asp:FileUpload ID="fupImage2" runat="server" />
                                <asp:HiddenField ID="hfImage2" runat="server" Value='<%# Bind("Image2") %>' />
                                <p style="font-size:0.9em; font-style: italic">1000 x 563px, max 4MB</p>
                            </td>
                        </tr>
                        <tr>
                            <td>Close-up Thumbnail:</td>
                            <td>
                                <asp:FileUpload ID="fupImage2Thumb" runat="server" />
                                <asp:HiddenField ID="hfImage2Thumb" runat="server" Value='<%# Bind("Thumbnail2") %>' />
                                <p style="font-size:0.9em; font-style: italic">360 x 203px, max 4MB</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="cbNotification" runat="server" Checked="True" /> Send a notification to subscribers that this product has been added
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Add" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="InsertCancelButton_Click"/>
                </InsertItemTemplate>
                <ItemTemplate>
                    <div class="article-top">
                        <h3>Product Information</h3>

                        <div class="article-bottom row">
                            <div class="col-md-3 article-para">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Thumbnail", "~/images/products/{0}") %>' CssClass="img-responsive zoom-img" />
                                <p></p>
                                <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("Thumbnail2", "~/images/products/{0}") %>' CssClass="img-responsive zoom-img" />
                                <p>
                                    <br />
                                    <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit Product" CssClass="btn btn-default" /> 
                                    <asp:Button ID="btnBack" runat="server" Text="Back to Products" CssClass="btn btn-default" OnClick="btnBack_Click" />
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
                                            <td>Price:</td>
                                            <td>
                                                <asp:Label ID="PriceLabel" runat="server" Text='<%# Bind("Price", "{0:c}") %>' />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="DiscountedCheckBox" runat="server" Checked='<%# Bind("Discounted") %>' Enabled="false" />
                                                Is this a discount price?
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Category:</td>
                                            <td>
                                                <asp:Label ID="WGCategoryIDLabel" runat="server" Text='<%# Bind("Category") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <hr />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Description:</td>
                                            <td colspan="2">
                                                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Bind("Description") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <hr />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>Status:</td>
                                            <td>
                                                <asp:Label ID="WGProductStatusIDLabel" runat="server" Text='<%# Bind("Status") %>' />
                                            </td>
                                            <td>Quantity:
                                        <asp:Label ID="QtyAvailableLabel" runat="server" Text='<%# Bind("QtyAvailable") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Vendor:</td>
                                            <td>
                                                <asp:Label ID="WGVendorIDLabel" runat="server" Text='<%# Bind("Vendor") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">Last updated on
                                        <asp:Label ID="LastUpdatedLabel" runat="server" Text='<%# Bind("LastUpdated", "{0:d}") %>' /></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="dsSelectedProduct" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' 
                DeleteCommand="DELETE FROM [WGProducts] WHERE [WGProductID] = @WGProductID" 
                InsertCommand="INSERT INTO [WGProducts] ([Name], [Description], [Price], [LastUpdated], [WGCategoryID], [WGProductStatusID], [WGVendorID], [Image], [Image2], [Thumbnail], [Discounted], [Thumbnail2], [QtyAvailable]) VALUES (@Name, @Description, @Price, @LastUpdated, @WGCategoryID, @WGProductStatusID, @WGVendorID, @Image, @Image2, @Thumbnail, @Discounted, @Thumbnail2, @QtyAvailable)
SELECT @NewProductID = Scope_Identity()" 
                SelectCommand="SELECT dbo.WGProducts.WGProductID, dbo.WGProducts.Name, dbo.WGProducts.Description, dbo.WGProducts.Price, dbo.WGProducts.LastUpdated, dbo.WGProducts.WGCategoryID, dbo.WGProducts.WGProductStatusID, dbo.WGProducts.WGVendorID, dbo.WGProducts.Image, dbo.WGProducts.Image2, dbo.WGProducts.Thumbnail, dbo.WGProducts.Discounted, dbo.WGProducts.Thumbnail2, dbo.WGProducts.QtyAvailable, dbo.WGCategories.Name AS Category, dbo.WGProductStatuses.Name AS Status, dbo.WGVendors.Name AS Vendor FROM dbo.WGProducts INNER JOIN dbo.WGCategories ON dbo.WGProducts.WGCategoryID = dbo.WGCategories.WGCategoryID INNER JOIN dbo.WGProductStatuses ON dbo.WGProducts.WGProductStatusID = dbo.WGProductStatuses.WGProductStatusID INNER JOIN dbo.WGVendors ON dbo.WGProducts.WGVendorID = dbo.WGVendors.WGVendorID WHERE (dbo.WGProducts.WGProductID = @WGProductID)" UpdateCommand="UPDATE [WGProducts] SET [Name] = @Name, [Description] = @Description, [Price] = @Price, [LastUpdated] = @LastUpdated, [WGCategoryID] = @WGCategoryID, [WGProductStatusID] = @WGProductStatusID, [WGVendorID] = @WGVendorID, [Image] = @Image, [Image2] = @Image2, [Thumbnail] = @Thumbnail, [Discounted] = @Discounted, [Thumbnail2] = @Thumbnail2, [QtyAvailable] = @QtyAvailable WHERE [WGProductID] = @WGProductID" OnInserting="dsSelectedProduct_Inserting" OnUpdating="dsSelectedProduct_Updating" OnInserted="dsSelectedProduct_Inserted">
                <DeleteParameters>
                    <asp:Parameter Name="WGProductID" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Price" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="LastUpdated" Type="DateTime"></asp:Parameter>
                    <asp:Parameter Name="WGCategoryID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="WGProductStatusID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="WGVendorID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="Image" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Image2" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Thumbnail" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Discounted" Type="Boolean"></asp:Parameter>
                    <asp:Parameter Name="Thumbnail2" Type="String"></asp:Parameter>
                    <asp:Parameter Name="QtyAvailable" Type="Int32"></asp:Parameter>
                    <asp:Parameter Direction="Output" Name="NewProductID" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvProducts" PropertyName="SelectedValue" Name="WGProductID" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Price" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="LastUpdated" Type="DateTime"></asp:Parameter>
                    <asp:Parameter Name="WGCategoryID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="WGProductStatusID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="WGVendorID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="Image" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Image2" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Thumbnail" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Discounted" Type="Boolean"></asp:Parameter>
                    <asp:Parameter Name="Thumbnail2" Type="String"></asp:Parameter>
                    <asp:Parameter Name="QtyAvailable" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="WGProductID" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
    </asp:MultiView>
    <br />
    <br />
</asp:Content>

