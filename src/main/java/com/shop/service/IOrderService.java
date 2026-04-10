package com.shop.service;

import com.shop.dto.OrderDTO;
import com.shop.entity.CartItem;
import com.shop.entity.Order;
import java.math.BigDecimal;
import java.util.List;

public interface IOrderService {
    boolean placeOrder(Order order, List<CartItem> cartItems);

    OrderDTO getOrderById(int id);

    List<OrderDTO> getAllOrders();

    List<OrderDTO> getOrdersByUserId(int userId);

    boolean updateStatus(int orderId, String status);

    int countAll();

    int countByStatus(String status);

    BigDecimal getTotalRevenue();
}
