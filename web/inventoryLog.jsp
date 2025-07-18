<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Vector" %>
<%@ page import="model.InventoryLog" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inventory Log</title>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/universal-table.css">
    </head>
    <body>
        <div class="inventory-log-container">
            <div class="container-fluid mt-3" style="padding-left:0; margin-left:0; width:100%; max-width:100%;">
                <div class="univ-table-wrapper">
                    <div class="univ-table-toolbar">
                        <div id="custom-dt-search"></div>
                        <!-- Toolbar can be extended here if needed -->
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle univ-table-custom mb-0" id="inventoryLogTable">
                            <thead>
                                <tr>
                                    <th><div class="univ-colheader"><span>ID</span></div></th>
                                    <th><div class="univ-colheader"><span>Product</span></div></th>
                                    <th><div class="univ-colheader"><span>Brand</span><span><button class="no-sort univ-btn-filter btn-sm w-100" data-col="2" title="Filter"><i class="fas fa-filter"></i></button></span></div></th>
                                    <th><div class="univ-colheader"><span>Type</span><span><button class="no-sort univ-btn-filter btn-sm w-100" data-col="3" title="Filter"><i class="fas fa-filter"></i></button></span></div></th>
                                    <th><div class="univ-colheader"><span>Action</span><span><button class="no-sort univ-btn-filter btn-sm w-100" data-col="4" title="Filter"><i class="fas fa-filter"></i></button></span></div></th>
                                    <th><div class="univ-colheader"><span>Quantity</span></div></th>
                                    <th><div class="univ-colheader"><span>Note</span></div></th>
                                    <th><div class="univ-colheader"><span>Date & Time</span></div></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="log" items="${inventoryLogs}">
                                    <tr>
                                        <td>${log.log_id}</td>
                                        <td>
                                            <div>
                                                <strong>${log.productName != null ? log.productName : 'Product #' + log.product_id}</strong>
                                                <br>
                                                <small class="text-muted">ID: ${log.product_id}</small>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty log.brandName}">${log.brandName}</c:when>
                                                <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty log.componentTypeName}">${log.componentTypeName}</c:when>
                                                <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="univ-action-badge
                                                  <c:choose>
                                                      <c:when test="${log.action == 'Add'}">univ-action-in</c:when>
                                                      <c:when test="${log.action == 'Remove'}">univ-action-out</c:when>
                                                      <c:otherwise>univ-action-adjust</c:otherwise>
                                                  </c:choose>">
                                                ${log.action}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="<c:choose>
                                                      <c:when test="${log.quantity > 0}">univ-quantity-positive</c:when>
                                                      <c:otherwise>univ-quantity-negative</c:otherwise>
                                                  </c:choose>">
                                                <c:choose>
                                                    <c:when test="${log.quantity > 0}">+${log.quantity}</c:when>
                                                    <c:otherwise>${log.quantity}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty log.note}">${log.note}</c:when>
                                                <c:otherwise><span class="text-muted">No note</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${log.created_at}" pattern="MMM dd, yyyy HH:mm:ss"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="columnFilterPopup" style="display:none; position:absolute; background:#fff; border:1px solid #ccc; box-shadow:0 2px 8px rgba(0,0,0,0.2); padding:10px; max-height:250px; overflow-y:auto; z-index:1000;">
                    <div style="text-align:right;">
                        <button id="closeFilterBtn" type="button" class="btn btn-sm btn-close"></button>
                    </div>
                    <div id="filterOptionsContainer"></div>
                    <div class="mt-2" style="display: flex; gap: 10px;">
                        <button id="applyFilterBtn" type="button" class="btn btn-sm btn-primary">Apply Filter</button>
                        <button id="clearFilterBtn" type="button" class="btn btn-sm btn-secondary">Clear Filter</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                const table = $('#inventoryLogTable').DataTable({
                    pagingType: "full_numbers",
                    lengthMenu: [[5, 10, 15], [5, 10, 15]],
                    pageLength: 10,
                    ordering: true,
                    dom: 'ftip',
                    columnDefs: [
                        {orderable: false, targets: [1, 2, 3, 4, 5, 6]}
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
                let currentFilterCol = null;
                $('.univ-btn-filter').on('click', function (e) {
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
                });
                $('#closeFilterBtn').on('click', function () {
                    $('#columnFilterPopup').hide();
                });
                $('#clearFilterBtn').on('click', function () {
                    const $popup = $('#columnFilterPopup');
                    $popup.hide();
                    table.columns().search('').draw();
                    $('#popupColumnFilter').val('');
                });
                $('#applyFilterBtn').off('click').on('click', function () {
                    const $popup = $('#columnFilterPopup');
                    $popup.hide();
                    const selectedVal = $('#popupColumnFilter').val();
                    if (!selectedVal) {
                        table.column(currentFilterCol).search('').draw();
                    } else {
                        const regex = '^' + selectedVal.replace(/[.*+?^$\\{}()|[\\]\\]/g, '\\$&') + '$';
                        table.column(currentFilterCol).search(regex, true, false).draw();
                    }
                });
                $('#custom-dt-search').append($('#inventoryLogTable_filter'));
            });
        </script>
    </body>
</html> 