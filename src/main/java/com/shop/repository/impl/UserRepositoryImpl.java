package com.shop.repository.impl;

import com.shop.dao.UserDAO;
import com.shop.entity.User;
import com.shop.repository.IUserRepository;
import java.util.List;

public class UserRepositoryImpl implements IUserRepository {
    private final UserDAO userDAO = new UserDAO();

    @Override
    public User findById(int id) {
        return userDAO.findById(id);
    }

    @Override
    public User findByUsername(String username) {
        return userDAO.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDAO.findByEmail(email);
    }

    @Override
    public List<User> findAll() {
        return userDAO.findAll();
    }

    @Override
    public List<User> findByRole(String role) {
        return userDAO.findByRole(role);
    }

    @Override
    public int save(User user) {
        return userDAO.insertUser(user);
    }

    @Override
    public int update(User user) {
        return userDAO.updateUser(user);
    }

    @Override
    public int delete(int id) {
        return userDAO.deleteUser(id);
    }

    @Override
    public int countAll() {
        return userDAO.countAll();
    }

    @Override
    public int countByRole(String role) {
        return userDAO.countByRole(role);
    }
}
