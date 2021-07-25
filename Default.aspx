<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="google-site-verification" content="vazRDmzDbHuH407gHxz_JDhbe5HPJ5qq2aENrso0qY" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Home</h1>
    <div id="fb-root"></div>
        <script>
            (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.6";
            fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
        </script>

    <div class="women-in">
        <div class="col-md-9 col-d">
            <div class="banner">
                <div class="banner-matter">
                    <h2>Stay <span class="emphasize">true</span> to yourself</h2>
                    <label>with one-of-a-kind handcrafted jewelry</label>
                </div>
            </div>
            <!---->
            <div class="in-line">
                <div class="para-an">
                    <h3>NEW PRODUCTS</h3>
                    <p>Check out our most recently-added products.</p>
                </div>

                <asp:ListView ID="lvLatestProducts" runat="server" DataKeyNames="WGProductID" DataSourceID="dsLatestProducts">
                    <LayoutTemplate>
                        <div class="lady-in">
                            <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                        </div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <div class="col-md-4 you-para">
                            <a href="Products.aspx?id=<%# Eval("WGProductID") %>" title="<%# Eval("Name") %>">
                                <img class="img-responsive pic-in" src="images/products/<%# Eval("Thumbnail") %>" alt="<%# Eval("Name") %>"></a>
                            <p><%# Eval("Name") %></p>
                            <span><%# Eval("Price", "{0:c}") %>  |
                                    <label class="cat-in"></label>
                                <a href="AddToCart.aspx?id=<%# Eval("WGProductID") %>">Add to Cart</a>
                        </div>
                    </ItemTemplate>
                </asp:ListView>

                <asp:SqlDataSource ID="dsLatestProducts" runat="server" ConnectionString="<%$ ConnectionStrings:WGConnectionString %>" SelectCommand="SELECT TOP (6) Name, WGProductID, Price, Thumbnail, LastUpdated, WGProductStatusID FROM WGProducts WHERE (WGProductStatusID = @WGProductStatusID) ORDER BY LastUpdated DESC, WGProductID DESC">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="WGProductStatusID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <div class="col-md-3 col-m-left" style="margin-top: -21px">
        <a href="~/Products.aspx?id=27" runat="server">
            <div class="in-left">
                <div class="cool">
                </div>
            </div>
        </a>
        <div class="discount">
            <a href="~/Products.aspx?discount=true" runat="server">
                <img class="img-responsive pic-in" src="~/images/sales.jpg" alt="Discounts" runat="server">

                <p class="no-more no-get">Get exclusive <b>discounts on</b> <span>selected products</span></p>
                <asp:LinkButton ID="btnDiscounts" runat="server" CssClass="know-more" PostBackUrl="~/Products.aspx?discount=true">Learn more</asp:LinkButton>
            </a>
        </div>
        <div class="discount">
            <a href="~/CustomOrders.aspx" runat="server">
                <img class="img-responsive pic-in" src="~/images/customorder.jpg" alt="Custom Orders" runat="server">
                <p class="no-more no-get">Submit an order for <b>CUSTOM</b> <span>handmade jewelry</span></p>
                <asp:LinkButton ID="btnCustomOrders" runat="server" CssClass="know-more" PostBackUrl="~/CustomOrders.aspx">Learn more</asp:LinkButton>
            </a>
            <br />
        </div>
        <div class="fb-page" data-href="https://www.facebook.com/whitesuncrafts/" data-tabs="timeline" data-width="310" data-height="265" data-small-header="true" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/whitesuncrafts/"><a href="https://www.facebook.com/whitesuncrafts/">White Sun Crafts</a></blockquote></div></div>
    </div>
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
                        <span><%# Eval("Price", "{0:c}") %>  |  
                            <a href="Secure/Customer/RemoveWishlist.aspx?id=<%# Eval("WGProductID") %>&action=move">Move to Cart</a>
                        </span>
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

