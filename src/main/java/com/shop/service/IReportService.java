package com.shop.service;

import com.shop.dto.CustomerReportDTO;
import com.shop.dto.TopProductDTO;
import java.io.OutputStream;
import java.util.List;

public interface IReportService {
    List<CustomerReportDTO> getCustomerReport();

    List<TopProductDTO> getTopSellingProducts(int limit);

    void exportCustomerReport(OutputStream outputStream) throws Exception;
}
