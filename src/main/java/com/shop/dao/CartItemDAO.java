package com.shop.dao;

import com.shop.entity.CartItem;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CartItemDAO extends BaseDAO<CartItem> {

    @Override
    protected CartItem mapRow(ResultSet rs) throws SQLException {
        CartItem ci = new CartItem();
        ci.setId(rs.getInt("id"));
        ci.setCartId(rs.getInt("cart_id"));
        ci.setProductId(rs.getInt("product_id"));
        ci.setQuantity(rs.getInt("quantity"));
        try {
            ci.setProductName(rs.getString("product_name"));
            ci.setProductPrice(rs.getBigDecimal("product_price"));
            ci.setProductImage(rs.getString("product_image"));
            ci.setProductStock(rs.getInt("product_stock"));
        } catch (SQLException ignored) {
        }
        return ci;
    }

    public List<CartItem> findByCartId(int cartId) {
        return queryList(
                "SELECT ci.*, p.name AS product_name, p.price AS product_price, p.image AS product_image, p.stock AS product_stock "
                        +
                        "FROM cart_items ci JOIN products p ON ci.product_id = p.id WHERE ci.cart_id = ?",
                cartId);
    }

    public CartItem findByCartIdAndProductId(int cartId, int productId) {
        return queryOne(
                "SELECT ci.*, p.name AS product_name, p.price AS product_price, p.image AS product_image, p.stock AS product_stock "
                        +
                        "FROM cart_items ci JOIN products p ON ci.product_id = p.id WHERE ci.cart_id = ? AND ci.product_id = ?",
                cartId, productId);
    }

    public int insertCartItem(CartItem ci) {
        return insert("INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (?, ?, ?)",
                ci.getCartId(), ci.getProductId(), ci.getQuantity());
    }

    public int updateQuantity(int id, int quantity) {
        return update("UPDATE cart_items SET quantity = ? WHERE id = ?", quantity, id);
    }

    public int deleteCartItem(int id) {
        return update("DELETE FROM cart_items WHERE id = ?", id);
    }

    public int deleteByCartId(int cartId) {
        return update("DELETE FROM cart_items WHERE cart_id = ?", cartId);
    }

    public int countByCartId(int cartId) {
        return count("SELECT COUNT(*) FROM cart_items WHERE cart_id = ?", cartId);
    }
}
