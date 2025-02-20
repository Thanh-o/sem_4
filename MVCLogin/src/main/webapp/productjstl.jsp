<%--
  Created by IntelliJ IDEA.
  User: Nguyen Trung Thanh
  Date: 20/02/2025
  Time: 9:05 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<%
    String action = request.getParameter("action");

    if ("add".equals(action)) {
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Product.addProduct(new Product(0,name, quantity));
        response.sendRedirect("productjstl.jsp");
        return;
    }

    if ("delete".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        Product.deleteProduct(id);
        response.sendRedirect("productjstl.jsp");
        return;
    }

    if ("update".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Product.updateProduct(new Product(id, name, quantity));
        response.sendRedirect("productjstl.jsp");
        return;
    }

    List<Product> products = null;
    try {
        products = Product.getAllProducts();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
    request.setAttribute("productList", products);

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Product Jstl</title>

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
<h4 class="mt-4">Add Product</h4>
<form action="productjstl.jsp" method="post" class="mb-3">
    <input type="hidden" name="action" value="add">
    Name:
    <input type="text" name="name"  required>
    Quantity:
    <input type="number" name="quantity"  required>

    <button type="submit" class="btn btn-success"><i class="fa fa-plus"></i> Add New</button>
</form>

<%
    if (request.getParameter("id") != null) {
%>
<h4>Update Product</h4>
<form action="productjstl.jsp" method="post" class="mb-3">
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

<h2>Product List</h2>
        <table class="table table-hover table-bordered">
            <thead class="thead-dark">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Quantity</th>
        <th>Action</th>
    </tr>
            </thead>
    <c:forEach var="product" items="${productList}">
        <tr>
            <td>${product.id}</td>
            <td>${product.name}</td>
            <td>${product.quantity}</td>
            <td>
                <a href="productjstl.jsp?action=edit&id=${product.id}&name=${product.name}&quantity=${product.quantity}" class="btn btn-warning btn-sm">Edit</a> |
                <a href="productjstl.jsp?action=delete&id=${product.id}" onclick="return confirm('Are you sure you want to delete this product?');" class="btn btn-danger btn-sm">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


</body>
</html>

