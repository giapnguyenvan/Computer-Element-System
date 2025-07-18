<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .rating {
            color: #ffd700;
            font-size: 20px;
        }
        .feedback-card {
            margin-bottom: 20px;
            transition: transform 0.2s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border: none;
        }
        .feedback-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .feedback-meta {
            font-size: 0.9em;
            color: #666;
        }
        .star-rating {
            display: inline-block;
        }
        .star-rating span {
            color: #ffd700;
            font-size: 1.2em;
        }
        .filter-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .pagination {
            margin-top: 30px;
        }
        .action-buttons {
            margin-top: 10px;
            display: flex;
            gap: 10px;
        }
        .rating-input {
            display: inline-flex;
            flex-direction: row-reverse;
            gap: 5px;
        }
        .rating-input input {
            display: none;
        }
        .rating-input label {
            cursor: pointer;
            font-size: 25px;
            color: #ddd;
        }
        .rating-input label:hover,
        .rating-input label:hover ~ label,
        .rating-input input:checked ~ label {
            color: #ffd700;
        }
        .alert {
            margin-bottom: 20px;
            border-radius: 10px;
        }
        .feedback-content {
            font-size: 1em;
            line-height: 1.5;
            color: #333;
        }
        .feedback-meta-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .star-rating-table {
            display: inline-block;
            font-size: 22px;
            letter-spacing: 2px;
            vertical-align: middle;
            white-space: nowrap;
        }
        .star-rating-table .star-checked {
            color: #ffd700;
        }
        .star-rating-table .star-unchecked {
            color: #ddd;
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
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body text-center">
                        <h5>Total Feedback: ${totalFeedback}</h5>
                        <p class="mb-0">Page ${currentPage} of ${totalPages}</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <form action="managefeedback" method="GET" class="row g-3">
                <input type="hidden" name="page" value="${currentPage}">
                <div class="col-md-3">
                    <label class="form-label">Sort By:</label>
                    <select name="sortBy" class="form-select" onchange="this.form.submit()">
                        <option value="newest" ${param.sortBy == 'newest' ? 'selected' : ''}>Newest First</option>
                        <option value="oldest" ${param.sortBy == 'oldest' ? 'selected' : ''}>Oldest First</option>
                        <option value="rating" ${param.sortBy == 'rating' ? 'selected' : ''}>Highest Rating</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Filter by Rating:</label>
                    <select name="rating" class="form-select" onchange="this.form.submit()">
                        <option value="">All Ratings</option>
                        <option value="5" ${param.rating == '5' ? 'selected' : ''}>5 Stars</option>
                        <option value="4" ${param.rating == '4' ? 'selected' : ''}>4 Stars</option>
                        <option value="3" ${param.rating == '3' ? 'selected' : ''}>3 Stars</option>
                        <option value="2" ${param.rating == '2' ? 'selected' : ''}>2 Stars</option>
                        <option value="1" ${param.rating == '1' ? 'selected' : ''}>1 Star</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Search:</label>
                    <div class="input-group">
                        <input type="text" name="search" class="form-control" placeholder="Search in feedback..." 
                               value="${param.search}">
                        <button class="btn btn-outline-secondary" type="submit">Search</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Feedback Display -->
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Rating</th>
                        <th>Content</th>
                        <th>Product</th>
                        <th>User</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${feedbackList}" var="feedback">
                        <tr>
                            <td>
                                <span class="star-rating-table">
                                    <c:forEach begin="1" end="5" var="i">
                                        <span class="${i <= feedback.rating ? 'star-checked' : 'star-unchecked'}">&#9733;</span>
                                    </c:forEach>
                                </span>
                            </td>
                            <td>
                                <div class="feedback-content">
                                    ${fn:substring(feedback.content, 0, 100)}${fn:length(feedback.content) > 100 ? '...' : ''}
                                </div>
                            </td>
                            <td>${feedback.productName}</td>
                            <td>${feedback.customerName}</td>
                            <td>${feedback.created_at}</td>
                            <td>
                                <div class="action-buttons">
                                    <button type="button" class="btn btn-sm btn-info" 
                                            onclick="showFeedbackContent(this)" 
                                            data-rating="${feedback.rating}"
                                            data-content="${fn:escapeXml(feedback.content)}"
                                            data-created="${feedback.created_at}"
                                            data-product-name="${feedback.productName}"
                                            data-user-name="${feedback.customerName}">
                                        View
                                    </button>
                                    <button type="button" class="btn btn-sm btn-danger" 
                                            onclick="deleteFeedback('${feedback.feedback_id}', '${feedback.customerEmail}')"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#deleteFeedbackModal">
                                        Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty feedbackList}">
                        <tr>
                            <td colspan="6" class="text-center">
                                <div class="alert alert-info" role="alert">
                                    No feedback found.
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Feedback pagination" class="d-flex justify-content-center">
                <ul class="pagination flex-wrap">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="managefeedback?page=${currentPage - 1}&sortBy=${param.sortBy}&rating=${param.rating}&search=${param.search}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="managefeedback?page=${i}&sortBy=${param.sortBy}&rating=${param.rating}&search=${param.search}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>
                    
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="managefeedback?page=${currentPage + 1}&sortBy=${param.sortBy}&rating=${param.rating}&search=${param.search}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>

    <!-- Add Feedback Modal -->
    <div class="modal fade" id="addFeedbackModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Feedback</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="managefeedback" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="mb-3">
                            <label class="form-label">Product ID:</label>
                            <input type="number" class="form-control" name="product_id" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">User ID:</label>
                            <input type="number" class="form-control" name="customer_id" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Rating:</label>
                            <div class="rating-input">
                                <input type="radio" id="star5" name="rating" value="5" required>
                                <label for="star5">★</label>
                                <input type="radio" id="star4" name="rating" value="4">
                                <label for="star4">★</label>
                                <input type="radio" id="star3" name="rating" value="3">
                                <label for="star3">★</label>
                                <input type="radio" id="star2" name="rating" value="2">
                                <label for="star2">★</label>
                                <input type="radio" id="star1" name="rating" value="1">
                                <label for="star1">★</label>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Content:</label>
                            <textarea class="form-control" name="content" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Feedback</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Feedback Modal -->
    <div class="modal fade" id="deleteFeedbackModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Feedback</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="managefeedback" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="feedback_id" id="delete_feedback_id">
                        <input type="hidden" name="customer_email" id="delete_customer_email">
                        <p>Are you sure you want to delete this feedback? This action cannot be undone.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Feedback Content Modal -->
    <div class="modal fade" id="feedbackContentModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Feedback Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="feedback-meta mb-3">
                        <div class="star-rating mb-2" id="modalFeedbackRating"></div>
                        <small>
                            Created: <span id="modalFeedbackCreated"></span><br>
                            Product: <span id="modalFeedbackProductName"></span><br>
                            User: <span id="modalFeedbackUserName"></span>
                        </small>
                    </div>
                    <div id="modalFeedbackContent" style="white-space: pre-wrap;"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showFeedbackContent(element) {
            const rating = element.getAttribute('data-rating');
            const content = element.getAttribute('data-content');
            const created = element.getAttribute('data-created');
            const productName = element.getAttribute('data-product-name');
            const userName = element.getAttribute('data-user-name');
            
            // Create star rating HTML
            let starsHtml = '';
            for (let i = 1; i <= 5; i++) {
                starsHtml += `<span style="color: #ffd700; font-size: 24px;">${i <= rating ? '★' : '☆'}</span>`;
            }
            
            document.getElementById('modalFeedbackRating').innerHTML = starsHtml;
            document.getElementById('modalFeedbackContent').textContent = content;
            document.getElementById('modalFeedbackCreated').textContent = created;
            document.getElementById('modalFeedbackProductName').textContent = productName;
            document.getElementById('modalFeedbackUserName').textContent = userName;
            
            new bootstrap.Modal(document.getElementById('feedbackContentModal')).show();
        }
        
        function deleteFeedback(id, customerEmail) {
            document.getElementById('delete_feedback_id').value = id;
            document.getElementById('delete_customer_email').value = customerEmail;
        }
    </script>
</body>
</html> 