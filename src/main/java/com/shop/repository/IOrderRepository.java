package com.shop.repository;

import com.shop.entity.Order;
import java.math.BigDecimal;
import java.util.List;

public interface IOrderRepository {
    Order findById(int id);

    List<Order> findAll();

    List<Order> findByUserId(int userId);

    List<Order> findByStatus(String status);

    int save(Order order);

    int updateStatus(int orderId, String status);

    int delete(int id);

    int countAll();

    int countByStatus(String status);

    BigDecimal getTotalRevenue();
}
