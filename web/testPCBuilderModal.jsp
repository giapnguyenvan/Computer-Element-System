<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Test PC Builder Modal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .modal-xl {
                max-width: 95%;
            }
            .modal-body iframe {
                width: 100%;
                height: 80vh;
                border: none;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2>Test PC Builder Modal</h2>
            <button class="btn btn-primary" onclick="openModal()">Open Product Management Modal</button>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="testModal" tabindex="-1">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Product Management</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <iframe id="testIframe" src="productservlet?service=productManagement&componentType=CPU" style="width:100%; height:80vh; border:none;"></iframe>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function openModal() {
                const modal = new bootstrap.Modal(document.getElementById('testModal'));
                modal.show();
            }

            // Hàm để iframe gọi
            function selectComponentFromIframe(productId, productName, price, componentType) {
                alert(`Selected: ${productName} - $${price} (${componentType})`);
                const modal = bootstrap.Modal.getInstance(document.getElementById('testModal'));
                if (modal) modal.hide();
            }
        </script>
    </body>
</html> 