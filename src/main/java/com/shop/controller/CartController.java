package com.shop.controller;

import com.shop.entity.CartItem;
import com.shop.entity.User;
import com.shop.service.ICartService;
import com.shop.service.impl.CartServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/cart/*")
public class CartController extends HttpServlet {
    private final ICartService cartService = new CartServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null || "/".equals(action)) {
            handleView(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        if ("/add".equals(action)) {
            handleAdd(request, response);
        } else if ("/update".equals(action)) {
            handleUpdate(request, response);
        } else if ("/remove".equals(action)) {
            handleRemove(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        List<CartItem> items = cartService.getCartItems(user.getId());

        request.setAttribute("cartItems", items);
        request.setAttribute("cartTotal", cartService.getCartTotal(user.getId()));
        updateCartCount(request.getSession(), user.getId());
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        cartService.addToCart(user.getId(), productId, quantity);
        updateCartCount(request.getSession(), user.getId());
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        cartService.updateQuantity(user.getId(), itemId, quantity);
        updateCartCount(request.getSession(), user.getId());
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleRemove(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        int itemId = Integer.parseInt(request.getParameter("itemId"));

        cartService.removeItem(user.getId(), itemId);
        updateCartCount(request.getSession(), user.getId());
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void updateCartCount(HttpSession session, int userId) {
        session.setAttribute("cartItemCount", cartService.getCartItemCount(userId));
    }
}
