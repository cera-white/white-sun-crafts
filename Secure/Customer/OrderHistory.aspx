<%@ Page Title="White Sun Crafts | Order History" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="OrderHistory.aspx.cs" Inherits="Secure_Customer_OrderHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Order History</h1>
    <div class="para-an">
        <h3>Order History</h3>
        <p>You can review the details of past purchases here.</p>
    </div>

    <asp:MultiView ID="mvOrderHistory" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwOrders" runat="server">
            <!--Master-->
            <asp:GridView ID="gvOrders" runat="server" DataSourceID="dsOrders" DataKeyNames="WGOrderID" AutoGenerateColumns="False" GridLines="Vertical" CellPadding="2" CssClass="table table-striped table-bordered" EmptyDataText="You don't have any orders to display." OnSelectedIndexChanged="gvOrders_SelectedIndexChanged">
                <Columns>
                    <asp:TemplateField HeaderText="Order No." ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Eval("WGOrderID") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="OrderDate" DataFormatString="{0:d}" HeaderText="Order Date" SortExpression="OrderDate" />
                    <asp:BoundField DataField="TotalItems" HeaderText="Total Items" SortExpression="TotalItems" />
                    <asp:BoundField DataField="TotalPrice" DataFormatString="{0:c}" HeaderText="Total Price" SortExpression="TotalPrice" />
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

            <asp:SqlDataSource ID="dsOrders" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" OnSelecting="dsOrders_Selecting" 
                SelectCommand="SELECT DISTINCT WGOrders.WGOrderID, WGOrders.FirstName + ' ' + WGOrders.LastName AS ShippedTo, WGOrders.OrderDate, WGOrders.HasBeenShipped, WGOrders.ShippedDate, (SELECT SUM(Price * Quantity) AS TotalPrice FROM WGOrderDetails WHERE (WGOrderID = WGOrders.WGOrderID)) AS TotalPrice, (SELECT SUM(WGOrderDetails.Quantity) AS TotalItems FROM WGOrderDetails WHERE (WGOrderID = WGOrders.WGOrderID)) AS TotalItems FROM WGOrders FULL OUTER JOIN WGOrderDetails AS WGOrderDetails_1 ON WGOrders.WGOrderID = WGOrderDetails_1.WGOrderID WHERE (WGOrders.Username = @Username)">
                <SelectParameters>
                    <asp:Parameter Name="Username" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:View>

        <asp:View ID="vwOrderDetails" runat="server">
            <!--Details-->
            <asp:Label ID="lblOrderNo" runat="server" Font-Bold="True"></asp:Label>
            <asp:GridView ID="gvOrderDetails" runat="server" AutoGenerateColumns="False" DataSourceID="dsOrderDetails" GridLines="Vertical" CellPadding="2" CssClass="table table-striped table-bordered" EmptyDataText="You don't have any orders to display.">
                <Columns>
                    <asp:BoundField DataField="WGProductID" HeaderText="ID" SortExpression="WGProductID" />
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
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsOrderDetails" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" SelectCommand="SELECT WGOrderDetails.WGOrderID, WGOrderDetails.WGProductID, WGOrderDetails.Price, WGOrderDetails.Quantity, WGProducts.Name, WGOrderDetails.Price * WGOrderDetails.Quantity AS ItemTotal FROM WGOrderDetails INNER JOIN WGProducts ON WGOrderDetails.WGProductID = WGProducts.WGProductID WHERE (WGOrderDetails.WGOrderID = @WGOrderID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvOrders" Name="WGOrderID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:Button ID="btnBack" runat="server" Text="Back to Orders" CssClass="btn btn-default" OnClick="btnBack_Click" />
        </asp:View>
    </asp:MultiView>
    <br />
    <br />
</asp:Content>

