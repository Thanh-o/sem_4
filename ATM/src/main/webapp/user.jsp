<%@ page import="util.JwtUtil" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .custom-card {
            max-width: 600px;
            margin: auto;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
        }

        .action-btn {
            min-width: 140px;
            font-size: 1.1rem;
        }
        .action-btn i {
            margin-right: 8px;
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
    <div class="card custom-card p-4 bg-white">
        <div class="card-body text-center">
            <h2 class="text-primary">💰 Your Balance</h2>
            <h3 class="text-success mt-3">$ <c:out value="${balance}" /> </h3>

            <p class="text-muted">Manage your transactions with ease.</p>
            <div class="d-flex justify-content-center mt-4">
                <a href="transfer.jsp" class="btn btn-primary action-btn mx-2">
                    <i class="fas fa-exchange-alt"></i> Transfer
                </a>
                <a href="withdraw.jsp" class="btn btn-warning action-btn mx-2">
                    <i class="fas fa-money-bill-wave"></i> Withdraw
                </a>
                <a href="history" class="btn btn-info action-btn mx-2">
                    <i class="fas fa-history"></i> History
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
