package com.shop.repository;

import com.shop.entity.User;
import java.util.List;

public interface IUserRepository {
    User findById(int id);

    User findByUsername(String username);

    User findByEmail(String email);

    List<User> findAll();

    List<User> findByRole(String role);

    int save(User user);

    int update(User user);

    int delete(int id);

    int countAll();

    int countByRole(String role);
}
