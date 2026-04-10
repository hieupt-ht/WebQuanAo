package com.shop.service.impl;

import com.shop.dto.UserDTO;
import com.shop.entity.User;
import com.shop.repository.IUserRepository;
import com.shop.repository.impl.UserRepositoryImpl;
import com.shop.service.IUserService;
import com.shop.util.PasswordUtil;
import java.util.ArrayList;
import java.util.List;

public class UserServiceImpl implements IUserService {
    private final IUserRepository userRepository = new UserRepositoryImpl();

    @Override
    public User login(String username, String password) {
        User user = userRepository.findByUsername(username);
        if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public boolean register(User user) {
        if (isUsernameExists(user.getUsername()) || isEmailExists(user.getEmail())) {
            return false;
        }
        user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        user.setRole("USER");
        return userRepository.save(user) > 0;
    }

    @Override
    public UserDTO getUserById(int id) {
        User user = userRepository.findById(id);
        return user != null ? toDTO(user) : null;
    }

    @Override
    public List<UserDTO> getAllUsers() {
        return toDTOList(userRepository.findAll());
    }

    @Override
    public List<UserDTO> getCustomers() {
        return toDTOList(userRepository.findByRole("USER"));
    }

    @Override
    public boolean updateUser(User user) {
        return userRepository.update(user) > 0;
    }

    @Override
    public boolean isUsernameExists(String username) {
        return userRepository.findByUsername(username) != null;
    }

    @Override
    public boolean isEmailExists(String email) {
        return userRepository.findByEmail(email) != null;
    }

    private UserDTO toDTO(User user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setFullname(user.getFullname());
        dto.setEmail(user.getEmail());
        dto.setPhone(user.getPhone());
        dto.setAddress(user.getAddress());
        dto.setRole(user.getRole());
        dto.setCreatedAt(user.getCreatedAt());
        return dto;
    }

    private List<UserDTO> toDTOList(List<User> users) {
        List<UserDTO> dtos = new ArrayList<>();
        for (User user : users) {
            dtos.add(toDTO(user));
        }
        return dtos;
    }
}
