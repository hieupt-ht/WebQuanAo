<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Web Shop Quần Áo - Fashion Store</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Font Awesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <!-- Custom CSS -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
        </head>

        <body>

            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
                <div class="container">
                    <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-shopping-bag me-2"></i>ANTIGRAVITY SHOP
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/products">Sản phẩm</a>
                            </li>
                        </ul>

                        <form class="d-flex me-3" action="${pageContext.request.contextPath}/products" method="GET">
                            <input class="form-control me-2 rounded-pill" type="search" placeholder="Tìm sản phẩm..."
                                name="keyword">
                            <button class="btn btn-outline-primary rounded-circle" type="submit"><i
                                    class="fas fa-search"></i></button>
                        </form>

                        <div class="d-flex align-items-center">
                            <a href="${pageContext.request.contextPath}/cart"
                                class="btn btn-outline-dark position-relative me-3 rounded-pill">
                                <i class="fas fa-shopping-cart"></i>
                                <span
                                    class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${sessionScope.cartItemCount != null ? sessionScope.cartItemCount : 0}
                                </span>
                            </a>

                            <c:choose>
                                <c:when test="${sessionScope.user != null}">
                                    <div class="dropdown">
                                        <button class="btn btn-outline-primary dropdown-toggle rounded-pill"
                                            type="button" id="userMenu" data-bs-toggle="dropdown">
                                            <i class="fas fa-user me-1"></i> ${sessionScope.user.fullname}
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                            <li><a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/order/history">Lịch sử
                                                    đơn hàng</a></li>
                                            <c:if test="${sessionScope.user.role != 'ADMIN'}">
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/user/address"><i class="fas fa-map-marker-alt me-1 text-muted"></i>Địa chỉ của tôi</a></li>
                                            </c:if>
                                            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item text-danger"
                                                        href="${pageContext.request.contextPath}/admin/dashboard">Trang
                                                        Quản Trị</a></li>
                                            </c:if>
                                            <li>
                                                <hr class="dropdown-divider">
                                            </li>
                                            <li><a class="dropdown-item text-secondary"
                                                    href="${pageContext.request.contextPath}/auth/logout">Đăng
                                                    xuất</a></li>
                                        </ul>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/auth/login"
                                        class="btn btn-primary rounded-pill px-4">Đăng nhập</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </nav>

            <div class="container py-4">
                <c:if test="${not empty param.message}">
                    <div class="alert alert-success alert-dismissible fade show animate__animated animate__fadeInDown"
                        role="alert">
                        ${param.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
            </div>