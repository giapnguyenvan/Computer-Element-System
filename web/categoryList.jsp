<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Category> list = (List<Category>) request.getAttribute("categories");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/universal-table.css">
</head>
<body>
<div class="container-fluid mt-3" style="padding-left:0; margin-left:0; width:100%; max-width:100%;">
    <div class="univ-table-wrapper">
        <div class="univ-table-toolbar">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                <i class="fas fa-plus me-2"></i> Add Category
            </button>
            <div id="custom-dt-search"></div>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle univ-table-custom mb-0" id="categoryTable">
                <thead class="table-light">
                <tr>
                    <th><div class="univ-colheader"><span>ID</span></div></th>
                    <th><div class="univ-colheader"><span>Name</span><span><button class="no-sort univ-btn-filter btn-sm w-100" data-col="1" title="Filter"><i class="fas fa-filter"></i></button></span></div></th>
                    <th><div class="univ-colheader"><span>Description</span><span><button class="no-sort univ-btn-filter btn-sm w-100" data-col="2" title="Filter"><i class="fas fa-filter"></i></button></span></div></th>
                    <th><div class="univ-colheader"><span>Actions</span></div></th>
                </tr>
                </thead>
                <tbody>
                <% if (list != null && !list.isEmpty()) {
                    for (Category c : list) { %>
                    <tr>
                        <td><strong><%= c.getId() %></strong></td>
                        <td><%= c.getName() %></td>
                        <td><%= c.getDescription() %></td>
                        <td>
                            <button class="btn  p-0 edit-action" title="Edit" data-category-id="<%= c.getId() %>" data-category-name="<%= c.getName().replace("'", "\\'") %>" data-category-description="<%= c.getDescription().replace("'", "\\'") %>" data-bs-toggle="modal" data-bs-target="#editCategoryModal">
                                <i class="fas fa-edit"></i>
                            </button>
                            <a href="<%= ctx %>/category?action=delete&id=<%= c.getId() %>" class="btn  p-0 delete-action text-danger" onclick="return confirm('Are you sure you want to delete this category?');" title="Delete">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </td>
                    </tr>
                <%  }
                } else { %>
                <tr><td colspan="4" class="text-center py-5">No categories found.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <div id="columnFilterPopup" style="display:none; position:absolute; background:#fff; border:1px solid #ccc; box-shadow:0 2px 8px rgba(0,0,0,0.2); padding:10px; max-height:250px; overflow-y:auto; z-index:1000;">
            <div style="text-align:right;">
                <button id="closeFilterBtn" type="button" class="btn btn-secondary">✕</button>
            </div>
            <div id="filterOptionsContainer"></div>
            <div class="mt-2" style="display: flex; gap: 10px;">
                <button id="applyFilterBtn" type="button" class="btn btn-primary">Apply Filter</button>
                <button id="clearFilterBtn" type="button" class="btn btn-secondary">Clear Filter</button>
            </div>
        </div>
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
                <form action="<%= ctx %>/category" method="post">
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
                <form action="<%= ctx %>/category" method="post">
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

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function () {
        const table = $('#categoryTable').DataTable({
            pagingType: "full_numbers",
            lengthMenu: [[5, 10, 15], [5, 10, 15]],
            pageLength: 10,
            ordering: true,
            dom: 'ftip',
            columnDefs: [
                {orderable: false, targets: [3]}
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
        $('#custom-dt-search').append($('#categoryTable_filter'));
        // Edit action: fill modal
        $('#categoryTable').on('click', '.edit-action', function () {
            var id = $(this).data('category-id');
            var name = $(this).data('category-name');
            var description = $(this).data('category-description');
            $('#editId').val(id);
            $('#editName').val(name);
            $('#editDescription').val(description);
        });
    });
</script>
</body>
</html>
