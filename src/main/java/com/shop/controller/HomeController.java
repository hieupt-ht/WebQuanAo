package com.shop.controller;

import com.shop.entity.Product;
import com.shop.entity.User;
import com.shop.service.ICartService;
import com.shop.service.ICategoryService;
import com.shop.service.IProductService;
import com.shop.service.impl.CartServiceImpl;
import com.shop.service.impl.CategoryServiceImpl;
import com.shop.service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();
    private final ICartService cartService = new CartServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> featuredProducts = productService.getFeatured(8);
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("categories", categoryService.getAll());

        // Update cart count in session if user is logged in
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            request.getSession().setAttribute("cartItemCount", cartService.getCartItemCount(user.getId()));
        }

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
