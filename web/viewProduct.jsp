<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Table</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            font-family: Arial, sans-serif;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            cursor: default;
        }
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .selected {
            background-color: #d1e7dd !important;
        }
        .colheader {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/nouislider@15.7.1/dist/nouislider.min.css">
</head>
<body>
<div class="container mt-3">
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/ProductEditServlet?action=new" class="btn btn-primary">New</a>
        <button type="button" class="btn btn-primary" id="editBtn">Edit</button>
        <button type="button" class="btn btn-danger" id="deleteBtn">Delete</button>
    </div>
    <table class="table table-striped table-hover align-middle text-center" id="myTable">
        <thead>
            <tr>
                <th><div class="colheader"><span class="sortable" data-col="0">Product ID</span><span><button class="no-sort btn btn-sm btn-light" data-col="0">F</button></span></div></th>
                <th><div class="colheader"><span class="sortable" data-col="1">Name</span><span><button class="no-sort btn btn-sm btn-light" data-col="1">F</button></span></div></th>
                <th><div class="colheader"><span class="sortable" data-col="2">Brand</span><span><button class="no-sort btn btn-sm btn-light" data-col="2">F</button></span></div></th>
                <th><div class="colheader"><span class="sortable" data-col="3">Category</span><span><button class="no-sort btn btn-sm btn-light" data-col="3">F</button></span></div></th>
                <th><div class="colheader"><span class="sortable" data-col="4">Price</span><span><button class="no-sort btn btn-sm btn-light" data-col="4">F</button></span></div></th>
                <th><div class="colheader"><span class="sortable" data-col="5">Stock</span><span><button class="no-sort btn btn-sm btn-light" data-col="5">F</button></span></div></th>
                <th><div class="colheader"><span class="sortable" data-col="6">Image</span><span><button class="no-sort btn btn-sm btn-light" data-col="6">F</button></span></div></th>
                <th><div class="colheader"><span class="sortable" data-col="7">Description</span><span><button class="no-sort btn btn-sm btn-light" data-col="7">F</button></span></div></th>
                <th><div class="colheader"><span class="sortable" data-col="8">Status</span><span><button class="no-sort btn btn-sm btn-light" data-col="8">F</button></span></div></th>
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
                                <img src="${product.imageUrl}" width="100" alt="Product Image">
                            </c:when>
                            <c:otherwise>No Image</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${product.description}</td>
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
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div id="columnFilterPopup" style="display:none; position:absolute; background:#fff; border:1px solid #ccc; box-shadow:0 2px 8px rgba(0,0,0,0.2); padding:10px; max-height:250px; overflow-y:auto; z-index:1000;">
        <div style="text-align:right;">
            <button id="closeFilterBtn" type="button" class="btn btn-sm btn-close"></button>
        </div>
        <div id="filterOptionsContainer"></div>
        <button id="applyFilterBtn" type="button" class="btn btn-sm btn-primary mt-2">Apply Filter</button>
    </div>
</div>

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
            columnDefs: [
                { orderable: false, targets: [] }
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
                table.column(currentFilterCol, { search: 'applied' }).data().each(function (value) {
                    let num = parseFloat(String(value).replace(/[^0-9.\-]+/g, ''));
                    if (!isNaN(num)) prices.push(num);
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
                        to: function (value) { return Math.round(value); },
                        from: function (value) { return Number(value); }
                    }
                });

                slider.noUiSlider.on('update', function (values) {
                    $('#minPriceVal').text(values[0]);
                    $('#maxPriceVal').text(values[1]);
                });

                // Save slider for use in filter
                $('#applyFilterBtn').data('slider', slider);
            } else {
                // Default: dropdown filter for other columns
                let selectHtml = '<select id="popupColumnFilter" style="width:100%; margin-top:5px;"><option value="">-- Select to filter --</option>';
                let uniqueValues = [];
                table.column(currentFilterCol, { search: 'applied' }).data().each(function (value) {
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
                    if (isNaN(price)) return false;
                    return price >= min && price <= max;
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

        // Row selection
        $('#myTable tbody').on('click', 'tr', function () {
            if ($(this).hasClass('selected')) {
                $(this).removeClass('selected');
            } else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
        });

        // Edit button
        $('#editBtn').on('click', function () {
            var selectedRow = table.row('.selected');
            if (selectedRow.length) {
                var productId = selectedRow.data()[0];
                window.location.href = "${pageContext.request.contextPath}/ProductEditServlet?action=edit&id=" + productId;
            } else {
                alert('Please select a product to edit.');
            }
        });

        // Delete button
        $('#deleteBtn').on('click', function () {
            var selectedRow = table.row('.selected');
            if (selectedRow.length) {
                if (confirm('Are you sure you want to delete this product?')) {
                    var productId = selectedRow.data()[0];
                    window.location.href = "${pageContext.request.contextPath}/ProductEditServlet?action=delete&id=" + productId;
                }
            } else {
                alert('Please select a product to delete.');
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
</script>
</body>
</html>
