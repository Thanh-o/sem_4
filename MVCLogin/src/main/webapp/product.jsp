<%--
  Created by IntelliJ IDEA.
  User: Nguyen Trung Thanh
  Date: 15/02/2025
  Time: 11:42 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f0f2f5;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .navbar {
            padding: 10px 20px;
        }
        .btn-custom {
            border-radius: 8px;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <a class="navbar-brand" href="welcome.jsp"><i class="fa fa-home"></i> Home</a>
        <form method="get" action="logout">
            <button type="submit" class="btn btn-danger btn-custom" onclick="return confirm('Are you sure you want to logout?');">
                <i class="fa fa-sign-out-alt"></i> Logout
            </button>
        </form>
    </div>
</nav>

<!-- Main Container -->
<div class="container d-flex justify-content-center">
    <div class="card w-100">
        <h2 class="text-center mb-4">Manage Products 🛒</h2>

        <!-- Add Product Form -->
        <h4>Add Product</h4>
        <form action="product" method="post" class="row g-3">
            <input type="hidden" name="action" value="add">
            <div class="col-md-5">
                <input type="text" class="form-control" name="name" placeholder="Name" required>
            </div>
            <div class="col-md-4">
                <input type="number" class="form-control" name="price" placeholder="Price" required>
            </div>
            <div class="col-md-5">
                <input type="text" class="form-control" name="description" placeholder="Description">
            </div>
            <div class="col-md-3">
                <button type="submit" class="btn btn-success btn-custom w-100"><i class="fa fa-plus"></i> Add New</button>
            </div>
        </form>

        <!-- Update Product Form -->
        <c:if test="${not empty param.id}">
            <h4 class="mt-4">Update Product</h4>
            <form action="product" method="post" class="row g-3">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${param.id}">
                <div class="col-md-5">
                    <input type="text" class="form-control" name="name" value="${param.name}" required>
                </div>
                <div class="col-md-4">
                    <input type="number" class="form-control" name="price" value="${param.price}" required>
                </div>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="description" value="${param.description}">
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-primary btn-custom w-100"><i class="fa fa-edit"></i> Update</button>
                </div>
            </form>
        </c:if>

        <!-- Product List Table -->
        <h4 class="mt-4">Product List</h4>
        <table class="table table-hover table-bordered text-center">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty products}">
                    <c:redirect url="product" />
                </c:when>
                <c:otherwise>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.id}</td>
                            <td>${product.name}</td>
                            <td>$ ${product.price}</td>
                            <td>${product.description}</td>
                            <td>
                                <div class="d-flex justify-content-center">
                                    <form action="product" method="get">
                                        <input type="hidden" name="id" value="${product.id}">
                                        <input type="hidden" name="name" value="${product.name}">
                                        <input type="hidden" name="price" value="${product.price}">
                                        <input type="hidden" name="description" value="${product.description}">
                                        <button type="submit" class="btn btn-warning btn-sm mx-2">
                                            <i class="fa fa-edit"></i> Edit
                                        </button>
                                    </form>
                                    <form action="product" method="post">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${product.id}">
                                        <button type="submit" class="btn btn-danger btn-sm mx-2"
                                                onclick="return confirm('Are you sure you want to delete this product?');">
                                            <i class="fa fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
