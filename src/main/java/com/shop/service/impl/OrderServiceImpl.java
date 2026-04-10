package com.shop.service.impl;

import com.shop.dao.OrderDetailDAO;
import com.shop.dto.OrderDTO;
import com.shop.entity.CartItem;
import com.shop.entity.Order;
import com.shop.entity.OrderDetail;
import com.shop.repository.IOrderRepository;
import com.shop.repository.IProductRepository;
import com.shop.repository.impl.OrderRepositoryImpl;
import com.shop.repository.impl.ProductRepositoryImpl;
import com.shop.service.IOrderService;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class OrderServiceImpl implements IOrderService {
    private final IOrderRepository orderRepository = new OrderRepositoryImpl();
    private final IProductRepository productRepository = new ProductRepositoryImpl();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    @Override
    public boolean placeOrder(Order order, List<CartItem> cartItems) {
        int orderId = orderRepository.save(order);
        if (orderId <= 0)
            return false;

        for (CartItem item : cartItems) {
            OrderDetail detail = new OrderDetail();
            detail.setOrderId(orderId);
            detail.setProductId(item.getProductId());
            detail.setQuantity(item.getQuantity());
            detail.setPrice(item.getProductPrice());
            orderDetailDAO.insertOrderDetail(detail);

            // Giảm stock
            productRepository.updateStock(item.getProductId(), item.getQuantity());
        }
        return true;
    }

    @Override
    public OrderDTO getOrderById(int id) {
        Order order = orderRepository.findById(id);
        if (order == null)
            return null;
        return toDTO(order);
    }

    @Override
    public List<OrderDTO> getAllOrders() {
        return toDTOList(orderRepository.findAll());
    }

    @Override
    public List<OrderDTO> getOrdersByUserId(int userId) {
        return toDTOList(orderRepository.findByUserId(userId));
    }

    @Override
    public boolean updateStatus(int orderId, String status) {
        return orderRepository.updateStatus(orderId, status) > 0;
    }

    @Override
    public int countAll() {
        return orderRepository.countAll();
    }

    @Override
    public int countByStatus(String status) {
        return orderRepository.countByStatus(status);
    }

    @Override
    public BigDecimal getTotalRevenue() {
        return orderRepository.getTotalRevenue();
    }

    private OrderDTO toDTO(Order order) {
        OrderDTO dto = new OrderDTO();
        dto.setId(order.getId());
        dto.setUserId(order.getUserId());
        dto.setUsername(order.getUsername());
        dto.setFullname(order.getFullname());
        dto.setPhone(order.getPhone());
        dto.setAddress(order.getAddress());
        dto.setTotalAmount(order.getTotalAmount());
        dto.setStatus(order.getStatus());
        dto.setPaymentMethod(order.getPaymentMethod());
        dto.setCreatedAt(order.getCreatedAt());
        dto.setOrderDetails(orderDetailDAO.findByOrderId(order.getId()));
        return dto;
    }

    private List<OrderDTO> toDTOList(List<Order> orders) {
        List<OrderDTO> dtos = new ArrayList<>();
        for (Order order : orders) {
            dtos.add(toDTO(order));
        }
        return dtos;
    }
}
