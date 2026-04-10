<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3 class="fw-bold mb-0"><i class="fas fa-map-marker-alt me-2 text-primary"></i>Địa Chỉ Của Tôi</h3>
                    <button class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#addAddressModal">
                        <i class="fas fa-plus me-1"></i> Thêm Địa Chỉ Mới
                    </button>
                </div>

                <c:choose>
                    <c:when test="${not empty addresses}">
                        <div class="row g-3">
                            <c:forEach items="${addresses}" var="addr">
                                <div class="col-12">
                                    <div class="card shadow-sm border-0 rounded-3 ${addr.isDefault() ? 'border-start border-primary border-4' : ''}">
                                        <div class="card-body p-4">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div class="flex-grow-1">
                                                    <div class="d-flex align-items-center mb-2">
                                                        <h6 class="fw-bold mb-0 me-3">${addr.receiverName}</h6>
                                                        <span class="text-muted small">${addr.phone}</span>
                                                        <c:if test="${addr.isDefault()}">
                                                            <span class="badge bg-primary ms-2">Mặc định</span>
                                                        </c:if>
                                                    </div>
                                                    <p class="text-muted mb-0">${addr.addressDetail}</p>
                                                </div>
                                                <div class="d-flex gap-2 ms-3">
                                                    <button class="btn btn-sm btn-outline-primary rounded-pill"
                                                            data-bs-toggle="modal" data-bs-target="#editModal${addr.id}">
                                                        <i class="fas fa-edit"></i> Sửa
                                                    </button>
                                                    <c:if test="${!addr.isDefault()}">
                                                        <form action="${pageContext.request.contextPath}/user/address/set-default" method="POST" class="d-inline">
                                                            <input type="hidden" name="addressId" value="${addr.id}">
                                                            <button type="submit" class="btn btn-sm btn-outline-success rounded-pill">
                                                                <i class="fas fa-check"></i> Đặt mặc định
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                    <form action="${pageContext.request.contextPath}/user/address/delete" method="POST" class="d-inline"
                                                          onsubmit="return confirm('Bạn có chắc muốn xóa địa chỉ này?')">
                                                        <input type="hidden" name="addressId" value="${addr.id}">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Edit Modal cho từng địa chỉ -->
                                <div class="modal fade" id="editModal${addr.id}" tabindex="-1">
                                    <div class="modal-dialog">
                                        <div class="modal-content rounded-4">
                                            <div class="modal-header border-0">
                                                <h5 class="modal-title fw-bold">Sửa Địa Chỉ</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/user/address/edit" method="POST">
                                                <div class="modal-body">
                                                    <input type="hidden" name="addressId" value="${addr.id}">
                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold small">Tên người nhận</label>
                                                        <input type="text" name="receiverName" class="form-control" value="${addr.receiverName}" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold small">Số điện thoại</label>
                                                        <input type="tel" name="phone" class="form-control" value="${addr.phone}" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold small">Địa chỉ chi tiết</label>
                                                        <textarea name="addressDetail" class="form-control" rows="3" required>${addr.addressDetail}</textarea>
                                                    </div>
                                                </div>
                                                <div class="modal-footer border-0">
                                                    <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Hủy</button>
                                                    <button type="submit" class="btn btn-primary rounded-pill">Lưu Thay Đổi</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-map-marker-alt fa-4x text-muted mb-3 opacity-25"></i>
                            <h5 class="text-muted">Bạn chưa có địa chỉ nào</h5>
                            <p class="text-muted">Hãy thêm địa chỉ giao hàng để đặt hàng nhanh hơn.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Add Address Modal -->
        <div class="modal fade" id="addAddressModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content rounded-4">
                    <div class="modal-header border-0">
                        <h5 class="modal-title fw-bold">Thêm Địa Chỉ Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/user/address/add" method="POST">
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
                                <textarea name="addressDetail" class="form-control" rows="3" placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố" required></textarea>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="isDefault" value="1" id="isDefaultCheck">
                                <label class="form-check-label" for="isDefaultCheck">Đặt làm địa chỉ mặc định</label>
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
