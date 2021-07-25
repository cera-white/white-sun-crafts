<%@ Page Title="White Sun Crafts | Wishlist" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Wishlist.aspx.cs" Inherits="Secure_Customer_Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Wishlist</h1>
    <div class="para-an">
        <h3>YOUR WISHLIST</h3>
        <p>Click on any product to view more information.</p>
    </div>

    <p><asp:CheckBox ID="cbShowInactive" runat="server" AutoPostBack="true" OnCheckedChanged="cbShowInactive_CheckedChanged" /> Show products no longer in stock</p>

    <div class="lady-on">
        <asp:ListView ID="lvWishlist" runat="server" DataSourceID="dsWishlist" DataKeyNames="WGProductID">
            <LayoutTemplate>
                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="col-md-4 you-women">
                    <a href="../../Products.aspx?id=<%# Eval("WGProductID") %>">
                        <img class="img-responsive pic-in" src="../../images/products/<%# Eval("Thumbnail") %>" alt="<%# Eval("Name") %>"></a>
                    <p><%# Eval("Name") %></p>
                    <span>
                        <label class="cat-in"></label>
                        <a href="RemoveWishlist.aspx?id=<%# Eval("WGProductID") %>&action=move">Move to Cart</a> | 
                    <a href="RemoveWishlist.aspx?id=<%# Eval("WGProductID") %>">Remove from List</a></span>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <p>Sorry, there are no items in your Wishlist.</p>
            </EmptyDataTemplate>
        </asp:ListView>

        <asp:SqlDataSource ID="dsWishlist" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' 
            SelectCommand="SELECT WGUserWishlist.UserId, WGUserWishlist.WGProductID, WGUserWishlist.DateAdded, WGProducts.Name, WGProducts.Price, WGProducts.Thumbnail, WGProducts.WGProductStatusID, WGProductStatuses.Name AS Status FROM WGProductStatuses INNER JOIN WGProducts ON WGProductStatuses.WGProductStatusID = WGProducts.WGProductStatusID LEFT OUTER JOIN WGUserWishlist ON WGProducts.WGProductID = WGUserWishlist.WGProductID WHERE (WGUserWishlist.UserId = @UserId) AND (WGProducts.WGProductStatusID = 1) ORDER BY WGUserWishlist.DateAdded DESC" OnSelecting="dsWishlist_Selecting">
            <SelectParameters>
                <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:ListView ID="lvInactiveWishlist" runat="server" DataSourceID="dsInactiveWishlist" DataKeyNames="WGProductID" Visible="false">
            <LayoutTemplate>
                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="col-md-4 you-women">
                    <a href="../../Products.aspx?id=<%# Eval("WGProductID") %>">
                        <img class="img-responsive pic-in" src="../../images/products/<%# Eval("Thumbnail") %>" alt="<%# Eval("Name") %>"></a>
                    <p><%# Eval("Name") %></p>
                    <span><%# Eval("Status") %> | 
                    <a href="RemoveWishlist.aspx?id=<%# Eval("WGProductID") %>">Remove from List</a></span>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <p>There are no additional items to display.</p>
            </EmptyDataTemplate>
        </asp:ListView>

        <asp:SqlDataSource ID="dsInactiveWishlist" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' 
            SelectCommand="SELECT WGUserWishlist.UserId, WGUserWishlist.WGProductID, WGProducts.Name, WGProducts.Price, WGProducts.Thumbnail, WGProducts.WGProductStatusID, WGProductStatuses.Name AS Status FROM WGProductStatuses INNER JOIN WGProducts ON WGProductStatuses.WGProductStatusID = WGProducts.WGProductStatusID LEFT OUTER JOIN WGUserWishlist ON WGProducts.WGProductID = WGUserWishlist.WGProductID WHERE (WGUserWishlist.UserId = @UserId) AND (WGProducts.WGProductStatusID != 1)" OnSelecting="dsWishlist_Selecting">
            <SelectParameters>
                <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <br />
    <br />
</asp:Content>

