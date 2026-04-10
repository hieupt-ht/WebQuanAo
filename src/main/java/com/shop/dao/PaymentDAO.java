package com.shop.dao;

import com.shop.entity.Payment;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class PaymentDAO extends BaseDAO<Payment> {

    @Override
    protected Payment mapRow(ResultSet rs) throws SQLException {
        Payment p = new Payment();
        p.setId(rs.getInt("id"));
        p.setOrderId(rs.getInt("order_id"));
        p.setMethod(rs.getString("method"));
        p.setAmount(rs.getBigDecimal("amount"));
        p.setStatus(rs.getString("status"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    }

    public Payment findByOrderId(int orderId) {
        return queryOne("SELECT * FROM payments WHERE order_id = ?", orderId);
    }

    public List<Payment> findAll() {
        return queryList("SELECT * FROM payments ORDER BY created_at DESC");
    }

    public int insertPayment(Payment p) {
        return insert("INSERT INTO payments (order_id, method, amount, status) VALUES (?, ?, ?, ?)",
                p.getOrderId(), p.getMethod(), p.getAmount(), p.getStatus() != null ? p.getStatus() : "PENDING");
    }

    public int updateStatus(int paymentId, String status) {
        return update("UPDATE payments SET status = ? WHERE id = ?", status, paymentId);
    }
}
