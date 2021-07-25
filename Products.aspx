<%@ Page Title="White Sun Crafts | Products" MaintainScrollPositionOnPostback="true" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Products.aspx.cs" Inherits="Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <link rel="stylesheet" href="css/etalage.css">
    <script src="js/jquery.min.js"></script>
    <link rel="stylesheet" href="css/etalage.css">
    <script src="js/jquery.etalage.min.js"></script>
    <script>
        jQuery(document).ready(function ($) {

            $('#etalage').etalage({
                thumb_image_width: 450,
                thumb_image_height: 253,
                source_image_width: 1000,
                source_image_height: 563,
                show_hint: true,
                click_callback: function (image_anchor, instance_id) {
                    alert('Callback example:\nYou clicked on an image with the anchor: "' + image_anchor + '"\n(in Etalage instance: "' + instance_id + '")');
                }
            });

        });
    </script>
    <!-- the jScrollPane script -->
    <script type="text/javascript" src="js/jquery.jscrollpane.min.js"></script>
    <script type="text/javascript" id="sourcecode">
        $(function () {
            $('.scroll-pane').jScrollPane();
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Products</h1>
    <asp:MultiView ID="mvProducts" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <!--Master View-->

            <div class="para-an">
                <h3>
                    <asp:Label ID="lblHeader" runat="server"></asp:Label></h3>
                <p>Click on any product to view more information.</p>
            </div>

            <asp:ListView ID="lvProducts" runat="server" DataSourceID="dsAllProducts" DataKeyNames="WGProductID" OnDataBound="lvProducts_DataBound">
                <LayoutTemplate>
                    <div class="lady-on">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="col-md-4 you-women">
                        <a href="Products.aspx?id=<%# Eval("WGProductID") %>">
                            <img class="img-responsive pic-in" src="images/products/<%# Eval("Thumbnail") %>" alt="<%# Eval("Name") %>"></a>
                        <p><%# Eval("Name") %></p>
                        <span><%# Eval("Price", "{0:c}") %>  |
                                    <label class="cat-in"></label>
                            <a href="AddToCart.aspx?id=<%# Eval("WGProductID") %>">Add to Cart</a>
                            <%if (Request.IsAuthenticated)
                                { %> | 
                            <a href="Secure/Customer/AddToWishlist.aspx?id=<%# Eval("WGProductID") %>">Add to Wishlist</a>
                            <%} %>
                        </span>
                    </div>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <p>Sorry, no products matched your search. Please try again.</p>
                </EmptyDataTemplate>
            </asp:ListView>

            <asp:SqlDataSource ID="dsAllProducts" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" SelectCommand="SELECT [WGProductID], [Name], [Price], [WGCategoryID], [WGProductStatusID], [Thumbnail], [Discounted], [Description] FROM [WGProducts] WHERE ([WGProductStatusID] = @WGProductStatusID)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="WGProductStatusID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsProductsByCategory" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGProductID], [Name], [Description], [Price], [WGCategoryID], [WGProductStatusID], [Thumbnail], [Discounted] FROM [WGProducts] WHERE (([WGCategoryID] = @WGCategoryID) AND ([WGProductStatusID] = @WGProductStatusID))">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="cat" Name="WGCategoryID" Type="Int32"></asp:QueryStringParameter>
                    <asp:Parameter DefaultValue="1" Name="WGProductStatusID" Type="Int32"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsProductsBySearch" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGProductID], [Name], [Description], [Price], [WGCategoryID], [WGProductStatusID], [Thumbnail], [Discounted] FROM [WGProducts] WHERE (([WGProductStatusID] = @WGProductStatusID) AND (([Name] LIKE '%' + @Name + '%') OR ([Description] LIKE '%' + @Description + '%'))) ORDER BY [Name]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="WGProductStatusID" Type="Int32"></asp:Parameter>
                    <asp:QueryStringParameter QueryStringField="search" DefaultValue="%" Name="Name" Type="String"></asp:QueryStringParameter>
                    <asp:QueryStringParameter QueryStringField="search" DefaultValue="%" Name="Description" Type="String"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsProductsByDiscount" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT [WGProductID], [Name], [Description], [Price], [WGCategoryID], [WGProductStatusID], [Thumbnail], [Discounted] FROM [WGProducts] WHERE (([WGProductStatusID] = @WGProductStatusID) AND ([Discounted] = @Discounted))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="WGProductStatusID" Type="Int32"></asp:Parameter>
                    <asp:Parameter DefaultValue="true" Name="Discounted" Type="Boolean"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <div class="clearfix"></div>
            <!--Paging-->
            <div class="pages pull-left" style="margin-left: -5px">
                <asp:DataPager ID="dpProducts" runat="server" PagedControlID="lvProducts" PageSize="6">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="prev glyphicon glyphicon-menu-left" RenderNonBreakingSpacesBetweenControls="False" PreviousPageText="" NextPageText="" />
                        <asp:NumericPagerField ButtonCount="10" ButtonType="Link" NumericButtonCssClass="num" NextPreviousButtonCssClass="num" CurrentPageLabelCssClass="num currentNum" RenderNonBreakingSpacesBetweenControls="false"></asp:NumericPagerField>
                        <asp:NextPreviousPagerField ButtonType="Link" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="next glyphicon glyphicon-menu-right" RenderNonBreakingSpacesBetweenControls="False" PreviousPageText="" NextPageText="" />
                    </Fields>
                </asp:DataPager>
                <asp:Label ID="lblShowingResults" runat="server"></asp:Label>
            </div>

        </asp:View>

        <asp:View ID="vwDetails" runat="server">
            <!--Details View-->
            <asp:FormView ID="fvSelectedProduct" runat="server" DataKeyNames="WGProductID" DataSourceID="dsSelectedProduct" OnPreRender="fvSelectedProduct_PreRender">
                <EditItemTemplate>
                </EditItemTemplate>
                <InsertItemTemplate>
                </InsertItemTemplate>
                <ItemTemplate>
                    <div class="single">
                        <div class="col-md-12">
                            <div class="single_grid">
                                <div class="grid">
                                    <ul id="etalage">
                                        <li>
                                            <img class="etalage_thumb_image img-responsive" src="images/products/<%# Eval("Thumbnail") %>" alt="<%# Eval("Name") %>">
                                            <img class="etalage_source_image img-responsive" src="images/products/<%# Eval("Image") %>" alt="<%# Eval("Name") %>">
                                        </li>
                                        <li>
                                            <img class="etalage_thumb_image img-responsive" src="images/products/<%# Eval("Thumbnail2") %>" alt="<%# Eval("Name") %>">
                                            <img class="etalage_source_image img-responsive" src="images/products/<%# Eval("Image2") %>" alt="<%# Eval("Name") %>">
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <!---->
                                <div class="span1_of_1_des">
                                    <div class="desc1" style="padding-left: 10px">
                                        <h3><%# Eval("Name") %>
                                            <span class="author">by <%# Eval("Creator") %></span></h3>
                                        <p><%# Eval("Description") %></p>
                                        <p><strong>Availability:</strong> <%# Eval("Status") %></p>
                                        <h5><%# Eval("Price", "{0:c}") %></h5>
                                        <div class="available">
                                            <span class="span_right">
                                                <%if (Request.IsAuthenticated)
                                                    { %>
                                                <asp:LinkButton ID="btnAddToWishlist" runat="server" OnClick="btnAddToWishlist_Click" OnPreRender="btnAddToWishlist_PreRender"></asp:LinkButton>
                                                <%}
                                                    else
                                                    {%>
                                                <a href="~/Login.aspx" runat="server">Log in to save to wishlist</a>
                                                <%} %>
                                            </span>
                                            <div class="form-in" id="AddToCart" runat="server">
                                                <a href="AddToCart.aspx?id=<%# Eval("WGProductID") %>">Add to Cart</a>
                                                <br />
                                                <br />
                                                <asp:Label ID="lblConfirm" runat="server"></asp:Label>
                                            </div>

                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <!----- tabs-box ---->
                            <div class="sap_tabs">
                                <div id="horizontalTab" style="display: block; width: 100%; margin: 0px;">
                                    <ul class="resp-tabs-list">
                                        <li class="resp-tab-item " aria-controls="tab_item-0" role="tab"><span>Product Details</span></li>
                                        <li class="resp-tab-item" aria-controls="tab_item-1" role="tab"><span>Comments</span></li>
                                        <div class="clearfix"></div>
                                    </ul>
                                    <div class="resp-tabs-container">
                                        <h2 class="resp-accordion resp-tab-active" role="tab" aria-controls="tab_item-0"><span class="resp-arrow"></span>Product Details</h2>
                                        <div class="tab-1 resp-tab-content resp-tab-content-active" aria-labelledby="tab_item-0" style="display: block">
                                            <div class="facts">
                                                <table>
                                                    <tr>
                                                        <td>Name:</td>
                                                        <td><%# Eval("Name") %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Price:</td>
                                                        <td><%# Eval("Price", "{0:c}") %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Category:</td>
                                                        <td><%# Eval("Category") %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Status:</td>
                                                        <td><%# Eval("Status") %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Created By:</td>
                                                        <td><a href="About.aspx?id=<%# Eval("WGVendorID") %>" target="_blank"><%# Eval("Creator") %></a></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Last Updated:</td>
                                                        <td><%# Eval("LastUpdated", "{0:d}") %></td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <h2 class="resp-accordion" role="tab" aria-controls="tab_item-1"><span class="resp-arrow"></span>Reviews</h2>
                                        <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-1">
                                            <div class="facts">
                                                <!--display comments-->
                                                <asp:ListView ID="lvComments" runat="server" DataSourceID="dsComments">
                                                    <LayoutTemplate>

                                                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>

                                                    </LayoutTemplate>
                                                    <ItemTemplate>
                                                        <div class="row">
                                                            <div class="col-xs-1">
                                                                <img src="images/users/<%# Eval("Image") %>" class="img-responsive" />
                                                            </div>
                                                            <div class="col-xs-9">
                                                                <p>
                                                                    <%# Eval("Comment") %>
                                                                </p>
                                                                <p style="font-size: 0.9em; font-style: italic;">
                                                                    Posted by <strong><%# Eval("UserName") %></strong> on <%# Eval("DatePosted") %>
                                                                </p>
                                                            </div>
                                                        </div>

                                                    </ItemTemplate>
                                                    <ItemSeparatorTemplate>
                                                        <hr />
                                                    </ItemSeparatorTemplate>
                                                    <EmptyDataTemplate>
                                                        <p>There are no comments to display for this product. Add your own!</p>
                                                    </EmptyDataTemplate>
                                                </asp:ListView>
                                                <hr />
                                                <%if (Request.IsAuthenticated)
                                                    { %>
                                                <asp:TextBox ID="tbComment" TextMode="MultiLine" Width="60%" Rows="2" runat="server" PlaceHolder="Add a new comment..."></asp:TextBox>
                                                <br />
                                                <br />
                                                <asp:Button ID="btnPostComment" runat="server" Text="Post Comment" ValidationGroup="EnterComment" CssClass="btn btn-default" OnClick="btnPostComment_Click" />
                                                <%}
                                                else
                                                {%>
                                                <p>Please <a href="Login.aspx">Log In</a> or <a href="GetRegistered.aspx">Sign Up</a> to add a comment.</p>
                                                <%} %>

                                                <asp:SqlDataSource ID="dsComments" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>'
                                                    SelectCommand="SELECT [WGUserCommentID], [Comment], [DatePosted], t1.[UserId], [WGProductID], [Image], [UserName] FROM [WGUserComments] AS t1 JOIN [WGCustomers] AS t2 on t1.UserId = t2.UserId JOIN [aspnet_Users] AS t3 on t1.UserId = t3.UserId WHERE ([WGProductID] = @WGProductID)">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="id" Name="WGProductID" Type="Int32"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
                                <script type="text/javascript">
                                    $(document).ready(function () {
                                        $('#horizontalTab').easyResponsiveTabs({
                                            type: 'default', //Types: default, vertical, accordion           
                                            width: '1080px', //auto or any width like 600px
                                            fit: false   // 100% fit in a container
                                        });
                                    });
                                </script>

                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="dsSelectedProduct" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT WGProducts.WGProductID, WGProducts.Name, WGProducts.Description, WGProducts.Price, WGProducts.Image, WGProducts.LastUpdated, WGProducts.WGCategoryID, WGProducts.WGProductStatusID, WGProducts.WGVendorID, WGProducts.Image2, WGProducts.Thumbnail, WGProducts.Discounted, WGCategories.Name AS Category, WGProductStatuses.Name AS Status, WGVendors.Name AS Creator, WGProducts.Thumbnail2, WGVendors.Website AS CreatorWebsite, WGProducts.QtyAvailable FROM WGProducts INNER JOIN WGCategories ON WGProducts.WGCategoryID = WGCategories.WGCategoryID INNER JOIN WGProductStatuses ON WGProducts.WGProductStatusID = WGProductStatuses.WGProductStatusID INNER JOIN WGVendors ON WGProducts.WGVendorID = WGVendors.WGVendorID WHERE (WGProducts.WGProductID = @WGProductID)">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="id" Name="WGProductID" Type="Int32"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:View>
    </asp:MultiView>
    <div class="clearfix"></div>
    <br />
    <!---->
    <%if (Request.IsAuthenticated)
        { %>
    <div class="lady-in-on">
        <div class="buy-an">
            <a href="~/Secure/Customer/Wishlist.aspx" runat="server"><h3>YOUR WISHLIST</h3></a>
            <p>Click to manage the items saved to your Wishlist.</p>
        </div>
        <asp:ListView ID="lvWishlist" runat="server" DataKeyNames="WGProductID" DataSourceID="dsWishlist">
            <LayoutTemplate>
                <ul id="flexiselDemo1">
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                </ul>
            </LayoutTemplate>
            <ItemTemplate>
                <li><a href="Products.aspx?id=<%# Eval("WGProductID") %>" title="<%# Eval("Name") %>">
                    <img class="img-responsive pic-in" src="images/products/<%# Eval("Thumbnail") %>" alt="<%# Eval("Name") %>"></a>
                    <div class="hide-in">
                        <p><%# Eval("Name") %></p>
                        <span><%# Eval("Price", "{0:c}") %>  |  <a href="Secure/Customer/RemoveWishlist.aspx?id=<%# Eval("WGProductID") %>&action=move">Move to Cart</a></span>
                    </div>
                </li>
            </ItemTemplate>
            <EmptyDataTemplate>
                <p>Sorry, there are no items in your Wishlist.</p>
            </EmptyDataTemplate>
        </asp:ListView>

        <asp:SqlDataSource ID="dsWishlist" runat="server" ConnectionString='<%$ ConnectionStrings:WGConnectionString %>' SelectCommand="SELECT WGUserWishlist.UserId, WGUserWishlist.WGProductID, WGUserWishlist.DateAdded, WGProducts.Name, WGProducts.Price, WGProducts.Thumbnail FROM WGUserWishlist INNER JOIN WGProducts ON WGUserWishlist.WGProductID = WGProducts.WGProductID WHERE (WGUserWishlist.UserId = @UserId) AND (WGProducts.WGProductStatusID = 1) ORDER BY WGUserWishlist.DateAdded DESC" OnSelecting="dsWishlist_Selecting">
            <SelectParameters>
                <asp:Parameter Name="UserId" Type="Object"></asp:Parameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <script type="text/javascript">
            $(window).load(function () {
                $("#flexiselDemo1").flexisel({
                    visibleItems: 4,
                    animationSpeed: 1000,
                    //autoPlay: false,
                    //autoPlaySpeed: 3000,
                    pauseOnHover: true,
                    clone: false,
                    enableResponsiveBreakpoints: true,
                    responsiveBreakpoints: {
                        portrait: {
                            changePoint: 480,
                            visibleItems: 1
                        },
                        landscape: {
                            changePoint: 640,
                            visibleItems: 2
                        },
                        tablet: {
                            changePoint: 768,
                            visibleItems: 3
                        }
                    }
                });

            });
        </script>
        <script type="text/javascript" src="js/jquery.flexisel.js"></script>
    </div>
    <%} %>
    <br />

</asp:Content>

