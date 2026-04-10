package com.shop.dao;

import com.shop.dto.CustomerReportDTO;
import com.shop.dto.TopProductDTO;
import com.shop.util.DBConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {

    public List<CustomerReportDTO> getCustomerReport() {
        List<CustomerReportDTO> list = new ArrayList<>();
        String sql = "SELECT u.fullname, u.phone, u.email, " +
                "COUNT(o.id) AS total_orders, " +
                "COALESCE(SUM(o.total_amount), 0) AS total_amount " +
                "FROM users u " +
                "INNER JOIN orders o ON u.id = o.user_id " +
                "WHERE o.status = 'COMPLETED' " +
                "GROUP BY u.id, u.fullname, u.phone, u.email " +
                "ORDER BY total_amount DESC";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                CustomerReportDTO dto = new CustomerReportDTO();
                dto.setFullname(rs.getString("fullname"));
                dto.setPhone(rs.getString("phone"));
                dto.setEmail(rs.getString("email"));
                dto.setTotalOrders(rs.getInt("total_orders"));
                dto.setTotalAmount(rs.getBigDecimal("total_amount"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    public List<TopProductDTO> getTopSellingProducts(int limit) {
        List<TopProductDTO> list = new ArrayList<>();
        String sql = "SELECT TOP (?) p.id AS product_id, p.name AS product_name, p.image AS product_image, " +
                "SUM(od.quantity) AS total_sold, SUM(od.quantity * od.price) AS total_revenue " +
                "FROM order_details od " +
                "INNER JOIN products p ON od.product_id = p.id " +
                "INNER JOIN orders o ON od.order_id = o.id " +
                "WHERE o.status IN ('COMPLETED', 'SHIPPING', 'PENDING') " +
                "GROUP BY p.id, p.name, p.image " +
                "ORDER BY total_sold DESC";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                TopProductDTO dto = new TopProductDTO();
                dto.setProductId(rs.getInt("product_id"));
                dto.setProductName(rs.getString("product_name"));
                dto.setProductImage(rs.getString("product_image"));
                dto.setTotalSold(rs.getInt("total_sold"));
                dto.setTotalRevenue(rs.getBigDecimal("total_revenue"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }
}
