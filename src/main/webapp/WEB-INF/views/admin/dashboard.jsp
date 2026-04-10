<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Antigravity Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body class="bg-light">

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 p-0 shadow sidebar sticky-top" style="height: 100vh;">
                <div class="p-4 text-center">
                    <h5 class="fw-bold text-white mb-0 mt-2">ADMIN PANEL</h5>
                    <hr class="text-white opacity-25 mt-4">
                </div>
                <nav class="nav flex-column mb-auto">
                    <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/admin/dashboard' ? 'active' : ''}"
                        href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-th-large me-2"></i> Dashboard
                    </a>
                    <a class="nav-link ${requestScope['javax.servlet.forward.servlet_path'] == '/admin/products' ? 'active' : ''}"
                        href="${pageContext.request.contextPath}/admin/products">
                        <i class="fas fa-box-open me-2"></i> Sản Phẩm
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                        <i class="fas fa-shopping-cart me-2"></i> Đơn Hàng
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/customers">
                        <i class="fas fa-users me-2"></i> Khách Hàng
                    </a>
                    <hr class="mx-3 text-white opacity-25">
                    <a class="nav-link text-warning" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-external-link-alt me-2"></i> Xem Trang Chủ
                    </a>
                    <a class="nav-link text-danger" href="${pageContext.request.contextPath}/auth/logout">
                        <i class="fas fa-sign-out-alt me-2"></i> Đăng Xuất
                    </a>
                </nav>
            </div>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom">
                    <h1 class="h2 fw-bold text-dark">DASHBOARD</h1>
                </div>

                <!-- Stats Cards Row 1 -->
                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm rounded-4 p-3 bg-white border-start border-success border-4 text-center">
                            <div class="card-body">
                                <h6 class="text-muted fw-bold small text-uppercase mb-2">Tổng Doanh Thu</h6>
                                <h3 class="fw-bold text-success mb-0"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol=""/>đ</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm rounded-4 p-3 bg-white border-start border-primary border-4 text-center">
                            <div class="card-body">
                                <h6 class="text-muted fw-bold small text-uppercase mb-2">Tổng Đơn Hàng</h6>
                                <h3 class="fw-bold text-primary mb-0">${orderCount}</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm rounded-4 p-3 bg-white border-start border-info border-4 text-center">
                            <div class="card-body">
                                <h6 class="text-muted fw-bold small text-uppercase mb-2">Đơn Hoàn Thành</h6>
                                <h3 class="fw-bold text-info mb-0">${completedOrderCount}</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm rounded-4 p-3 bg-white border-start border-warning border-4 text-center">
                            <div class="card-body">
                                <h6 class="text-muted fw-bold small text-uppercase mb-2">Đang Xử Lý</h6>
                                <h3 class="fw-bold text-warning mb-0">${pendingOrderCount}</h3>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Top Products Table -->
                    <div class="col-lg-8 mb-4">
                        <div class="card shadow-sm border-0 rounded-4">
                            <div class="card-header bg-white border-0 pt-4 pb-0 px-4">
                                <h5 class="fw-bold mb-0"><i class="fas fa-crown text-warning me-2"></i>Top 5 Sản Phẩm Bán Chạy</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="table-responsive">
                                    <table class="table align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Sản phẩm</th>
                                                <th class="text-center">Đã bán</th>
                                                <th class="text-end">Doanh thu</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${topProducts}" var="tp">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <img src="${tp.productImage}" alt="${tp.productName}" class="rounded-3 me-3 shadow-sm" style="width: 45px; height: 45px; object-fit: cover;">
                                                            <div>
                                                                <h6 class="mb-0 fw-bold small">${tp.productName}</h6>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-center">
                                                        <span class="badge bg-success rounded-pill px-3 py-2">${tp.totalSold}</span>
                                                    </td>
                                                    <td class="text-end fw-bold text-primary">
                                                        <fmt:formatNumber value="${tp.totalRevenue}" type="currency" currencySymbol=""/> đ
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty topProducts}">
                                                <tr>
                                                    <td colspan="3" class="text-center py-4 text-muted">Chưa có dữ liệu bán hàng.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Card -->
                    <div class="col-lg-4 mb-4">
                        <div class="card shadow-sm border-0 rounded-4 p-4 text-center h-100 d-flex flex-column justify-content-center bg-primary text-white">
                            <i class="fas fa-shipping-fast fa-3x mb-3 opacity-50"></i>
                            <h4 class="fw-bold">Xử Lý Đơn Hàng</h4>
                            <p class="opacity-75 mb-4">Bạn có <strong>${pendingOrderCount}</strong> đơn hàng đang chờ xác nhận và <strong>${shippingOrderCount}</strong> đơn đang giao.</p>
                            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-light text-primary fw-bold rounded-pill px-4 align-self-center mt-auto">
                                ĐẾN TRANG QUẢN LÝ <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>