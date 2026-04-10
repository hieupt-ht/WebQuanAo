package com.shop.service.impl;

import com.shop.entity.Category;
import com.shop.repository.ICategoryRepository;
import com.shop.repository.impl.CategoryRepositoryImpl;
import com.shop.service.ICategoryService;
import java.util.List;

public class CategoryServiceImpl implements ICategoryService {
    private final ICategoryRepository categoryRepository = new CategoryRepositoryImpl();

    @Override
    public Category getById(int id) {
        return categoryRepository.findById(id);
    }

    @Override
    public List<Category> getAll() {
        return categoryRepository.findAll();
    }

    @Override
    public boolean save(Category category) {
        return categoryRepository.save(category) > 0;
    }

    @Override
    public boolean update(Category category) {
        return categoryRepository.update(category) > 0;
    }

    @Override
    public boolean delete(int id) {
        return categoryRepository.delete(id) > 0;
    }
}
