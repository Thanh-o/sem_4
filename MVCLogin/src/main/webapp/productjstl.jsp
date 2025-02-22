<%--
  Created by IntelliJ IDEA.
  User: Nguyen Trung Thanh
  Date: 20/02/2025
  Time: 9:05 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
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
    <title>Product Jstl</title>

</head>
<body>

<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/fptaptech2025"
                   user="root" password=""/>
<%--READ--%>
<sql:query var="result" dataSource="${db}">
    SELECT * FROM products;
</sql:query>
<%--INSERT, DELETE,EDIT dung sql update--%>
<%--    INSERT--%>
<c:if test="${param.action == 'add'}">
    <sql:update dataSource="${db}" var="add">
        INSERT INTO products (name, price, description) VALUES (?, ?, ?);
        <sql:param value="${param.name}" />
        <sql:param value="${param.price}" />
        <sql:param value="${param.description}" />
    </sql:update>

    <c:choose>
        <c:when test="${add >= 1}">
            <c:redirect url="productjstl.jsp?message=added" />
        </c:when>
        <c:otherwise>
            <c:set var="erroradd" value="Error add new." />
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${param.message == 'added'}">
    <p style="color: green;">Added new Successfully!</p>
</c:if>

<c:if test="${not empty erroradd}">
    <p style="color: red;">${erroradd}</p>
</c:if>
<%--    UPDATE--%>
<c:if test="${param.action == 'update'}">
    <sql:update dataSource="${db}" var="update">
        UPDATE products SET name = ?, price = ?, description = ? WHERE id = ?;
        <sql:param value="${param.name}" />
        <sql:param value="${param.price}" />
        <sql:param value="${param.description}" />
        <sql:param value="${param.id}" />
    </sql:update>

    <c:choose>
        <c:when test="${update >= 1}">
            <c:redirect url="productjstl.jsp?message=updated" />

        </c:when>
        <c:otherwise>
            <c:set var="erroru" value="Error update!" />
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${param.message == 'updated'}">
    <p style="color: green;">Updated Successfully!</p>
</c:if>

<c:if test="${not empty erroru}">
    <p style="color: red;">${erroru}</p>
</c:if>
<%--DELETE--%>
<c:if test="${param.action == 'delete'}">
    <sql:update dataSource="${db}" var="delete">
        DELETE FROM products WHERE id = ?;
        <sql:param value="${param.id}" />
    </sql:update>

    <c:choose>
        <c:when test="${delete >= 1}">
            <c:redirect url="productjstl.jsp?message=deleted" />

        </c:when>
        <c:otherwise>
            <c:set var="errorMessage" value="Delete failed product! Maybe the product doesn't exist." />
        </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${param.message == 'deleted'}">
    <p style="color: green;">Delete Successfully!</p>
</c:if>

<c:if test="${not empty errorMessage}">
    <p style="color: red;">${errorMessage}</p>
</c:if>

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

<div class="container d-flex justify-content-center mt-4">
    <div class="card w-100 shadow-lg p-4">
        <h2 class="text-center mb-4">Manage Products 🛒</h2>

        <!-- Add Product Form -->
        <h4>Add Product</h4>
        <form action="productjstl.jsp" method="post" class="mb-4">
            <input type="hidden" name="action" value="add">
            <div class="row g-3">
                <div class="col-md-5">
                    <input type="text" class="form-control" name="name" placeholder="Name" required>
                </div>
                <div class="col-md-3">
                    <input type="number" class="form-control" name="price" placeholder="Price" required>
                </div>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="description" placeholder="Description">
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-success w-100"><i class="fa fa-plus"></i> Add New</button>
                </div>
            </div>
        </form>

        <!-- Update Product Form -->
        <c:if test="${param.action == 'edit'}">
            <h4>Update Product</h4>
            <form action="productjstl.jsp" method="post" class="mb-4">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${param.id}">
                <div class="row g-3">
                    <div class="col-md-5">
                        <input type="text" class="form-control" name="name" value="${param.name}" required>
                    </div>
                    <div class="col-md-3">
                        <input type="number" class="form-control" name="price" value="${param.price}" required>
                    </div>
                    <div class="col-md-5">
                        <input type="text" class="form-control" name="description" value="${param.description}">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100"><i class="fa fa-save"></i> Update</button>
                    </div>
                </div>
            </form>
        </c:if>

        <!-- Product List -->
        <h4>Product List</h4>
        <div class="table-responsive">
            <table class="table table-hover table-bordered p-3">
                <thead class="table-dark">
                <tr class="text-center">
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${result.rows}">
                    <tr class="align-middle text-center">
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>${product.price}</td>
                        <td>${product.description}</td>
                        <td>
                            <a href="productjstl.jsp?action=edit&id=${product.id}&name=${product.name}&price=${product.price}&description=${product.description}"
                               class="btn btn-warning btn-sm mx-2">
                                <i class="fa fa-edit"></i> Edit
                            </a>
                            <a href="productjstl.jsp?action=delete&id=${product.id}"
                               class="btn btn-danger btn-sm mx-2"
                               onclick="return confirm('Are you sure you want to delete this product?');">
                                <i class="fa fa-trash"></i> Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


</body>
</html>

