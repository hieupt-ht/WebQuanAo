package com.shop.controller;

import com.shop.entity.User;
import com.shop.entity.UserAddress;
import com.shop.service.IUserAddressService;
import com.shop.service.impl.UserAddressServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet("/user/address/*")
public class AddressController extends HttpServlet {
    private final IUserAddressService addressService = new UserAddressServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || "/".equals(pathInfo)) {
            handleList(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if ("/add".equals(pathInfo)) {
            handleAdd(request, response);
        } else if ("/edit".equals(pathInfo)) {
            handleEdit(request, response);
        } else if ("/delete".equals(pathInfo)) {
            handleDelete(request, response);
        } else if ("/set-default".equals(pathInfo)) {
            handleSetDefault(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        List<UserAddress> addresses = addressService.getAddressesByUserId(user.getId());
        request.setAttribute("addresses", addresses);
        request.getRequestDispatcher("/WEB-INF/views/addresses.jsp").forward(request, response);
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        User user = (User) request.getSession().getAttribute("user");

        UserAddress addr = new UserAddress();
        addr.setUserId(user.getId());
        addr.setReceiverName(request.getParameter("receiverName"));
        addr.setPhone(request.getParameter("phone"));
        addr.setAddressDetail(request.getParameter("addressDetail"));

        String isDefault = request.getParameter("isDefault");
        addr.setDefault(isDefault != null && isDefault.equals("1"));

        addressService.addAddress(addr);
        
        String redirectTo = request.getParameter("redirectTo");
        if ("checkout".equals(redirectTo)) {
            response.sendRedirect(request.getContextPath() + "/order/checkout");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/address?message=" + URLEncoder.encode("Thêm địa chỉ thành công!", "UTF-8"));
        }
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        UserAddress existing = addressService.getAddressById(addressId);
        if (existing == null || existing.getUserId() != user.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        existing.setReceiverName(request.getParameter("receiverName"));
        existing.setPhone(request.getParameter("phone"));
        existing.setAddressDetail(request.getParameter("addressDetail"));

        addressService.updateAddress(existing);
        response.sendRedirect(request.getContextPath() + "/user/address?message=" + URLEncoder.encode("Cập nhật địa chỉ thành công!", "UTF-8"));
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        addressService.deleteAddress(user.getId(), addressId);
        response.sendRedirect(request.getContextPath() + "/user/address?message=" + URLEncoder.encode("Đã xóa địa chỉ!", "UTF-8"));
    }

    private void handleSetDefault(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        addressService.setDefaultAddress(user.getId(), addressId);
        response.sendRedirect(request.getContextPath() + "/user/address?message=" + URLEncoder.encode("Đã đặt địa chỉ mặc định!", "UTF-8"));
    }
}
