package com.shop.repository;

import com.shop.entity.Cart;
import com.shop.entity.CartItem;
import java.util.List;

public interface ICartRepository {
    Cart findByUserId(int userId);

    int createCart(int userId);

    List<CartItem> getCartItems(int cartId);

    CartItem findCartItem(int cartId, int productId);

    int addItem(CartItem item);

    int updateItemQuantity(int itemId, int quantity);

    int removeItem(int itemId);

    int clearCart(int cartId);

    int countItems(int cartId);
}
