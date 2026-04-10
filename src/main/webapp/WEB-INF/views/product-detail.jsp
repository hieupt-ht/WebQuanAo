<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                <li class="breadcrumb-item active">${product.name}</li>
            </ol>
        </nav>

        <div class="row bg-white rounded-4 shadow-sm p-4 animate-fade-in">
            <!-- Product Image -->
            <div class="col-md-6 mb-4">
                <div class="rounded-4 overflow-hidden shadow-sm">
                    <img src="${product.image != null ? product.image : 'https://placehold.co/600x800/FFF/000?text=Product'}"
                        class="img-fluid w-100" alt="${product.name}">
                </div>
            </div>

            <!-- Product Info -->
            <div class="col-md-6">
                <h6 class="text-primary fw-bold text-uppercase mb-2">${product.categoryName}</h6>
                <h1 class="fw-bold mb-3">${product.name}</h1>

                <div class="d-flex align-items-center mb-4">
                    <div class="text-warning me-2">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="text-muted small border-start ps-2">(124 đánh giá)</span>
                </div>

                <h2 class="price-text display-6 mb-4">
                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" /> đ
                </h2>

                <p class="text-muted mb-5 lead">${product.description}</p>

                <form action="${pageContext.request.contextPath}/cart/add" method="POST">
                    <input type="hidden" name="productId" value="${product.id}">

                    <div class="mb-4">
                        <label class="form-label fw-bold">Kích thước (Size)</label>
                        <div class="d-flex gap-2">
                            <c:forEach items="${fn:split(product.size, ',')}" var="s">
                                <input type="radio" class="btn-check" name="size" id="size-${s}" value="${s}"
                                    autocomplete="off" required>
                                <label class="btn btn-outline-secondary rounded-pill px-3" for="size-${s}">${s}</label>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold">Màu sắc (Color)</label>
                        <div class="d-flex gap-2">
                            <c:forEach items="${fn:split(product.color, ',')}" var="c">
                                <input type="radio" class="btn-check" name="color" id="color-${c}" value="${c}"
                                    autocomplete="off">
                                <label class="btn btn-outline-secondary rounded-pill px-3" for="color-${c}">${c}</label>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="row g-3 items-center mb-5 mt-2">
                        <div class="col-auto">
                            <label class="form-label fw-bold mb-0">Số lượng:</label>
                        </div>
                        <div class="col-auto">
                            <div class="input-group" style="width: 140px;">
                                <button class="btn btn-outline-secondary rounded-start-pill" type="button"
                                    onclick="this.parentNode.querySelector('input[type=number]').stepDown()">-</button>
                                <input type="number" name="quantity" class="form-control text-center bg-light border-0"
                                    value="1" min="1" max="${product.stock}">
                                <button class="btn btn-outline-secondary rounded-end-pill" type="button"
                                    onclick="this.parentNode.querySelector('input[type=number]').stepUp()">+</button>
                            </div>
                        </div>
                        <div class="col-auto">
                            <span class="text-muted small">${product.stock} sản phẩm có sẵn</span>
                        </div>
                    </div>

                    <div class="d-grid gap-3">
                        <button type="submit" class="btn btn-primary btn-lg rounded-pill p-3 fw-bold">
                            <i class="fas fa-cart-plus me-2"></i> THÊM VÀO GIỎ HÀNG
                        </button>
                        <button type="button" class="btn btn-outline-danger btn-lg rounded-pill p-3 fw-bold">
                            <i class="fas fa-heart me-2"></i> THÊM VÀO YÊU THÍCH
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>