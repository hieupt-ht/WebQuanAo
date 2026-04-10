package com.shop.dao;

import com.shop.entity.UserAddress;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserAddressDAO extends BaseDAO<UserAddress> {

    @Override
    protected UserAddress mapRow(ResultSet rs) throws SQLException {
        UserAddress addr = new UserAddress();
        addr.setId(rs.getInt("id"));
        addr.setUserId(rs.getInt("user_id"));
        addr.setReceiverName(rs.getString("receiver_name"));
        addr.setPhone(rs.getString("phone"));
        addr.setAddressDetail(rs.getString("address_detail"));
        addr.setDefault(rs.getBoolean("is_default"));
        addr.setCreatedAt(rs.getTimestamp("created_at"));
        return addr;
    }

    public List<UserAddress> findByUserId(int userId) {
        return queryList("SELECT * FROM user_addresses WHERE user_id = ? ORDER BY is_default DESC, created_at DESC", userId);
    }

    public UserAddress findById(int id) {
        return queryOne("SELECT * FROM user_addresses WHERE id = ?", id);
    }

    public UserAddress findDefaultByUserId(int userId) {
        return queryOne("SELECT * FROM user_addresses WHERE user_id = ? AND is_default = 1", userId);
    }

    public int insertAddress(UserAddress addr) {
        return insert(
                "INSERT INTO user_addresses (user_id, receiver_name, phone, address_detail, is_default) VALUES (?, ?, ?, ?, ?)",
                addr.getUserId(), addr.getReceiverName(), addr.getPhone(), addr.getAddressDetail(),
                addr.isDefault() ? 1 : 0);
    }

    public int updateAddress(UserAddress addr) {
        return update(
                "UPDATE user_addresses SET receiver_name = ?, phone = ?, address_detail = ? WHERE id = ?",
                addr.getReceiverName(), addr.getPhone(), addr.getAddressDetail(), addr.getId());
    }

    public int deleteAddress(int id) {
        return update("DELETE FROM user_addresses WHERE id = ?", id);
    }

    public int clearDefault(int userId) {
        return update("UPDATE user_addresses SET is_default = 0 WHERE user_id = ?", userId);
    }

    public int setDefault(int id) {
        return update("UPDATE user_addresses SET is_default = 1 WHERE id = ?", id);
    }

    public int countByUserId(int userId) {
        return count("SELECT COUNT(*) FROM user_addresses WHERE user_id = ?", userId);
    }
}
