<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Product Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .main-container {
                padding: 20px;
                max-width: 1400px;
                margin: 0 auto;
            }
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }
            .card-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 15px 15px 0 0 !important;
                padding: 20px;
            }
            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
            }
            .btn-primary:hover {
                background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
                transform: translateY(-1px);
            }
            .table-container {
                background: white;
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .dataTables_wrapper .dataTables_filter {
                margin-bottom: 20px;
            }
            .dataTables_wrapper .dataTables_filter input {
                border-radius: 8px;
                border: 1px solid #ddd;
                padding: 8px 12px;
                width: 300px;
            }
            .dataTables_wrapper .dataTables_length select {
                border-radius: 8px;
                border: 1px solid #ddd;
                padding: 5px 10px;
            }
            .dataTables_wrapper .dataTables_paginate .paginate_button {
                border-radius: 8px;
                margin: 0 2px;
            }
            .dataTables_wrapper .dataTables_paginate .paginate_button.current {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                color: white !important;
            }
            .product-image {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid #e9ecef;
            }
            .action-buttons {
                display: flex;
                gap: 8px;
                justify-content: center;
            }
            .btn-sm {
                padding: 5px 10px;
                border-radius: 6px;
                font-size: 12px;
            }
            .status-badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 500;
            }
            .status-active {
                background-color: #d4edda;
                color: #155724;
            }
            .status-inactive {
                background-color: #f8d7da;
                color: #721c24;
            }
            .upload-section {
                background: white;
                border-radius: 15px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .file-upload-area {
                border: 2px dashed #ddd;
                border-radius: 10px;
                padding: 30px;
                text-align: center;
                transition: all 0.3s ease;
                cursor: pointer;
            }
            .file-upload-area:hover {
                border-color: #667eea;
                background-color: #f8f9ff;
            }
            .file-upload-area.dragover {
                border-color: #667eea;
                background-color: #f8f9ff;
            }
            .preview-table {
                margin-top: 20px;
                border-radius: 10px;
                overflow: hidden;
            }
            .preview-table th {
                background-color: #f8f9fa;
                font-weight: 600;
            }
            .loading-spinner {
                display: none;
                text-align: center;
                padding: 20px;
            }
            .alert {
                border-radius: 10px;
                border: none;
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <!-- Header Card -->
            <div class="card">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3 class="mb-0">
                            <i class="fas fa-boxes me-2"></i>Product Management
                        </h3>
                        <div>
                            <button type="button" class="btn btn-light me-2" onclick="showUploadSection()">
                                <i class="fas fa-file-upload me-1"></i>Upload Excel
                            </button>
                            <a href="${pageContext.request.contextPath}/addProduct.jsp" class="btn btn-light">
                                <i class="fas fa-plus me-1"></i>Add Product
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Upload Section (Hidden by default) -->
            <div id="uploadSection" class="upload-section" style="display: none;">
                <h5 class="mb-3">
                    <i class="fas fa-upload me-2"></i>Upload Products from Excel
                </h5>
                
                <div class="file-upload-area" id="fileUploadArea">
                    <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                    <h5>Drag & Drop Excel file here</h5>
                    <p class="text-muted">or click to browse</p>
                    <input type="file" id="excelFile" accept=".xlsx,.xls" style="display: none;">
                </div>

                <div id="previewContainer" style="display: none;">
                    <h6 class="mt-3 mb-2">Preview:</h6>
                    <div class="table-responsive">
                        <table class="table table-sm table-bordered preview-table" id="previewTable">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                    <div class="mt-3">
                        <button type="button" class="btn btn-success" id="confirmUploadBtn">
                            <i class="fas fa-check me-1"></i>Confirm Upload
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="hideUploadSection()">
                            <i class="fas fa-times me-1"></i>Cancel
                        </button>
                    </div>
                </div>

                <div class="loading-spinner" id="loadingSpinner">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-2">Processing upload...</p>
                </div>
            </div>

            <!-- Alert Messages -->
            <div id="alertContainer"></div>

            <!-- Products DataTable -->
            <div class="table-container">
                <table id="productsTable" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Brand</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${product}">
                            <tr>
                                <td>${product.productId}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty product.imageUrl}">
                                            <img src="${product.imageUrl}" class="product-image" alt="Product">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-image bg-light d-flex align-items-center justify-content-center">
                                                <i class="fas fa-image text-muted"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${product.name}</td>
                                <td>${product.brandName}</td>
                                <td>${product.componentTypeName}</td>
                                <td>$${product.price}</td>
                                <td>${product.stock}</td>
                                <td>
                                    <span class="status-badge ${product.status == 'Active' ? 'status-active' : 'status-inactive'}">
                                        ${product.status != null ? product.status : 'Active'}
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-outline-primary btn-sm edit-product" data-product-id="${product.productId}" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-outline-danger btn-sm delete-product" data-product-id="${product.productId}" title="Delete">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                        <button class="btn btn-success btn-sm select-product" data-product-id="${product.productId}" data-product-name="${product.name}" data-product-price="${product.price}" title="Select">
                                            <i class="fas fa-check"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

        <script>
            $(document).ready(function() {
                // Initialize DataTable
                const table = $('#productsTable').DataTable({
                    pageLength: 10,
                    lengthMenu: [[5, 10, 25, 50], [5, 10, 25, 50]],
                    order: [[0, 'desc']],
                    responsive: true,
                    language: {
                        search: "Search products:",
                        lengthMenu: "Show _MENU_ products per page",
                        info: "Showing _START_ to _END_ of _TOTAL_ products",
                        paginate: {
                            first: "First",
                            last: "Last",
                            next: "Next",
                            previous: "Previous"
                        }
                    },
                    columnDefs: [
                        { orderable: false, targets: [1, 8] }, // Image and Actions columns
                        { className: "text-center", targets: [1, 6, 7, 8] }
                    ]
                });

                // File upload functionality
                const fileUploadArea = document.getElementById('fileUploadArea');
                const excelFile = document.getElementById('excelFile');

                // Click to upload
                fileUploadArea.addEventListener('click', () => {
                    excelFile.click();
                });

                // Drag and drop
                fileUploadArea.addEventListener('dragover', (e) => {
                    e.preventDefault();
                    fileUploadArea.classList.add('dragover');
                });

                fileUploadArea.addEventListener('dragleave', () => {
                    fileUploadArea.classList.remove('dragover');
                });

                fileUploadArea.addEventListener('drop', (e) => {
                    e.preventDefault();
                    fileUploadArea.classList.remove('dragover');
                    const files = e.dataTransfer.files;
                    if (files.length > 0) {
                        excelFile.files = files;
                        handleFileSelect();
                    }
                });

                // File selection
                excelFile.addEventListener('change', handleFileSelect);

                // Confirm upload
                $('#confirmUploadBtn').on('click', function() {
                    uploadProducts();
                });

                // Edit product
                $('#productsTable').on('click', '.edit-product', function() {
                    const productId = $(this).data('product-id');
                    window.location.href = "${pageContext.request.contextPath}/producteditservlet?action=edit&id=" + productId;
                });

                // Delete product
                $('#productsTable').on('click', '.delete-product', function() {
                    const productId = $(this).data('product-id');
                    if (confirm('Are you sure you want to deactivate this product? This will change its status to Inactive.')) {
                        window.location.href = "${pageContext.request.contextPath}/producteditservlet?action=delete&id=" + productId;
                    }
                });

                // Select product for PC Builder
                $('#productsTable').on('click', '.select-product', function() {
                    const productId = $(this).data('product-id');
                    const productName = $(this).data('product-name');
                    const productPrice = $(this).data('product-price');
                    
                    // Lấy componentType từ URL parameter
                    const urlParams = new URLSearchParams(window.location.search);
                    const componentType = urlParams.get('componentType');
                    
                    if (componentType) {
                        // Gọi hàm từ parent window
                        if (window.parent && window.parent.selectComponentFromIframe) {
                            window.parent.selectComponentFromIframe(productId, productName, productPrice, componentType);
                        } else {
                            // Fallback: hiển thị thông báo
                            alert(`Đã chọn: ${productName} - $${productPrice}`);
                        }
                    } else {
                        alert('Không xác định được loại linh kiện');
                    }
                });
            });

            function showUploadSection() {
                $('#uploadSection').slideDown();
                $('#productsTable_wrapper').slideUp();
            }

            function hideUploadSection() {
                $('#uploadSection').slideUp();
                $('#productsTable_wrapper').slideDown();
                resetUploadForm();
            }

            function resetUploadForm() {
                $('#excelFile').val('');
                $('#previewContainer').hide();
                $('#previewTable thead').empty();
                $('#previewTable tbody').empty();
            }

            function handleFileSelect() {
                const file = document.getElementById('excelFile').files[0];
                if (!file) return;

                if (!file.name.endsWith('.xlsx') && !file.name.endsWith('.xls')) {
                    showAlert('Please upload a valid Excel file.', 'danger');
                    return;
                }

                const reader = new FileReader();
                reader.onload = function(e) {
                    try {
                        const data = new Uint8Array(e.target.result);
                        const workbook = XLSX.read(data, { type: 'array' });
                        const sheetName = workbook.SheetNames[0];
                        const worksheet = workbook.Sheets[sheetName];
                        const json = XLSX.utils.sheet_to_json(worksheet, { header: 1, defval: "" });

                        displayPreview(json);
                    } catch (error) {
                        showAlert('Error reading Excel file: ' + error.message, 'danger');
                    }
                };
                reader.readAsArrayBuffer(file);
            }

            function displayPreview(json) {
                const headers = ['Name', 'Brand', 'Component Type', 'Model', 'Price', 'Import Price', 'Stock', 'SKU', 'Description'];
                
                let headerHtml = '<tr>';
                headers.forEach(header => {
                    headerHtml += `<th class="text-center">${header}</th>`;
                });
                headerHtml += '</tr>';
                
                $('#previewTable thead').html(headerHtml);

                let bodyHtml = '';
                // Start from index 1 to skip header row
                for (let i = 1; i < Math.min(json.length, 10); i++) { // Show max 10 rows
                    const row = json[i];
                    bodyHtml += '<tr>';
                    row.forEach(cell => {
                        bodyHtml += `<td>${cell || ''}</td>`;
                    });
                    bodyHtml += '</tr>';
                }
                
                $('#previewTable tbody').html(bodyHtml);
                $('#previewContainer').show();
            }

            function uploadProducts() {
                const file = document.getElementById('excelFile').files[0];
                if (!file) {
                    showAlert('Please select a file first.', 'warning');
                    return;
                }

                const formData = new FormData();
                formData.append('excelFile', file);

                $('#loadingSpinner').show();
                $('#confirmUploadBtn').prop('disabled', true);

                fetch('${pageContext.request.contextPath}/ProductImportServlet', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    $('#loadingSpinner').hide();
                    $('#confirmUploadBtn').prop('disabled', false);
                    
                    if (data.success) {
                        showAlert(`Successfully uploaded ${data.count} products!`, 'success');
                        hideUploadSection();
                        // Reload the page to refresh the table
                        setTimeout(() => {
                            location.reload();
                        }, 2000);
                    } else {
                        showAlert('Upload failed: ' + data.message, 'danger');
                    }
                })
                .catch(error => {
                    $('#loadingSpinner').hide();
                    $('#confirmUploadBtn').prop('disabled', false);
                    showAlert('Upload failed: ' + error.message, 'danger');
                });
            }

            function showAlert(message, type) {
                const alertHtml = `
                    <div class="alert alert-${type} alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                `;
                $('#alertContainer').html(alertHtml);
                
                // Auto-dismiss after 5 seconds
                setTimeout(() => {
                    $('.alert').alert('close');
                }, 5000);
            }
        </script>
    </body>
</html> 