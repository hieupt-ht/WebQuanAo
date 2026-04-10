package com.shop.service;

import com.shop.entity.UserAddress;
import java.util.List;

public interface IUserAddressService {
    List<UserAddress> getAddressesByUserId(int userId);

    UserAddress getAddressById(int id);

    UserAddress getDefaultAddress(int userId);

    boolean addAddress(UserAddress address);

    boolean updateAddress(UserAddress address);

    boolean deleteAddress(int userId, int addressId);

    boolean setDefaultAddress(int userId, int addressId);
}
