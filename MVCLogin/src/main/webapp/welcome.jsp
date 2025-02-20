<%--
  Created by IntelliJ IDEA.
  User: Nguyen Trung Thanh
  Date: 13/02/2025
  Time: 11:40 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            padding: 20px;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand mb-0 h1">Welcome, <%= session.getAttribute("username") %></span>
        <form method="post" class="d-inline">
            <button type="submit" name="logout" class="btn btn-danger" onclick="return confirm('Are you sure you want to logout?');">Logout</button>
        </form>
    </div>
</nav>

<div class="container">
    <div class="card shadow-sm">
        <h2 class="text-center">Welcome, <%= session.getAttribute("username") %>!</h2>
        <div class="text-center mt-3">
            <a href="product.jsp" class="btn btn-primary">View Products</a>
        </div>
        <div class="text-center mt-3">
            <a href="productjstl.jsp" class="btn btn-primary">View Products Jstl</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

