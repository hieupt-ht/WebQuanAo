package com.shop.controller;

import com.shop.dto.OrderDTO;
import com.shop.entity.CartItem;
import com.shop.entity.Order;
import com.shop.entity.User;
import com.shop.entity.UserAddress;
import com.shop.service.ICartService;
import com.shop.service.IOrderService;
import com.shop.service.IUserAddressService;
import com.shop.service.impl.CartServiceImpl;
import com.shop.service.impl.OrderServiceImpl;
import com.shop.service.impl.UserAddressServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet("/order/*")
public class OrderController extends HttpServlet {
    private final IOrderService orderService = new OrderServiceImpl();
    private final ICartService cartService = new CartServiceImpl();
    private final IUserAddressService addressService = new UserAddressServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if ("/checkout".equals(pathInfo)) {
            handleCheckoutPage(request, response);
        } else if ("/history".equals(pathInfo)) {
            handleHistory(request, response);
        } else if ("/detail".equals(pathInfo)) {
            handleDetail(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if ("/checkout".equals(pathInfo)) {
            handleCheckoutSubmit(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleCheckoutPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        List<CartItem> items = cartService.getCartItems(user.getId());

        if (items.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Lấy danh sách địa chỉ của user
        List<UserAddress> addresses = addressService.getAddressesByUserId(user.getId());
        UserAddress defaultAddress = addressService.getDefaultAddress(user.getId());

        request.setAttribute("cartItems", items);
        request.setAttribute("total", cartService.getCartTotal(user.getId()));
        request.setAttribute("addresses", addresses);
        request.setAttribute("defaultAddress", defaultAddress);
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }

    private void handleCheckoutSubmit(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        List<CartItem> items = cartService.getCartItems(user.getId());

        if (items.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        Order order = new Order();
        order.setUserId(user.getId());

        // Lấy thông tin giao hàng từ địa chỉ đã chọn hoặc nhập tay
        String addressIdStr = request.getParameter("addressId");
        if (addressIdStr != null && !addressIdStr.isEmpty()) {
            int addressId = Integer.parseInt(addressIdStr);
            UserAddress addr = addressService.getAddressById(addressId);
            if (addr != null && addr.getUserId() == user.getId()) {
                order.setFullname(addr.getReceiverName());
                order.setPhone(addr.getPhone());
                order.setAddress(addr.getAddressDetail());
            } else {
                response.sendRedirect(request.getContextPath() + "/order/checkout?error=" + URLEncoder.encode("Địa chỉ không hợp lệ.", "UTF-8"));
                return;
            }
        } else {
            // Fallback: nhập tay (khi user chưa có địa chỉ nào)
            order.setFullname(request.getParameter("fullname"));
            order.setPhone(request.getParameter("phone"));
            order.setAddress(request.getParameter("address"));
        }

        order.setPaymentMethod(request.getParameter("paymentMethod"));
        order.setTotalAmount(cartService.getCartTotal(user.getId()));
        order.setStatus("PENDING");

        if (orderService.placeOrder(order, items)) {
            cartService.clearCart(user.getId());
            response.sendRedirect(request.getContextPath() + "/order/history?message=" + URLEncoder.encode("Đặt hàng thành công!", "UTF-8"));
        } else {
            response.sendRedirect(request.getContextPath() + "/order/checkout?error=" + URLEncoder.encode("Đặt hàng thất bại.", "UTF-8"));
        }
    }

    private void handleHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        List<OrderDTO> orders = orderService.getOrdersByUserId(user.getId());

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/views/order-history.jsp").forward(request, response);
    }

    private void handleDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        OrderDTO order = orderService.getOrderById(id);

        User user = (User) request.getSession().getAttribute("user");
        if (order != null && order.getUserId() == user.getId()) {
            request.setAttribute("order", order);
            request.getRequestDispatcher("/WEB-INF/views/order-detail.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        }
    }
}
