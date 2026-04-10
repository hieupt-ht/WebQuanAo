package com.shop.service.impl;

import com.shop.entity.Product;
import com.shop.repository.IProductRepository;
import com.shop.repository.impl.ProductRepositoryImpl;
import com.shop.service.IProductService;
import java.util.List;

public class ProductServiceImpl implements IProductService {
    private final IProductRepository productRepository = new ProductRepositoryImpl();

    @Override
    public Product getById(int id) {
        return productRepository.findById(id);
    }

    @Override
    public List<Product> getAll() {
        return productRepository.findAll();
    }

    @Override
    public List<Product> getByCategory(int categoryId) {
        return productRepository.findByCategory(categoryId);
    }

    @Override
    public List<Product> search(String keyword) {
        return productRepository.search(keyword);
    }

    @Override
    public List<Product> getWithPagination(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return productRepository.findWithPagination(offset, pageSize);
    }

    @Override
    public List<Product> getByCategoryWithPagination(int categoryId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return productRepository.findByCategoryWithPagination(categoryId, offset, pageSize);
    }

    @Override
    public List<Product> searchWithPagination(String keyword, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return productRepository.searchWithPagination(keyword, offset, pageSize);
    }

    @Override
    public List<Product> getFeatured(int limit) {
        return productRepository.findFeatured(limit);
    }

    @Override
    public boolean save(Product product) {
        return productRepository.save(product) > 0;
    }

    @Override
    public boolean update(Product product) {
        return productRepository.update(product) > 0;
    }

    @Override
    public boolean delete(int id) {
        return productRepository.delete(id) > 0;
    }

    @Override
    public int getTotalPages(int pageSize) {
        int total = productRepository.countAll();
        return (int) Math.ceil((double) total / pageSize);
    }

    @Override
    public int getTotalPagesByCategory(int categoryId, int pageSize) {
        int total = productRepository.countByCategory(categoryId);
        return (int) Math.ceil((double) total / pageSize);
    }

    @Override
    public int getTotalPagesBySearch(String keyword, int pageSize) {
        int total = productRepository.countBySearch(keyword);
        return (int) Math.ceil((double) total / pageSize);
    }

    @Override
    public int countAll() {
        return productRepository.countAll();
    }
}
