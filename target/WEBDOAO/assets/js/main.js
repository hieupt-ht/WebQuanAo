// Main JS for Antigravity Shop

document.addEventListener('DOMContentLoaded', function () {
    console.log('Antigravity Shop JS Loaded');

    // Auto-dismiss alerts
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(alert => {
        setTimeout(() => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 5000);
    });

    // Simple AJAX for adding to cart (Optional enhancement)
    // For now, let's keep it traditional redirect or we can add Toast if needed.
});

function confirmDelete(message) {
    return confirm(message || 'Bạn có chắc chắn muốn xóa không?');
}
