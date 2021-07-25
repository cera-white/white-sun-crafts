<%@ Page Title="White Sun Crafts | Shopping Cart" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ShoppingCart.aspx.cs" Inherits="ShoppingCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <meta name="robots" content="noindex" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <h1 style="display: none;">White Sun Crafts | Shopping Cart</h1>
    <input type="hidden" name="cmd" value="_cart">
    <input type="hidden" name="upload" value="1">
    <input type="hidden" name="business" value="whitesuncrafts@anigrams.org">

    <div class="para-an" id="ShoppingCartTitle">
        <h3>Shopping Cart</h3>
        <p>Please review the details of your order before proceeding to checkout.</p>
    </div>

    <asp:GridView ID="CartList" runat="server" AutoGenerateColumns="False" GridLines="Vertical" CellPadding="4"
        ItemType="EF.WGCartItem" SelectMethod="GetShoppingCartItems"
        CssClass="table table-striped table-bordered" EmptyDataText="There are no items in your shopping cart.">
        <Columns>
            <asp:BoundField DataField="WGProductID" HeaderText="ID"></asp:BoundField>
            <asp:TemplateField HeaderText="Name">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("WGProduct.Name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <a href="Products.aspx?id=<%# Eval("WGProduct.WGProductID") %>" target="_blank"><asp:Label ID="Label1" runat="server" Text='<%# Bind("WGProduct.Name") %>'></asp:Label></a>
                    <input type="hidden" name="item_name_<%# Container.DataItemIndex+1 %>" value="<%# Eval("WGProduct.Name") %>">
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Price (each)">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("WGProduct.Price") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("WGProduct.Price", "{0:c}") %>'></asp:Label>
                    <input type="hidden" name="amount_<%# Container.DataItemIndex+1 %>" value="<%# Eval("WGProduct.Price", "{0:c}") %>">
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Quantity">
                <ItemTemplate>
                    <asp:DropDownList ID="PurchaseQuantity" runat="server" OnPreRender="ddlQty_PreRender"></asp:DropDownList>
                    <input type="hidden" name="quantity_<%# Container.DataItemIndex+1 %>" value="<%# Eval("Quantity") %>">
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Item Total">
                <ItemTemplate>
                    <%#: string.Format("{0:c}", ((Convert.ToDouble(Item.Quantity)) *  Convert.ToDouble(Item.WGProduct.Price)))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Remove Item">
                <ItemTemplate>
                    <asp:CheckBox ID="Remove" runat="server"></asp:CheckBox>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <div>
        <asp:Button ID="UpdateBtn" runat="server" Text="Update Cart" OnClick="UpdateBtn_Click" CssClass="btn btn-default pull-right" />
        <p style="font-weight: bold">
            <asp:Label ID="LabelTotalText" runat="server" Text="Order Total: "></asp:Label>
            <asp:Label ID="lblTotal" runat="server" EnableViewState="false"></asp:Label>
        </p>
        <br class="clearfix" />
        <asp:TextBox ID="tbCoupon" runat="server" PlaceHolder="Enter Coupon Code"></asp:TextBox>
        <asp:LinkButton ID="btnApplyCoupon" runat="server" OnClick="btnApplyCoupon_Click">Apply</asp:LinkButton>

        <span id="couponFields" runat="server"></span>
    </div>
    <br class="clearfix" />

    <%if (Request.IsAuthenticated)
        { %>
    <div class="form-in">
        <input type="hidden" name="return" value="http://whitesuncrafts.aniramgs.org/PaymentSuccess.aspx" />
        <input type="hidden" name="cancel_return" value="http://whitesuncrafts.anigrams.org/ShoppingCart.aspx" />
        <input type="submit" value="Continue to Checkout" id="paypalbutton" class="btn">
        <br />
        <br />
    </div>
    <%}
        else
        { %>
    <p style="text-transform: uppercase; font-size: 0.8725em">Please <a href="Login.aspx" class="plain-text">Log In</a> or <a href="GetRegistered.aspx" class="plain-text">Sign Up</a> before checking out.</p>
    <br /><br />
    <%} %>

    <script>
        $(document).ready(function () {
            $("#paypalbutton").on("click", function (n) {
                n.preventDefault();
                $("#mainForm").attr("action", "https://www.paypal.com/cgi-bin/webscr");
                $("#mainForm").submit();
            });
        });
    </script>

</asp:Content>

