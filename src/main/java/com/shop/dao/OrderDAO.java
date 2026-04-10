package com.shop.dao;

import com.shop.entity.Order;
import com.shop.util.DBConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.List;

public class OrderDAO extends BaseDAO<Order> {

    @Override
    protected Order mapRow(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setUserId(rs.getInt("user_id"));
        o.setFullname(rs.getString("fullname"));
        o.setPhone(rs.getString("phone"));
        o.setAddress(rs.getString("address"));
        o.setTotalAmount(rs.getBigDecimal("total_amount"));
        o.setStatus(rs.getString("status"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setCreatedAt(rs.getTimestamp("created_at"));
        try {
            o.setUsername(rs.getString("username"));
        } catch (SQLException ignored) {
        }
        return o;
    }

    public Order findById(int id) {
        return queryOne("SELECT o.*, u.username FROM orders o JOIN users u ON o.user_id = u.id WHERE o.id = ?", id);
    }

    public List<Order> findAll() {
        return queryList(
                "SELECT o.*, u.username FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.created_at DESC");
    }

    public List<Order> findByUserId(int userId) {
        return queryList(
                "SELECT o.*, u.username FROM orders o JOIN users u ON o.user_id = u.id WHERE o.user_id = ? ORDER BY o.created_at DESC",
                userId);
    }

    public List<Order> findByStatus(String status) {
        return queryList(
                "SELECT o.*, u.username FROM orders o JOIN users u ON o.user_id = u.id WHERE o.status = ? ORDER BY o.created_at DESC",
                status);
    }

    public int insertOrder(Order o) {
        return insert(
                "INSERT INTO orders (user_id, fullname, phone, address, total_amount, status, payment_method) VALUES (?, ?, ?, ?, ?, ?, ?)",
                o.getUserId(), o.getFullname(), o.getPhone(), o.getAddress(), o.getTotalAmount(),
                o.getStatus() != null ? o.getStatus() : "PENDING",
                o.getPaymentMethod() != null ? o.getPaymentMethod() : "COD");
    }

    public int updateStatus(int orderId, String status) {
        return update("UPDATE orders SET status = ? WHERE id = ?", status, orderId);
    }

    public int deleteOrder(int id) {
        return update("DELETE FROM orders WHERE id = ?", id);
    }

    public int countAll() {
        return count("SELECT COUNT(*) FROM orders");
    }

    public int countByStatus(String status) {
        return count("SELECT COUNT(*) FROM orders WHERE status = ?", status);
    }

    public BigDecimal getTotalRevenue() {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement("SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE status = 'COMPLETED'");
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return BigDecimal.ZERO;
    }
}
