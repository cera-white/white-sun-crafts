<%@ Page Title="White Sun Crafts | Manage: Orders" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageOrders.aspx.cs" Inherits="Secure_Vendor_ManageOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Manage: Orders</h1>
    <div class="para-an">
        <h3>Manage Orders</h3>
        <p>You can review the details of past and pending orders here.</p>
    </div>
    <asp:MultiView ID="mvOrders" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <!--Master-->
            <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" DataSourceID="dsAllOrders" DataKeyNames="WGOrderID"
                GridLines="Vertical" CellPadding="2" CssClass="table table-striped table-bordered" EmptyDataText="You don't have any orders to display." OnSelectedIndexChanged="gvOrders_SelectedIndexChanged">
                <Columns>
                    <asp:TemplateField HeaderText="Order No." ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Eval("WGOrderID") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ShippedTo" HeaderText="Buyer Name" ReadOnly="True" SortExpression="ShippedTo" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" ReadOnly="True" SortExpression="TotalPrice" DataFormatString="{0:c}" />
                    <asp:BoundField DataField="TotalItems" HeaderText="Total Items" ReadOnly="True" SortExpression="TotalItems" />
                    <asp:TemplateField HeaderText="Shipped" SortExpression="HasBeenShipped">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("HasBeenShipped") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("HasBeenShipped") %>' Enabled="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Shipped Date" SortExpression="ShippedDate">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ShippedDate") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" OnPreRender="Label1_PreRender" Text='<%# Bind("ShippedDate", "{0:d}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsAllOrders" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT DISTINCT WGOrders.WGOrderID, WGOrders.FirstName + ' ' + WGOrders.LastName AS ShippedTo, WGOrders.OrderDate, WGOrders.HasBeenShipped, WGOrders.ShippedDate, (SELECT SUM(Price * Quantity) AS TotalPrice FROM WGOrderDetails WHERE (WGOrderID = WGOrders.WGOrderID)) AS TotalPrice, (SELECT SUM(WGOrderDetails.Quantity) AS TotalItems FROM WGOrderDetails WHERE (WGOrderID = WGOrders.WGOrderID)) AS TotalItems FROM WGOrders FULL OUTER JOIN WGOrderDetails AS WGOrderDetails_1 ON WGOrders.WGOrderID = WGOrderDetails_1.WGOrderID"></asp:SqlDataSource>

            <asp:SqlDataSource ID="dsVendorOrders" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT DISTINCT dbo.WGOrders.WGOrderID, dbo.WGOrders.FirstName + ' ' + dbo.WGOrders.LastName AS ShippedTo, dbo.WGOrders.OrderDate, dbo.WGOrders.HasBeenShipped, dbo.WGOrders.ShippedDate, (SELECT SUM(Price * Quantity) AS TotalPrice FROM dbo.WGOrderDetails WHERE (WGOrderID = dbo.WGOrders.WGOrderID)) AS TotalPrice, (SELECT SUM(Quantity) AS TotalItems FROM dbo.WGOrderDetails AS WGOrderDetails_2 WHERE (WGOrderID = dbo.WGOrders.WGOrderID)) AS TotalItems, dbo.WGProducts.WGVendorID FROM dbo.WGProducts INNER JOIN dbo.WGOrderDetails AS WGOrderDetails_1 ON dbo.WGProducts.WGProductID = WGOrderDetails_1.WGProductID FULL OUTER JOIN dbo.WGOrders ON WGOrderDetails_1.WGOrderID = dbo.WGOrders.WGOrderID WHERE (dbo.WGProducts.WGVendorID = @WGVendorID)" OnSelecting="dsVendorOrders_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="WGVendorID"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:View>

        <asp:View ID="vwDetails" runat="server">
            <!--Details-->
            <asp:GridView ID="gvOrderDetails" runat="server" AutoGenerateColumns="False" DataKeyNames="WGOrderDetailID" DataSourceID="dsOrderDetails" GridLines="Vertical" CellPadding="2" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="WGOrderDetailID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="WGOrderDetailID" />
                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <a href="../../Products.aspx?id=<%# Eval("WGProductID") %>" target="_blank"><%# Eval("Name") %></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Price" DataFormatString="{0:c}" HeaderText="Price (each)" SortExpression="Price" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                    <asp:BoundField DataField="ItemTotal" DataFormatString="{0:c}" HeaderText="Item Total" ReadOnly="True" SortExpression="ItemTotal" />
                    <asp:BoundField DataField="Vendor" HeaderText="Vendor" SortExpression="Vendor" />
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsOrderDetails" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT dbo.WGOrderDetails.WGOrderDetailID, dbo.WGOrderDetails.WGOrderID, dbo.WGOrderDetails.WGProductID, dbo.WGOrderDetails.Price, dbo.WGOrderDetails.Quantity, dbo.WGVendors.Name AS Vendor, dbo.WGProducts.Name, dbo.WGOrderDetails.Price * dbo.WGOrderDetails.Quantity AS ItemTotal FROM dbo.WGOrderDetails INNER JOIN dbo.WGProducts ON dbo.WGOrderDetails.WGProductID = dbo.WGProducts.WGProductID INNER JOIN dbo.WGVendors ON dbo.WGProducts.WGVendorID = dbo.WGVendors.WGVendorID WHERE (dbo.WGOrderDetails.WGOrderID = @WGOrderID)" DeleteCommand="DELETE FROM [WGOrderDetails] WHERE [WGOrderDetailID] = @WGOrderDetailID" InsertCommand="INSERT INTO dbo.WGOrders(HasBeenShipped, ShippedDate) VALUES (@HasBeenShipped, @ShippedDate)" UpdateCommand="UPDATE [WGOrderDetails] SET [WGOrderID] = @WGOrderID, [WGProductID] = @WGProductID, [Price] = @Price, [Quantity] = @Quantity WHERE [WGOrderDetailID] = @WGOrderDetailID">
                <DeleteParameters>
                    <asp:Parameter Name="WGOrderDetailID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="HasBeenShipped" />
                    <asp:Parameter Name="ShippedDate" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvOrders" PropertyName="SelectedValue" Name="WGOrderID" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="WGOrderID" Type="Int32" />
                    <asp:Parameter Name="WGProductID" Type="Int32" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="Quantity" Type="Int32" />
                    <asp:Parameter Name="WGOrderDetailID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:Button ID="btnEdit" runat="server" Text="Update Shipment Status" CssClass="btn btn-default" OnClick="btnEdit_Click" />
            &nbsp;<asp:Button ID="btnBack" runat="server" Text="Back to Orders" CssClass="btn btn-default" OnClick="btnBack_Click" />

        </asp:View>

        <asp:View ID="vwEdit" runat="server">
            <!--Edit Mode-->
            <asp:FormView ID="fvShipping" runat="server" DataKeyNames="WGOrderID" DataSourceID="dsShipping" OnItemUpdated="fvShipping_ItemUpdated">
                <EditItemTemplate>
                    <table>
                        <tr>
                            <td>Order No:</td>
                            <td>
                                <asp:Label ID="WGOrderIDLabel" runat="server" Text='<%# Eval("WGOrderID") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Order Date:</td>
                            <td>
                                <asp:Label ID="OrderDateLabel" runat="server" Text='<%# Bind("OrderDate") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Buyer Name:</td>
                            <td>
                                <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' /> <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Buyer Email:</td>
                            <td>
                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Shipping Address:</td>
                            <td colspan="3">
                                <asp:Label ID="ShipAddressLabel" runat="server" Text='<%# Bind("ShipAddress") %>' /> <br />
                                <asp:Label ID="ShipCityLabel" runat="server" Text='<%# Bind("ShipCity") %>' />, <asp:Label ID="ShipRegionLabel" runat="server" Text='<%# Bind("ShipRegion") %>' /> 
                                <asp:Label ID="ShipPostalCodeLabel" runat="server" Text='<%# Bind("ShipPostalCode") %>' /> <br />
                                <asp:Label ID="ShipCountryLabel" runat="server" Text='<%# Bind("ShipCountry") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="HasBeenShippedCheckBox" runat="server" Checked='<%# Bind("HasBeenShipped") %>' /> Has Been Shipped
                            </td>
                        </tr>
                        <tr>
                            <td>Shipped Date:</td>
                            <td>
                                <asp:TextBox ID="ShippedDateTextBox" runat="server" Text='<%# Bind("ShippedDate") %>' />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-default" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" OnClick="UpdateCancelButton_Click" />
                </EditItemTemplate>
                <InsertItemTemplate>
                </InsertItemTemplate>
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>Order No:</td>
                            <td>
                                <asp:Label ID="WGOrderIDLabel" runat="server" Text='<%# Eval("WGOrderID") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Order Date:</td>
                            <td>
                                <asp:Label ID="OrderDateLabel" runat="server" Text='<%# Bind("OrderDate") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Buyer Name:</td>
                            <td>
                                <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' /> <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Buyer Email:</td>
                            <td>
                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Shipping Address:</td>
                            <td colspan="3">
                                <asp:Label ID="ShipAddressLabel" runat="server" Text='<%# Bind("ShipAddress") %>' /> <br />
                                <asp:Label ID="ShipCityLabel" runat="server" Text='<%# Bind("ShipCity") %>' />, <asp:Label ID="ShipRegionLabel" runat="server" Text='<%# Bind("ShipRegion") %>' /> 
                                <asp:Label ID="ShipPostalCodeLabel" runat="server" Text='<%# Bind("ShipPostalCode") %>' /> <br />
                                <asp:Label ID="ShipCountryLabel" runat="server" Text='<%# Bind("ShipCountry") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="HasBeenShippedCheckBox" runat="server" Checked='<%# Bind("HasBeenShipped") %>' Enabled="false" /> Has Been Shipped
                            </td>
                        </tr>
                        <tr>
                            <td>Shipped Date:</td>
                            <td>
                                <asp:Label ID="ShippedDateLabel" runat="server" Text='<%# Bind("ShippedDate") %>' />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="btnBack" runat="server" Text="Back to Orders" CssClass="btn btn-default" OnClick="btnBack_Click" />
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="dsShipping" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" DeleteCommand="DELETE FROM [WGOrders] WHERE [WGOrderID] = @WGOrderID" InsertCommand="INSERT INTO [WGOrders] ([OrderDate], [FirstName], [LastName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry], [Email], [HasBeenShipped], [ShippedDate]) VALUES (@OrderDate, @FirstName, @LastName, @ShipAddress, @ShipCity, @ShipRegion, @ShipPostalCode, @ShipCountry, @Email, @HasBeenShipped, @ShippedDate)" SelectCommand="SELECT [WGOrderID], [OrderDate], [FirstName], [LastName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry], [Email], [HasBeenShipped], [ShippedDate] FROM [WGOrders] WHERE ([WGOrderID] = @WGOrderID)" UpdateCommand="UPDATE [WGOrders] SET [OrderDate] = @OrderDate, [FirstName] = @FirstName, [LastName] = @LastName, [ShipAddress] = @ShipAddress, [ShipCity] = @ShipCity, [ShipRegion] = @ShipRegion, [ShipPostalCode] = @ShipPostalCode, [ShipCountry] = @ShipCountry, [Email] = @Email, [HasBeenShipped] = @HasBeenShipped, [ShippedDate] = @ShippedDate WHERE [WGOrderID] = @WGOrderID">
                <DeleteParameters>
                    <asp:Parameter Name="WGOrderID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="OrderDate" Type="DateTime" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="ShipAddress" Type="String" />
                    <asp:Parameter Name="ShipCity" Type="String" />
                    <asp:Parameter Name="ShipRegion" Type="String" />
                    <asp:Parameter Name="ShipPostalCode" Type="String" />
                    <asp:Parameter Name="ShipCountry" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="HasBeenShipped" Type="Boolean" />
                    <asp:Parameter Name="ShippedDate" Type="DateTime" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvOrders" Name="WGOrderID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="OrderDate" Type="DateTime" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="ShipAddress" Type="String" />
                    <asp:Parameter Name="ShipCity" Type="String" />
                    <asp:Parameter Name="ShipRegion" Type="String" />
                    <asp:Parameter Name="ShipPostalCode" Type="String" />
                    <asp:Parameter Name="ShipCountry" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="HasBeenShipped" Type="Boolean" />
                    <asp:Parameter Name="ShippedDate" Type="DateTime" />
                    <asp:Parameter Name="WGOrderID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
    </asp:MultiView>
    <br />
    <br />
</asp:Content>

