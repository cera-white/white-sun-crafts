using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EF;

/// <summary>
/// Summary description for ShoppingCartActions
/// </summary>
public class ShoppingCartActions : IDisposable
{
    public string ShoppingCartId { get; set; }

    private WGEntities _db = new WGEntities();

    public const string CartSessionKey = "CartID";

    public void AddToCart(int id)
    {
        // Retrieve the product from the database.           
        ShoppingCartId = GetCartId();

        var cartItem = _db.WGCartItems.SingleOrDefault(
            c => c.CartID == ShoppingCartId
            && c.WGProductID == id);
        if (cartItem == null)
        {
            // Create a new cart item if no cart item exists.                 
            cartItem = new WGCartItem
            {
                ItemID = Guid.NewGuid().ToString(),
                WGProductID = id,
                CartID = ShoppingCartId,
                WGProduct = _db.WGProducts.SingleOrDefault(
               p => p.WGProductID == id),
                Quantity = 1,
                DateCreated = DateTime.Now
            };

            _db.WGCartItems.Add(cartItem);
        }
        else
        {
            // If the item does exist in the cart,                  
            // then add one to the quantity.  
            var prod = _db.WGProducts.SingleOrDefault(p => p.WGProductID == id);

            if (cartItem.Quantity < prod.QtyAvailable)
            {
                cartItem.Quantity++;
            }
            else
            {
                cartItem.Quantity = (int)prod.QtyAvailable;
            }
        }
        _db.SaveChanges();
    }

    public void Dispose()
    {
        if (_db != null)
        {
            _db.Dispose();
            _db = null;
        }
    }

    public string GetCartId()
    {
        if (HttpContext.Current.Session[CartSessionKey] == null)
        {
            if (!string.IsNullOrWhiteSpace(HttpContext.Current.User.Identity.Name))
            {
                HttpContext.Current.Session[CartSessionKey] = HttpContext.Current.User.Identity.Name;
            }
            else
            {
                // Generate a new random GUID using System.Guid class.     
                Guid tempCartId = Guid.NewGuid();
                HttpContext.Current.Session[CartSessionKey] = tempCartId.ToString();
            }
        }
        return HttpContext.Current.Session[CartSessionKey].ToString();
    }

    public List<WGCartItem> GetCartItems()
    {
        ShoppingCartId = GetCartId();

        return _db.WGCartItems.Where(
            c => c.CartID == ShoppingCartId).ToList();
    }

    public decimal GetTotal()
    {
        ShoppingCartId = GetCartId();
        // Multiply product price by quantity of that product to get        
        // the current price for each of those products in the cart.  
        // Sum all product price totals to get the cart total.   
        decimal? total = decimal.Zero;
        total = (decimal?)(from cartItems in _db.WGCartItems
                           where cartItems.CartID == ShoppingCartId
                           select (int?)cartItems.Quantity *
                           cartItems.WGProduct.Price).Sum();
        return total ?? decimal.Zero;
    }

    public ShoppingCartActions GetCart(HttpContext context)
    {
        using (var cart = new ShoppingCartActions())
        {
            cart.ShoppingCartId = cart.GetCartId();
            return cart;
        }
    }

    public void UpdateShoppingCartDatabase(String cartId, ShoppingCartUpdates[] CartItemUpdates)
    {
        using (var db = new WGEntities())
        {
            try
            {
                int CartItemCount = CartItemUpdates.Count();
                List<WGCartItem> myCart = GetCartItems();
                foreach (var cartItem in myCart)
                {
                    // Iterate through all rows within shopping cart list
                    for (int i = 0; i < CartItemCount; i++)
                    {
                        if (cartItem.WGProduct.WGProductID == CartItemUpdates[i].ProductId)
                        {
                            if (CartItemUpdates[i].PurchaseQuantity < 1 || CartItemUpdates[i].RemoveItem == true)
                            {
                                RemoveItem(cartId, cartItem.WGProductID);
                            }
                            else
                            {
                                UpdateItem(cartId, cartItem.WGProductID, CartItemUpdates[i].PurchaseQuantity);
                            }
                        }
                    }
                }
            }
            catch (Exception exp)
            {
                throw new Exception("ERROR: Unable to Update Cart Database - " + exp.Message.ToString(), exp);
            }
        }
    }

    public void RemoveItem(string removeCartID, int removeProductID)
    {
        using (var _db = new WGEntities())
        {
            try
            {
                var myItem = (from c in _db.WGCartItems where c.CartID == removeCartID && c.WGProduct.WGProductID == removeProductID select c).FirstOrDefault();
                if (myItem != null)
                {
                    // Remove Item.
                    _db.WGCartItems.Remove(myItem);
                    _db.SaveChanges();
                }
            }
            catch (Exception exp)
            {
                throw new Exception("ERROR: Unable to Remove Cart Item - " + exp.Message.ToString(), exp);
            }
        }
    }

    public void UpdateItem(string updateCartID, int updateProductID, int quantity)
    {
        using (var _db = new WGEntities())
        {
            try
            {
                var myItem = (from c in _db.WGCartItems where c.CartID == updateCartID && c.WGProduct.WGProductID == updateProductID select c).FirstOrDefault();
                if (myItem != null)
                {
                    myItem.Quantity = quantity;
                    _db.SaveChanges();
                }
            }
            catch (Exception exp)
            {
                throw new Exception("ERROR: Unable to Update Cart Item - " + exp.Message.ToString(), exp);
            }
        }
    }

    public void EmptyCart()
    {
        ShoppingCartId = GetCartId();
        var cartItems = _db.WGCartItems.Where(
            c => c.CartID == ShoppingCartId);
        foreach (var cartItem in cartItems)
        {
            _db.WGCartItems.Remove(cartItem);
        }
        // Save changes.             
        _db.SaveChanges();
    }

    public int GetCount()
    {
        ShoppingCartId = GetCartId();

        // Get the count of each item in the cart and sum them up          
        int? count = (from cartItems in _db.WGCartItems
                      where cartItems.CartID == ShoppingCartId
                      select (int?)cartItems.Quantity).Sum();
        // Return 0 if all entries are null         
        return count ?? 0;
    }

    public struct ShoppingCartUpdates
    {
        public int ProductId;
        public int PurchaseQuantity;
        public bool RemoveItem;
    }

    public void MigrateCart(string cartId, string userName)
    {
        var shoppingCart = _db.WGCartItems.Where(c => c.CartID == cartId);
        foreach (WGCartItem item in shoppingCart)
        {
            item.CartID = userName;
        }
        HttpContext.Current.Session[CartSessionKey] = userName;
        _db.SaveChanges();
    }
}