package com.shop.service.impl;

import com.shop.entity.Cart;
import com.shop.entity.CartItem;
import com.shop.repository.ICartRepository;
import com.shop.repository.impl.CartRepositoryImpl;
import com.shop.service.ICartService;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class CartServiceImpl implements ICartService {
    private final ICartRepository cartRepository = new CartRepositoryImpl();

    private Cart getOrCreateCart(int userId) {
        Cart cart = cartRepository.findByUserId(userId);
        if (cart == null) {
            int cartId = cartRepository.createCart(userId);
            cart = new Cart();
            cart.setId(cartId);
            cart.setUserId(userId);
        }
        return cart;
    }

    @Override
    public List<CartItem> getCartItems(int userId) {
        Cart cart = cartRepository.findByUserId(userId);
        if (cart == null)
            return new ArrayList<>();
        return cartRepository.getCartItems(cart.getId());
    }

    @Override
    public boolean addToCart(int userId, int productId, int quantity) {
        Cart cart = getOrCreateCart(userId);
        CartItem existing = cartRepository.findCartItem(cart.getId(), productId);
        if (existing != null) {
            return cartRepository.updateItemQuantity(existing.getId(), existing.getQuantity() + quantity) > 0;
        } else {
            CartItem item = new CartItem();
            item.setCartId(cart.getId());
            item.setProductId(productId);
            item.setQuantity(quantity);
            return cartRepository.addItem(item) > 0;
        }
    }

    @Override
    public boolean updateQuantity(int userId, int itemId, int quantity) {
        if (quantity <= 0)
            return removeItem(userId, itemId);
        return cartRepository.updateItemQuantity(itemId, quantity) > 0;
    }

    @Override
    public boolean removeItem(int userId, int itemId) {
        return cartRepository.removeItem(itemId) > 0;
    }

    @Override
    public boolean clearCart(int userId) {
        Cart cart = cartRepository.findByUserId(userId);
        if (cart == null)
            return false;
        return cartRepository.clearCart(cart.getId()) >= 0;
    }

    @Override
    public BigDecimal getCartTotal(int userId) {
        List<CartItem> items = getCartItems(userId);
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }

    @Override
    public int getCartItemCount(int userId) {
        Cart cart = cartRepository.findByUserId(userId);
        if (cart == null)
            return 0;
        return cartRepository.countItems(cart.getId());
    }
}
