package com.shop.repository.impl;

import com.shop.dao.ProductDAO;
import com.shop.entity.Product;
import com.shop.repository.IProductRepository;
import java.util.List;

public class ProductRepositoryImpl implements IProductRepository {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    public Product findById(int id) {
        return productDAO.findById(id);
    }

    @Override
    public List<Product> findAll() {
        return productDAO.findAll();
    }

    @Override
    public List<Product> findByCategory(int categoryId) {
        return productDAO.findByCategory(categoryId);
    }

    @Override
    public List<Product> search(String keyword) {
        return productDAO.search(keyword);
    }

    @Override
    public List<Product> findByPriceRange(double min, double max) {
        return productDAO.findByPriceRange(min, max);
    }

    @Override
    public List<Product> findWithPagination(int offset, int limit) {
        return productDAO.findWithPagination(offset, limit);
    }

    @Override
    public List<Product> findByCategoryWithPagination(int categoryId, int offset, int limit) {
        return productDAO.findByCategoryWithPagination(categoryId, offset, limit);
    }

    @Override
    public List<Product> searchWithPagination(String keyword, int offset, int limit) {
        return productDAO.searchWithPagination(keyword, offset, limit);
    }

    @Override
    public List<Product> findFeatured(int limit) {
        return productDAO.findFeatured(limit);
    }

    @Override
    public int save(Product product) {
        return productDAO.insertProduct(product);
    }

    @Override
    public int update(Product product) {
        return productDAO.updateProduct(product);
    }

    @Override
    public int delete(int id) {
        return productDAO.deleteProduct(id);
    }

    @Override
    public int countAll() {
        return productDAO.countAll();
    }

    @Override
    public int countByCategory(int categoryId) {
        return productDAO.countByCategory(categoryId);
    }

    @Override
    public int countBySearch(String keyword) {
        return productDAO.countBySearch(keyword);
    }

    @Override
    public int updateStock(int productId, int quantity) {
        return productDAO.updateStock(productId, quantity);
    }
}
