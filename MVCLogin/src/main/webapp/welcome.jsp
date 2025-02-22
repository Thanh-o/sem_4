<%@ page import="util.JwtUtil" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Trung Thanh
  Date: 13/02/2025
  Time: 11:40 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.Cookie, util.JwtUtil" %>
<%
    String username = null;
    String token = null;

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("jwt_token".equals(cookie.getName())) {
                token = cookie.getValue();
                username = JwtUtil.validateToken(token);
            }
        }
    }

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f0f2f5;
        }
        .container {
            margin-top: 80px;
        }
        .card {
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            background: white;
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
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <span class="navbar-brand mb-0 h1">👋 Welcome, <%= username %></span>
        <form method="get" action="logout">
            <button type="submit" class="btn btn-danger btn-custom" onclick="return confirm('Are you sure you want to logout?');">
                <i class="fa fa-sign-out-alt"></i> Logout
            </button>
        </form>
    </div>
</nav>

<div class="container d-flex justify-content-center">
    <div class="card text-center">
        <h2>Welcome, <%= username %>! 🎉</h2>
        <p class="text-muted">Explore our products below</p>
        <div class="mt-4">
            <a href="product.jsp" class="btn btn-primary btn-custom">Products</a>
            <a href="productjstl.jsp" class="btn btn-secondary btn-custom">Products JSTL</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

