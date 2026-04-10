<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>${product != null ? 'Sửa sản phẩm' : 'Thêm sản phẩm'} - Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
        </head>

        <body class="bg-light">
            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card shadow border-0 rounded-4">
                            <div class="card-header bg-primary text-white py-3 rounded-top-4">
                                <h5 class="fw-bold mb-0 text-center">${product != null ? 'CẬP NHẬT SẢN PHẨM' : 'THÊM SẢN
                                    PHẨM MỚI'}</h5>
                            </div>
                            <div class="card-body p-4 p-md-5">
                                <form
                                    action="${pageContext.request.contextPath}/admin/products/${product != null ? 'edit' : 'add'}"
                                    method="POST">
                                    <input type="hidden" name="id" value="${product.id}">

                                    <div class="mb-3">
                                        <label class="form-label fw-bold small text-muted">Tên sản phẩm *</label>
                                        <input type="text" name="name" class="form-control" value="${product.name}"
                                            required>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold small text-muted">Danh mục *</label>
                                            <select name="categoryId" class="form-select" required>
                                                <c:forEach items="${categories}" var="cat">
                                                    <option value="${cat.id}" ${product.categoryId==cat.id ? 'selected'
                                                        : '' }>${cat.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold small text-muted">Giá bán (đ) *</label>
                                            <input type="number" name="price" class="form-control"
                                                value="${product.price}" required>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold small text-muted">Số lượng kho *</label>
                                            <input type="number" name="stock" class="form-control"
                                                value="${product.stock}" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold small text-muted">Ảnh (URL hoặc
                                                filename)</label>
                                            <input type="text" name="image" class="form-control"
                                                value="${product.image}">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold small text-muted">Kích thước (ví dụ:
                                                S,M,L,XL)</label>
                                            <input type="text" name="size" class="form-control" value="${product.size}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold small text-muted">Màu sắc (ví dụ:
                                                Đen,Trắng,Đỏ)</label>
                                            <input type="text" name="color" class="form-control"
                                                value="${product.color}">
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label fw-bold small text-muted">Mô tả sản phẩm</label>
                                        <textarea name="description" class="form-control"
                                            rows="4">${product.description}</textarea>
                                    </div>

                                    <div class="d-grid gap-2">
                                        <button type="submit"
                                            class="btn btn-primary btn-lg rounded-pill fw-bold shadow-sm">LƯU THÔNG
                                            TIN</button>
                                        <a href="${pageContext.request.contextPath}/admin/products"
                                            class="btn btn-outline-secondary rounded-pill">HỦY THAY ĐỔI</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>