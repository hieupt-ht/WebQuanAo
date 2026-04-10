<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div class="text-center py-5">
            <h1 class="display-1 fw-bold text-muted">404</h1>
            <h2 class="fw-bold mb-4">Ối! Trang không tìm thấy.</h2>
            <p class="text-muted mb-5">Trang bạn đang tìm kiếm có thể đã bị xóa hoặc không tồn tại.</p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg rounded-pill px-5">QUAY LẠI
                TRANG CHỦ</a>
        </div>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>