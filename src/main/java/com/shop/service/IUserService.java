package com.shop.service;

import com.shop.dto.UserDTO;
import com.shop.entity.User;
import java.util.List;

public interface IUserService {
    User login(String username, String password);

    boolean register(User user);

    UserDTO getUserById(int id);

    List<UserDTO> getAllUsers();

    List<UserDTO> getCustomers();

    boolean updateUser(User user);

    boolean isUsernameExists(String username);

    boolean isEmailExists(String email);
}
