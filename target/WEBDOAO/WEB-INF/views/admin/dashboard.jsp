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
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="bg-light">

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 p-0 shadow sidebar sticky-top" style="height: 100vh;">
                <div class="p-4 text-center animate-fade-in">
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
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom animate-fade-in">
                    <h1 class="h2 fw-bold text-dark">DASHBOARD TỔNG QUAN</h1>
                </div>

                <!-- Stats Cards Row 1 -->
                <div class="row g-4 mb-4 scroll-fade-up">
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm rounded-4 p-3 bg-white border-start border-success border-4 text-center tilt-card">
                            <div class="card-body">
                                <h6 class="text-muted fw-bold small text-uppercase mb-2">Tổng Doanh Thu</h6>
                                <h3 class="fw-bold text-success mb-0 d-flex justify-content-center align-items-center">
                                    <span class="count-up" data-val="${totalRevenue}">0</span> đ
                                </h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm rounded-4 p-3 bg-white border-start border-primary border-4 text-center tilt-card">
                            <div class="card-body">
                                <h6 class="text-muted fw-bold small text-uppercase mb-2">Tổng Đơn Hàng</h6>
                                <h3 class="fw-bold text-primary mb-0 count-up" data-val="${orderCount}">0</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm rounded-4 p-3 bg-white border-start border-info border-4 text-center tilt-card">
                            <div class="card-body">
                                <h6 class="text-muted fw-bold small text-uppercase mb-2">Theo Dõi Đơn</h6>
                                <div class="d-flex justify-content-between text-muted small mt-2 px-2">
                                    <span>Xong: <strong class="text-info">${completedOrderCount}</strong></span>
                                    <span>Giao: <strong class="text-warning">${shippingOrderCount}</strong></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm rounded-4 p-3 bg-white border-start border-warning border-4 text-center tilt-card">
                            <div class="card-body">
                                <h6 class="text-muted fw-bold small text-uppercase mb-2">Chờ Xử Lý</h6>
                                <h3 class="fw-bold text-warning mb-0 count-up" data-val="${pendingOrderCount}">0</h3>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row 1 -->
                <div class="row mb-4 scroll-fade-up">
                    <div class="col-lg-8">
                        <div class="card shadow-sm border-0 rounded-4 p-4 h-100">
                            <h5 class="fw-bold mb-3"><i class="fas fa-chart-line text-primary me-2"></i>Doanh Thu Theo Tháng</h5>
                            <canvas id="revenueChart" style="max-height: 300px; width: 100%;"></canvas>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card shadow-sm border-0 rounded-4 p-4 h-100">
                            <h5 class="fw-bold mb-3 text-center"><i class="fas fa-chart-pie text-info me-2"></i>Tỉ Lệ Trạng Thái Đơn</h5>
                            <div class="d-flex justify-content-center align-items-center h-100">
                                <canvas id="statusChart" style="max-height: 250px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row 2 -->
                <div class="row scroll-fade-up">
                    <!-- Top Products Table -->
                    <div class="col-lg-7 mb-4">
                        <div class="card shadow-sm border-0 rounded-4 h-100">
                            <div class="card-header bg-white border-0 pt-4 pb-0 px-4">
                                <h5 class="fw-bold mb-0"><i class="fas fa-crown text-warning me-2"></i>Top 5 Sản Phẩm Bán Chạy</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="table-responsive">
                                    <table class="table align-middle table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Sản phẩm</th>
                                                <th class="text-center">Đã bán</th>
                                                <th class="text-end">Doanh thu</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${topProducts}" var="tp">
                                                <tr class="transition">
                                                    <td>
                                                        <div class="d-flex align-items-center tilt-card" style="transform-origin: left center;">
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

                    <!-- Top Products Bar Chart -->
                    <div class="col-lg-5 mb-4">
                        <div class="card shadow-sm border-0 rounded-4 p-4 h-100">
                            <h5 class="fw-bold mb-3"><i class="fas fa-chart-bar text-success me-2"></i>Số Lượng Bán Top 5</h5>
                            <canvas id="topProductsChart" style="max-height: 250px; width: 100%;"></canvas>
                            
                            <hr class="my-4">
                            <!-- Action Button -->
                            <div class="text-center mt-auto">
                                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-primary btn-glow rounded-pill px-5 fw-bold shadow-sm">
                                    <i class="fas fa-cogs me-2"></i> XỬ LÝ ĐƠN HÀNG NGAY
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Thu thập Data từ Model Attribute JSON -->
    <script>
        const revenueData = ${revenueByMonthJson != null ? revenueByMonthJson : '{}'};
        const statusData = ${orderStatusStatsJson != null ? orderStatusStatsJson : '{}'};
        const topProductsData = ${topProductsJson != null ? topProductsJson : '[]'};
    </script>

    <!-- Script Init Mọi thứ (Chart, Animations) -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            
            /* =========================================
             1. INTERSECTION OBSERVER FOR SCROLL ANIMATION
             ========================================= */
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('visible');
                    }
                });
            }, { threshold: 0.1 });

            document.querySelectorAll('.scroll-fade-up').forEach(el => observer.observe(el));
            // Kích hoạt ngay element đầu tiên ko cần thẻ cuộn tới
            setTimeout(() => {
                document.querySelectorAll('.scroll-fade-up').forEach(el => el.classList.add('visible'));
            }, 100);

            /* =========================================
             2. COUNT UP ANIMATION FOR NUMBERS
             ========================================= */
            const countElements = document.querySelectorAll('.count-up');
            countElements.forEach(el => {
                const target = parseFloat(el.getAttribute('data-val')) || 0;
                const duration = 1500;
                const stepTime = Math.abs(Math.floor(duration / 60));
                
                let current = 0;
                const increment = target / (duration / stepTime);
                const isCurrency = target > 10000; 

                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        current = target;
                        clearInterval(timer);
                    }
                    if(isCurrency) {
                        el.innerText = Math.round(current).toLocaleString('vi-VN');
                    } else {
                        el.innerText = Math.round(current);
                    }
                }, stepTime);
            });

            /* =========================================
             3. VANILLA 3D TILT EFFECT
             ========================================= */
            const tiltCards = document.querySelectorAll('.tilt-card');
            tiltCards.forEach(card => {
                card.addEventListener('mousemove', e => {
                    const rect = card.getBoundingClientRect();
                    const x = e.clientX - rect.left;
                    const y = e.clientY - rect.top;
                    const centerX = rect.width / 2;
                    const centerY = rect.height / 2;
                    const rotateX = ((y - centerY) / centerY) * -5;
                    const rotateY = ((x - centerX) / centerX) * 5;
                    card.style.transform = "perspective(1000px) rotateX(" + rotateX + "deg) rotateY(" + rotateY + "deg) scale(1.02)";
                });
                card.addEventListener('mouseleave', () => {
                    card.style.transform = "perspective(1000px) rotateX(0deg) rotateY(0deg) scale(1)";
                });
            });

            /* =========================================
             4. RENDER CHART.JS CHARTS
             ========================================= */
            
            Chart.defaults.font.family = "'Inter', sans-serif";
            
            // 4.1 LINE CHART (REVENUE)
            const revLabels = Object.keys(revenueData);
            const revValues = Object.values(revenueData);
            
            if(document.getElementById('revenueChart')) {
                new Chart(document.getElementById('revenueChart'), {
                    type: 'line',
                    data: {
                        labels: revLabels.length ? revLabels : ['Chưa có DL'],
                        datasets: [{
                            label: 'Doanh thu (VND)',
                            data: revValues.length ? revValues : [0],
                            borderColor: '#0d6efd',
                            backgroundColor: 'rgba(13, 110, 253, 0.1)',
                            borderWidth: 3,
                            fill: true,
                            tension: 0.4, // smooth curve
                            pointBackgroundColor: '#0d6efd',
                            pointHoverRadius: 8
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) { return value.toLocaleString('vi-VN') + 'đ'; }
                                }
                            }
                        }
                    }
                });
            }

            // 4.2 PIE CHART (ORDER STATUS)
            const statusLabels = Object.keys(statusData);
            const statusValues = Object.values(statusData);
            
            // Map colors to specific status
            const colorMap = { 'PENDING': '#ffc107', 'SHIPPING': '#fd7e14', 'COMPLETED': '#198754', 'CANCELLED': '#dc3545' };
            const bgColors = statusLabels.map(s => colorMap[s] || '#aaa');

            if(document.getElementById('statusChart')) {
                new Chart(document.getElementById('statusChart'), {
                    type: 'doughnut',
                    data: {
                        labels: statusLabels.length ? statusLabels : ['Chưa có ĐH'],
                        datasets: [{
                            data: statusValues.length ? statusValues : [1],
                            backgroundColor: bgColors.length ? bgColors : ['#eee'],
                            borderWidth: 2,
                            hoverOffset: 10
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        cutout: '65%',
                        plugins: {
                            legend: { position: 'bottom', labels: { usePointStyle: true, padding: 20 } }
                        }
                    }
                });
            }

            // 4.3 BAR CHART (TOP PRODUCTS)
            const productNames = topProductsData.map(p => p.productName.substring(0, 15) + '...');
            const productSolds = topProductsData.map(p => p.totalSold);

            if(document.getElementById('topProductsChart')) {
                new Chart(document.getElementById('topProductsChart'), {
                    type: 'bar',
                    data: {
                        labels: productNames.length ? productNames : ['Chưa có'],
                        datasets: [{
                            label: 'Lượt bán',
                            data: productSolds.length ? productSolds : [0],
                            backgroundColor: 'rgba(25, 135, 84, 0.8)',
                            borderRadius: 6,
                            barThickness: 25
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } },
                        scales: {
                            y: { beginAtZero: true, ticks: { stepSize: 1 } },
                            x: { grid: { display: false } }
                        }
                    }
                });
            }

        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>