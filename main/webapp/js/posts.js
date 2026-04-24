// Xử lý toggle switch trạng thái Published / Draft cho form đăng bài
const toggle = document.getElementById('statusToggle');
const toggleText = document.getElementById('toggleStatusText');

function updateToggleText() {
    if (!toggle || !toggleText) return;
    if (toggle.checked) {
        toggleText.textContent = 'Published';
        toggleText.style.color = '#22c55e';
    } else {
        toggleText.textContent = 'Draft';
        toggleText.style.color = '#64748b';
    }
}

if (toggle) {
    toggle.addEventListener('change', updateToggleText);
    updateToggleText();
}

