package com.shop.dao;

import com.shop.entity.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserDAO extends BaseDAO<User> {

    @Override
    protected User mapRow(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setFullname(rs.getString("fullname"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setRole(rs.getString("role"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        return user;
    }

    public User findById(int id) {
        return queryOne("SELECT * FROM users WHERE id = ?", id);
    }

    public User findByUsername(String username) {
        return queryOne("SELECT * FROM users WHERE username = ?", username);
    }

    public User findByEmail(String email) {
        return queryOne("SELECT * FROM users WHERE email = ?", email);
    }

    public List<User> findAll() {
        return queryList("SELECT * FROM users ORDER BY created_at DESC");
    }

    public List<User> findByRole(String role) {
        return queryList("SELECT * FROM users WHERE role = ? ORDER BY created_at DESC", role);
    }

    public int insertUser(User user) {
        return insert(
                "INSERT INTO users (username, password, fullname, email, phone, address, role) VALUES (?, ?, ?, ?, ?, ?, ?)",
                user.getUsername(), user.getPassword(), user.getFullname(), user.getEmail(),
                user.getPhone(), user.getAddress(), user.getRole() != null ? user.getRole() : "USER");
    }

    public int updateUser(User user) {
        return update("UPDATE users SET fullname = ?, email = ?, phone = ?, address = ? WHERE id = ?",
                user.getFullname(), user.getEmail(), user.getPhone(), user.getAddress(), user.getId());
    }

    public int deleteUser(int id) {
        return update("DELETE FROM users WHERE id = ?", id);
    }

    public int countAll() {
        return count("SELECT COUNT(*) FROM users");
    }

    public int countByRole(String role) {
        return count("SELECT COUNT(*) FROM users WHERE role = ?", role);
    }
}
