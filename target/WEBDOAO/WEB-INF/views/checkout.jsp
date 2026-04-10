<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <h3 class="fw-bold mb-4 text-center">XÁC NHẬN ĐẶT HÀNG</h3>

        <form action="${pageContext.request.contextPath}/order/checkout" method="POST" id="checkoutForm">
            <div class="row">
                <!-- Shipping Info -->
                <div class="col-lg-7 mb-4">
                    <div class="card shadow-sm border-0 rounded-4 p-4">
                        <h5 class="fw-bold mb-4 border-bottom pb-2"><i class="fas fa-map-marker-alt me-2 text-primary"></i>Địa chỉ giao hàng</h5>

                        <c:choose>
                            <c:when test="${not empty addresses}">
                                <!-- Chọn từ danh sách địa chỉ đã lưu -->
                                <div class="mb-3">
                                    <c:forEach items="${addresses}" var="addr">
                                        <div class="form-check p-3 border rounded-3 mb-2 ${addr.isDefault() ? 'border-primary bg-light' : ''}">
                                            <input class="form-check-input ms-0 me-2" type="radio" name="addressId"
                                                   id="addr${addr.id}" value="${addr.id}"
                                                   ${addr.isDefault() ? 'checked' : ''}>
                                            <label class="form-check-label w-100" for="addr${addr.id}">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <span class="fw-bold">${addr.receiverName}</span>
                                                        <span class="text-muted ms-2">${addr.phone}</span>
                                                        <c:if test="${addr.isDefault()}">
                                                            <span class="badge bg-primary ms-2">Mặc định</span>
                                                        </c:if>
                                                        <p class="text-muted mb-0 mt-1 small">${addr.addressDetail}</p>
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Nút thêm địa chỉ mới -->
                                <button type="button" class="btn btn-outline-primary btn-sm rounded-pill mb-3"
                                        data-bs-toggle="modal" data-bs-target="#addAddressModal">
                                    <i class="fas fa-plus me-1"></i> Thêm địa chỉ mới
                                </button>
                            </c:when>
                            <c:otherwise>
                                <!-- Nhập tay khi chưa có địa chỉ nào -->
                                <div class="alert alert-info small">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Bạn chưa có địa chỉ nào. Hãy nhập thông tin giao hàng bên dưới hoặc
                                    <a href="${pageContext.request.contextPath}/user/address" class="fw-bold">thêm địa chỉ</a>.
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold small text-muted">Họ và tên người nhận</label>
                                    <input type="text" name="fullname" class="form-control"
                                        value="${sessionScope.user.fullname}" required>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-muted">Số điện thoại</label>
                                        <input type="tel" name="phone" class="form-control" value="${sessionScope.user.phone}"
                                            required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-muted">Email</label>
                                        <input type="email" class="form-control" value="${sessionScope.user.email}" readonly
                                            disabled>
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <label class="form-label fw-bold small text-muted">Địa chỉ nhận hàng</label>
                                    <textarea name="address" class="form-control" rows="3"
                                        required placeholder="Nhập địa chỉ giao hàng..."></textarea>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <h5 class="fw-bold mb-3 mt-2 border-bottom pb-2">Phương thức thanh toán</h5>
                        <div class="form-check p-3 border rounded-3 mb-2">
                            <input class="form-check-input ms-0 me-2" type="radio" name="paymentMethod" id="cod"
                                value="COD" checked>
                            <label class="form-check-label w-100" for="cod">
                                <div class="d-flex justify-content-between">
                                    <span>Thanh toán khi nhận hàng (COD)</span>
                                    <i class="fas fa-truck text-muted"></i>
                                </div>
                            </label>
                        </div>
                        <div class="form-check p-3 border rounded-3 mb-2 opacity-50">
                            <input class="form-check-input ms-0 me-2" type="radio" name="paymentMethod" id="online"
                                value="ONLINE" disabled>
                            <label class="form-check-label w-100" for="online">
                                <div class="d-flex justify-content-between">
                                    <span>Chuyển khoản / Ví điện tử (Sắp ra mắt)</span>
                                    <i class="fas fa-credit-card text-muted"></i>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Order Summary -->
                <div class="col-lg-5">
                    <div class="card shadow-sm border-0 rounded-4 p-4">
                        <h5 class="fw-bold mb-4 border-bottom pb-2">Tóm tắt đơn hàng</h5>
                        <div class="mb-4" style="max-height: 300px; overflow-y: auto;">
                            <c:forEach items="${cartItems}" var="item">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="${item.productImage != null ? item.productImage : 'https://placehold.co/50x60'}"
                                        class="rounded-2 me-3" width="50" alt="${item.productName}">
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0 small fw-bold">${item.productName}</h6>
                                        <p class="text-muted mb-0 smallest">SL: ${item.quantity} x
                                            <fmt:formatNumber value="${item.productPrice}" type="currency"
                                                currencySymbol="" />đ
                                        </p>
                                    </div>
                                    <div class="text-end">
                                        <span class="fw-bold small">
                                            <fmt:formatNumber value="${item.subtotal}" type="currency"
                                                currencySymbol="" />đ
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <hr>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tổng phụ:</span>
                            <span>
                                <fmt:formatNumber value="${total}" type="currency" currencySymbol="" /> đ
                            </span>
                        </div>
                        <div class="d-flex justify-content-between mb-4">
                            <span class="text-muted">Phí vận chuyển:</span>
                            <span class="text-success">Miễn phí</span>
                        </div>
                        <div class="d-flex justify-content-between mb-5">
                            <h5 class="fw-bold">TỔNG CỘNG:</h5>
                            <h5 class="fw-bold text-primary">
                                <fmt:formatNumber value="${total}" type="currency" currencySymbol="" /> đ
                            </h5>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg rounded-pill p-3 fw-bold">
                                XÁC NHẬN ĐẶT HÀNG <i class="fas fa-check-circle ms-2"></i>
                            </button>
                            <p class="text-center text-muted small mt-3">Nhấn nút đặt hàng đồng nghĩa bạn chấp nhận các
                                điều khoản của chúng tôi.</p>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- Modal thêm địa chỉ nhanh từ trang checkout -->
        <div class="modal fade" id="addAddressModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content rounded-4">
                    <div class="modal-header border-0">
                        <h5 class="modal-title fw-bold">Thêm Địa Chỉ Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/user/address/add" method="POST">
                        <input type="hidden" name="redirectTo" value="checkout">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label fw-bold small">Tên người nhận *</label>
                                <input type="text" name="receiverName" class="form-control" value="${sessionScope.user.fullname}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold small">Số điện thoại *</label>
                                <input type="tel" name="phone" class="form-control" value="${sessionScope.user.phone}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold small">Địa chỉ chi tiết *</label>
                                <textarea name="addressDetail" class="form-control" rows="3"
                                    placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer border-0">
                            <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary rounded-pill">Thêm Địa Chỉ</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>