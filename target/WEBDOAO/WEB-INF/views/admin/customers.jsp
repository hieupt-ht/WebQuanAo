<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Quản lý Khách hàng - Admin</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
            </head>

            <body class="bg-light">
                <div class="container-fluid">
                    <div class="row">
                        <main class="col-md-12 px-md-4 py-4">
                            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                                <h1 class="h2 fw-bold">QUẢN LÝ KHÁCH HÀNG</h1>
                                <div>
                                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                                        class="btn btn-outline-secondary btn-sm me-2 rounded-pill"><i
                                            class="fas fa-arrow-left"></i> Quay lại</a>
                                    <a href="${pageContext.request.contextPath}/admin/customers/export"
                                        class="btn btn-success btn-sm rounded-pill px-3"><i
                                            class="fas fa-file-excel"></i> Xuất Excel khách hàng</a>
                                </div>
                            </div>

                            <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-white">
                                            <tr>
                                                <th class="ps-4">Mã KH</th>
                                                <th>Họ và tên</th>
                                                <th>Email</th>
                                                <th>Số điện thoại</th>
                                                <th>Địa chỉ</th>
                                                <th class="pe-4 text-end">Ngày tham gia</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${customers}" var="u">
                                                <tr>
                                                    <td class="ps-4 text-muted small">#USER-${u.id}</td>
                                                    <td class="fw-bold">${u.fullname}</td>
                                                    <td>${u.email}</td>
                                                    <td>${u.phone}</td>
                                                    <td>
                                                        <div class="text-truncate" style="max-width: 200px;">
                                                            ${u.address}</div>
                                                    </td>
                                                    <td class="pe-4 text-end text-muted small">
                                                        <fmt:formatDate value="${u.createdAt}" pattern="dd/MM/yyyy" />
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="alert alert-info mt-4 rounded-4 border-0">
                                <i class="fas fa-info-circle me-2"></i> Tổng cộng có
                                <strong>${customers.size()}</strong> khách hàng trong hệ thống.
                            </div>
                        </main>
                    </div>
                </div>
            </body>

            </html>