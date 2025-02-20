<%--
  Created by IntelliJ IDEA.
  User: Nguyen Trung Thanh
  Date: 15/02/2025
  Time: 11:42 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<html>
<head>
    <title>Product</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="welcome.jsp">Home</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>
</nav>

<div class="container mt-4">
    <div class="card shadow-sm p-4">

        <!-- Add Product Form -->
        <h4 class="mt-4">Add Product</h4>
        <form action="product" method="post" class="mb-3">
            <input type="hidden" name="action" value="add">
                Name:
                <input type="text" name="name"  required>
                Quantity:
                <input type="number" name="quantity"  required>

            <button type="submit" class="btn btn-success"><i class="fa fa-plus"></i> Add New</button>
        </form>

        <!-- Update Product Form -->
        <%
            if (request.getParameter("id") != null) {
        %>
        <h4>Update Product</h4>
        <form action="product" method="post" class="mb-3">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
              Name:
                <input type="text" name="name" value="<%= request.getParameter("name") %>"  required>
             Quantity:
                <input type="number" name="quantity" value="<%= request.getParameter("quantity") %>"  required>

            <button type="submit" class="btn btn-primary"><i class="fa fa-edit"></i> Update</button>
        </form>
        <%
            }
        %>

        <!-- Product List Table -->
        <h4>Product List</h4>
        <table class="table table-hover table-bordered">
            <thead class="thead-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Quantity</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                try {
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products == null) {
                        response.sendRedirect("product");
                        return;
                    }
                    for (Product product : products) {
            %>
            <tr>
                <td><%= product.getId() %></td>
                <td><%= product.getName() %></td>
                <td><%= product.getQuantity() %></td>
                <td>
                    <form action="product" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= product.getId() %>">
                        <input type="hidden" name="name" value="<%= product.getName() %>">
                        <input type="hidden" name="quantity" value="<%= product.getQuantity() %>">
                        <button type="submit" class="btn btn-warning btn-sm">
                            <i class="fa fa-edit"></i> Edit
                        </button>
                    </form>
                    <form action="product" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= product.getId() %>">
                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this product?');">
                            <i class="fa fa-trash"></i> Delete
                        </button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
