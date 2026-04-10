package com.shop.repository;

import com.shop.entity.Product;
import java.util.List;

public interface IProductRepository {
    Product findById(int id);

    List<Product> findAll();

    List<Product> findByCategory(int categoryId);

    List<Product> search(String keyword);

    List<Product> findByPriceRange(double min, double max);

    List<Product> findWithPagination(int offset, int limit);

    List<Product> findByCategoryWithPagination(int categoryId, int offset, int limit);

    List<Product> searchWithPagination(String keyword, int offset, int limit);

    List<Product> findFeatured(int limit);

    int save(Product product);

    int update(Product product);

    int delete(int id);

    int countAll();

    int countByCategory(int categoryId);

    int countBySearch(String keyword);

    int updateStock(int productId, int quantity);
}
