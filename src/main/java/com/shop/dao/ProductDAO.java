package com.shop.dao;

import com.shop.entity.Product;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ProductDAO extends BaseDAO<Product> {

    @Override
    protected Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setImage(rs.getString("image"));
        p.setSize(rs.getString("size"));
        p.setColor(rs.getString("color"));
        p.setStock(rs.getInt("stock"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        try {
            p.setCategoryName(rs.getString("category_name"));
        } catch (SQLException ignored) {
        }
        return p;
    }

    public Product findById(int id) {
        return queryOne(
                "SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id = c.id WHERE p.id = ?",
                id);
    }

    public List<Product> findAll() {
        return queryList(
                "SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id = c.id ORDER BY p.created_at DESC");
    }

    public List<Product> findByCategory(int categoryId) {
        return queryList(
                "SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id = c.id WHERE p.category_id = ? ORDER BY p.created_at DESC",
                categoryId);
    }

    public List<Product> search(String keyword) {
        String like = "%" + keyword + "%";
        return queryList(
                "SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id = c.id WHERE p.name LIKE ? OR p.description LIKE ? ORDER BY p.created_at DESC",
                like, like);
    }

    public List<Product> findByPriceRange(double minPrice, double maxPrice) {
        return queryList(
                "SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id = c.id WHERE p.price BETWEEN ? AND ? ORDER BY p.price ASC",
                minPrice, maxPrice);
    }

    public List<Product> findWithPagination(int offset, int limit) {
        return queryList(
                "SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id = c.id ORDER BY p.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY",
                offset, limit);
    }

    public List<Product> findByCategoryWithPagination(int categoryId, int offset, int limit) {
        return queryList(
                "SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id = c.id WHERE p.category_id = ? ORDER BY p.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY",
                categoryId, offset, limit);
    }

    public List<Product> searchWithPagination(String keyword, int offset, int limit) {
        String like = "%" + keyword + "%";
        return queryList(
                "SELECT p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id = c.id WHERE p.name LIKE ? OR p.description LIKE ? ORDER BY p.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY",
                like, like, offset, limit);
    }

    public List<Product> findFeatured(int limit) {
        return queryList(
                "SELECT TOP (?) p.*, c.name AS category_name FROM products p JOIN categories c ON p.category_id = c.id ORDER BY p.stock DESC, p.created_at DESC",
                limit);
    }

    public int insertProduct(Product p) {
        return insert(
                "INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                p.getName(), p.getDescription(), p.getPrice(), p.getImage(), p.getSize(), p.getColor(), p.getStock(),
                p.getCategoryId());
    }

    public int updateProduct(Product p) {
        return update(
                "UPDATE products SET name = ?, description = ?, price = ?, image = ?, size = ?, color = ?, stock = ?, category_id = ? WHERE id = ?",
                p.getName(), p.getDescription(), p.getPrice(), p.getImage(), p.getSize(), p.getColor(), p.getStock(),
                p.getCategoryId(), p.getId());
    }

    public int deleteProduct(int id) {
        return update("DELETE FROM products WHERE id = ?", id);
    }

    public int countAll() {
        return count("SELECT COUNT(*) FROM products");
    }

    public int countByCategory(int categoryId) {
        return count("SELECT COUNT(*) FROM products WHERE category_id = ?", categoryId);
    }

    public int countBySearch(String keyword) {
        String like = "%" + keyword + "%";
        return count("SELECT COUNT(*) FROM products WHERE name LIKE ? OR description LIKE ?", like, like);
    }

    public int updateStock(int productId, int quantity) {
        return update("UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?", quantity, productId,
                quantity);
    }
}
