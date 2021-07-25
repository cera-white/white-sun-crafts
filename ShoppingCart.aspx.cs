using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EF;
using System.Collections.Specialized;
using System.Collections;
using System.Web.ModelBinding;

public partial class ShoppingCart : System.Web.UI.Page
{
    //Create the datacontext (to reach the EF layer)
    WGEntities ctx = new WGEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
        {
            decimal cartTotal = 0;
            cartTotal = usersShoppingCart.GetTotal();
            if (cartTotal > 0)
            {
                // Display Total.
                lblTotal.Text = string.Format("{0:c}", cartTotal);
            }
            else
            {
                LabelTotalText.Text = "";
                lblTotal.Text = "";
                UpdateBtn.Visible = false;
            }
        }
    }

    public List<WGCartItem> GetShoppingCartItems()
    {
        ShoppingCartActions actions = new ShoppingCartActions();
        return actions.GetCartItems();
    }

    public List<WGCartItem> UpdateCartItems()
    {
        using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
        {
            string cartId = usersShoppingCart.GetCartId();

            ShoppingCartActions.ShoppingCartUpdates[] cartUpdates = new ShoppingCartActions.ShoppingCartUpdates[CartList.Rows.Count];
            for (int i = 0; i < CartList.Rows.Count; i++)
            {
                IOrderedDictionary rowValues = new OrderedDictionary();
                rowValues = GetValues(CartList.Rows[i]);
                cartUpdates[i].ProductId = Convert.ToInt32(rowValues["WGProductID"]);

                CheckBox cbRemove = new CheckBox();
                cbRemove = (CheckBox)CartList.Rows[i].FindControl("Remove");
                cartUpdates[i].RemoveItem = cbRemove.Checked;

                DropDownList quantityTextBox = new DropDownList();
                quantityTextBox = (DropDownList)CartList.Rows[i].FindControl("PurchaseQuantity");
                cartUpdates[i].PurchaseQuantity = Convert.ToInt16(quantityTextBox.Text.ToString());
            }
            usersShoppingCart.UpdateShoppingCartDatabase(cartId, cartUpdates);
            CartList.DataBind();
            lblTotal.Text = string.Format("{0:c}", usersShoppingCart.GetTotal());
            return usersShoppingCart.GetCartItems();
        }
    }

    public static IOrderedDictionary GetValues(GridViewRow row)
    {
        IOrderedDictionary values = new OrderedDictionary();
        foreach (DataControlFieldCell cell in row.Cells)
        {
            if (cell.Visible)
            {
                // Extract values from the cell.
                cell.ContainingField.ExtractValuesFromCell(values, cell, row.RowState, true);
            }
        }
        return values;
    }

    protected void UpdateBtn_Click(object sender, EventArgs e)
    {
        UpdateCartItems();
    }

    protected void ddlQty_PreRender(object sender, EventArgs e)
    {
        ShoppingCartActions userShoppingCart = new ShoppingCartActions();

        DropDownList ddlQty = (DropDownList)((DropDownList)sender).Parent.FindControl("PurchaseQuantity");
        Label Label1 = (Label)((DropDownList)sender).Parent.FindControl("Label1");
        string prodName = Label1.Text;

        WGProduct prod = (from p in ctx.WGProducts
                          where p.Name == prodName
                          select p).Single();

        for (int i = 1; i <= prod.QtyAvailable; i++)
        {
            ddlQty.Items.Add(new ListItem(i.ToString()));
        }

        string cartID = userShoppingCart.GetCartId();

        WGCartItem cartItem = (from ci in ctx.WGCartItems
                               where ci.CartID == cartID && ci.WGProductID == prod.WGProductID
                               select ci).Single();

        if (cartItem.Quantity > prod.QtyAvailable)
        {
            ddlQty.Text = prod.QtyAvailable.ToString();
        }
        else
        {
            ddlQty.Text = cartItem.Quantity.ToString();
        }

        ddlQty.DataBind();
    }

    protected void btnApplyCoupon_Click(object sender, EventArgs e)
    {
        ShoppingCartActions userShoppingCart = new ShoppingCartActions();

        if (tbCoupon.Text.ToLower() == "please")
        {
            couponFields.InnerHtml = "<p>Success! A 10% discount has been applied to your order total.</p> <input type=\"hidden\" name=\"discount_rate_cart\" value=\"10\">";
            decimal discount = decimal.Multiply(userShoppingCart.GetTotal(), 0.9m);
            lblTotal.Text = string.Format("{0:c}", discount);
        }
        else if (tbCoupon.Text.ToLower() == "free shipping")
        {
            couponFields.InnerHtml = "<p>Success! Free shipping has been applied to your order.</p> <input type=\"hidden\" name=\"handling_cart\" value=\"0\">";
        }
    }
}