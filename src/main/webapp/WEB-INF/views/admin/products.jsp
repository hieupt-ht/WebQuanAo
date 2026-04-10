<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Quản lý Sản phẩm - Admin</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
            </head>

            <body class="bg-light">
                <div class="container-fluid">
                    <div class="row">
                        <!-- Reuse Sidebar pattern (normally I'd use an include, but for speed let's just use simple layouts) -->
                        <main class="col-md-12 px-md-4 py-4">
                            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                                <h1 class="h2 fw-bold">QUẢN LÝ SẢN PHẨM</h1>
                                <div>
                                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                                        class="btn btn-outline-secondary btn-sm me-2 rounded-pill"><i
                                            class="fas fa-arrow-left"></i> Quay lại</a>
                                    <a href="${pageContext.request.contextPath}/admin/products/add"
                                        class="btn btn-primary btn-sm rounded-pill px-3"><i class="fas fa-plus"></i>
                                        Thêm sản phẩm</a>
                                </div>
                            </div>

                            <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-white">
                                            <tr>
                                                <th class="ps-4">ID</th>
                                                <th>Ảnh</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Giá</th>
                                                <th>Kho</th>
                                                <th>Danh mục</th>
                                                <th class="pe-4 text-end">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${products}" var="p">
                                                <tr>
                                                    <td class="ps-4 text-muted small">#${p.id}</td>
                                                    <td><img src="${p.image != null ? p.image : 'https://placehold.co/40x50'}"
                                                            width="40" class="rounded shadow-sm"></td>
                                                    <td class="fw-bold">${p.name}</td>
                                                    <td class="text-primary fw-bold">
                                                        <fmt:formatNumber value="${p.price}" type="currency"
                                                            currencySymbol="" /> đ
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge ${p.stock < 10 ? 'bg-danger' : 'bg-success'} rounded-pill">${p.stock}</span>
                                                    </td>
                                                    <td>${p.categoryName}</td>
                                                    <td class="pe-4 text-end">
                                                        <a href="${pageContext.request.contextPath}/admin/products/edit?id=${p.id}"
                                                            class="btn btn-outline-primary btn-sm rounded-circle me-1"><i
                                                                class="fas fa-edit"></i></a>
                                                        <a href="${pageContext.request.contextPath}/admin/products/delete?id=${p.id}"
                                                            class="btn btn-outline-danger btn-sm rounded-circle"
                                                            onclick="return confirmDelete('Xóa sản phẩm này?')"><i
                                                                class="fas fa-trash-alt"></i></a>
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