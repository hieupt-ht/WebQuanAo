package com.shop.repository.impl;

import com.shop.dao.CategoryDAO;
import com.shop.entity.Category;
import com.shop.repository.ICategoryRepository;
import java.util.List;

public class CategoryRepositoryImpl implements ICategoryRepository {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    public Category findById(int id) {
        return categoryDAO.findById(id);
    }

    @Override
    public List<Category> findAll() {
        return categoryDAO.findAll();
    }

    @Override
    public int save(Category category) {
        return categoryDAO.insertCategory(category);
    }

    @Override
    public int update(Category category) {
        return categoryDAO.updateCategory(category);
    }

    @Override
    public int delete(int id) {
        return categoryDAO.deleteCategory(id);
    }
}
