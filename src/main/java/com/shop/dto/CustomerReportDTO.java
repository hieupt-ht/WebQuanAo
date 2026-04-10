package com.shop.dto;

import java.math.BigDecimal;

public class CustomerReportDTO {
    private String fullname;
    private String phone;
    private String email;
    private int totalOrders;
    private BigDecimal totalAmount;

    public CustomerReportDTO() {
    }

    public CustomerReportDTO(String fullname, String phone, String email, int totalOrders, BigDecimal totalAmount) {
        this.fullname = fullname;
        this.phone = phone;
        this.email = email;
        this.totalOrders = totalOrders;
        this.totalAmount = totalAmount;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
}
