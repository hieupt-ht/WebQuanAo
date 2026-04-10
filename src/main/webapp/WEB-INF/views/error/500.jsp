<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div class="text-center py-5">
            <h1 class="display-1 fw-bold text-danger">500</h1>
            <h2 class="fw-bold mb-4">Lỗi Hệ Thống!</h2>
            <p class="text-muted mb-5">Đã có lỗi xảy ra từ phía chúng tôi. Vui lòng thử lại sau.</p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg rounded-pill px-5">QUAY LẠI
                TRANG CHỦ</a>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>