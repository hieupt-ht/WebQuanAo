package com.shop.repository;

import com.shop.entity.Category;
import java.util.List;

public interface ICategoryRepository {
    Category findById(int id);

    List<Category> findAll();

    int save(Category category);

    int update(Category category);

    int delete(int id);
}
