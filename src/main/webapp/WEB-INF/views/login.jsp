<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div class="row justify-content-center py-5">
            <div class="col-md-5 col-lg-4">
                <div class="card shadow-lg border-0 rounded-4 overflow-hidden">
                    <div class="bg-primary py-4 text-center">
                        <h3 class="text-white fw-bold mb-0">ĐĂNG NHẬP</h3>
                    </div>
                    <div class="card-body p-4 p-md-5">
                        <form action="${pageContext.request.contextPath}/auth/login" method="POST">
                            <div class="mb-4">
                                <label class="form-label fw-bold small text-muted">Tên đăng nhập</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-user text-muted"></i></span>
                                    <input type="text" name="username" class="form-control bg-light border-0"
                                        placeholder="Username" required autofocus>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-bold small text-muted">Mật khẩu</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-lock text-muted"></i></span>
                                    <input type="password" name="password" class="form-control bg-light border-0"
                                        placeholder="Password" required>
                                </div>
                            </div>
                            <div class="mb-4 d-flex justify-content-between small">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="remember">
                                    <label class="form-check-label text-muted" for="remember">Ghi nhớ tôi</label>
                                </div>
                                <a href="#" class="text-decoration-none text-primary">Quên mật khẩu?</a>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 py-3 fw-bold rounded-pill shadow-sm">
                                ĐĂNG NHẬP <i class="fas fa-arrow-right ms-2"></i>
                            </button>

                            <div class="text-center mt-5">
                                <p class="text-muted small">Chưa có tài khoản? <a
                                        href="${pageContext.request.contextPath}/auth/register"
                                        class="text-primary fw-bold text-decoration-none">Đăng ký ngay</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>