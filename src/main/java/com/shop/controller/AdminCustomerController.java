package com.shop.controller;

import com.shop.service.IReportService;
import com.shop.service.IUserService;
import com.shop.service.impl.ReportServiceImpl;
import com.shop.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/customers/*")
public class AdminCustomerController extends HttpServlet {
    private final IUserService userService = new UserServiceImpl();
    private final IReportService reportService = new ReportServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        if (action == null || "/".equals(action)) {
            request.setAttribute("customers", userService.getCustomers());
            request.getRequestDispatcher("/WEB-INF/views/admin/customers.jsp").forward(request, response);
        } else if ("/export".equals(action)) {
            handleExport(request, response);
        }
    }

    private void handleExport(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=customers_report.xlsx");

        try {
            reportService.exportCustomerReport(response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Export failed");
        }
    }
}
