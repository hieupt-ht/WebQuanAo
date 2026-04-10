package com.shop.dao;

import com.shop.entity.OrderDetail;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class OrderDetailDAO extends BaseDAO<OrderDetail> {

    @Override
    protected OrderDetail mapRow(ResultSet rs) throws SQLException {
        OrderDetail od = new OrderDetail();
        od.setId(rs.getInt("id"));
        od.setOrderId(rs.getInt("order_id"));
        od.setProductId(rs.getInt("product_id"));
        od.setQuantity(rs.getInt("quantity"));
        od.setPrice(rs.getBigDecimal("price"));
        try {
            od.setProductName(rs.getString("product_name"));
            od.setProductImage(rs.getString("product_image"));
        } catch (SQLException ignored) {
        }
        return od;
    }

    public List<OrderDetail> findByOrderId(int orderId) {
        return queryList(
                "SELECT od.*, p.name AS product_name, p.image AS product_image FROM order_details od JOIN products p ON od.product_id = p.id WHERE od.order_id = ?",
                orderId);
    }

    public int insertOrderDetail(OrderDetail od) {
        return insert("INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)",
                od.getOrderId(), od.getProductId(), od.getQuantity(), od.getPrice());
    }

    public int deleteByOrderId(int orderId) {
        return update("DELETE FROM order_details WHERE order_id = ?", orderId);
    }
}
