package com.shop.service;

import com.shop.entity.Product;
import java.util.List;

public interface IProductService {
    Product getById(int id);

    List<Product> getAll();

    List<Product> getByCategory(int categoryId);

    List<Product> search(String keyword);

    List<Product> getWithPagination(int page, int pageSize);

    List<Product> getByCategoryWithPagination(int categoryId, int page, int pageSize);

    List<Product> searchWithPagination(String keyword, int page, int pageSize);

    List<Product> getFeatured(int limit);

    boolean save(Product product);

    boolean update(Product product);

    boolean delete(int id);

    int getTotalPages(int pageSize);

    int getTotalPagesByCategory(int categoryId, int pageSize);

    int getTotalPagesBySearch(String keyword, int pageSize);

    int countAll();
}
