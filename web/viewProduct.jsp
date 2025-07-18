<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Product Table</title>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/nouislider@15.7.1/dist/nouislider.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/universal-table.css">
    </head>
    <body>
        <div id="productTableContainer">
            <div class="container-fluid mt-3" style="padding-left:0; margin-left:0; width:100%; max-width:100%;">
                <div class="univ-table-wrapper">
                    <div class="univ-table-toolbar">
                        <button type="button" class="btn btn-primary" onclick="openUploadModal()">
                            <i class="fas fa-file-upload me-2"></i>Upload Excel
                        </button>
                        <div id="custom-dt-search"></div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle univ-table-custom mb-0" id="myTable">
                            <thead class="table-light">
                                <tr>
                                    <th><div class="univ-colheader"><span>ID</span></div></th>
                                    <th><div class="univ-colheader"><span>Name</span></div></th>
                                    <th><div class="univ-colheader"><span>Brand</span><span><button class="no-sort univ-btn-filter btn-sm w-100" data-col="2" title="Filter"><i class="fas fa-filter"></i></button></span></div></th>
                                    <th><div class="univ-colheader"><span>Category</span><span><button class="no-sort univ-btn-filter btn-sm w-100" data-col="3" title="Filter"><i class="fas fa-filter"></i></button></span></div></th>
                                    <th><div class="univ-colheader"><span>Price</span><span><button class="no-sort univ-btn-filter btn-sm w-100" data-col="4" title="Filter"><i class="fas fa-filter"></i></button></span></div></th>
                                    <th><div class="univ-colheader"><span>Stock</span><span><button class="no-sort univ-btn-filter btn-sm w-100" data-col="5" title="Filter"><i class="fas fa-filter"></i></button></span></div></th>
                                    <th><div class="univ-colheader"><span>Image</span></div></th>
                                    <th><div class="univ-colheader"><span>Status</span><span><button class="no-sort univ-btn-filter btn-sm w-100" data-col="7" title="Filter"><i class="fas fa-filter"></i></button></span></div></th>
                                    <th><div class="univ-colheader"><span>Actions</span></div></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${product}">
                                    <tr>
                                        <td>${product.productId}</td>
                                        <td>${product.name}</td>
                                        <td>${product.brandName}</td>
                                        <td>${product.componentTypeName}</td>
                                        <td>${product.price}</td>
                                        <td>${product.stock}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.imageUrl}">
                                                    <img src="${product.imageUrl}" width="36" height="36" style="object-fit:cover; border-radius:6px;" alt="Product Image">
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted small">No Image</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${product.status != null}">
                                                    ${product.status}
                                                </c:when>
                                                <c:otherwise>
                                                    Active
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button class="btn btn-link p-0 edit-action" title="Edit" data-product-id="${product.productId}">
                                                <i class="fas fa-edit text-primary"></i>
                                            </button>
                                            <button class="btn btn-link p-0 delete-action" title="Delete" data-product-id="${product.productId}">
                                                <i class="fas fa-trash-alt text-danger"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="columnFilterPopup" style="display:none;
                     position:absolute;
                     background:#fff;
                     border:1px solid #ccc;
                     box-shadow:0 2px 8px rgba(0,0,0,0.2);
                     padding:10px;
                     max-height:250px;
                     overflow-y:auto;
                     z-index:1000;">
                    <div style="text-align:right;">
                        <button id="closeFilterBtn" type="button" class="btn btn-sm btn-close"></button>
                    </div>
                    <div id="filterOptionsContainer"></div>
                    <div class="mt-2" style="display: flex; gap: 10px;">
                        <button id="applyFilterBtn" type="button" class="btn btn-sm btn-primary">Apply Filter</button>
                        <button id="clearFilterBtn" type="button" class="btn btn-sm btn-secondary">Clear Filter</button>
                    </div>
                </div>

                <!-- Upload Modal -->
                <div id="uploadModal" style="display:none;
                     position:fixed;
                     top:10%;
                     left:50%;
                     transform:translateX(-50%);
                     background:#fff;
                     padding:20px;
                     border:1px solid #ccc;
                     z-index:1050;">
                    <h5>Select an Excel file</h5>
                    <form id="uploadForm" method="post" action="ProductImportServlet" enctype="multipart/form-data">
                        <input type="file" name="excelFile" id="excelFile" accept=".xlsx, .xls" required><br><br>
                        <div id="previewContainer" style="display:none;">
                            <h5>Product Preview</h5>
                            <div style="overflow-x: auto; max-width: 100%;">
                                <table id="previewTable" border="1" class="table table-bordered" style="min-width: 800px;">
                                    <thead></thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Move the buttons here, outside of #previewContainer -->
                        <div class="modal-footer" style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px;">
                            <button type="submit" class="btn btn-success">Confirm Upload</button>
                            <button type="button" class="btn btn-secondary" onclick="closeUploadModal()">Cancel</button>
                        </div>
                    </form>
                </div>

                <!-- Optional overlay for dim background -->
                <div id="previewOverlay" style="display:none;
                     position:fixed;
                     top:0;
                     left:0;
                     width:100%;
                     height:100%;
                     background:rgba(0,0,0,0.5);
                     z-index:1049;" onclick="closeUploadModal()"></div>


            </div>

            <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
            <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
            <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/nouislider@15.7.1/dist/nouislider.min.js"></script>
            <script>
                         $(document).ready(function () {
                             const table = $('#myTable').DataTable({
                                 pagingType: "full_numbers",
                                 lengthMenu: [[5, 10, 15], [5, 10, 15]],
                                 pageLength: 5,
                                 ordering: true,
                                 dom: 'ftip',
                                 columnDefs: [
                                     {orderable: false, targets: [1, 2, 3, 6, 7, 8]}
                                 ],
                                 language: {
                                     paginate: {
                                         first: '<<',
                                         previous: '<',
                                         next: '>',
                                         last: '>>'
                                     }
                                 }
                             });
                             // Move DataTables search box into the toolbar
                             $('#custom-dt-search').append($('#myTable_filter'));
                             $('#myTable thead th').on('click', function (e) {
                                 e.preventDefault();
                                 e.stopPropagation();
                             });
                             let sortStates = {};
                             let currentFilterCol = null;
                             $('.sortable').on('click', function () {
                                 const col = parseInt($(this).data('col'));
                                 sortStates[col] = !sortStates[col] || false;
                                 const direction = sortStates[col] ? 'asc' : 'desc';
                                 sortTable(col, direction);
                                 $(this).closest('th').toggleClass('sorted-asc sorted-desc', sortStates[col]);
                                 table.draw();
                             });
                             $('.sort-asc').on('click', function (e) {
                                 e.stopPropagation();
                                 const col = parseInt($(this).data('col'));
                                 sortStates[col] = !sortStates[col] || false;
                                 const direction = sortStates[col] ? 'asc' : 'desc';
                                 sortTable(col, direction);
                                 $(this).closest('th').toggleClass('sorted-asc sorted-desc', sortStates[col]);
                                 table.draw();
                             });
                             $('.no-sort').on('click', function (e) {
                                 e.stopPropagation();
                                 currentFilterCol = parseInt($(this).data('col'));
                                 const $popup = $('#columnFilterPopup');
                                 const $btn = $(this);
                                 const offset = $btn.offset();
                                 $popup.css({
                                     top: offset.top + $btn.outerHeight(),
                                     left: offset.left,
                                     display: 'block',
                                     width: $btn.outerWidth() * 8
                                 });
                                 // If this is the Price column (col 4), show min/max filter
                                 if (currentFilterCol === 4) {
                                     // Get all price values from all pages
                                     let prices = [];
                                     table.column(currentFilterCol, {search: 'applied'}).data().each(function (value) {
                                         let num = parseFloat(String(value).replace(/[^0-9.\-]+/g, ''));
                                         if (!isNaN(num))
                                             prices.push(num);
                                     });
                                     let min = Math.min.apply(null, prices);
                                     let max = Math.max.apply(null, prices);
                                     let html = `
                        <div>
                            <div id="priceSlider" style="margin:20px 10px 10px 10px"></div>
                            <div>
                                <span>Min: <span id="minPriceVal">${min}</span></span>
                                <span class="ms-3">Max: <span id="maxPriceVal">${max}</span></span>
                            </div>
                        </div>
                    `;
                                     $('#filterOptionsContainer').html(html);
                                     // Initialize noUiSlider
                                     var slider = document.getElementById('priceSlider');
                                     noUiSlider.create(slider, {
                                         start: [min, max],
                                         connect: true,
                                         range: {
                                             'min': min,
                                             'max': max
                                         },
                                         tooltips: [true, true],
                                         format: {
                                             to: function (value) {
                                                 return Math.round(value);
                                             },
                                             from: function (value) {
                                                 return Number(value);
                                             }
                                         }
                                     });
                                     slider.noUiSlider.on('update', function (values) {
                                         $('#minPriceVal').text(values[0]);
                                         $('#maxPriceVal').text(values[1]);
                                     });
                                     // Save slider for use in filter
                                     $('#applyFilterBtn').data('slider', slider);
                                 } else if (currentFilterCol === 5) {
                                     // Stock filter with slider
                                     let stocks = [];
                                     table.column(currentFilterCol, {search: 'applied'}).data().each(function (value) {
                                         let num = parseFloat(String(value).replace(/[^0-9.\-]+/g, ''));
                                         if (!isNaN(num))
                                             stocks.push(num);
                                     });
                                     let min = Math.min.apply(null, stocks);
                                     let max = Math.max.apply(null, stocks);
                                     let html = `
                        <div>
                            <div id="stockSlider" style="margin:20px 10px 10px 10px"></div>
                            <div>
                                <span>Min: <span id="minStockVal">${min}</span></span>
                                <span class="ms-3">Max: <span id="maxStockVal">${max}</span></span>
                            </div>
                        </div>
                    `;
                                     $('#filterOptionsContainer').html(html);
                                     // Initialize noUiSlider
                                     var slider = document.getElementById('stockSlider');
                                     noUiSlider.create(slider, {
                                         start: [min, max],
                                         connect: true,
                                         range: {
                                             'min': min,
                                             'max': max
                                         },
                                         tooltips: [true, true],
                                         format: {
                                             to: function (value) {
                                                 return Math.round(value);
                                             },
                                             from: function (value) {
                                                 return Number(value);
                                             }
                                         }
                                     });
                                     slider.noUiSlider.on('update', function (values) {
                                         $('#minStockVal').text(values[0]);
                                         $('#maxStockVal').text(values[1]);
                                     });
                                     // Save slider for use in filter
                                     $('#applyFilterBtn').data('slider', slider);
                                 } else {
                                     // Default: dropdown filter for other columns
                                     let selectHtml = '<select id="popupColumnFilter" style="width:100%; margin-top:5px;"><option value="">-- Select to filter --</option>';
                                     let uniqueValues = [];
                                     table.column(currentFilterCol, {search: 'applied'}).data().each(function (value) {
                                         value = $('<div>').html(value).text().trim();
                                         if (value && uniqueValues.indexOf(value) === -1) {
                                             uniqueValues.push(value);
                                         }
                                     });
                                     uniqueValues.sort().forEach(function (val) {
                                         selectHtml += '<option value="' + val + '">' + val + '</option>';
                                     });
                                     selectHtml += '</select>';
                                     $('#filterOptionsContainer').html(selectHtml);
                                 }
                             });
                             $('#closeFilterBtn').on('click', function () {
                                 $('#columnFilterPopup').hide();
                             });

                             $('#clearFilterBtn').on('click', function () {
                                 const $popup = $('#columnFilterPopup');
                                 $popup.hide();

                                 // Clear all custom filters by removing all search functions
                                 $.fn.dataTable.ext.search = [];

                                 // Clear all column searches
                                 table.columns().search('').draw();

                                 // Reset any dropdown selections
                                 $('#popupColumnFilter').val('');
                             });
                             $('#applyFilterBtn').off('click').on('click', function () {
                                 const $popup = $('#columnFilterPopup');
                                 $popup.hide();
                                 if (currentFilterCol === 4) {
                                     // Price filter with slider
                                     let slider = $('#applyFilterBtn').data('slider');
                                     let values = slider.noUiSlider.get();
                                     let min = parseFloat(values[0]);
                                     let max = parseFloat(values[1]);
                                     // Remove previous price filter
                                     $.fn.dataTable.ext.search = $.fn.dataTable.ext.search.filter(function (f) {
                                         return f.name !== 'priceRange';
                                     });
                                     $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
                                         let price = parseFloat(data[4].replace(/[^0-9.\-]+/g, ''));
                                         if (isNaN(price))
                                             return false;
                                         return price >= min && price <= max;
                                     });
                                     table.draw();
                                 } else if (currentFilterCol === 5) {
                                     // Stock filter with slider
                                     let slider = $('#applyFilterBtn').data('slider');
                                     let values = slider.noUiSlider.get();
                                     let min = parseFloat(values[0]);
                                     let max = parseFloat(values[1]);
                                     // Remove previous stock filter
                                     $.fn.dataTable.ext.search = $.fn.dataTable.ext.search.filter(function (f) {
                                         return f.name !== 'stockRange';
                                     });
                                     $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
                                         let stock = parseFloat(data[5].replace(/[^0-9.\-]+/g, ''));
                                         if (isNaN(stock))
                                             return false;
                                         return stock >= min && stock <= max;
                                     });
                                     table.draw();
                                 } else {
                                     // Default: dropdown filter
                                     const selectedVal = $('#popupColumnFilter').val();
                                     if (!selectedVal) {
                                         table.column(currentFilterCol).search('').draw();
                                     } else {
                                         const regex = '^' + selectedVal.replace(/[.*+?^$\\{}()|[\]\\]/g, '\\$&') + '$';
                                         table.column(currentFilterCol).search(regex, true, false).draw();
                                     }
                                 }
                             });
                             // Edit action
                             $('#myTable').on('click', '.edit-action', function () {
                                 var productId = $(this).data('product-id');
                                 window.location.href = "${pageContext.request.contextPath}/producteditservlet?action=edit&id=" + productId;
                             });
                             // Delete action
                             $('#myTable').on('click', '.delete-action', function () {
                                 var productId = $(this).data('product-id');
                                 if (confirm('Are you sure you want to deactivate this product? This will change its status to Inactive.')) {
                                     window.location.href = "${pageContext.request.contextPath}/producteditservlet?action=delete&id=" + productId;
                                 }
                             });
                             function sortTable(col, direction) {
                                 const $rows = $('#myTable tbody tr:visible').get();
                                 $rows.sort(function (a, b) {
                                     const aVal = $(a).find('td:eq(' + col + ')').text().trim();
                                     const bVal = $(b).find('td:eq(' + col + ')').text().trim();
                                     if (!isNaN(aVal) && !isNaN(bVal)) {
                                         return direction === 'asc' ? aVal - bVal : bVal - aVal;
                                     }
                                     return direction === 'asc' ? aVal.localeCompare(bVal) : bVal.localeCompare(aVal);
                                 });
                                 $.each($rows, function (index, row) {
                                     $('#myTable tbody').append(row);
                                 });
                             }
                         });
                         function openUploadModal() {
                             document.getElementById("uploadModal").style.display = "block";
                             document.getElementById("previewOverlay").style.display = "block";
                             document.body.classList.add('modal-open');
                         }

                         function closeUploadModal() {
                             document.getElementById("uploadModal").style.display = "none";
                             document.getElementById("previewOverlay").style.display = "none";
                             document.body.classList.remove('modal-open');
                         }


                         document.getElementById('excelFile').addEventListener('change', function (e) {
                             const file = e.target.files[0];
                             if (!file)
                                 return;

                             if (!file.name.endsWith('.xlsx') && !file.name.endsWith('.xls')) {
                                 alert("Please upload a valid Excel file.");
                                 return;
                             }

                             const reader = new FileReader();

                             reader.onload = function (e) {
                                 const data = new Uint8Array(e.target.result);
                                 const workbook = XLSX.read(data, {type: 'array'});

                                 // Sheet 1: Products
                                 const productSheetName = workbook.SheetNames[0];
                                 const productSheet = workbook.Sheets[productSheetName];
                                 const productJson = XLSX.utils.sheet_to_json(productSheet, {header: 1, defval: ""});

                                 // Preview logic for product sheet only
                                 previewSheet('previewTable', productJson, ['Name', 'Brand', 'Component Type', 'Model', 'Price', 'Import Price', 'Stock', 'SKU', 'Description']);

                                 document.getElementById('previewContainer').style.display = 'block';
                             };

                             reader.readAsArrayBuffer(file);
                         });

                         function previewSheet(tableId, json, hardcodedHeaders) {
                             const previewTable = document.getElementById(tableId);
                             const thead = previewTable.querySelector('thead');
                             const tbody = previewTable.querySelector('tbody');

                             thead.innerHTML = '';
                             tbody.innerHTML = '';

                             // Use hardcoded headers
                             const headerHtml = '<tr>' + hardcodedHeaders.map(function (header) {
                                 return '<th>' + header + '</th>';
                             }).join('') + '</tr>';
                             thead.innerHTML = headerHtml;

                             // Data rows - start from index 1 (skip first row)
                             for (let i = 1; i < json.length; i++) {
                                 const row = json[i];
                                 const rowHtml = '<tr>' + row.map(function (cell) {
                                     return '<td>' + (cell ?? '') + '</td>';
                                 }).join('') + '</tr>';
                                 tbody.innerHTML += rowHtml;
                             }
                         }
            </script>
        </div>
    </body>
</html>