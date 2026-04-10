<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <!-- Hero Carousel -->
        <div id="heroCarousel" class="carousel slide shadow rounded-4 overflow-hidden mb-5" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
                        class="d-block w-100" alt="Slider 1" style="height: 450px; object-fit: cover;">
                    <div
                        class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded-4 p-4 animate__animated animate__fadeIn">
                        <h1 class="display-4 fw-bold">BST Mùa Hè 2026</h1>
                        <p>Khám phá phong cách mới với bộ sưu tập năng động và hiện đại.</p>
                        <a href="${pageContext.request.contextPath}/products"
                            class="btn btn-primary btn-lg rounded-pill px-5">Mua ngay</a>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
                        class="d-block w-100" alt="Slider 2" style="height: 450px; object-fit: cover;">
                    <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded-4 p-4">
                        <h1 class="display-4 fw-bold">Ưu Đãi Đặc Biệt</h1>
                        <p>Giảm giá lên đến 50% cho các sản phẩm phụ kiện.</p>
                        <a href="${pageContext.request.contextPath}/products"
                            class="btn btn-primary btn-lg rounded-pill px-5">Xem ngay</a>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>

        <!-- Featured Categories -->
        <section class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold m-0 pl-2 border-start border-primary border-4">Danh Mục Nổi Bật</h3>
            </div>
            <div class="row g-4">
                <c:forEach items="${categories}" var="cat" end="3">
                    <div class="col-6 col-md-3">
                        <a href="${pageContext.request.contextPath}/products?categoryId=${cat.id}"
                            class="text-decoration-none">
                            <div class="card bg-white text-center py-4 h-100 shadow-sm border-0">
                                <div class="card-body">
                                    <i class="fas fa-tshirt fa-3x text-primary mb-3"></i>
                                    <h5 class="card-title text-dark fw-bold">${cat.name}</h5>
                                </div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- Featured Products -->
        <section class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold m-0 pl-2 border-start border-primary border-4">Sản Phẩm Mới</h3>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-link text-decoration-none">Xem tất
                    cả
                    <i class="fas fa-arrow-right ms-1"></i></a>
            </div>

            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                <c:forEach items="${featuredProducts}" var="p">
                    <div class="col">
                        <div class="card shadow-sm h-100">
                            <div class="product-image-wrapper">
                                <span class="badge bg-danger badge-new">New</span>
                                <img src="${p.image != null ? p.image : 'https://placehold.co/400x500/FFF/000?text=Product'}"
                                    class="card-img-top" alt="${p.name}">
                            </div>
                            <div class="card-body">
                                <p class="text-muted small mb-1">${p.categoryName}</p>
                                <h6 class="card-title fw-bold text-truncate">${p.name}</h6>
                                <p class="price-text mb-2">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" /> đ
                                </p>
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/products/detail?id=${p.id}"
                                        class="btn btn-outline-primary btn-sm rounded-pill">Chi tiết</a>
                                    <form action="${pageContext.request.contextPath}/cart/add" method="POST">
                                        <input type="hidden" name="productId" value="${p.id}">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn-primary btn-sm rounded-pill w-100">
                                            <i class="fas fa-cart-plus me-1"></i> Thêm vào giỏ
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>