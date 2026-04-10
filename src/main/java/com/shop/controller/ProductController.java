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
import java.util.List;

@WebServlet("/products/*")
public class ProductController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();
    private static final int PAGE_SIZE = 9;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || "/".equals(pathInfo)) {
            handleList(request, response);
        } else if ("/detail".equals(pathInfo)) {
            handleDetail(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryIdStr = request.getParameter("categoryId");
        String keyword = request.getParameter("keyword");
        String pageStr = request.getParameter("page");

        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        List<Product> products;
        int totalPages;

        if (keyword != null && !keyword.isEmpty()) {
            products = productService.searchWithPagination(keyword, page, PAGE_SIZE);
            totalPages = productService.getTotalPagesBySearch(keyword, PAGE_SIZE);
            request.setAttribute("keyword", keyword);
        } else if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            int categoryId = Integer.parseInt(categoryIdStr);
            products = productService.getByCategoryWithPagination(categoryId, page, PAGE_SIZE);
            totalPages = productService.getTotalPagesByCategory(categoryId, PAGE_SIZE);
            request.setAttribute("categoryId", categoryId);
        } else {
            products = productService.getWithPagination(page, PAGE_SIZE);
            totalPages = productService.getTotalPages(PAGE_SIZE);
        }

        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categories", categoryService.getAll());

        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
    }

    private void handleDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productService.getById(id);

        if (product != null) {
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
