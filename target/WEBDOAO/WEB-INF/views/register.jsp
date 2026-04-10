<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div class="row justify-content-center py-5">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow-lg border-0 rounded-4 overflow-hidden">
                    <div class="bg-primary py-4 text-center">
                        <h3 class="text-white fw-bold mb-0">ĐĂNG KÝ TÀI KHOẢN</h3>
                    </div>
                    <div class="card-body p-4 p-md-5">
                        <form action="${pageContext.request.contextPath}/auth/register" method="POST">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small text-muted">Tên đăng nhập *</label>
                                    <input type="text" name="username" class="form-control bg-light border-0" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small text-muted">Mật khẩu *</label>
                                    <input type="password" name="password" class="form-control bg-light border-0"
                                        required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold small text-muted">Họ và tên *</label>
                                <input type="text" name="fullname" class="form-control bg-light border-0" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small text-muted">Email *</label>
                                    <input type="email" name="email" class="form-control bg-light border-0" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold small text-muted">Số điện thoại</label>
                                    <input type="tel" name="phone" class="form-control bg-light border-0">
                                </div>
                            </div>




                            <div class="mb-4 form-check">
                                <input type="checkbox" class="form-check-input" id="terms" required>
                                <label class="form-check-label small text-muted" for="terms">Tôi đồng ý với các <a
                                        href="#" class="text-primary text-decoration-none">điều khoản dịch
                                        vụ</a></label>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 py-3 fw-bold rounded-pill shadow-sm">
                                ĐĂNG KÝ TÀI KHOẢN <i class="fas fa-check-circle ms-2"></i>
                            </button>

                            <div class="text-center mt-4">
                                <p class="text-muted small">Đã có tài khoản? <a
                                        href="${pageContext.request.contextPath}/auth/login"
                                        class="text-primary fw-bold text-decoration-none">Đăng nhập</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>