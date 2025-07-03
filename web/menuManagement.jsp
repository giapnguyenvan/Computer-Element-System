<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }
        .content-wrapper {
            background-color: white;
            border-radius: .5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin: 1rem;
        }
        .nav-tabs {
            padding: 0 1rem;
            margin-bottom: 0;
            background: #fff;
            border-bottom: 1px solid #dee2e6;
        }
        .nav-tabs .nav-link {
            color: #6c757d;
            font-weight: 500;
            padding: 1rem 1.5rem;
            border: none;
            border-bottom: 2px solid transparent;
            margin-bottom: -1px;
        }
        .nav-tabs .nav-link:hover {
            border-color: transparent;
            color: #0d6efd;
        }
        .nav-tabs .nav-link.active {
            color: #0d6efd;
            border-bottom: 2px solid #0d6efd;
            background: none;
        }
        .tab-content {
            padding: 0;
            background: #fff;
        }
        .tab-pane {
            display: none;
            width: 100%;
        }
        .tab-pane.active {
            display: block;
        }
        .iframe-container {
            width: 100%;
            height: calc(100vh - 130px); /* Điều chỉnh chiều cao để tránh thanh cuộn */
            position: relative;
        }
        .iframe-container iframe {
            width: 100%;
            height: 100%;
            border: none;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }
    </style>
</head>
<body>
<div class="content-wrapper">
    <ul class="nav nav-tabs" id="menuTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="level1-tab" data-bs-toggle="tab" data-bs-target="#level1" type="button" role="tab">
                <i class="fas fa-list-ul me-2"></i>Menu (Level 1)
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="level2-tab" data-bs-toggle="tab" data-bs-target="#level2" type="button" role="tab">
                <i class="fas fa-stream me-2"></i>Menu (Level 2)
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="level3-tab" data-bs-toggle="tab" data-bs-target="#level3" type="button" role="tab">
                <i class="fas fa-indent me-2"></i>Menu (Level 3)
            </button>
        </li>
    </ul>

    <div class="tab-content" id="menuTabsContent">
        <div class="tab-pane fade show active" id="level1" role="tabpanel">
            <div class="iframe-container">
                <iframe src="${pageContext.request.contextPath}/menuItemManagement" scrolling="no"></iframe>
            </div>
        </div>
        <div class="tab-pane fade" id="level2" role="tabpanel">
            <div class="iframe-container">
                <iframe src="${pageContext.request.contextPath}/menuAttributeManagement" scrolling="no"></iframe>
            </div>
        </div>
        <div class="tab-pane fade" id="level3" role="tabpanel">
            <div class="iframe-container">
                <iframe src="${pageContext.request.contextPath}/menuAttributeValueManagement" scrolling="no"></iframe>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Xử lý sự kiện khi chuyển tab
    document.querySelectorAll('.nav-link').forEach(tab => {
        tab.addEventListener('click', function() {
            // Loại bỏ class active từ tất cả các tab
            document.querySelectorAll('.nav-link').forEach(t => t.classList.remove('active'));
            // Thêm class active cho tab được click
            this.classList.add('active');
            
            // Ẩn tất cả các tab content
            document.querySelectorAll('.tab-pane').forEach(content => {
                content.classList.remove('show', 'active');
            });
            
            // Hiển thị tab content tương ứng
            const target = this.getAttribute('data-bs-target').substring(1);
            const activeContent = document.getElementById(target);
            activeContent.classList.add('show', 'active');
        });
    });

    // Điều chỉnh chiều cao iframe tự động
    function adjustIframeHeight() {
        const iframes = document.querySelectorAll('iframe');
        iframes.forEach(iframe => {
            iframe.onload = function() {
                try {
                    const height = iframe.contentWindow.document.documentElement.scrollHeight;
                    iframe.style.height = height + 'px';
                    iframe.parentElement.style.height = height + 'px';
                } catch(e) {
                    console.log('Cannot adjust iframe height due to same-origin policy');
                }
            };
        });
    }

    window.onload = adjustIframeHeight;
</script>
</body>
</html> 