package com.shop.service;

import com.shop.entity.Category;
import java.util.List;

public interface ICategoryService {
    Category getById(int id);

    List<Category> getAll();

    boolean save(Category category);

    boolean update(Category category);

    boolean delete(int id);
}
