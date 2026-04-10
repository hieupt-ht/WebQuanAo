package com.shop.service;

import com.shop.entity.CartItem;
import java.math.BigDecimal;
import java.util.List;

public interface ICartService {
    List<CartItem> getCartItems(int userId);

    boolean addToCart(int userId, int productId, int quantity);

    boolean updateQuantity(int userId, int itemId, int quantity);

    boolean removeItem(int userId, int itemId);

    boolean clearCart(int userId);

    BigDecimal getCartTotal(int userId);

    int getCartItemCount(int userId);
}
