package com.shop.service.impl;

import com.shop.entity.UserAddress;
import com.shop.repository.IUserAddressRepository;
import com.shop.repository.impl.UserAddressRepositoryImpl;
import com.shop.service.IUserAddressService;
import java.util.List;

public class UserAddressServiceImpl implements IUserAddressService {
    private final IUserAddressRepository addressRepository = new UserAddressRepositoryImpl();

    @Override
    public List<UserAddress> getAddressesByUserId(int userId) {
        return addressRepository.findByUserId(userId);
    }

    @Override
    public UserAddress getAddressById(int id) {
        return addressRepository.findById(id);
    }

    @Override
    public UserAddress getDefaultAddress(int userId) {
        return addressRepository.findDefaultByUserId(userId);
    }

    @Override
    public boolean addAddress(UserAddress address) {
        // Nếu đây là địa chỉ đầu tiên → tự động set default
        if (addressRepository.countByUserId(address.getUserId()) == 0) {
            address.setDefault(true);
        }
        // Nếu địa chỉ mới được set default → clear default cũ
        if (address.isDefault()) {
            addressRepository.clearDefault(address.getUserId());
        }
        return addressRepository.save(address) > 0;
    }

    @Override
    public boolean updateAddress(UserAddress address) {
        return addressRepository.update(address) > 0;
    }

    @Override
    public boolean deleteAddress(int userId, int addressId) {
        UserAddress addr = addressRepository.findById(addressId);
        if (addr == null || addr.getUserId() != userId) {
            return false;
        }
        boolean wasDefault = addr.isDefault();
        int result = addressRepository.delete(addressId);

        // Nếu xóa địa chỉ default → set địa chỉ đầu tiên còn lại làm default
        if (wasDefault && result > 0) {
            List<UserAddress> remaining = addressRepository.findByUserId(userId);
            if (!remaining.isEmpty()) {
                addressRepository.setDefault(remaining.get(0).getId());
            }
        }
        return result > 0;
    }

    @Override
    public boolean setDefaultAddress(int userId, int addressId) {
        UserAddress addr = addressRepository.findById(addressId);
        if (addr == null || addr.getUserId() != userId) {
            return false;
        }
        addressRepository.clearDefault(userId);
        return addressRepository.setDefault(addressId) > 0;
    }
}
