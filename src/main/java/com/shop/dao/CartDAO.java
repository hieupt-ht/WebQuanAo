package com.shop.dao;

import com.shop.entity.Cart;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CartDAO extends BaseDAO<Cart> {

    @Override
    protected Cart mapRow(ResultSet rs) throws SQLException {
        Cart c = new Cart();
        c.setId(rs.getInt("id"));
        c.setUserId(rs.getInt("user_id"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        return c;
    }

    public Cart findByUserId(int userId) {
        return queryOne("SELECT * FROM cart WHERE user_id = ?", userId);
    }

    public int insertCart(int userId) {
        return insert("INSERT INTO cart (user_id) VALUES (?)", userId);
    }

    public int deleteByUserId(int userId) {
        return update("DELETE FROM cart WHERE user_id = ?", userId);
    }
}
