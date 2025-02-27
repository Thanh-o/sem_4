<%@ page import="util.JwtUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        .custom-card {
            max-width: 500px;
            margin: auto;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .custom-btn {
            width: 100%;
            font-size: 1.1rem;
        }
    </style>
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="user">👋Welcome, <%= username %>!</a>
        <div class="ms-auto">
            <form method="get" action="logout">
                <button type="submit" class="btn btn-danger btn-custom" onclick="return confirm('Are you sure you want to logout?');">
                    <i class="fa fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="card custom-card bg-white">
        <div class="card-body">
            <h2 class="text-center text-primary">
                <i class="fas fa-exchange-alt"></i> Transfer Funds
            </h2>
            <p class="text-muted text-center">Secure and fast money transfer</p>

            <form action="transfer" method="post">
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-user"></i> Recipient ID</label>
                    <input type="number" name="recipient" class="form-control" required placeholder="Enter recipient ID">
                </div>

                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-dollar-sign"></i> Amount to Transfer</label>
                    <input type="number" name="amount" class="form-control" required placeholder="Enter amount">
                </div>

                <button type="submit" class="btn btn-primary custom-btn">
                    <i class="fas fa-paper-plane"></i> Transfer
                </button>
            </form>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show mt-3">
                    <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("error"); %>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
