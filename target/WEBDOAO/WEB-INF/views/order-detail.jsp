<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold mb-0">CHI TIẾT ĐƠN HÀNG #ORD-${order.id}</h3>
            <a href="${pageContext.request.contextPath}/order/history"
                class="btn btn-outline-secondary btn-sm rounded-pill"><i class="fas fa-arrow-left me-2"></i> Quay
                lại</a>
        </div>

        <div class="row">
            <div class="col-lg-8 mb-4">
                <!-- Order Items -->
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-4">
                    <div class="card-header bg-white py-3">
                        <h6 class="fw-bold mb-0">Danh sách sản phẩm</h6>
                    </div>
                    <div class="table-responsive">
                        <table class="table align-middle mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">Sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th class="pe-4 text-end">Tổng cộng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${order.orderDetails}" var="item">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="d-flex align-items-center">
                                                <img src="${item.productImage != null ? item.productImage : 'https://placehold.co/50x60'}"
                                                    class="rounded-2 me-3" width="50" alt="${item.productName}">
                                                <h6 class="mb-0 small fw-bold">${item.productName}</h6>
                                            </div>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="" />
                                            đ
                                        </td>
                                        <td>${item.quantity}</td>
                                        <td class="pe-4 text-end fw-bold text-primary">
                                            <fmt:formatNumber value="${item.price * item.quantity}" type="currency"
                                                currencySymbol="" /> đ
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot class="bg-light">
                                <tr>
                                    <td colspan="3" class="text-end fw-bold ps-4">THÀNH TIỀN:</td>
                                    <td class="pe-4 text-end fw-bold text-primary fs-5">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency"
                                            currencySymbol="" />
                                        đ
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <!-- Shipping/Status Info -->
                <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                    <h6 class="fw-bold mb-3 border-bottom pb-2">Thông tin nhận hàng</h6>
                    <p class="mb-1 fw-bold smallest">${order.fullname}</p>
                    <p class="mb-1 smallest text-muted">${order.phone}</p>
                    <p class="mb-3 smallest text-muted">${order.address}</p>

                    <h6 class="fw-bold mb-2 mt-2">Trạng thái:</h6>
                    <div class="mb-3">
                        <c:choose>
                            <c:when test="${order.status == 'PENDING'}"><span
                                    class="badge bg-warning text-dark rounded-pill px-3">Đang chờ xử lý</span></c:when>
                            <c:when test="${order.status == 'SHIPPING'}"><span
                                    class="badge bg-info text-dark rounded-pill px-3">Đang giao hàng</span></c:when>
                            <c:when test="${order.status == 'COMPLETED'}"><span
                                    class="badge bg-success rounded-pill px-3">Đã giao thành công</span></c:when>
                            <c:when test="${order.status == 'CANCELLED'}"><span
                                    class="badge bg-danger rounded-pill px-3">Đã
                                    bị hủy</span></c:when>
                        </c:choose>
                    </div>

                    <h6 class="fw-bold mb-1 mt-2">Ngày đặt:</h6>
                    <p class="text-muted smallest">
                        <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                    </p>

                    <h6 class="fw-bold mb-1 mt-2">Thanh toán:</h6>
                    <p class="text-muted smallest mb-0">${order.paymentMethod == 'COD' ? 'Thanh toán khi nhận hàng' :
                        'Thanh
                        toán online'}</p>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>