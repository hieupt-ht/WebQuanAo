<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Quản lý Đơn hàng - Admin</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
            </head>

            <body class="bg-light">
                <div class="container-fluid">
                    <div class="row">
                        <main class="col-md-12 px-md-4 py-4">
                            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                                <h1 class="h2 fw-bold">QUẢN LÝ ĐƠN HÀNG</h1>
                                <a href="${pageContext.request.contextPath}/admin/dashboard"
                                    class="btn btn-outline-secondary btn-sm rounded-pill"><i
                                        class="fas fa-arrow-left"></i> Quay lại</a>
                            </div>

                            <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-white">
                                            <tr>
                                                <th class="ps-4">Mã đơn</th>
                                                <th>Khách hàng</th>
                                                <th>Ngày đặt</th>
                                                <th>Tổng tiền</th>
                                                <th>Trạng thái</th>
                                                <th class="pe-4 text-end">Cập nhật trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${orders}" var="o">
                                                <tr>
                                                    <td class="ps-4 fw-bold">#ORD-${o.id}</td>
                                                    <td>
                                                        <div class="small fw-bold">${o.fullname}</div>
                                                        <div class="text-muted smallest">${o.phone}</div>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${o.createdAt}"
                                                            pattern="dd/MM/yyyy HH:mm" />
                                                    </td>
                                                    <td class="fw-bold text-primary">
                                                        <fmt:formatNumber value="${o.totalAmount}" type="currency"
                                                            currencySymbol="" /> đ
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${o.status == 'PENDING'}"><span
                                                                    class="badge bg-warning text-dark rounded-pill px-3">PENDING</span>
                                                            </c:when>
                                                            <c:when test="${o.status == 'SHIPPING'}"><span
                                                                    class="badge bg-info text-dark rounded-pill px-3">SHIPPING</span>
                                                            </c:when>
                                                            <c:when test="${o.status == 'COMPLETED'}"><span
                                                                    class="badge bg-success rounded-pill px-3">COMPLETED</span>
                                                            </c:when>
                                                            <c:when test="${o.status == 'CANCELLED'}"><span
                                                                    class="badge bg-danger rounded-pill px-3">CANCELLED</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td class="pe-4 text-end">
                                                        <form
                                                            action="${pageContext.request.contextPath}/admin/orders/updateStatus"
                                                            method="GET" class="d-inline">
                                                            <input type="hidden" name="id" value="${o.id}">
                                                            <select name="status"
                                                                class="form-select form-select-sm d-inline-block w-auto rounded-pill"
                                                                onchange="this.form.submit()">
                                                                <option value="PENDING" ${o.status=='PENDING'
                                                                    ? 'selected' : '' }>Chờ</option>
                                                                <option value="SHIPPING" ${o.status=='SHIPPING'
                                                                    ? 'selected' : '' }>Giao</option>
                                                                <option value="COMPLETED" ${o.status=='COMPLETED'
                                                                    ? 'selected' : '' }>Xong</option>
                                                                <option value="CANCELLED" ${o.status=='CANCELLED'
                                                                    ? 'selected' : '' }>Hủy</option>
                                                            </select>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>
            </body>

            </html>