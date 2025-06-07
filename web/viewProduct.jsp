<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, model.Products" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String sortBy = request.getParameter("sortBy");
    String order = request.getParameter("order");
    String baseUrl = request.getContextPath() + "/productservlet?service=viewProduct";
%>

<%! 
    public String getNextOrder(String col, String sortBy, String order) {
        if (sortBy == null || !sortBy.equals(col)) return "asc";
        if ("asc".equalsIgnoreCase(order)) return "desc";
        if ("desc".equalsIgnoreCase(order)) return "none";
        return "asc";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product List</title>
        <style>
            .sort-link {
                text-decoration: none;
                color: blue;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <h2>Product List</h2>
        <a href="${pageContext.request.contextPath}/productservlet?service=insertProduct" class="insert-btn">Insert Product</a>

        <form action="${pageContext.request.contextPath}/productservlet?service=searchProduct" method="get" style="margin-bottom:20px;">
            <input type="hidden" name="service" value="searchProduct" />
            <input type="text" name="keyword" placeholder="Search by name, brand, description..." value="${keyword != null ? keyword : ''}" />

            <button type="submit">Search & Sort</button>
        </form>
        <!-- Filter Dropdown -->
        <form action="productservlet" method="get">
            <input type="hidden" name="service" value="filterByBrand"/>
            <select name="brand" required>
                <option value="">-- Select Brand --</option>
                <c:forEach var="b" items="${brand}">
                    <option value="${b}">${b}</option>
                </c:forEach>
            </select>
            <button type="submit">Filter Brand</button>
        </form>
        <form action="productservlet" method="get">
            <input type="hidden" name="service" value="filterByCategory"/>
            <select name="category_id" required>
                <option value="">-- Select Category --</option>
                <c:forEach var="c" items="${category}">
                    <option value="${c.id}">${c.name}</option>
                </c:forEach>
            </select>
            <button type="submit">Filter Category</button>
        </form>
        <table border="1" cellpadding="5" cellspacing="0">
            <thead>
                <tr>
                    <th>
                        <a class="sort-link" href="<%= 
                            "none".equals(getNextOrder("id", sortBy, order)) 
                            ? baseUrl 
                            : baseUrl + "&sortBy=id&order=" + getNextOrder("id", sortBy, order)
                           %>">Product ID</a>
                    </th>
                    <th>Name</th>
                    <th>Brand</th>
                    <th>
                        <a class="sort-link" href="<%= 
                            "none".equals(getNextOrder("category_id", sortBy, order)) 
                            ? baseUrl 
                            : baseUrl + "&sortBy=category_id&order=" + getNextOrder("category_id", sortBy, order)
                           %>">Category ID</a>
                    </th>
                    <th>
                        <a class="sort-link" href="<%= 
                            "none".equals(getNextOrder("price", sortBy, order)) 
                            ? baseUrl 
                            : baseUrl + "&sortBy=price&order=" + getNextOrder("price", sortBy, order)
                           %>">Price</a>
                    </th>
                    <th>
                        <a class="sort-link" href="<%= 
                        "none".equals(getNextOrder("stock", sortBy, order)) 
                        ? baseUrl 
                        : baseUrl + "&sortBy=stock&order=" + getNextOrder("stock", sortBy, order)
                           %>">Stock</a>
                    </th>
                    <th>Image</th>
                    <th>Description</th>
                    <th>Spec_description</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${product}" var="product">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>${product.brand}</td>
                        <td>${product.categoryName}</td>
                        <td>${product.price}</td>
                        <td>${product.stock}</td>
                        <td><img src="${product.image_url}" alt="${product.name}" width="100" /></td>
                        <td>${product.description}</td>
                        <td>${product.spec_description}</td>
                        <td>${product.status}</td>

                        <td>
                            <a href="productservlet?service=updateProduct&id=${product.id}" style="padding: 5px 10px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 3px;">
                                Edit
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
