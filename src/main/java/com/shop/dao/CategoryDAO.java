package com.shop.dao;

import com.shop.entity.Category;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CategoryDAO extends BaseDAO<Category> {

    @Override
    protected Category mapRow(ResultSet rs) throws SQLException {
        Category c = new Category();
        c.setId(rs.getInt("id"));
        c.setName(rs.getString("name"));
        c.setDescription(rs.getString("description"));
        return c;
    }

    public Category findById(int id) {
        return queryOne("SELECT * FROM categories WHERE id = ?", id);
    }

    public List<Category> findAll() {
        return queryList("SELECT * FROM categories ORDER BY name");
    }

    public int insertCategory(Category c) {
        return insert("INSERT INTO categories (name, description) VALUES (?, ?)", c.getName(), c.getDescription());
    }

    public int updateCategory(Category c) {
        return update("UPDATE categories SET name = ?, description = ? WHERE id = ?", c.getName(), c.getDescription(),
                c.getId());
    }

    public int deleteCategory(int id) {
        return update("DELETE FROM categories WHERE id = ?", id);
    }
}
