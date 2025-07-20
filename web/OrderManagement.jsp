<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f0f2f5;
            }
            .management-header {
                background-color: white;
                padding: 1.5rem;
                border-radius: .5rem;
                box-shadow: 0 2px 4px rgba(0,0,0,.1);
                margin-bottom: 2rem;
            }
            .table-wrapper {
                background-color: white;
                padding: 1.5rem;
                border-radius: .5rem;
                box-shadow: 0 2px 4px rgba(0,0,0,.1);
            }
            .btn-action {
                background: none;
                border: none;
                padding: 0;
                margin: 0 8px;
                color: #6c757d;
                font-size: 1.1rem;
            }
            .btn-action:hover {
                color: #0d6efd;
            }
            .text-danger:hover {
                color: #dc3545 !important;
            }
            .page-info {
                display: inline-block;
                padding: 0.375rem 0.75rem;
                background-color: #0d6efd;
                color: white;
                border-radius: 0.25rem;
                margin: 0 5px;
                font-weight: 500;
            }
            .table thead th {
                font-weight: 600;
                color: #343a40;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container my-5">
            <!-- Management Header -->
            <div class="management-header">
                <h4 class="mb-4">Order Management</h4>
                <div class="row g-3 align-items-center">
                    <div class="col-md-6">
                        <form action="order-list-manage" method="get">
                            <div class="input-group">
                                <select
                                    class="form-control" id="status" name="status">
                                    <option value="all" ${status == "all"?"selected":""}>All</option>
                                    <option value="Pending" ${status == "Pending"?"selected":""}>Pending</option>
                                    <option value="Shipping" ${status == "Shipping"?"selected":""}>Shipping</option>
                                    <option value="Completed" ${status == "Completed"?"selected":""}>Completed</option>
                                    <option value="Cancel" ${status == "Cancel"?"selected":""}>Cancel</option>
                                </select>
                                <input value="${fromDate}" 
                                       style="margin-right: 20px; margin-left: 20px" type="date" class="form-control" name="fromDate">
                                <input value="${toDate}"
                                       style="margin-right: 20px;" type="date" class="form-control" name="toDate">
                                <input type="submit" class="btn btn-primary"/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Category List Table -->
            <div class="table-wrapper">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Orders</h4>
                    <!--<span class="text-muted">Total Order </span>-->
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Customer name</th>
                                <th>Shipping fee</th>
                                <th>Total</th>
                                <th>Payment method</th>
                                <th>Address</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${orders.size() == 0}">
                                <tr><td colspan="7" class="text-center py-5">No categories found.</td></tr>
                            </c:if>
                            <c:forEach items="${orders}" var="order" varStatus="eStatus">
                                <tr>
                                    <td>${order.id}</td>
                                    <td>${order.customer.name}</td>
                                    <td>${order.shippingFee}</td>
                                    <td>${order.totalAmount}</td>
                                    <td>${order.paymentMethod.name}</td>
                                    <td>${order.shippingAddress}</td>
                                    <td>
                                        <input type="text" id='old_order_status_${order.id}' value="${order.status}" hidden="">
                                        <select id='status_order_${order.id}' onchange="changeStatus(${order.id})">
                                            <option id='status_order_${order.id}_Pending' value="Pending" ${order.status == "Pending"?"selected":""}>Pending</option>
                                            <option id='status_order_${order.id}_Shipping' value="Shipping" ${order.status == "Shipping"?"selected":""}>Shipping</option>
                                            <option id='status_order_${order.id}_Completed' value="Completed" ${order.status == "Completed"?"selected":""}>Completed</option>
                                            <option id='status_order_${order.id}_Cancel' value="Cancel" ${order.status == "Cancel"?"selected":""}>Cancel</option>
                                        </select>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
            </div>
        </div>

        <!-- Add Category Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New Category</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/category" method="post">
                            <input type="hidden" name="action" value="add" />
                            <div class="mb-3">
                                <label for="name" class="form-label">Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>
                            <div class="text-end">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Add</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Category Modal -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Category</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="category" method="post">
                            <input type="hidden" name="action" value="update" />
                            <input type="hidden" name="id" id="editId">
                            <div class="mb-3">
                                <label for="editName" class="form-label">Name</label>
                                <input type="text" class="form-control" id="editName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="editDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
                            </div>
                            <div class="text-end">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <form id="update_status_form" action="order-list-manage" method="post" hidden="">
            <input type="text" name="order_id" id="order_id">
            <input type="text" name="order_status" id="order_status">
        </form>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <script>
                                            function changeStatus(order_id) {
                                                let isOk = window.confirm("Do you want to update!");
                                                if (!isOk) {
                                                    let old_status = document.getElementById("old_order_status_"+order_id).value;
                                                    let eleOption = document.getElementById("status_order_"+order_id+"_"+old_status);
                                                    eleOption.selected = true;
                                                    return;
                                                }
                                                const status_selected = document.getElementById("status_order_" + order_id).value;
                                                document.getElementById("order_id").value = order_id + '';
                                                document.getElementById("order_status").value = status_selected;
                                                document.getElementById("update_status_form").submit();
                                            }
        </script>
    </body>
</html>
