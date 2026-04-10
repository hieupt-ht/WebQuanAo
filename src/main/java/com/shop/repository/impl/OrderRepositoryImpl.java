package com.shop.repository.impl;

import com.shop.dao.OrderDAO;
import com.shop.entity.Order;
import com.shop.repository.IOrderRepository;
import java.math.BigDecimal;
import java.util.List;

public class OrderRepositoryImpl implements IOrderRepository {
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    public Order findById(int id) {
        return orderDAO.findById(id);
    }

    @Override
    public List<Order> findAll() {
        return orderDAO.findAll();
    }

    @Override
    public List<Order> findByUserId(int userId) {
        return orderDAO.findByUserId(userId);
    }

    @Override
    public List<Order> findByStatus(String status) {
        return orderDAO.findByStatus(status);
    }

    @Override
    public int save(Order order) {
        return orderDAO.insertOrder(order);
    }

    @Override
    public int updateStatus(int orderId, String status) {
        return orderDAO.updateStatus(orderId, status);
    }

    @Override
    public int delete(int id) {
        return orderDAO.deleteOrder(id);
    }

    @Override
    public int countAll() {
        return orderDAO.countAll();
    }

    @Override
    public int countByStatus(String status) {
        return orderDAO.countByStatus(status);
    }

    @Override
    public BigDecimal getTotalRevenue() {
        return orderDAO.getTotalRevenue();
    }
}
