package com.shop.controller;

import com.shop.entity.Product;
import com.shop.service.ICategoryService;
import com.shop.service.IProductService;
import com.shop.service.impl.CategoryServiceImpl;
import com.shop.service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/products/*")
public class AdminProductController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null || "/".equals(action)) {
            request.setAttribute("products", productService.getAll());
            request.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(request, response);
        } else if ("/add".equals(action)) {
            request.setAttribute("categories", categoryService.getAll());
            request.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(request, response);
        } else if ("/edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("product", productService.getById(id));
            request.setAttribute("categories", categoryService.getAll());
            request.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(request, response);
        } else if ("/delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            productService.delete(id);
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        Product p = new Product();
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            p.setId(Integer.parseInt(idStr));
        }

        p.setName(request.getParameter("name"));
        p.setDescription(request.getParameter("description"));
        p.setPrice(new BigDecimal(request.getParameter("price")));
        p.setImage(request.getParameter("image")); // For now, simple URL/filename string
        p.setSize(request.getParameter("size"));
        p.setColor(request.getParameter("color"));
        p.setStock(Integer.parseInt(request.getParameter("stock")));
        p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));

        if ("/add".equals(action)) {
            productService.save(p);
        } else if ("/edit".equals(action)) {
            productService.update(p);
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
