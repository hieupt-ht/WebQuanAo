<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <h3 class="fw-bold mb-4">GIỎ HÀNG CỦA BẠN</h3>

        <c:choose>
            <c:when test="${not empty cartItems}">
                <div class="row">
                    <div class="col-lg-8 mb-4">
                        <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="bg-light">
                                        <tr>
                                            <th class="ps-4">Sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Tổng cộng</th>
                                            <th class="pe-4"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${cartItems}" var="item">
                                            <tr>
                                                <td class="ps-4">
                                                    <div class="d-flex align-items-center">
                                                        <img src="${item.productImage != null ? item.productImage : 'https://placehold.co/60x80'}"
                                                            class="rounded-3 me-3" width="60" alt="${item.productName}">
                                                        <div>
                                                            <h6 class="mb-0 fw-bold">${item.productName}</h6>
                                                            <p class="text-muted small mb-0">SKU: PROD-${item.productId}
                                                            </p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <fmt:formatNumber value="${item.productPrice}" type="currency"
                                                        currencySymbol="" /> đ
                                                </td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/cart/update"
                                                        method="POST" class="d-flex align-items-center">
                                                        <input type="hidden" name="itemId" value="${item.id}">
                                                        <div class="input-group input-group-sm" style="width: 100px;">
                                                            <input type="number" name="quantity"
                                                                class="form-control text-center"
                                                                value="${item.quantity}" min="1"
                                                                max="${item.productStock}"
                                                                onchange="this.form.submit()">
                                                        </div>
                                                    </form>
                                                </td>
                                                <td class="fw-bold text-primary">
                                                    <fmt:formatNumber value="${item.subtotal}" type="currency"
                                                        currencySymbol="" /> đ
                                                </td>
                                                <td class="pe-4 text-end">
                                                    <form action="${pageContext.request.contextPath}/cart/remove"
                                                        method="POST">
                                                        <input type="hidden" name="itemId" value="${item.id}">
                                                        <button type="submit"
                                                            class="btn btn-outline-danger btn-sm rounded-circle"
                                                            onclick="return confirmDelete('Xóa sản phẩm này khỏi giỏ hàng?')">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/products"
                                class="btn btn-outline-primary rounded-pill">
                                <i class="fas fa-arrow-left me-2"></i> Tiếp tục mua sắm
                            </a>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card shadow-sm border-0 rounded-4 p-4">
                            <h5 class="fw-bold mb-4">TỔNG CỘNG</h5>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Tạm tính:</span>
                                <span>
                                    <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="" /> đ
                                </span>
                            </div>
                            <div class="d-flex justify-content-between mb-4">
                                <span class="text-muted">Vận chuyển:</span>
                                <span class="text-success">Miễn phí</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-5">
                                <h5 class="fw-bold">Thành tiền:</h5>
                                <h5 class="fw-bold text-primary">
                                    <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="" /> đ
                                </h5>
                            </div>
                            <div class="d-grid">
                                <a href="${pageContext.request.contextPath}/order/checkout"
                                    class="btn btn-primary btn-lg rounded-pill p-3 fw-bold">
                                    TIẾN HÀNH ĐẶT HÀNG <i class="fas fa-arrow-right ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5 bg-white rounded-4 shadow-sm">
                    <i class="fas fa-shopping-cart fa-5x text-muted mb-4 opacity-50"></i>
                    <h4 class="text-muted mb-4">Giỏ hàng của bạn đang trống!</h4>
                    <a href="${pageContext.request.contextPath}/products"
                        class="btn btn-primary btn-lg rounded-pill px-5">KHÁM PHÁ CỬA HÀNG</a>
                </div>
            </c:otherwise>
        </c:choose>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>