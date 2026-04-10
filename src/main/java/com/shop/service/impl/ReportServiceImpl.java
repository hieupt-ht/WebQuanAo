package com.shop.service.impl;

import com.shop.dao.ReportDAO;
import com.shop.dto.CustomerReportDTO;
import com.shop.dto.TopProductDTO;
import com.shop.service.IReportService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal;

public class ReportServiceImpl implements IReportService {
    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    public List<CustomerReportDTO> getCustomerReport() {
        return reportDAO.getCustomerReport();
    }

    @Override
    public List<TopProductDTO> getTopSellingProducts(int limit) {
        return reportDAO.getTopSellingProducts(limit);
    }

    @Override
    public Map<String, BigDecimal> getRevenueByMonth() {
        return reportDAO.getRevenueByMonth();
    }

    @Override
    public Map<String, Integer> getOrderStatusStats() {
        return reportDAO.getOrderStatusStats();
    }

    @Override
    public void exportCustomerReport(OutputStream outputStream) throws Exception {
        List<CustomerReportDTO> data = getCustomerReport();

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Báo Cáo Khách Hàng");

            // Header style
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 12);
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            headerStyle.setBorderTop(BorderStyle.THIN);
            headerStyle.setBorderLeft(BorderStyle.THIN);
            headerStyle.setBorderRight(BorderStyle.THIN);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);

            // Data style
            CellStyle dataStyle = workbook.createCellStyle();
            dataStyle.setBorderBottom(BorderStyle.THIN);
            dataStyle.setBorderTop(BorderStyle.THIN);
            dataStyle.setBorderLeft(BorderStyle.THIN);
            dataStyle.setBorderRight(BorderStyle.THIN);

            // Currency style
            CellStyle currencyStyle = workbook.createCellStyle();
            currencyStyle.cloneStyleFrom(dataStyle);
            DataFormat format = workbook.createDataFormat();
            currencyStyle.setDataFormat(format.getFormat("#,##0"));

            // Title row
            Row titleRow = sheet.createRow(0);
            Cell titleCell = titleRow.createCell(0);
            titleCell.setCellValue("BÁO CÁO KHÁCH HÀNG ĐÃ MUA HÀNG THÀNH CÔNG");
            CellStyle titleStyle = workbook.createCellStyle();
            Font titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleFont.setFontHeightInPoints((short) 14);
            titleStyle.setFont(titleFont);
            titleCell.setCellStyle(titleStyle);

            // Header row
            Row headerRow = sheet.createRow(2);
            String[] headers = { "STT", "Tên Khách Hàng", "Số Điện Thoại", "Email", "Tổng Đơn Hàng",
                    "Tổng Tiền (VNĐ)" };
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // Data rows
            int rowNum = 3;
            for (int i = 0; i < data.size(); i++) {
                CustomerReportDTO dto = data.get(i);
                Row row = sheet.createRow(rowNum++);

                Cell cell0 = row.createCell(0);
                cell0.setCellValue(i + 1);
                cell0.setCellStyle(dataStyle);

                Cell cell1 = row.createCell(1);
                cell1.setCellValue(dto.getFullname());
                cell1.setCellStyle(dataStyle);

                Cell cell2 = row.createCell(2);
                cell2.setCellValue(dto.getPhone() != null ? dto.getPhone() : "");
                cell2.setCellStyle(dataStyle);

                Cell cell3 = row.createCell(3);
                cell3.setCellValue(dto.getEmail());
                cell3.setCellStyle(dataStyle);

                Cell cell4 = row.createCell(4);
                cell4.setCellValue(dto.getTotalOrders());
                cell4.setCellStyle(dataStyle);

                Cell cell5 = row.createCell(5);
                cell5.setCellValue(dto.getTotalAmount().doubleValue());
                cell5.setCellStyle(currencyStyle);
            }

            // Auto-size columns
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(outputStream);
        }
    }
}
