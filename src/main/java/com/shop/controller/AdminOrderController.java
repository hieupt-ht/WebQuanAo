package com.shop.controller;

import com.shop.service.IOrderService;
import com.shop.service.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/orders/*")
public class AdminOrderController extends HttpServlet {
    private final IOrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null || "/".equals(action)) {
            request.setAttribute("orders", orderService.getAllOrders());
            request.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(request, response);
        } else if ("/updateStatus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            orderService.updateStatus(id, status);
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
}
