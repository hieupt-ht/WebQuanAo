<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div class="row">
            <!-- Sidebar: Categories -->
            <div class="col-lg-3 mb-4">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">Danh Mục</h5>
                        <div class="list-group list-group-flush">
                            <a href="${pageContext.request.contextPath}/products"
                                class="list-group-item list-group-item-action border-0 px-0 ${categoryId == null ? 'text-primary fw-bold' : ''}">
                                Tất cả sản phẩm
                            </a>
                            <c:forEach items="${categories}" var="cat">
                                <a href="${pageContext.request.contextPath}/products?categoryId=${cat.id}"
                                    class="list-group-item list-group-item-action border-0 px-0 ${categoryId == cat.id ? 'text-primary fw-bold' : ''}">
                                    ${cat.name}
                                </a>
                            </c:forEach>
                        </div>

                        <hr class="my-4 text-muted">

                        <h5 class="fw-bold mb-3">Khoảng giá</h5>
                        <form action="${pageContext.request.contextPath}/products" method="GET">
                            <div class="mb-3">
                                <input type="number" name="minPrice" class="form-control form-control-sm mb-2"
                                    placeholder="Từ (đ)">
                                <input type="number" name="maxPrice" class="form-control form-control-sm"
                                    placeholder="Đến (đ)">
                            </div>
                            <button type="submit" class="btn btn-primary btn-sm w-100 rounded-pill">Lọc giá</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Main Content: Product Grid -->
            <div class="col-lg-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold mb-0">
                        <c:choose>
                            <c:when test="${not empty keyword}">Kết quả tìm kiếm cho: "${keyword}"</c:when>
                            <c:otherwise>Sản Phẩm</c:otherwise>
                        </c:choose>
                    </h4>
                    <div class="small text-muted">Hiển thị ${products.size()} sản phẩm</div>
                </div>

                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                            <c:forEach items="${products}" var="p">
                                <div class="col">
                                    <div class="card shadow-sm h-100">
                                        <div class="product-image-wrapper">
                                            <img src="${p.image != null ? p.image : 'https://placehold.co/400x500/FFF/000?text=Product'}"
                                                class="card-img-top" alt="${p.name}">
                                        </div>
                                        <div class="card-body">
                                            <h6 class="card-title fw-bold text-truncate">${p.name}</h6>
                                            <p class="price-text mb-2">
                                                <fmt:formatNumber value="${p.price}" type="currency"
                                                    currencySymbol="" /> đ
                                            </p>
                                            <div class="d-grid gap-2">
                                                <a href="${pageContext.request.contextPath}/products/detail?id=${p.id}"
                                                    class="btn btn-outline-primary btn-sm rounded-pill">Chi tiết</a>
                                                <form action="${pageContext.request.contextPath}/cart/add"
                                                    method="POST">
                                                    <input type="hidden" name="productId" value="${p.id}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <button type="submit" class="btn btn-primary btn-sm rounded-pill">
                                                        <i class="fas fa-cart-plus me-1"></i> Thêm vào giỏ
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav>
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link rounded-circle me-2"
                                            href="?page=${currentPage - 1}${categoryId != null ? '&categoryId='.concat(categoryId) : ''}${keyword != null ? '&keyword='.concat(keyword) : ''}">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link rounded-circle me-2"
                                                href="?page=${i}${categoryId != null ? '&categoryId='.concat(categoryId) : ''}${keyword != null ? '&keyword='.concat(keyword) : ''}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link rounded-circle"
                                            href="?page=${currentPage + 1}${categoryId != null ? '&categoryId='.concat(categoryId) : ''}${keyword != null ? '&keyword='.concat(keyword) : ''}">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-search fa-4x text-muted mb-3"></i>
                            <h4>Không tìm thấy sản phẩm nào!</h4>
                            <a href="${pageContext.request.contextPath}/products"
                                class="btn btn-primary mt-3 rounded-pill">Quay lại danh sách</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>