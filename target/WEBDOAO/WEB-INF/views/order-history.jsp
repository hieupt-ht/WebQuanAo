<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <h3 class="fw-bold mb-4">LỊCH SỬ ĐƠN HÀNG</h3>

        <c:choose>
            <c:when test="${not empty orders}">
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">Mã đơn hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Người nhận</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th class="pe-4 text-end">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="o">
                                    <tr>
                                        <td class="ps-4 fw-bold">#ORD-${o.id}</td>
                                        <td>
                                            <fmt:formatDate value="${o.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td>${o.fullname}</td>
                                        <td class="fw-bold text-primary">
                                            <fmt:formatNumber value="${o.totalAmount}" type="currency"
                                                currencySymbol="" />
                                            đ
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${o.status == 'PENDING'}"><span
                                                        class="badge bg-warning text-dark rounded-pill px-3">Đang
                                                        chờ</span>
                                                </c:when>
                                                <c:when test="${o.status == 'SHIPPING'}"><span
                                                        class="badge bg-info text-dark rounded-pill px-3">Đang
                                                        giao</span>
                                                </c:when>
                                                <c:when test="${o.status == 'COMPLETED'}"><span
                                                        class="badge bg-success rounded-pill px-3">Hoàn thành</span>
                                                </c:when>
                                                <c:when test="${o.status == 'CANCELLED'}"><span
                                                        class="badge bg-danger rounded-pill px-3">Đã hủy</span></c:when>
                                            </c:choose>
                                        </td>
                                        <td class="pe-4 text-end">
                                            <a href="${pageContext.request.contextPath}/order/detail?id=${o.id}"
                                                class="btn btn-outline-primary btn-sm rounded-pill px-3">Chi tiết</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5 bg-white rounded-4 shadow-sm">
                    <i class="fas fa-box-open fa-5x text-muted mb-4 opacity-50"></i>
                    <h4 class="text-muted mb-4">Bạn chưa có đơn hàng nào!</h4>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary rounded-pill px-5">MUA
                        SẮM
                        NGAY</a>
                </div>
            </c:otherwise>
        </c:choose>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>