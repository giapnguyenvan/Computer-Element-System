<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Shippers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .shipper-card {
            margin-bottom: 20px;
            transition: transform 0.2s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border: none;
        }
        .shipper-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .filter-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .status-badge {
            font-size: 0.8em;
            padding: 4px 8px;
        }
        .status-active {
            background-color: #d4edda;
            color: #155724;
        }
        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }
        .status-busy {
            background-color: #fff3cd;
            color: #856404;
        }
        .rating {
            color: #ffd700;
            font-size: 16px;
        }
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .stats-number {
            font-size: 2em;
            font-weight: bold;
        }
        .stats-label {
            font-size: 0.9em;
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        
        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <!-- Stats Section -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <div class="stats-number">${totalShippers}</div>
                    <div class="stats-label">Total Shippers</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <div class="stats-number">
                        <c:set var="activeCount" value="0"/>
                        <c:forEach items="${shipperList}" var="shipper">
                            <c:if test="${shipper.status == 'Active'}">
                                <c:set var="activeCount" value="${activeCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${activeCount}
                    </div>
                    <div class="stats-label">Active Shippers</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <div class="stats-number">Page ${currentPage}</div>
                    <div class="stats-label">of ${totalPages}</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addShipperModal">
                        <i class="fas fa-plus"></i> Add New Shipper
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <form action="manageshipper" method="GET" class="row g-3">
                <input type="hidden" name="page" value="${currentPage}">
                <div class="col-md-2">
                    <label class="form-label">Sort By:</label>
                    <select name="sortBy" class="form-select" onchange="this.form.submit()">
                        <option value="name" ${param.sortBy == 'name' ? 'selected' : ''}>Name</option>
                        <option value="rating" ${param.sortBy == 'rating' ? 'selected' : ''}>Rating</option>
                        <option value="deliveries" ${param.sortBy == 'deliveries' ? 'selected' : ''}>Deliveries</option>
                        <option value="joinDate" ${param.sortBy == 'joinDate' ? 'selected' : ''}>Join Date</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label">Status:</label>
                    <select name="status" class="form-select" onchange="this.form.submit()">
                        <option value="">All Status</option>
                        <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Active</option>
                        <option value="Inactive" ${param.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                        <option value="Busy" ${param.status == 'Busy' ? 'selected' : ''}>Busy</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label">Vehicle Type:</label>
                    <select name="vehicleType" class="form-select" onchange="this.form.submit()">
                        <option value="">All Types</option>
                        <option value="Motorcycle" ${param.vehicleType == 'Motorcycle' ? 'selected' : ''}>Motorcycle</option>
                        <option value="Car" ${param.vehicleType == 'Car' ? 'selected' : ''}>Car</option>
                        <option value="Truck" ${param.vehicleType == 'Truck' ? 'selected' : ''}>Truck</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Search:</label>
                    <div class="input-group">
                        <input type="text" name="search" class="form-control" placeholder="Search by name, phone, or email..." 
                               value="${param.search}">
                        <button class="btn btn-outline-secondary" type="submit">Search</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Shippers Display -->
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Contact</th>
                        <th>Vehicle</th>
                        <th>Status</th>
                        <th>Rating</th>
                        <th>Deliveries</th>
                        <th>Location</th>
                        <th>Join Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${shipperList}" var="shipper">
                        <tr>
                            <td><strong>${shipper.name}</strong></td>
                            <td>
                                <i class="fas fa-phone"></i> ${shipper.phone}<br>
                                <c:if test="${not empty shipper.email}">
                                    <i class="fas fa-envelope"></i> ${shipper.email}
                                </c:if>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${shipper.vehicle_type == 'Motorcycle'}">
                                        <i class="fas fa-motorcycle"></i>
                                    </c:when>
                                    <c:when test="${shipper.vehicle_type == 'Car'}">
                                        <i class="fas fa-car"></i>
                                    </c:when>
                                    <c:when test="${shipper.vehicle_type == 'Truck'}">
                                        <i class="fas fa-truck"></i>
                                    </c:when>
                                </c:choose>
                                ${shipper.vehicle_type}
                                <c:if test="${not empty shipper.vehicle_number}">
                                    <br><small>${shipper.vehicle_number}</small>
                                </c:if>
                            </td>
                            <td>
                                <span class="badge status-badge 
                                    <c:choose>
                                        <c:when test="${shipper.status == 'Active'}">status-active</c:when>
                                        <c:when test="${shipper.status == 'Inactive'}">status-inactive</c:when>
                                        <c:when test="${shipper.status == 'Busy'}">status-busy</c:when>
                                    </c:choose>">
                                    ${shipper.status}
                                </span>
                            </td>
                            <td>
                                <div class="rating">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="fas fa-star${i <= shipper.rating ? '' : '-o'}"></i>
                                    </c:forEach>
                                    <br><small>${shipper.rating}/5.0</small>
                                </div>
                            </td>
                            <td><span class="badge bg-info">${shipper.total_deliveries}</span></td>
                            <td>
                                <c:if test="${not empty shipper.current_location}">
                                    <i class="fas fa-map-marker-alt"></i> ${shipper.current_location}
                                </c:if>
                            </td>
                            <td><fmt:formatDate value="${shipper.join_date}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-sm btn-info" 
                                            onclick="viewShipperDetails('${shipper.shipper_id}', '${shipper.name}')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button type="button" class="btn btn-sm btn-warning" 
                                            onclick="editShipper('${shipper.shipper_id}', '${shipper.name}', '${shipper.phone}', '${shipper.email}', '${shipper.vehicle_number}', '${shipper.vehicle_type}', '${shipper.status}', '${shipper.current_location}')"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#editShipperModal">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button type="button" class="btn btn-sm btn-danger" 
                                            onclick="deleteShipper('${shipper.shipper_id}', '${shipper.name}')"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#deleteShipperModal">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty shipperList}">
                        <tr>
                            <td colspan="9" class="text-center">
                                <div class="alert alert-info" role="alert">
                                    No shippers found.
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Shipper pagination" class="d-flex justify-content-center">
                <ul class="pagination flex-wrap">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="manageshipper?page=${currentPage - 1}&sortBy=${param.sortBy}&status=${param.status}&vehicleType=${param.vehicleType}&search=${param.search}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="manageshipper?page=${i}&sortBy=${param.sortBy}&status=${param.status}&vehicleType=${param.vehicleType}&search=${param.search}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>
                    
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="manageshipper?page=${currentPage + 1}&sortBy=${param.sortBy}&status=${param.status}&vehicleType=${param.vehicleType}&search=${param.search}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>

    <!-- Add Shipper Modal -->
    <div class="modal fade" id="addShipperModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Shipper</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="manageshipper" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Name: *</label>
                                    <input type="text" class="form-control" name="name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Phone: *</label>
                                    <input type="text" class="form-control" name="phone" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Email:</label>
                                    <input type="email" class="form-control" name="email">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Vehicle Number:</label>
                                    <input type="text" class="form-control" name="vehicle_number">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Vehicle Type:</label>
                                    <select class="form-select" name="vehicle_type">
                                        <option value="Motorcycle">Motorcycle</option>
                                        <option value="Car">Car</option>
                                        <option value="Truck">Truck</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Status:</label>
                                    <select class="form-select" name="status">
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                        <option value="Busy">Busy</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Current Location:</label>
                            <input type="text" class="form-control" name="current_location" placeholder="e.g., Quận 1, TP.HCM">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Shipper</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Shipper Modal -->
    <div class="modal fade" id="editShipperModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Shipper</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="manageshipper" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="shipper_id" id="edit_shipper_id">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Name: *</label>
                                    <input type="text" class="form-control" name="name" id="edit_name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Phone: *</label>
                                    <input type="text" class="form-control" name="phone" id="edit_phone" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Email:</label>
                                    <input type="email" class="form-control" name="email" id="edit_email">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Vehicle Number:</label>
                                    <input type="text" class="form-control" name="vehicle_number" id="edit_vehicle_number">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Vehicle Type:</label>
                                    <select class="form-select" name="vehicle_type" id="edit_vehicle_type">
                                        <option value="Motorcycle">Motorcycle</option>
                                        <option value="Car">Car</option>
                                        <option value="Truck">Truck</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Status:</label>
                                    <select class="form-select" name="status" id="edit_status">
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                        <option value="Busy">Busy</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Current Location:</label>
                            <input type="text" class="form-control" name="current_location" id="edit_current_location">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-warning">Update Shipper</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Shipper Modal -->
    <div class="modal fade" id="deleteShipperModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Shipper</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="manageshipper" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="shipper_id" id="delete_shipper_id">
                        <p>Are you sure you want to delete shipper <strong id="delete_shipper_name"></strong>? This action cannot be undone.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editShipper(id, name, phone, email, vehicleNumber, vehicleType, status, currentLocation) {
            document.getElementById('edit_shipper_id').value = id;
            document.getElementById('edit_name').value = name;
            document.getElementById('edit_phone').value = phone;
            document.getElementById('edit_email').value = email || '';
            document.getElementById('edit_vehicle_number').value = vehicleNumber || '';
            document.getElementById('edit_vehicle_type').value = vehicleType;
            document.getElementById('edit_status').value = status;
            document.getElementById('edit_current_location').value = currentLocation || '';
        }
        
        function deleteShipper(id, name) {
            document.getElementById('delete_shipper_id').value = id;
            document.getElementById('delete_shipper_name').textContent = name;
        }
        
        function viewShipperDetails(id, name) {
            alert('Viewing details for shipper: ' + name);
        }
    </script>
</body>
</html> 