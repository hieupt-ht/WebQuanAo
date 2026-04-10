package com.shop.repository.impl;

import com.shop.dao.CartDAO;
import com.shop.dao.CartItemDAO;
import com.shop.entity.Cart;
import com.shop.entity.CartItem;
import com.shop.repository.ICartRepository;
import java.util.List;

public class CartRepositoryImpl implements ICartRepository {
    private final CartDAO cartDAO = new CartDAO();
    private final CartItemDAO cartItemDAO = new CartItemDAO();

    @Override
    public Cart findByUserId(int userId) {
        return cartDAO.findByUserId(userId);
    }

    @Override
    public int createCart(int userId) {
        return cartDAO.insertCart(userId);
    }

    @Override
    public List<CartItem> getCartItems(int cartId) {
        return cartItemDAO.findByCartId(cartId);
    }

    @Override
    public CartItem findCartItem(int cartId, int productId) {
        return cartItemDAO.findByCartIdAndProductId(cartId, productId);
    }

    @Override
    public int addItem(CartItem item) {
        return cartItemDAO.insertCartItem(item);
    }

    @Override
    public int updateItemQuantity(int itemId, int quantity) {
        return cartItemDAO.updateQuantity(itemId, quantity);
    }

    @Override
    public int removeItem(int itemId) {
        return cartItemDAO.deleteCartItem(itemId);
    }

    @Override
    public int clearCart(int cartId) {
        return cartItemDAO.deleteByCartId(cartId);
    }

    @Override
    public int countItems(int cartId) {
        return cartItemDAO.countByCartId(cartId);
    }
}
