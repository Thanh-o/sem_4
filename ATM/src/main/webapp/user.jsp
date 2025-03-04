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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .dashboard-card {
            border: none;
            border-radius: 15px;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
        }

        .btn-action {
            padding: 12px 25px;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .balance-display {
            background: #e9ecef;
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #007bff;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
    </style>
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="user">🏠 Home</a>
        <div class="ms-auto">
            <form method="get" action="logout">
                <button type="submit" class="btn btn-danger btn-custom" onclick="return confirm('Are you sure you want to logout?');">
                    <i class="fa fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="dashboard-card p-4">
                <div class="text-center">
                    <h2 class="text-primary mb-4">
                        👋Welcome, <%= username %>!
                    </h2>

                    <div class="balance-display">
                        <h6 class="text-muted mb-2">Available Balance</h6>
                        <h3 class="text-success fw-bold">
                            $<c:out value="${balance}" />
                        </h3>
                    </div>

                    <div class="d-flex flex-wrap justify-content-center gap-3 mt-4">
                        <a href="transfer.jsp" class="btn btn-primary btn-action">
                            <i class="fas fa-exchange-alt me-2"></i>Transfer
                        </a>
                        <a href="withdraw.jsp" class="btn btn-warning btn-action">
                            <i class="fas fa-money-bill-wave me-2"></i>Withdraw
                        </a>
                        <a href="history" class="btn btn-info btn-action">
                            <i class="fas fa-history me-2"></i>History
                        </a>
                    </div>

                    <div class="mt-4 text-muted">
                        <small>Last updated: <%= new java.util.Date() %></small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>