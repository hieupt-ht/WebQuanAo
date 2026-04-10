package com.shop.repository;

import com.shop.entity.UserAddress;
import java.util.List;

public interface IUserAddressRepository {
    List<UserAddress> findByUserId(int userId);

    UserAddress findById(int id);

    UserAddress findDefaultByUserId(int userId);

    int save(UserAddress address);

    int update(UserAddress address);

    int delete(int id);

    int clearDefault(int userId);

    int setDefault(int id);

    int countByUserId(int userId);
}
