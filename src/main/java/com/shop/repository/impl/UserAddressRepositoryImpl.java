package com.shop.repository.impl;

import com.shop.dao.UserAddressDAO;
import com.shop.entity.UserAddress;
import com.shop.repository.IUserAddressRepository;
import java.util.List;

public class UserAddressRepositoryImpl implements IUserAddressRepository {
    private final UserAddressDAO dao = new UserAddressDAO();

    @Override
    public List<UserAddress> findByUserId(int userId) {
        return dao.findByUserId(userId);
    }

    @Override
    public UserAddress findById(int id) {
        return dao.findById(id);
    }

    @Override
    public UserAddress findDefaultByUserId(int userId) {
        return dao.findDefaultByUserId(userId);
    }

    @Override
    public int save(UserAddress address) {
        return dao.insertAddress(address);
    }

    @Override
    public int update(UserAddress address) {
        return dao.updateAddress(address);
    }

    @Override
    public int delete(int id) {
        return dao.deleteAddress(id);
    }

    @Override
    public int clearDefault(int userId) {
        return dao.clearDefault(userId);
    }

    @Override
    public int setDefault(int id) {
        return dao.setDefault(id);
    }

    @Override
    public int countByUserId(int userId) {
        return dao.countByUserId(userId);
    }
}
