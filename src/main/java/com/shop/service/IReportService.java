package com.shop.service;

import com.shop.dto.CustomerReportDTO;
import com.shop.dto.TopProductDTO;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal;

public interface IReportService {
    List<CustomerReportDTO> getCustomerReport();

    List<TopProductDTO> getTopSellingProducts(int limit);

    Map<String, BigDecimal> getRevenueByMonth();

    Map<String, Integer> getOrderStatusStats();

    void exportCustomerReport(OutputStream outputStream) throws Exception;
}
