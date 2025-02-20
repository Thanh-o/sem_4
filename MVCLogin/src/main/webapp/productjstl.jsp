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
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
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
                INSERT INTO products (name, quantity) VALUES (?, ?);
                <sql:param value="${param.name}" />
                <sql:param value="${param.quantity}" />
            </sql:update>

            <c:choose>
                <c:when test="${add >= 1}">
                    <% response.sendRedirect("productjstl.jsp?message=added"); %>
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
                UPDATE products SET name = ?, quantity = ? WHERE id = ?;
                <sql:param value="${param.name}" />
                <sql:param value="${param.quantity}" />
                <sql:param value="${param.id}" />
            </sql:update>

            <c:choose>
                <c:when test="${update >= 1}">
                    <% response.sendRedirect("productjstl.jsp?message=updated"); %>
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
                    <% response.sendRedirect("productjstl.jsp?message=deleted"); %>
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

        <h4>Add Product</h4>
        <form action="productjstl.jsp" method="post" class="mb-3">
            <input type="hidden" name="action" value="add">
            Name:
            <input type="text" name="name" required>
            Quantity:
            <input type="number" name="quantity" required>
            <button type="submit" class="btn btn-success"><i class="fa fa-plus"></i> Add New</button>
        </form>

        <c:if test="${param.action == 'edit'}">
            <h4>Update Product</h4>
            <form action="productjstl.jsp" method="post" class="mb-3">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${param.id}">
                Name:
                <input type="text" name="name" value="${param.name}" required>
                Quantity:
                <input type="number" name="quantity" value="${param.quantity}" required>
                <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Update</button>
            </form>
        </c:if>

        <h4>Product List</h4>
        <table class="table table-hover table-bordered">
            <thead class="thead-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Quantity</th>
                <th>Action</th>
            </tr>
            </thead>
            <c:forEach var="product" items="${result.rows}">
                <tr>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.quantity}</td>
                    <td>
                        <a href="productjstl.jsp?action=edit&id=${product.id}&name=${product.name}&quantity=${product.quantity}"
                           class="btn btn-warning btn-sm">
                            <i class="fa fa-edit"></i> Edit
                        </a>

                        <a href="productjstl.jsp?action=delete&id=${product.id}"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you confirm delete?');">
                            <i class="fa fa-trash"></i> Delete
                        </a>
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

