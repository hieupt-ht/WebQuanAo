package com.shop.controller;

import com.shop.service.IOrderService;
import com.shop.service.IProductService;
import com.shop.service.IReportService;
import com.shop.service.IUserService;
import com.shop.service.impl.OrderServiceImpl;
import com.shop.service.impl.ProductServiceImpl;
import com.shop.service.impl.ReportServiceImpl;
import com.shop.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();
    private final IOrderService orderService = new OrderServiceImpl();
    private final IUserService userService = new UserServiceImpl();
    private final IReportService reportService = new ReportServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thống kê cơ bản
        request.setAttribute("productCount", productService.countAll());
        request.setAttribute("orderCount", orderService.countAll());
        request.setAttribute("userCount", userService.getCustomers().size());

        // Thống kê theo trạng thái đơn hàng
        request.setAttribute("pendingOrderCount", orderService.countByStatus("PENDING"));
        request.setAttribute("shippingOrderCount", orderService.countByStatus("SHIPPING"));
        request.setAttribute("completedOrderCount", orderService.countByStatus("COMPLETED"));

        // Tổng doanh thu
        request.setAttribute("totalRevenue", orderService.getTotalRevenue());

        // Top sản phẩm bán chạy
        request.setAttribute("topProducts", reportService.getTopSellingProducts(5));

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
